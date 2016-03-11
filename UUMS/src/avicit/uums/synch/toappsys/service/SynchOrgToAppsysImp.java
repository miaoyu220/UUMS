package avicit.uums.synch.toappsys.service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import avicit.platform6.api.sysuser.SysDeptAPI;
import avicit.platform6.api.sysuser.SysOrgAPI;
import avicit.platform6.api.sysuser.dto.SysDept;
import avicit.platform6.api.sysuser.dto.SysOrg;
import avicit.platform6.bpm.pvm.internal.util.StringUtil;
import avicit.platform6.commons.utils.DateUtil;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.spring.SpringFactory;
import avicit.platform6.core.threadPool.WorkerThreadPool;
import avicit.uums.appsys.register.uumsappsys.dto.UumsAppSysDTO;
import avicit.uums.appsys.register.uumsappsys.service.UumsAppSysService;
import avicit.uums.appsys.synchconfig.uumssynchtypeconfig.dto.UumsSynchOrgUserMapperDTO;
import avicit.uums.appsys.synchconfig.uumssynchtypeconfig.dto.UumsSynchTypeConfigDTO;
import avicit.uums.appsys.synchconfig.uumssynchtypeconfig.service.UumsSynchTypeConfigService;
import avicit.uums.synch.fromhr.dto.UumsOrgDept;
import avicit.uums.synch.log.orglog.uumslogsynchorg.dto.UumsLogSynchOrgDTO;
import avicit.uums.synch.log.orglog.uumslogsynchorg.service.UumsLogSynchOrgService;
import avicit.uums.synch.toappsys.dao.DbOrgUserDao;
import avicit.uums.synch.toappsys.dao.LdapOrgDao;
import avicit.uums.synch.toappsys.dao.WsOrgUserDao;
import avicit.uums.synch.toappsys.orgdept.uumsorgsynchrecord.dto.UumsOrgSynchRecordDTO;
import avicit.uums.synch.toappsys.orgdept.uumsorgsynchrecord.service.UumsOrgSynchRecordService;

/**
 * 
 * 组织信息同步实现类
 * @author miaoyu
 * @since 2016年1月6日
 *
 */
@Service
public class SynchOrgToAppsysImp implements SynchOrgToAppsys {
	private static final Logger logger = LoggerFactory
			.getLogger(SynchOrgToAppsysImp.class);

	@Autowired
	private SysOrgAPI sysOrgApi;
	@Autowired
	private SysDeptAPI sysDeptApi;
	@Autowired
	private UumsAppSysService appSysService;
	@Autowired
	private UumsSynchTypeConfigService synchTypeConfigService;
	@Autowired
	private UumsOrgSynchRecordService orgSynchRecordService;
	@Autowired
	private LdapOrgDao ldapDao;
	@Autowired
	private DbOrgUserDao orgUserDao;
	@Autowired
	private WsOrgUserDao wsOrgUserDao;
	@Autowired
	private UumsLogSynchOrgService logSynchOrgService;
	@Autowired
	private WorkerThreadPool workerThreadPool;
	private String synchType; // 操作类型：1-新增，2-更新，3-删除
	private String operator; //同步操作人
	
	public String getSynchType() {
		return synchType;
	}

	public void setSynchType(String synchType) {
		this.synchType = synchType;
	}

	public String getOperator() {
		return operator;
	}

	public void setOperator(String operator) {
		this.operator = operator;
	}

	/**
	 * 同步所有新增、更新、删除的组织到已注册的应用系统中
	 * @param synchType 同步操作类型：1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception
	 */
	public void synchAllOrgDeptToAppByAllApp(String synchType, String operator) throws Exception{
		try {
			UumsAppSysDTO uumsAppSysDTO = new UumsAppSysDTO();
			QueryReqBean<UumsAppSysDTO> queryReqBean = new QueryReqBean<UumsAppSysDTO>();
			queryReqBean.setSearchParams(uumsAppSysDTO);
			List<UumsAppSysDTO> appList = appSysService.searchUumsAppSys(queryReqBean);
			Assert.notEmpty(appList, "获取所有已注册的应用系统失败！");
			
			for(UumsAppSysDTO app : appList){
				synchAllOrgDeptToAppByAppId(app.getId(), synchType, operator);
			}
			
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new Exception("执行synchAllOrgDeptToAppByAllApp时出错：" + e.getMessage());
		}
	}

	/**
	 * 初始化所有组织数据到应用系统
	 * @param appId 应用系统ID
	 * @param synchType 同步操作类型，1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception 
	 */
	public void initAllOrgDeptToAppByAppId(String appId, String synchType, String operator) throws Exception {
		try {
			this.setProperties(synchType, operator);
			Map<String, Object> confMap = synchTypeConfigService.getSynchConfigInfoMapByAppid(appId, "UUMS_ORG");
			UumsSynchTypeConfigDTO synchTypeDto = (UumsSynchTypeConfigDTO)confMap.get("synchType");
			@SuppressWarnings("unchecked")
			List<UumsSynchOrgUserMapperDTO> mappList = (List<UumsSynchOrgUserMapperDTO>)confMap.get("mapperList");
			
			//初始化组织部门数据
			this.initAllOrgDeptToAppByAppId(synchTypeDto, mappList);
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw e;
		}
	}
	
	/**
	 * 同步新增、更新、删除的组织到应用系统
	 * @param appId 应用系统ID
	 * @param synchType 同步操作类型：1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception 
	 */
	public void synchAllOrgDeptToAppByAppId(String appId, String synchType, String operator) throws Exception{
		try {
			//同步新增
			this.synchInsertedOrgDeptToAppByAppId(appId, synchType, operator);
			//同步更新
			this.synchUpdatedOrgDeptToAppByAppId(appId, synchType, operator);
			//同步删除
			this.synchDeletedOrgDeptToAppByAppId(appId, synchType, operator);
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new Exception("执行synchAllOrgDeptToAppByAppid时出错：" + e.getMessage());
		}
		
	}

	/**
	 * 同步新增组织到应用系统
	 * @param appId 应用系统ID
	 * @param synchType 同步操作类型：1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception 
	 */
	public void synchInsertedOrgDeptToAppByAppId(String appId, String synchType, String operator) throws Exception{
		try {
			this.setProperties(synchType, operator);
			this.synchOrgDeptToAppByAppId(appId, "1");
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new Exception("执行synchInsertedOrgDeptToAppByAppid时出错：" + e.getMessage());
		}
		
	}

	/**
	 * 同步已更新组织到应用系统
	 * @param appId 应用系统ID
	 * @param synchType 同步操作类型：1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception 
	 */
	public void synchUpdatedOrgDeptToAppByAppId(String appId, String synchType, String operator) throws Exception{
		try {
			this.setProperties(synchType, operator);
			this.synchOrgDeptToAppByAppId(appId, "2");
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new Exception("执行synchUpdatedOrgDeptToAppByAppid时出错：" + e.getMessage());
		}
	}

	/**
	 * 同步已删除组织到应用系统
	 * @param appId 应用系统ID
	 * @param synchType 同步操作类型：1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception 
	 */
	public void synchDeletedOrgDeptToAppByAppId(String appId, String synchType, String operator) throws Exception{
		try {
			this.setProperties(synchType, operator);
			this.synchOrgDeptToAppByAppId(appId, "3");
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new Exception("执行synchDeletedOrgDeptToAppByAppid时出错：" + e.getMessage());
		}
	}
	
	/**
	 * 初始化所有组织数据到应用系统
	 * @param synchTypeDto UumsSynchTypeConfigDTO 应用系统同步配置信息
	 * @param mappList List<UumsSynchOrgUserMapperDTO> 应用系统同步映射配置信息
	 * @throws Exception
	 */
	private void initAllOrgDeptToAppByAppId(UumsSynchTypeConfigDTO synchTypeDto, List<UumsSynchOrgUserMapperDTO> mappList) throws Exception{
		try {
			List<SysOrg> orgList = sysOrgApi.getAllSysOrgList();
			Assert.notEmpty(orgList, "初始化同步应用系统组织数据失败，无法获取组织数据！");
			List<SysDept> deptList = sysDeptApi.getAllSysDeptList();
			Assert.notEmpty(deptList, "初始化同步应用系统部门数据失败，无法获取部门数据！");
			
			//初始化组织
			synchAllOrgDeptToApp(synchTypeDto, mappList, orgList);
			//初始化部门
			synchAllOrgDeptToApp(synchTypeDto, mappList, deptList);
			
		} catch (Exception e) {
			throw new Exception("执行initAllOrgDeptToAppByAppid时出错：" + e.getMessage());
		}
	}

	private void synchAllOrgDeptToApp(UumsSynchTypeConfigDTO synchTypeDto, List<UumsSynchOrgUserMapperDTO> mappList, 
			List beanList)throws Exception{
		List<UumsLogSynchOrgDTO> logList = new ArrayList<UumsLogSynchOrgDTO>();
		List<UumsOrgDept> orgList = new ArrayList<UumsOrgDept>();
		
		for(Object bean : beanList){
			/*************同步日志信息***begin***********/
			UumsLogSynchOrgDTO logDto = new UumsLogSynchOrgDTO();
			logDto.setOperator(operator);
			logDto.setAppId(synchTypeDto.getAppId());
			logDto.setSynchType(synchType);
			/*************同步日志信息***end***********/
			try {
				UumsOrgDept orgDept = this.convertOrgDeptDto(bean, "1");
				orgList.add(orgDept);
				if("db".equals(synchTypeDto.getSynchType())){//数据库同步方式
					
					orgUserDao.insertOrgUserIntoApp(orgDept, mappList, synchTypeDto, "org");
					
				}else if("ldap".equals(synchTypeDto.getSynchType())){//LDAP同步方式
					
					insertOrgDeptIntoAppByLdap(orgDept, mappList, synchTypeDto, "1");
					
				}else if("webservice".equals(synchTypeDto.getSynchType())){//WEB SERVICE同步方式
					
					wsOrgUserDao.synchOrg(orgDept, mappList, synchTypeDto);
					
				}
				//记录同步成功日志
				logDto.setSynchFlag("1");
				logList.add(logDto);
			} catch (Exception e) {
				//记录同步失败日志
				logDto.setSynchFlag("0");
				logDto.setFaildCause(e.getMessage());
				logList.add(logDto);
			}
		}
		//保存同步日志,多线程执行
		logSynchOrgService.setOrgList(orgList);
		logSynchOrgService.setLogList(logList);
		workerThreadPool.submitCall(logSynchOrgService, WorkerThreadPool.Priority.NORMAL);
	}
	
	/**
	 * SysOrg或SysDept格式转换为UumsOrgDept
	 * @param beanDto 组织部门对象
	 * @param operType 操作类型：1-新增，2-更新，3-删除
	 * @return
	 * @throws Exception
	 */
	private UumsOrgDept convertOrgDeptDto(Object beanDto, String operType) throws Exception{
		UumsOrgDept orgDept = new UumsOrgDept();
		if(beanDto instanceof SysOrg){
			SysOrg org = (SysOrg)beanDto;
			BeanUtils.copyProperties(org, orgDept);
			orgDept.setDeptCode(org.getOrgCode());
			orgDept.setDeptName(sysOrgApi.getSysOrgNameBySysOrgId(org.getId(), "zh_CN"));
			orgDept.setOrderBy(new BigDecimal(org.getOrderBy()));
			orgDept.setOrgOrDept("1");
			if("ORG_ROOT".equals(org.getOrgCode())){
				orgDept.setParentOrgCode("-1");
			}else{
				orgDept.setParentOrgCode(sysOrgApi.getParentSysOrgBySysOrgId(org.getId()).getOrgCode());
			}
		}else{
			SysDept dept = (SysDept)beanDto;
			BeanUtils.copyProperties(dept, orgDept);
			orgDept.setDeptName(sysDeptApi.getSysDeptNameBySysDeptId(dept.getId(), "zh_CN"));
			orgDept.setOrgOrDept("2");
			if("-1".equals(dept.getParentDeptId())){//如果是根部门，则获取其直接父组织编码
				String parentOrgCode = sysOrgApi.getSysOrgBySysOrgId(dept.getOrgId()).getOrgCode();
				orgDept.setParentOrgCode(parentOrgCode);
			}else{
				String parentDeptCode = sysDeptApi.getSysDeptBySysDeptId(dept.getParentDeptId()).getDeptCode();
				orgDept.setParentOrgCode(parentDeptCode);
			}
		}
		orgDept.setOperFlag(operType);
		orgDept.setSynchTime(DateUtil.getToday());
		
		return orgDept;
	}
	
	/**
	 * 查询应用系统未同步和同步失败的组织数据
	 * @param appId 应用系统ID
	 * @param operType 操作类型：1-新增，2-更新，3-删除
	 * @return List<UumsOrgSynchRecordDTO>
	 * @throws Exception
	 */
	private List<UumsOrgSynchRecordDTO> searchUumsOrgSynchRecord(String appId, String operType)throws Exception{
		QueryReqBean<UumsOrgSynchRecordDTO> queryReqBean = new QueryReqBean<UumsOrgSynchRecordDTO>();
		UumsOrgSynchRecordDTO orgSynchRecordDTO = new UumsOrgSynchRecordDTO();
		orgSynchRecordDTO.setAppId(appId);
		orgSynchRecordDTO.setOperFlag(operType);
		orgSynchRecordDTO.setSynchFlag("0");
		queryReqBean.setSearchParams(orgSynchRecordDTO);
		List<UumsOrgSynchRecordDTO> orgSynchRecordList = orgSynchRecordService.searchUumsOrgSynchRecord(queryReqBean);
		
		orgSynchRecordDTO.setSynchFlag("2");
		List<UumsOrgSynchRecordDTO> orgSynchFaildRecordList = orgSynchRecordService.searchUumsOrgSynchRecord(queryReqBean);
		for(UumsOrgSynchRecordDTO dto : orgSynchFaildRecordList){
			orgSynchRecordList.add(dto);
		}
		
		//排序，新增更新操作为降序，删除为升序
		if("3".equals(operType)){
			return sortOrgDeptList(orgSynchRecordList, "asc");
		}else{
			return sortOrgDeptList(orgSynchRecordList, "desc");
		}
	}
	
	/**
	 * 同步新增、更新、删除的组织部门数据到应用系统
	 * @param appId 应用系统ID
	 * @param operType 操作类型：1-新增，2-更新，3-删除
	 * @param synchType 同步操作类型：1-手工同步，2-自动同步
	 * @throws Exception
	 */
	private void synchOrgDeptToAppByAppId(String appId, String operType)throws Exception{
		List<UumsOrgSynchRecordDTO> orgSynchRecordList = this.searchUumsOrgSynchRecord(appId, operType);
		Map<String, Object> confMap = synchTypeConfigService.getSynchConfigInfoMapByAppid(appId, "UUMS_ORG");
		UumsSynchTypeConfigDTO synchTypeDto = (UumsSynchTypeConfigDTO)confMap.get("synchType");
		@SuppressWarnings("unchecked")
		List<UumsSynchOrgUserMapperDTO> mappList = (List<UumsSynchOrgUserMapperDTO>)confMap.get("mapperList");
		List<UumsLogSynchOrgDTO> logList = new ArrayList<UumsLogSynchOrgDTO>();
		List<UumsOrgDept> orgList = new ArrayList<UumsOrgDept>();
		for(UumsOrgSynchRecordDTO synchDto : orgSynchRecordList){
			/*************同步日志信息***begin***********/
			UumsLogSynchOrgDTO logDto = new UumsLogSynchOrgDTO();
			logDto.setOperator(operator);
			logDto.setAppId(synchTypeDto.getAppId());
			logDto.setSynchType(synchType);
			/*************同步日志信息***end***********/
			
			try {
				UumsOrgDept orgDept = formatOrgDeptDto(synchDto, operType);
				if(orgDept == null){
					continue;
				}
				orgList.add(orgDept);
				
				int row = 0;
				if("db".equals(synchTypeDto.getSynchType())){//数据库同步方式
					row = orgUserDao.insertOrgUserIntoApp(orgDept, mappList, synchTypeDto, "org");
					
				}else if("ldap".equals(synchTypeDto.getSynchType())){//LDAP同步方式
					row = insertOrgDeptIntoAppByLdap(orgDept, mappList, synchTypeDto, operType);
					
				}else if("webservice".equals(synchTypeDto.getSynchType())){//WEB SERVICE同步方式
					row = wsOrgUserDao.synchOrg(orgDept, mappList, synchTypeDto);
					
				}
				
				//更新同步状态
				if(row >= 1){
					this.saveSynchLog(synchDto, "1", synchType);
				}else{
					this.saveSynchLog(synchDto, "2", synchType);
				}
				
				//记录同步成功日志
				logDto.setSynchFlag("1");
				logList.add(logDto);
			} catch (Exception e) {
				//记录同步失败日志
				logDto.setSynchFlag("0");
				logDto.setFaildCause(e.getMessage());
				logList.add(logDto);
			}
		}
		//保存同步日志,多线程执行
		logSynchOrgService.setOrgList(orgList);
		logSynchOrgService.setLogList(logList);
		workerThreadPool.submitCall(logSynchOrgService, WorkerThreadPool.Priority.NORMAL);
	}
	
	private UumsOrgDept formatOrgDeptDto(UumsOrgSynchRecordDTO synchDto, String operType) throws Exception{
		UumsOrgDept orgDept;
		if(!"3".equals(operType)){//非删除操作下才能查询到组织部门信息
			if("1".equals(synchDto.getOrgOrDept())){
				SysOrg org = sysOrgApi.getSysOrgBySysOrgId(synchDto.getSysOrgId());
				if(org == null){
					this.saveSynchLog(synchDto, "1", synchType);
					return null;
				}
				orgDept = this.convertOrgDeptDto(org, operType);
			}else{
				SysDept dept = sysDeptApi.getSysDeptBySysDeptId(synchDto.getSysOrgId());
				if(dept == null){
					this.saveSynchLog(synchDto, "1", synchType);
					return null;
				}
				orgDept = this.convertOrgDeptDto(dept, operType);
			}
		}else{
			orgDept = new UumsOrgDept();
			orgDept.setDeptName(synchDto.getOrgName());
			orgDept.setDeptCode(synchDto.getOrgCode());
			orgDept.setOperFlag("3");
			orgDept.setSynchTime(DateUtil.getToday());
			orgDept.setOrgOrDept(synchDto.getOrgOrDept());
		}
		return orgDept;
	}
	
	/**
	 * 更新同步状态
	 * @param synchDto
	 * @param synchFlag 同步结果，1-成功，0-失败
	 * @param synchType 同步操作类型：1-手工同步，2-自动同步
	 * @throws Exception
	 */
	private void saveSynchLog(UumsOrgSynchRecordDTO synchDto, String synchFlag, String synchType)throws Exception{
		synchDto.setSynchFlag(synchFlag);
		synchDto.setSynchTime(new Date());
		synchDto.setSynchType(synchType);
		orgSynchRecordService.updateUumsOrgSynchRecordSensitive(synchDto);
	}
	
	
	/**
	 * LDAP同步方式同步组织和部门数据到应用系统
	 * @param orgDept UumsOrgDept 组织和部门对象
	 * @param mappList List<UumsSynchOrgUserMapperDTO> 应用系统同步映射信息
	 * @param jdbcTemplate JdbcTemplate 
	 * @param tableName 应用系统组织和部门表CODE
	 * @param operType 操作类型：1-新增，2-更新，3-删除
	 * @throws Exception
	 * @return 
	 */
	private int insertOrgDeptIntoAppByLdap(UumsOrgDept orgDept, List<UumsSynchOrgUserMapperDTO> mappList, 
			UumsSynchTypeConfigDTO synchTypeDto, String operType) throws Exception{
		if("3".equals(operType)){
			return ldapDao.delete(orgDept, synchTypeDto, mappList);
		}else{
			return ldapDao.addOrUpdate(orgDept, mappList, synchTypeDto);
		}
	}
	
	/**
	 * 排序，新增或修改操作时应该降序调用即先增加父组织，删除操作时应该升序调用即先删除子组织。
	 * @param List<UumsOrgSynchRecordDTO>
	 * @param orderType 排序类型：升序-asc，降序-desc
	 * @return
	 */
	private List<UumsOrgSynchRecordDTO> sortOrgDeptList(List<UumsOrgSynchRecordDTO> orgSynchRecordList, String orderType){
		if(orgSynchRecordList.size() == 0){
			return orgSynchRecordList;
		}
		List<UumsOrgSynchRecordDTO> sortDeptList = new ArrayList<UumsOrgSynchRecordDTO>();
		int index = 0;
		int size = orgSynchRecordList.size();
		for(int i=0; i<size; i++){
			UumsOrgSynchRecordDTO deptO = orgSynchRecordList.get(0);
			sortDeptList.add(i, deptO);
			index = 0;
			for(int j=0; j<orgSynchRecordList.size(); j++){
				UumsOrgSynchRecordDTO deptI = orgSynchRecordList.get(j);
				if("desc".equals(orderType)){
					if((deptI.getSysOrgId()).equals((sortDeptList.get(i)).getParentOrgCode())){
						sortDeptList.remove(i);
						sortDeptList.add(i, deptI);
						index = j;
					}
				}else{
					if((deptI.getParentOrgCode()).equals((sortDeptList.get(i)).getSysOrgId())){
						sortDeptList.remove(i);
						sortDeptList.add(i, deptI);
						index = j;
					}
				}
			}
			orgSynchRecordList.remove(index);
		}
		return sortDeptList;
	}

	/**
	 * 初始化所有组织数据到应用系统
	 * @param appCode 应用系统编码
	 * @param synchType 同步操作类型：1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception 
	 */
	@Override
	public void initAllOrgDeptToAppByAppCode(String appCode, String synchType, String operator) throws Exception {
		Assert.notNull(appCode, "传入参数appCode不能为空！");
		appSysService = getAppSysServiceInstance();
		UumsAppSysDTO appSys = appSysService.queryUumsAppSysByAppCode(appCode);
		if(appSys != null){
			initAllOrgDeptToAppByAppId(appSys.getId(), synchType, operator);
		}
	}

	/**
	 * 同步新增、更新、删除的组织到应用系统
	 * @param appCode 应用系统编码
	 * @param synchType 同步操作类型：1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception 
	 */
	@Override
	public void synchAllOrgDeptToAppByAppCode(String appCode, String synchType, String operator)
			throws Exception {
		Assert.notNull(appCode, "传入参数appCode不能为空！");
		appSysService = getAppSysServiceInstance();
		UumsAppSysDTO appSys = appSysService.queryUumsAppSysByAppCode(appCode);
		if(appSys != null){
			synchAllOrgDeptToAppByAppId(appSys.getId(), synchType, operator);
		}
	}

	/**
	 * 同步新增组织到应用系统
	 * @param appCode 应用系统编码
	 * @param synchType 同步操作类型：1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception 
	 */
	@Override
	public void synchInsertedOrgDeptToAppByAppCode(String appCode,
			String synchType, String operator) throws Exception {
		Assert.notNull(appCode, "传入参数appCode不能为空！");
		appSysService = getAppSysServiceInstance();
		UumsAppSysDTO appSys = appSysService.queryUumsAppSysByAppCode(appCode);
		if(appSys != null){
			synchInsertedOrgDeptToAppByAppId(appSys.getId(), synchType, operator);
		}
	}

	/**
	 * 同步已更新组织到应用系统
	 * @param appCode 应用系统编码
	 * @param synchType 同步操作类型：1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception 
	 */
	@Override
	public void synchUpdatedOrgDeptToAppByAppCode(String appCode,
			String synchType, String operator) throws Exception {
		Assert.notNull(appCode, "传入参数appCode不能为空！");
		appSysService = getAppSysServiceInstance();
		UumsAppSysDTO appSys = appSysService.queryUumsAppSysByAppCode(appCode);
		if(appSys != null){
			synchUpdatedOrgDeptToAppByAppId(appSys.getId(), synchType, operator);
		}
	}

	/**
	 * 同步已删除组织到应用系统
	 * @param appCode 应用系统编码
	 * @param synchType 同步操作类型：1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception 
	 */
	@Override
	public void synchDeletedOrgDeptToAppByAppCode(String appCode,
			String synchType, String operator) throws Exception {
		Assert.notNull(appCode, "传入参数appCode不能为空！");
		appSysService = getAppSysServiceInstance();
		UumsAppSysDTO appSys = appSysService.queryUumsAppSysByAppCode(appCode);
		if(appSys != null){
			synchDeletedOrgDeptToAppByAppId(appSys.getId(), synchType, operator);
		}
	}
	
	private UumsAppSysService getAppSysServiceInstance(){
		if (appSysService == null){
			return SpringFactory.getBean(UumsAppSysService.class);
		}
		return appSysService;
	}
	
	private void setProperties(String synchType, String operator){
		if(StringUtils.isEmpty(synchType)){
			this.setSynchType("2");
		}else{
			this.setSynchType(synchType);
		}
		if(StringUtils.isEmpty(operator)){
			this.setOperator("系统管理员");
		}else{
			this.setOperator(operator);
		}
	}
}
