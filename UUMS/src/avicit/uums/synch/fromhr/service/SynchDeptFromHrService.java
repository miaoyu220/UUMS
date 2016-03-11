package avicit.uums.synch.fromhr.service;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import avicit.platform6.api.sysuser.SysDeptAPI;
import avicit.platform6.api.sysuser.SysOrgAPI;
import avicit.platform6.api.sysuser.dto.SysDept;
import avicit.platform6.commons.utils.PojoUtil;
import avicit.platform6.core.threadPool.WorkerThreadPool;
import avicit.uums.appsys.register.uumsappsys.dto.UumsAppSysDTO;
import avicit.uums.appsys.register.uumsappsys.service.UumsAppSysService;
import avicit.uums.appsys.synchconfig.uumssynchtypeconfig.dto.UumsSynchOrgUserMapperDTO;
import avicit.uums.appsys.synchconfig.uumssynchtypeconfig.dto.UumsSynchTypeConfigDTO;
import avicit.uums.appsys.synchconfig.uumssynchtypeconfig.service.UumsSynchOrgUserMapperService;
import avicit.uums.appsys.synchconfig.uumssynchtypeconfig.service.UumsSynchTypeConfigService;
import avicit.uums.synch.fromhr.dao.SynchOrgFromHrDao;
import avicit.uums.synch.fromhr.dto.UumsOrgDept;
import avicit.uums.synch.fromhr.rest.SynchDeptFromHrRestClient;
import avicit.uums.synch.log.orglog.uumslogsynchorg.dto.UumsLogSynchOrgDTO;
import avicit.uums.synch.log.orglog.uumslogsynchorg.service.UumsLogSynchOrgService;
/**
 * 从权威数据源HR同步部门数据Service类
 * @author miaoyu
 * @since 2016-3-3
 *
 */
@Service
public class SynchDeptFromHrService implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static final Logger logger =  LoggerFactory.getLogger(SynchDeptFromHrService.class);
	@Autowired
	private UumsAppSysService appSysService;
	@Autowired
	private UumsSynchOrgUserMapperService synchOrgUserMapperService;
	@Autowired
	private UumsSynchTypeConfigService synchTypeConfigService;
	@Autowired
	private SysDeptAPI sysDeptApi;
	@Autowired
	private SysOrgAPI sysOrgApi;
	@Autowired
	private SynchDeptFromHrRestClient restClient;
	@Autowired
	private SynchOrgFromHrDao dao;
	@Autowired
	private UumsLogSynchOrgService logSynchOrgService;
	private String appId;
	@Autowired
	private WorkerThreadPool workerThreadPool; 
	
	private List<UumsOrgDept> synchOrgFromHr(String operType, String orgOrDept)throws Exception{
		try {
			UumsAppSysDTO appsysDto= appSysService.queryHrAppSys();
			if(appsysDto != null){
				this.setAppId(appsysDto.getId());
				UumsSynchTypeConfigDTO synchTypeDto = synchTypeConfigService.queryUumsSynchTypeConfigByAppId(appsysDto.getId());
				if(synchTypeDto != null){
					List<UumsSynchOrgUserMapperDTO> mappList = synchOrgUserMapperService.queryUumsSynchOrgUserMapperByPidMaintypeColCode(synchTypeDto.getId(), "UUMS_ORG");
					
					List<UumsOrgDept> deptList = dao.synchOrgFromHr(synchTypeDto, mappList, operType, orgOrDept);
					
					return sortOrgDeptList(deptList);
				}else{
					return null;
				}
			}else{
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	/**
	 * 从HR同步新增、修改、删除的部门数据
	 * @param synchType 同步操作类型，1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception
	 */
	public void synchDeptFromHr(String synchType, String operator) throws Exception{
		try {
			// 新增
			this.saveOrUpdateSysDept("1", synchType, operator);
			// 更新
			this.saveOrUpdateSysDept("2", synchType, operator);
			// 删除
			this.deleteSysDept(synchType, operator);
		} catch (Exception e) {
			throw e;
		}
	}
	/**
	 * 同步新增、修改的部门数据
	 * @param operType 操作类型：1-新增，2-更新，3-删除
	 * @param synchType 同步操作类型，1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @return
	 * @throws Exception
	 */
	public boolean saveOrUpdateSysDept(String operType, String synchType, String operator) throws Exception{
		try {
			if(StringUtils.isEmpty(operType)){
				operType = "1";
			}
			List<UumsOrgDept> deptList = new ArrayList<UumsOrgDept>();
			if(operType.equals("1")){
				deptList = this.synchOrgFromHr("1", "2");
			}else{
				deptList = this.synchOrgFromHr("2", "2");
			}
			if(deptList == null){
				return false;
			}
			List<Object[]> resultList = new ArrayList<Object[]>();
			List<UumsLogSynchOrgDTO> logList = new ArrayList<UumsLogSynchOrgDTO>();
			for(UumsOrgDept uumsDept : deptList){
				/*************同步日志信息***begin***********/
				UumsLogSynchOrgDTO logDto = new UumsLogSynchOrgDTO();
				logDto.setOperator(operator);
				logDto.setAppId(this.getAppId());
				logDto.setSynchType(synchType);
				/*************同步日志信息***end***********/
				try {
					String deptId = sysDeptApi.getSysDeptIdByDeptCode(uumsDept.getDeptCode());
					uumsDept.setId(deptId);
					String parentDeptId = sysDeptApi.getSysDeptIdByDeptCode(uumsDept.getParentOrgCode());
					uumsDept.setParentDeptId(parentDeptId);
					this.saveOrUpdateSysDept(uumsDept);
					
					// 记录同步成功的组织ID
					resultList.add(new Object[]{ uumsDept.getSid() });
					
					//记录同步日志
					logDto.setSynchFlag("1");
					logList.add(logDto);
				} catch (Exception e) {
					logDto.setSynchFlag("0");
					logDto.setFaildCause(e.getMessage());
					logList.add(logDto);
					logger.error("从HR同步新增修改的部门【" + uumsDept.getDeptName() +"】失败：" + e.getMessage());
				}
			}
			
			//更新HR组织表中的同步状态
			updateSynchFlagToHr(resultList);
			//保存同步日志
			//logSynchOrgService.insertUumsLogSynchOrg(deptList, logList);
			//保存同步日志,多线程执行
			logSynchOrgService.setOrgList(deptList);
			logSynchOrgService.setLogList(logList);
			workerThreadPool.submitCall(logSynchOrgService, WorkerThreadPool.Priority.NORMAL);
			
			return true;
		} catch (Exception e) {
			throw new Exception("从权威数据源HR系统同步新增更新部门错误：" + e.getMessage());
		}
	}
	
	private SysDept saveOrUpdateSysDept(UumsOrgDept uumsDept)throws Exception{
		SysDept sysDeptVo = new SysDept();
		PojoUtil.copyProperties(sysDeptVo, uumsDept, true);
		if (StringUtils.isEmpty(sysDeptVo.getId())
				&& StringUtils.isEmpty(sysDeptVo.getParentDeptId())) {
			sysDeptVo.setParentDeptId("-1");
			String orgId = sysOrgApi.getSysOrgIdByCode(uumsDept.getParentOrgCode());
			if (StringUtils.isEmpty(orgId)) {
				orgId = "ORG_ROOT";
			}
			sysDeptVo.setOrgId(orgId);
			// insert
			sysDeptVo = restClient.insertDeptInfoRest(sysDeptVo);
		} else if (StringUtils.isEmpty(sysDeptVo.getId())
				&& StringUtils.isNotEmpty(sysDeptVo.getParentDeptId())) {
			sysDeptVo.setOrgId(sysDeptApi.getSysDeptBySysDeptId(
					sysDeptVo.getParentDeptId()).getOrgId());
			// insert
			sysDeptVo = restClient.insertDeptInfoRest(sysDeptVo);
		} else if (StringUtils.isNotEmpty(sysDeptVo.getId())
				&& StringUtils.isEmpty(sysDeptVo.getParentDeptId())) {
			sysDeptVo.setParentDeptId("-1");
			String orgId = sysOrgApi.getSysOrgIdByCode(uumsDept.getParentOrgCode());
			if (StringUtils.isEmpty(orgId)) {
				orgId = "ORG_ROOT";
			}
			sysDeptVo.setOrgId(orgId);
			// update
			SysDept sysDept = sysDeptApi.getSysDeptBySysDeptId(sysDeptVo.getId());
			PojoUtil.copyProperties(sysDept, sysDeptVo, true);
			sysDeptVo = restClient.updateDeptInfoRest(sysDept);
		} else {
			SysDept sysDept = sysDeptApi.getSysDeptBySysDeptId(sysDeptVo.getId());
			PojoUtil.copyProperties(sysDept, sysDeptVo, true);
			// update
			sysDeptVo = restClient.updateDeptInfoRest(sysDept);
		}
		
		return sysDeptVo;
	}
	
	/**
	 * 同步删除的部门
	 * @return
	 * @throws Exception
	 */
	public boolean deleteSysDept(String synchType, String operator)throws Exception{
		try {
			List<UumsOrgDept> deptList = this.synchOrgFromHr("3", "2");
			if(deptList == null){
				return false;
			}
			List<Object[]> resultList = new ArrayList<Object[]>();
			List<UumsLogSynchOrgDTO> logList = new ArrayList<UumsLogSynchOrgDTO>();
			int size = deptList.size();
			for(int i=size-1; i>=0; i--){
				/*************同步日志信息***begin***********/
				UumsLogSynchOrgDTO logDto = new UumsLogSynchOrgDTO();
				logDto.setOperator(operator);
				logDto.setAppId(this.getAppId());
				logDto.setSynchType(synchType);
				/*************同步日志信息***end***********/
				UumsOrgDept uumsDept = deptList.get(i);
				try {
					String deptId = sysDeptApi.getSysDeptIdByDeptCode(uumsDept.getDeptCode());
					if(StringUtils.isNotEmpty(deptId)){
						String reString = restClient.isHaveChildrenRest(deptId); 
						if (StringUtils.isEmpty(reString)) {
							restClient.deleteSysDeptByIdRest(deptId);
							
							// 记录同步成功的组织ID
							resultList.add(new Object[]{ uumsDept.getSid() });
							//记录同步日志
							logDto.setSynchFlag("1");
							logList.add(logDto);
						}else{
							//记录同步日志
							logDto.setSynchFlag("0");
							logDto.setFaildCause("含有子部门，不能删除!");
							logList.add(logDto);
							
							// LOG 含有子部门，不能删除
							logger.info("含有子部门，不能删除!");
						}
					}
				} catch (Exception e) {
					logDto.setSynchFlag("0");
					logDto.setFaildCause(e.getMessage());
					logList.add(logDto);
					logger.error("从HR同步删除的不卖【" + uumsDept.getDeptCode() +"】失败：" + e.getMessage());
				}
			}
			
			//更新HR组织表中的同步状态
			updateSynchFlagToHr(resultList);
			//保存同步日志
			//logSynchOrgService.insertUumsLogSynchOrg(deptList, logList);
			//保存同步日志,多线程执行
			logSynchOrgService.setOrgList(deptList);
			logSynchOrgService.setLogList(logList);
			workerThreadPool.submitCall(logSynchOrgService, WorkerThreadPool.Priority.NORMAL);
			
			return true;
		} catch (Exception e) {
			throw new Exception("从权威数据源HR系统同步删除部门错误：" + e.getMessage());
		}
	}
	
	/**
	 * 排序，始终保持父组织在前面
	 * @param deptList
	 * @return
	 */
	private List<UumsOrgDept> sortOrgDeptList(List<UumsOrgDept> deptList){
		if(deptList.size() == 0){
			return deptList;
		}
		List<UumsOrgDept> sortDeptList = new ArrayList<UumsOrgDept>();
		int index = 0;
		int size = deptList.size();
		for(int i=0; i<size; i++){
			UumsOrgDept deptO = deptList.get(0);
			sortDeptList.add(i, deptO);
			index = 0;
			for(int j=0; j<deptList.size(); j++){
				UumsOrgDept deptI = deptList.get(j);
				if((deptI.getDeptCode()).equals((sortDeptList.get(i)).getParentOrgCode())){
					sortDeptList.add(i, deptI);
					index = j;
				}
			}
			deptList.remove(index);
		}
		return sortDeptList;
	}
	
	/**
	 * 更新权威数据源HR组织表的同步状态
	 * @param deptList
	 */
	private void updateSynchFlagToHr(List<Object[]> orgIdList){
		if(orgIdList.size() == 0){
			return;
		}
		try {
			UumsAppSysDTO appsysDto= appSysService.queryHrAppSys();
			if(appsysDto != null){
				UumsSynchTypeConfigDTO synchTypeDto = synchTypeConfigService.queryUumsSynchTypeConfigByAppId(appsysDto.getId());
				if(synchTypeDto != null){
					List<UumsSynchOrgUserMapperDTO> mappList = synchOrgUserMapperService.queryUumsSynchOrgUserMapperByPidMaintypeColCode(synchTypeDto.getId(), "UUMS_ORG");
					
					dao.updateSynchFlagToHr(orgIdList, synchTypeDto, mappList);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("更新权威数据源HR组织表的同步状态时错误：" + e.getMessage());
		}
	}
	
	public String getAppId() {
		return appId;
	}

	public void setAppId(String appId) {
		this.appId = appId;
	}
}
