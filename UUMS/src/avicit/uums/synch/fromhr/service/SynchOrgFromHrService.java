package avicit.uums.synch.fromhr.service;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import avicit.platform6.api.sysuser.SysOrgAPI;
import avicit.platform6.api.sysuser.dto.SysOrg;
import avicit.platform6.api.sysuser.dto.SysOrgVo;
import avicit.platform6.commons.utils.DateUtil;
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
import avicit.uums.synch.fromhr.rest.SynchOrgFromHrRestClient;
import avicit.uums.synch.log.orglog.uumslogsynchorg.dto.UumsLogSynchOrgDTO;
import avicit.uums.synch.log.orglog.uumslogsynchorg.service.UumsLogSynchOrgService;
/**
 * 从权威数据源HR同步组织数据Service类
 * @author miaoyu
 * @since 2016-3-3
 *
 */
@Service
public class SynchOrgFromHrService implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static final Logger logger =  LoggerFactory.getLogger(SynchOrgFromHrService.class);
	@Autowired
	private UumsAppSysService appSysService;
	@Autowired
	private UumsSynchOrgUserMapperService synchOrgUserMapperService;
	@Autowired
	private UumsSynchTypeConfigService synchTypeConfigService;
	@Autowired
	private SysOrgAPI orgApi;
	@Autowired
	private SynchOrgFromHrRestClient restClient;
	@Autowired
	private SynchOrgFromHrDao dao;
	@Autowired
	private SynchDeptFromHrService deptService;
	@Autowired
	private WorkerThreadPool workerThreadPool; 
	@Autowired
	private UumsLogSynchOrgService logSynchOrgService;
	private String appId;
	
	/**
	 * 从HR同步新增、修改、删除的组织和部门数据
	 * @param synchType 同步操作类型，1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception
	 */
	public void synchOrgDeptFromHr(String synchType, String operator) {
		//先同步新增和更新的组织部门数据
		synchOrgDeptFromHrForAddUpdate(synchType, operator);
		
		//然后同步删除的组织部门数据
		synchOrgDeptFromHrForDel(synchType, operator);
	}
	
	/**
	 * 从HR同步新增、修改的组织和部门数据
	 * @param synchType 同步操作类型，1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 */
	public void synchOrgDeptFromHrForAddUpdate(String synchType, String operator) {
		try {
			// 新增组织
			this.saveUpdateSysOrg("1", synchType, operator);
		} catch (Exception e) {
			logger.error(e.getStackTrace().toString());
		}
		try {
			// 更新组织
			this.saveUpdateSysOrg("2", synchType, operator);
		} catch (Exception e) {
			logger.error(e.getStackTrace().toString());
		}
		try {
			// 新增部门
			deptService.saveOrUpdateSysDept("1", synchType, operator);
		} catch (Exception e) {
			logger.error(e.getStackTrace().toString());
		}
		try {
			// 更新部门
			deptService.saveOrUpdateSysDept("2", synchType, operator);
		} catch (Exception e) {
			logger.error(e.getStackTrace().toString());
		}
	}
	/**
	 * 从HR同步删除的组织和部门数据
	 * @param synchType 同步操作类型，1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception
	 */
	public void synchOrgDeptFromHrForDel(String synchType, String operator) {
		try {
			// 删除部门
			deptService.deleteSysDept(synchType, operator);
		} catch (Exception e) {
			logger.error(e.getStackTrace().toString());
		}
		try {
			// 先删除部门最后执行删除组织
			this.deleteSysOrg(synchType, operator);
		} catch (Exception e) {
			logger.error(e.getStackTrace().toString());
		}
	}
	
	/**
	 * 从HR同步新增或修改的组织数据
	 * @param operType 操作类型：1-新增，2-更新，3-删除
	 * @param synchType 同步操作类型，1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @return
	 * @throws Exception
	 */
	public boolean saveUpdateSysOrg(String operType, String synchType, String operator) throws Exception{
		try {
			if(StringUtils.isEmpty(operType)){
				operType = "1";
			}
			List<UumsOrgDept> orgList = new ArrayList<UumsOrgDept>();
			if(operType.equals("1")){
				orgList = this.synchOrgFromHr("1", "1");
			}else{
				orgList = this.synchOrgFromHr("2", "1");
			}
			if(orgList == null){
				return false;
			}
			List<Object[]> resultList = new ArrayList<Object[]>();
			List<UumsLogSynchOrgDTO> logList = new ArrayList<UumsLogSynchOrgDTO>();
			for(UumsOrgDept uumsDept : orgList){
				/*************同步日志信息***begin***********/
				UumsLogSynchOrgDTO logDto = new UumsLogSynchOrgDTO();
				logDto.setOperator(operator);
				logDto.setAppId(this.getAppId());
				logDto.setSynchType(synchType);
				/*************同步日志信息***end***********/
				try {
					String orgId = orgApi.getSysOrgIdByCode(uumsDept.getOrgCode());
					String parentId = orgApi.getSysOrgIdByCode(uumsDept.getParentOrgCode());
					parentId = StringUtils.isEmpty(parentId)? "ORG_ROOT" : parentId;
					uumsDept.setParentOrgId(parentId);
					SysOrgVo sysOrgVo = new SysOrgVo();
					if(StringUtils.isEmpty(orgId)){// 新增
						BeanUtils.copyProperties(uumsDept, sysOrgVo, "creationDate", "lastUpdateDate");
						restClient.insertOrgInfoRest(sysOrgVo);
					}else{// 更新
						uumsDept.setId(orgId);
						SysOrg sysOrg = orgApi.getSysOrgBySysOrgId(orgId);
						BeanUtils.copyProperties(uumsDept, sysOrg, "creationDate", "lastUpdateDate");
						PojoUtil.copyProperties(sysOrgVo, sysOrg, true);
						restClient.updateOrgInfoRest(sysOrgVo);
					}
					// 记录同步成功的组织ID
					resultList.add(new Object[]{ uumsDept.getSid() });
					//记录同步日志
					logDto.setSynchFlag("1");
					logList.add(logDto);
				} catch (Exception e) {
					logDto.setSynchFlag("0");
					logDto.setFaildCause(e.getMessage());
					logList.add(logDto);
					logger.error("从HR同步新增修改的组织【" + uumsDept.getDeptCode() +"】失败：" + e.getMessage());
				}
			}
			
			//更新HR组织表中的同步状态
			updateSynchFlagToHr(resultList);
			//保存同步日志,同步进行
			//logSynchOrgService.insertUumsLogSynchOrg(orgList, logList);
			//保存同步日志,多线程执行
			logSynchOrgService.setOrgList(orgList);
			logSynchOrgService.setLogList(logList);
			workerThreadPool.submitCall(logSynchOrgService, WorkerThreadPool.Priority.NORMAL);
			
			return true;
		} catch (Exception e) {
			throw new Exception("从权威数据源HR系统同步新增更新组织失败："+e.getMessage());
		}
	}
	
	/**
	 * 从HR同步删除的组织数据
	 * @param synchType 同步操作类型，1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @return
	 * @throws Exception
	 */
	public boolean deleteSysOrg(String synchType, String operator) throws Exception{
		try {
			List<UumsOrgDept> orgList = this.synchOrgFromHr("3", "1");
			if(orgList == null){
				return false;
			}

			List<Map<String, String>> list = new ArrayList<Map<String, String>>();
			List<Object[]> resultList = new ArrayList<Object[]>();
			List<UumsLogSynchOrgDTO> logList = new ArrayList<UumsLogSynchOrgDTO>();
			for(UumsOrgDept uumsDept : orgList){
				/*************同步日志信息***begin***********/
				UumsLogSynchOrgDTO logDto = new UumsLogSynchOrgDTO();
				logDto.setOperator(operator);
				logDto.setAppId(this.getAppId());
				logDto.setSynchType(synchType);
				/*************同步日志信息***end***********/
				try {
					Map<String ,String> map = new HashMap<String ,String>();
					String orgId = orgApi.getSysOrgIdByCode(uumsDept.getOrgCode());
					if(orgId != null){
						map.put("id", orgId);
					    map.put("type", "org");
					    list.add(map);
					}
					//为能更改权威数据源HR组织表的同步状态，必须逐条进行同步删除
					restClient.deleteSysOrgByIdsRest(list);
					// 记录同步成功的组织ID
					resultList.add(new Object[]{ uumsDept.getSid() });
					//记录同步日志
					logDto.setSynchFlag("1");
					logList.add(logDto);
				} catch (Exception e) {
					//记录同步日志
					logDto.setSynchFlag("0");
					logDto.setFaildCause(e.getMessage());
					logList.add(logDto);
					logger.error("从HR同步删除的组织【" + uumsDept.getDeptCode() +"】失败：" + e.getMessage());
				}
				list.clear();
			}
			
			//更新HR组织表中的同步状态
			updateSynchFlagToHr(resultList);
			//保存同步日志
			//logSynchOrgService.insertUumsLogSynchOrg(orgList, logList);
			//保存同步日志,多线程执行
			logSynchOrgService.setOrgList(orgList);
			logSynchOrgService.setLogList(logList);
			workerThreadPool.submitCall(logSynchOrgService, WorkerThreadPool.Priority.NORMAL);
			
			return true;
		} catch (Exception e) {
			throw new Exception("从权威数据源HR系统同步删除组织失败："+e.getMessage());
		}
	}
	
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
			logger.debug(e.getMessage());
			throw e;
		}
	}
	
	/**
	 * 更新权威数据源HR组织表的同步状态
	 * @param deptList
	 */
	private void updateSynchFlagToHr(List<Object[]> orgIdList){
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

	public String getAppId() {
		return appId;
	}

	public void setAppId(String appId) {
		this.appId = appId;
	}
	
}
