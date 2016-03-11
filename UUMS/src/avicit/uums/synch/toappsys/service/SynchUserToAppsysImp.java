package avicit.uums.synch.toappsys.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import avicit.platform6.api.syspermissionresource.permissionanalysis.core.support.LoaderConstant;
import avicit.platform6.api.sysuser.dto.SysDept;
import avicit.platform6.api.sysuser.dto.SysUser;
import avicit.platform6.api.sysuser.dto.SysUserDeptPosition;
import avicit.platform6.commons.utils.PojoUtil;
import avicit.platform6.core.rest.msg.Muti3Bean;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.spring.SpringFactory;
import avicit.platform6.core.threadPool.WorkerThreadPool;
import avicit.uums.appsys.register.uumsappsys.dto.UumsAppSysDTO;
import avicit.uums.appsys.register.uumsappsys.service.UumsAppSysService;
import avicit.uums.appsys.synchconfig.uumssynchtypeconfig.dto.UumsSynchOrgUserMapperDTO;
import avicit.uums.appsys.synchconfig.uumssynchtypeconfig.dto.UumsSynchTypeConfigDTO;
import avicit.uums.appsys.synchconfig.uumssynchtypeconfig.service.UumsSynchTypeConfigService;
import avicit.uums.permission.synch.uumsuserapppermissions.dto.UumsUserAppPermissionsDTO;
import avicit.uums.permission.synch.uumsuserapppermissions.service.UumsUserAppPermissionsService;
import avicit.uums.synch.log.userlog.uumslogsynchuser.dto.UumsLogSynchUserDTO;
import avicit.uums.synch.log.userlog.uumslogsynchuser.service.UumsLogSynchUserService;
import avicit.uums.synch.toappsys.dao.DbOrgUserDao;
import avicit.uums.synch.toappsys.dao.LdapUserDao;
import avicit.uums.synch.toappsys.dao.WsOrgUserDao;
import avicit.uums.synch.toappsys.dto.UumsUser;

/**
 * 用户数据同步实现类
 * @author miaoyu
 * @since 2016年1月9日
 *
 */
@Service
public class SynchUserToAppsysImp implements SynchUserToAppsys, LoaderConstant {
	private static final Logger logger = LoggerFactory
			.getLogger(SynchUserToAppsysImp.class);
	@Autowired
	private UumsAppSysService appSysService;
	@Autowired
	private UumsSynchTypeConfigService synchTypeConfigService;
	@Autowired
	private UumsUserAppPermissionsService permissionsService;
	@Autowired
	private LdapUserDao ldapDao;
	@Autowired
	private DbOrgUserDao orgUserDao;
	@Autowired
	private WsOrgUserDao wsOrgUserDao;
	@Autowired
	private WorkerThreadPool workerThreadPool;
	@Autowired
	private UumsLogSynchUserService logSynchUserService;
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
	 * 初始化所有用户数据到应用系统
	 * @param appId 应用系统ID
	 * @throws Exception 
	 */
	public void initAllUserToAppByAppId(String appId) throws Exception {
		Assert.notNull(appId, "传入参数应用系统ID无效:NULL");
		UumsAppSysDTO app = appSysService.queryUumsAppSysByPrimaryKey(appId);
		
		//只有允许自动创建账号的应用系统才可以进行用户初始化
		if("N".equals(app.getIsAutoCreateAccount())){
			throw new Exception("初始化失败：系统不允许自动创建账号！");
		}
		
		//查询系统所有用户并过滤掉平台三员和平台管理员
		//List<SysUser> userList = sysUserLoader.getAllSysUsers();
		String hql = "from SysUser t where t.no not in(?,?,?,?)";
		List<SysUser> userList = sysUserLoader.getSysUserByHQL(hql, new String[]{"admin", "sysadmin", "safeaudi", "safeadmin"});
		Assert.notEmpty(userList, "初始化失败：无系统用户数据！");
		for(SysUser user : userList){
			UumsUserAppPermissionsDTO permission = new UumsUserAppPermissionsDTO();
			permission.setActFlag("0");//活动状态默认为：禁止
			permission.setAppId(appId);
			permission.setAuditFlag("3");
			permission.setOperFlag("1");
			permission.setSynchFlag("0");
			permission.setUserId(user.getId());
			
			permissionsService.insertOrUpdatePermission(permission, false);
		}
	}

	/**
	 * 同步所有新增、更新、删除的用户到已注册的应用系统中
	 * @param synchType 同步操作类型：1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception
	 */
	public void synchAllUserToAppByAllApp(String synchType, String operator) throws Exception {
		try {
			UumsAppSysDTO uumsAppSysDTO = new UumsAppSysDTO();
			QueryReqBean<UumsAppSysDTO> queryReqBean = new QueryReqBean<UumsAppSysDTO>();
			queryReqBean.setSearchParams(uumsAppSysDTO);
			List<UumsAppSysDTO> appList = appSysService.searchUumsAppSys(queryReqBean);
			Assert.notEmpty(appList, "获取所有已注册的应用系统失败！");
			
			for(UumsAppSysDTO app : appList){
				synchAllUserToAppByAppId(app.getId(), synchType, operator);
			}
			
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new Exception("执行synchAllUserToAppByAllApp时出错：" + e.getMessage());
		}
	}

	/**
	 * 同步新增、更新、删除的用户到应用系统
	 * @param appId 应用系统ID
	 * @param synchType 同步操作类型：1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception 
	 */
	public void synchAllUserToAppByAppId(String appId, String synchType, String operator)
			throws Exception {
		try {
			//同步新增
			synchInsertedUserToAppByAppId(appId, synchType, operator);
			//同步更新
			synchUpdatedUserToAppByAppId(appId, synchType, operator);
			//同步删除
			synchDeletedUserToAppByAppId(appId, synchType, operator);
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new Exception("执行synchAllUserToAppByAppid时出错：" + e.getMessage());
		}
	}

	/**
	 * 同步新增用户到应用系统
	 * @param appId 应用系统ID
	 * @param synchType 同步操作类型：1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception 
	 */
	public void synchInsertedUserToAppByAppId(String appId, String synchType, String operator)
			throws Exception {
		this.setProperties(synchType, operator);
		this.synchUserToAppByAppid(appId, "1");
	}

	/**
	 * 同步已更新用户到应用系统
	 * @param appId 应用系统ID
	 * @param synchType 同步操作类型：1-手工同步，2-自动同步
	 * @throws Exception 
	 */
	public void synchUpdatedUserToAppByAppId(String appId, String synchType, String operator)
			throws Exception {
		this.setProperties(synchType, operator);
		this.synchUserToAppByAppid(appId, "2");
	}

	/**
	 * 同步已删除用户到应用系统
	 * @param appId 应用系统ID
	 * @param synchType 同步操作类型：1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception 
	 */
	public void synchDeletedUserToAppByAppId(String appId, String synchType, String operator)
			throws Exception {
		this.setProperties(synchType, operator);
		this.synchUserToAppByAppid(appId, "3");
	}
	
	/**
	 * 同步新增、更新、删除的组织部门数据到应用系统
	 * @param appId 应用系统ID
	 * @param operType 操作类型：1-新增，2-更新，3-删除
	 * @param synchType 同步操作类型：1-手工同步，2-自动同步
	 * @throws Exception
	 */
	private void synchUserToAppByAppid(String appId, String operType)throws Exception{
		List<UumsUserAppPermissionsDTO> perList = this.searchPermission(appId, operType);
		
		Map<String, Object> confMap = synchTypeConfigService.getSynchConfigInfoMapByAppid(appId, "UUMS_USER");
		UumsSynchTypeConfigDTO synchTypeDto = (UumsSynchTypeConfigDTO)confMap.get("synchType");
		@SuppressWarnings("unchecked")
		List<UumsSynchOrgUserMapperDTO> mappList = (List<UumsSynchOrgUserMapperDTO>)confMap.get("mapperList");
		List<UumsLogSynchUserDTO> logList = new ArrayList<UumsLogSynchUserDTO>();
		List<UumsUser> userList = new ArrayList<UumsUser>();
		for(UumsUserAppPermissionsDTO perm : perList){
			/*************同步日志信息***begin***********/
			UumsLogSynchUserDTO logDto = new UumsLogSynchUserDTO();
			logDto.setOperator(operator);
			logDto.setAppId(synchTypeDto.getAppId());
			logDto.setSynchType(synchType);
			/*************同步日志信息***end***********/
			
			try {
				int row = synchUserToAppSys(perm, operType, userList, synchTypeDto, mappList);
				
				//更新同步日志
				if(row == 1){//同步成功
					if(!"3".equals(operType)){//新增或更新操作
						perm.setActFlag("1");//活动状态：活动
					}else{//删除操作
						perm.setActFlag("0");//活动状态：禁止
					}
					this.saveSynchUserLog(perm, "1", synchType);
					
					//记录同步成功日志
					logDto.setSynchFlag("1");
					logList.add(logDto);
				}else{//同步失败
					this.saveSynchUserLog(perm, "0", synchType);
					//记录同步失败日志
					logDto.setSynchFlag("0");
					logDto.setFaildCause("未知错误！");
					logList.add(logDto);
				}
			} catch (Exception e) {
				//记录同步失败日志
				logDto.setSynchFlag("0");
				logDto.setFaildCause(e.getMessage());
				logList.add(logDto);
			}
		}
		//保存同步日志,多线程执行
		logSynchUserService.setUserList(userList);
		logSynchUserService.setLogList(logList);
		workerThreadPool.submitCall(logSynchUserService, WorkerThreadPool.Priority.NORMAL);
	}
	
	private int synchUserToAppSys(UumsUserAppPermissionsDTO perm, String operType, List<UumsUser> userList,
			UumsSynchTypeConfigDTO synchTypeDto, List<UumsSynchOrgUserMapperDTO> mappList) throws Exception{
		UumsUser uumsUser = new UumsUser();
		if(!"3".equals(operType)){//非删除操作下才能查询到组织部门信息
			//SysUser sysUser = sysUserLoader.getSysUserById(perm.getUserId());
			//获取用户信息，附带照片数据
			Muti3Bean<SysUser,byte[],byte[]> resut= sysUserLoader.getSysUserByIdforupload(perm.getUserId());
			SysUser sysUser = resut.getDto1();
			uumsUser.setUumsPhoto(resut.getDto2());
			
			SysDept dept = sysUserDeptPositionLoader.getChiefDeptBySysUserId(perm.getUserId());
			SysUserDeptPosition dp = sysUserDeptPositionLoader.getModelByUserIdAndDeptId(perm.getUserId(), dept.getId());
			PojoUtil.copyProperties(uumsUser, sysUser);
			uumsUser.setDeptCode(dept.getDeptCode());
			uumsUser.setIsManager(dp.getIsManager());
			
			if(sysUser == null){
				this.saveSynchUserLog(perm, "1", synchType);
				return 0;
			}
		}else{
			// 删除同步
			uumsUser.setName(perm.getUserName());
			uumsUser.setLoginName(perm.getUnitCode());
			uumsUser.setUnitCode(perm.getUnitCode());
			uumsUser.setNo(perm.getUnitCode());
		}
		uumsUser.setSynchTime(new Date());
		uumsUser.setOperFlag(operType);
		userList.add(uumsUser);
		
		int row = 0;
		if("db".equals(synchTypeDto.getSynchType())){//数据库同步方式
			//row = insertUserIntoAppByDB(uumsUser, mappList, synchTypeDto);
			row = orgUserDao.insertOrgUserIntoApp(uumsUser, mappList, synchTypeDto, "user");
			
		}else if("ldap".equals(synchTypeDto.getSynchType())){//LDAP同步方式
			row = insertUserAppByLdap(uumsUser, mappList, synchTypeDto, operType);
			
		}else if("webservice".equals(synchTypeDto.getSynchType())){//WEB SERVICE同步方式
			row = wsOrgUserDao.synchUser(uumsUser, mappList, synchTypeDto);
			
		}
		return row;
	}
	/**
	 * 查询应用系统未同步且审批通过或不需要审批的用户权限
	 * @param appId 应用系统ID
	 * @param operType 操作类型：1-新增，2-更新，3-删除，null-所有未同步
	 * @return
	 * @throws Exception
	 */
	private List<UumsUserAppPermissionsDTO> searchPermission(String appId, String operType) throws Exception{
		QueryReqBean<UumsUserAppPermissionsDTO> queryReqBean = new QueryReqBean<UumsUserAppPermissionsDTO>();
		UumsUserAppPermissionsDTO serchParameter = new UumsUserAppPermissionsDTO();
		serchParameter.setAppId(appId);
		serchParameter.setOperFlag(operType);
		serchParameter.setSynchFlag("0");
		serchParameter.setAuditFlag("2");
		queryReqBean.setSearchParams(serchParameter);
		//查询未同步且审批通过的用户权限
		List<UumsUserAppPermissionsDTO> p1List = permissionsService.searchUumsUserAppPermissions(queryReqBean);
		//查询未同步且不需要审批的用户权限
		serchParameter.setAuditFlag("3");
		List<UumsUserAppPermissionsDTO> p2List = permissionsService.searchUumsUserAppPermissions(queryReqBean);
		//合并数据
		for(UumsUserAppPermissionsDTO dto : p2List){
			p1List.add(dto);
		}
		
		return p1List;
	}

	/**
	 * 更新同步状态
	 * @param perm
	 * @param synchFlag 同步结果，1-成功，0-失败
	 * @param synchType 同步操作类型：1-手工同步，2-自动同步
	 * @throws Exception
	 */
	private void saveSynchUserLog(UumsUserAppPermissionsDTO perm, String synchFlag, String synchType)throws Exception{
		perm.setSynchFlag(synchFlag);
		perm.setSynchTime(new Date());
		perm.setSynchType(synchType);
		permissionsService.updateUumsUserAppPermissionsSensitive(perm);
	}
	
	/**
	 * LDAP同步方式同步用户数据到应用系统
	 * @param user UumsUser 用户对象
	 * @param mappList List<UumsSynchOrgUserMapperDTO> 应用系统同步映射信息
	 * @param jdbcTemplate JdbcTemplate 
	 * @param tableName 应用系统组织和部门表CODE
	 * @param operType 操作类型：1-新增，2-更新，3-删除
	 * @throws Exception
	 * @return 
	 */
	private int insertUserAppByLdap(UumsUser user, List<UumsSynchOrgUserMapperDTO> mappList, 
			UumsSynchTypeConfigDTO synchTypeDto, String operType) throws Exception{
		if("3".equals(operType)){
			return ldapDao.delete(user, synchTypeDto, mappList);
		}else{
			return ldapDao.addOrUpdate(user, mappList, synchTypeDto);
		}
	}

	/**
	 * 初始化所有用户数据到应用系统
	 * @param appCode 应用系统编码
	 * @throws Exception 
	 */
	@Override
	public void initAllUserToAppByAppCode(String appCode) throws Exception {
		Assert.notNull(appCode, "传入参数appCode不能为空！");
		appSysService = getAppSysServiceInstance();
		UumsAppSysDTO appSys = appSysService.queryUumsAppSysByAppCode(appCode);
		if(appSys != null){
			initAllUserToAppByAppId(appSys.getId());
		}
	}

	/**
	 * 同步新增、更新、删除的用户到应用系统
	* @param appCode 应用系统编码
	 * @param synchType 同步操作类型：1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception 
	 */
	@Override
	public void synchAllUserToAppByAppCode(String appCode, String synchType, String operator)
			throws Exception {
		Assert.notNull(appCode, "传入参数appCode不能为空！");
		appSysService = getAppSysServiceInstance();
		UumsAppSysDTO appSys = appSysService.queryUumsAppSysByAppCode(appCode);
		if(appSys != null){
			synchAllUserToAppByAppId(appSys.getId(), synchType, operator);
		}
	}

	/**
	 * 同步新增用户到应用系统
	 * @param appCode 应用系统编码
	 * @param synchType 同步操作类型：1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception 
	 */
	@Override
	public void synchInsertedUserToAppByAppCode(String appCode, String synchType, String operator)
			throws Exception {
		Assert.notNull(appCode, "传入参数appCode不能为空！");
		appSysService = getAppSysServiceInstance();
		UumsAppSysDTO appSys = appSysService.queryUumsAppSysByAppCode(appCode);
		if(appSys != null){
			synchInsertedUserToAppByAppId(appSys.getId(), synchType, operator);
		}
	}

	/**
	 * 同步已更新用户到应用系统
	 * @param appCode 应用系统编码
	 * @param synchType 同步操作类型：1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception 
	 */
	@Override
	public void synchUpdatedUserToAppByAppCode(String appCode, String synchType, String operator)
			throws Exception {
		Assert.notNull(appCode, "传入参数appCode不能为空！");
		appSysService = getAppSysServiceInstance();
		UumsAppSysDTO appSys = appSysService.queryUumsAppSysByAppCode(appCode);
		if(appSys != null){
			synchUpdatedUserToAppByAppId(appSys.getId(), synchType, operator);
		}
	}

	/**
	 * 同步已删除用户到应用系统
	 * @param appCode 应用系统编码
	 * @param synchType 同步操作类型：1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception 
	 */
	@Override
	public void synchDeletedUserToAppByAppCode(String appCode, String synchType, String operator)
			throws Exception {
		Assert.notNull(appCode, "传入参数appCode不能为空！");
		appSysService = getAppSysServiceInstance();
		UumsAppSysDTO appSys = appSysService.queryUumsAppSysByAppCode(appCode);
		if(appSys != null){
			synchDeletedUserToAppByAppId(appSys.getId(), synchType, operator);
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
