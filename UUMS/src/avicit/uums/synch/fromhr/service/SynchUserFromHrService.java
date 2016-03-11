package avicit.uums.synch.fromhr.service;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import avicit.platform6.api.session.SessionHelper;
import avicit.platform6.api.session.SessionParam;
import avicit.platform6.api.sysuser.SysDeptAPI;
import avicit.platform6.api.sysuser.SysUserAPI;
import avicit.platform6.api.sysuser.dto.SysDept;
import avicit.platform6.api.sysuser.dto.SysUser;
import avicit.platform6.api.sysuser.dto.SysUserVo;
import avicit.platform6.commons.utils.ComUtil;
import avicit.platform6.commons.utils.PojoUtil;
import avicit.platform6.core.rest.msg.Muti2Bean;
import avicit.platform6.core.rest.msg.Muti3Bean;
import avicit.platform6.core.threadPool.WorkerThreadPool;
import avicit.platform6.modules.system.sysorguser.sysuser.service.SysUserEvent;
import avicit.platform6.modules.system.sysorguser.sysuser.service.SysUserService;
import avicit.uums.appsys.register.uumsappsys.dto.UumsAppSysDTO;
import avicit.uums.appsys.register.uumsappsys.service.UumsAppSysService;
import avicit.uums.appsys.synchconfig.uumssynchtypeconfig.dto.UumsSynchOrgUserMapperDTO;
import avicit.uums.appsys.synchconfig.uumssynchtypeconfig.dto.UumsSynchTypeConfigDTO;
import avicit.uums.appsys.synchconfig.uumssynchtypeconfig.service.UumsSynchOrgUserMapperService;
import avicit.uums.appsys.synchconfig.uumssynchtypeconfig.service.UumsSynchTypeConfigService;
import avicit.uums.synch.fromhr.dao.SynchUserFromHrDao;
import avicit.uums.synch.fromhr.dto.UumsUserCache;
import avicit.uums.synch.fromhr.rest.SynchUserFromHrRestClient;
import avicit.uums.synch.log.userlog.uumslogsynchuser.dto.UumsLogSynchUserDTO;
import avicit.uums.synch.log.userlog.uumslogsynchuser.service.UumsLogSynchUserService;
import avicit.uums.synch.toappsys.dto.UumsUser;
/**
 * 从权威数据源HR同步用户数据Service类
 * @author miaoyu
 * @since 2016-3-3
 *
 */
@Service
public class SynchUserFromHrService implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static final Logger logger =  LoggerFactory.getLogger(SynchUserFromHrService.class);
	@Autowired
	private UumsAppSysService appSysService;
	@Autowired
	private UumsSynchOrgUserMapperService synchOrgUserMapperService;
	@Autowired
	private UumsSynchTypeConfigService synchTypeConfigService;
	@Autowired
	private SysDeptAPI sysDeptApi;
	@Autowired
	private SysUserAPI sysUserApi;
	@Autowired
	private SynchUserFromHrRestClient restClient;
	@Autowired
	private SynchUserFromHrDao dao;
	@Autowired
	private SysUserService sysUserService;
	private String appId;
	@Autowired
	private WorkerThreadPool workerThreadPool; 
	@Autowired
	private UumsLogSynchUserService logSynchUserService;
	
	public String getAppId() {
		return appId;
	}

	public void setAppId(String appId) {
		this.appId = appId;
	}

	/**
	 * 从HR同步所有新增、修改和删除操作的用户
	 * @param synchType 同步操作类型，1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception
	 */
	public void synchUserFromHr(String synchType, String operator) throws Exception{
		try {
			// 新增用户
			this.saveSysUser(synchType, operator);
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			// 更新用户
			this.updateSysUser(synchType, operator);
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			// 删除用户
			this.deleteSysUser(synchType, operator);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	/**
	 * 从HR同步所有新增的用户
	 * @param synchType 同步操作类型，1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @return
	 * @throws Exception
	 */
	public boolean saveSysUser(String synchType, String operator) throws Exception{
		try {
			List<UumsUser> userList = this.synchUserFromHr("1");
			if(userList == null){
				return false;
			}
			List<Object[]> resultList = new ArrayList<Object[]>();
			List<UumsLogSynchUserDTO> logList = new ArrayList<UumsLogSynchUserDTO>();
			for(UumsUser user : userList){
				/*************同步日志信息***begin***********/
				UumsLogSynchUserDTO logDto = new UumsLogSynchUserDTO();
				logDto.setOperator(operator);
				logDto.setAppId(this.getAppId());
				logDto.setSynchType(synchType);
				/*************同步日志信息***end***********/
				try {
					//把用户照片加载到缓存中
					if(user.getPhoto() != null){
						UumsUserCache.PHOTO_CAHCHE.put(user.getNo(), user.getPhoto());
					}
					SysUser sysUser = sysUserApi.getSysUserByUnitCode(user.getUnitCode());
					if (sysUser != null) {// 如果用户存在则更新
						PojoUtil.copyProperties(sysUser, user, true);
						this.insertUpdateSysUser(sysUser, "update");
					} else {// 如果用户不存在则新增
						user = setSysUserProperties(user);
						// 同步用户数据到UUMS数据库中
						this.insertUpdateSysUser(user, "insert");
					}
					
//					//单独保存照片
//					if(user.getPhoto() != null){
//						try {
//							avicit.platform6.modules.system.sysorguser.sysuser.domain.SysUser sysUserVo = new avicit.platform6.modules.system.sysorguser.sysuser.domain.SysUser();
//							PojoUtil.copyProperties(sysUserVo, user, true);
//							sysUserService.updateSysUser(sysUserVo);
//						} catch (Exception e) {
//							logger.error("保存用户【"+ user.getNo() +"】照片失败：" + e.getMessage());
//						}
//					}
					
					// 记录同步成功的组织ID
					resultList.add(new Object[]{ user.getSid() });
					//记录同步日志
					logDto.setSynchFlag("1");
					logList.add(logDto);
				} catch (Exception e) {
					logDto.setSynchFlag("0");
					logDto.setFaildCause(e.getMessage());
					logList.add(logDto);
					logger.error("从HR同步新增的用户【" + user.getNo() +"】失败：" + e.getMessage());
				}
			}
			
			//更新HR组织表中的同步状态
			updateSynchFlagToHr(resultList);
			//保存同步日志,多线程执行
			logSynchUserService.setUserList(userList);
			logSynchUserService.setLogList(logList);
			workerThreadPool.submitCall(logSynchUserService, WorkerThreadPool.Priority.NORMAL);
			
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("从权威数据源HR系统同步新增用户失败："+e.getMessage());
		}
	}
	
	/**
	 * 同步新增用户属性赋值
	 * @param user
	 * @return
	 */
	private UumsUser setSysUserProperties(UumsUser user){
		String deptId = sysDeptApi.getSysDeptIdByDeptCode(user.getDeptCode());
		if(StringUtils.isEmpty(deptId)){
			// 放在临时部门下
			SysDept deptTemp = sysDeptApi.getSysDeptBySysDeptId(sysDeptApi.getSysDeptIdByDeptCode("DEPT_TEMP"));
			user.setDeptId(deptTemp.getId());
			user.setDeptName(deptTemp.getDeptName());
		}else{
			SysDept dept = sysDeptApi.getSysDeptBySysDeptId(deptId);
			user.setDeptId(dept.getId());
			user.setDeptName(dept.getDeptName());
		}
		user.setId(ComUtil.getId());
		user.setLoginName(user.getNo());// 需要考虑变更
		user.setPositionId("1"); // 默认岗位为：普通员工
		// 密级代码必填
		if(StringUtils.isEmpty(user.getSecretLevel())){
			user.setSecretLevel("1"); // 默认为非涉密人员
		}
		user.setRuleId("8a58ab5f4be29ef7014be2d442bd01ab"); // 默认角色为：一般用户
		user.setRuleName("一般用户");
		user.setType("0"); // 类型为自定义用户
		user.setLanguageCode("zh_CN");
		//user.setSex("1"); // 性别，1-男，2-女
		//user.setStatus("1"); // 用户状态，1-有效，3-无效
		// 集团统一编码为必填，如果为空则默认为用户编号
		if(StringUtils.isEmpty(user.getUnitCode())){
			user.setUnitCode(user.getNo());
		}
		
		return user;
	}
	
	/**
	 * 从HR同步所有更新的用户
	 * @param synchType 同步操作类型，1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @return
	 * @throws Exception
	 */
	public boolean updateSysUser(String synchType, String operator) throws Exception{
		try {
			List<UumsUser> userList = this.synchUserFromHr("2");
			if(userList == null){
				return false;
			}
			List<Object[]> resultList = new ArrayList<Object[]>();
			List<UumsLogSynchUserDTO> logList = new ArrayList<UumsLogSynchUserDTO>();
			for(UumsUser user : userList){
				/*************同步日志信息***begin***********/
				UumsLogSynchUserDTO logDto = new UumsLogSynchUserDTO();
				logDto.setOperator(operator);
				logDto.setAppId(this.getAppId());
				logDto.setSynchType(synchType);
				/*************同步日志信息***end***********/
				try {
					SysUser sysUser = sysUserApi.getSysUserByUnitCode(user.getUnitCode());
					if (sysUser != null) {// 如果用户存在则更新
						PojoUtil.copyProperties(sysUser, user, true);
						this.insertUpdateSysUser(sysUser, "update");
					} else {// 如果用户不存在则新增
						user = setSysUserProperties(user);
						// 同步用户数据到UUMS数据库中
						this.insertUpdateSysUser(user, "insert");
					}
					
					// 记录同步成功的组织ID
					resultList.add(new Object[]{ user.getSid() });
					//记录同步日志
					logDto.setSynchFlag("1");
					logList.add(logDto);
				} catch (Exception e) {
					logDto.setSynchFlag("0");
					logDto.setFaildCause(e.getMessage());
					logList.add(logDto);
					logger.error("从HR同步更新的用户【" + user.getNo() +"】失败：" + e.getMessage());
				}
			}
			
			//更新HR组织表中的同步状态
			updateSynchFlagToHr(resultList);
			
			//保存同步日志,多线程执行
			logSynchUserService.setUserList(userList);
			logSynchUserService.setLogList(logList);
			workerThreadPool.submitCall(logSynchUserService, WorkerThreadPool.Priority.NORMAL);
			
			return true;
		} catch (Exception e) {
			throw new Exception("从权威数据源HR系统同步更新用户失败："+e.getMessage());
		}
	}
	
	/**
	 * 从HR同步所有删除的用户
	 * @param synchType 同步操作类型，1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @return
	 * @throws Exception
	 */
	public boolean deleteSysUser(String synchType, String operator) throws Exception{
		try {
			List<UumsUser> userList = this.synchUserFromHr("3");
			if(userList == null){
				return false;
			}
			List<Object[]> resultList = new ArrayList<Object[]>();
			List<UumsLogSynchUserDTO> logList = new ArrayList<UumsLogSynchUserDTO>();
			List<UumsUser> userLogList = new ArrayList<UumsUser>();
			for(UumsUser user : userList){
				/*************同步日志信息***begin***********/
				UumsLogSynchUserDTO logDto = new UumsLogSynchUserDTO();
				logDto.setOperator(operator);
				logDto.setAppId(this.getAppId());
				logDto.setSynchType(synchType);
				/*************同步日志信息***end***********/
				try {
					SysUser sysUser = sysUserApi.getSysUserByUnitCode(user.getUnitCode());
					if(sysUser != null){
						String userId = sysUser.getId();
						String userDeptId = sysUser.getDeptId();
						this.deleteSysUsers(new String[]{ userId }, new String[]{ userDeptId });
						
						// 记录同步成功的组织ID
						resultList.add(new Object[]{ user.getSid() });
						//记录同步日志
						logDto.setSynchFlag("1");
						logList.add(logDto);
						PojoUtil.copyProperties(user, sysUser, true);
						userLogList.add(user);
					}
				} catch (Exception e) {
					logDto.setSynchFlag("0");
					logDto.setFaildCause(e.getMessage());
					logList.add(logDto);
					logger.error("从HR同步删除的用户【" + user.getNo() +"】失败：" + e.getMessage());
				}
			}
			// 批量删除用户
			//this.deleteSysUsers(userIds, userDeptIds);
			//更新HR组织表中的同步状态
			updateSynchFlagToHr(resultList);
			
			//保存同步日志,多线程执行
			logSynchUserService.setUserList(userLogList);
			logSynchUserService.setLogList(logList);
			workerThreadPool.submitCall(logSynchUserService, WorkerThreadPool.Priority.NORMAL);
			
			return true;
		} catch (Exception e) {
			throw new Exception("从权威数据源HR系统同步删除用户失败："+e.getMessage());
		}
	}
	
	/**
	 * 更新权威数据源HR组织表的同步状态
	 * @param deptList
	 */
	private void updateSynchFlagToHr(List<Object[]> userIdList){
		if(userIdList.size() == 0){
			return;
		}
		try {
			UumsAppSysDTO appsysDto= appSysService.queryHrAppSys();
			if(appsysDto != null){
				UumsSynchTypeConfigDTO synchTypeDto = synchTypeConfigService.queryUumsSynchTypeConfigByAppId(appsysDto.getId());
				if(synchTypeDto != null){
					List<UumsSynchOrgUserMapperDTO> mappList = synchOrgUserMapperService.queryUumsSynchOrgUserMapperByPidMaintypeColCode(synchTypeDto.getId(), "UUMS_ORG");
					
					dao.updateSynchFlagToHr(userIdList, synchTypeDto, mappList);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("更新权威数据源HR组织表的同步状态时错误：" + e.getMessage());
		}
	}
	
	private List<UumsUser> synchUserFromHr(String operType)throws Exception{
		UumsAppSysDTO appsysDto= appSysService.queryHrAppSys();
		if(appsysDto != null){
			this.setAppId(appsysDto.getId());
			UumsSynchTypeConfigDTO synchTypeDto = synchTypeConfigService.queryUumsSynchTypeConfigByAppId(appsysDto.getId());
			if(synchTypeDto != null){
				List<UumsSynchOrgUserMapperDTO> mappList = synchOrgUserMapperService.queryUumsSynchOrgUserMapperByPidMaintypeColCode(synchTypeDto.getId(), "UUMS_USER");
				
				List<UumsUser> userList = dao.synchUserFromHr(synchTypeDto, mappList, operType);
				
				return userList;
			}else{
				return null;
			}
		}else{
			return null;
		}
	}
	/**
	 * 新增或更新用户
	 * @param syUserVo
	 * @param operType insert-新增，update-更新
	 * @throws Exception
	 */
	private void insertUpdateSysUser(SysUser syUserVo, String operType) throws Exception{
		try {
			HashMap<String, Object> sessionParam = new HashMap<String, Object>();
			sessionParam.put(SessionParam.applicationId, SessionHelper.getApplicationId());
			
			if(syUserVo == null){
				return;
			}
			
			if("insert".equals(operType)){
				Muti2Bean<SysUser, String> parameterbean = new Muti2Bean<SysUser, String>();
				parameterbean.setDto1(syUserVo);
				parameterbean.setDto2(SessionHelper.getApplicationId());
				restClient.insertUserInfoRest(parameterbean);
			}else{
				Muti3Bean<SysUser, Map<String, Object>, Void> parameterbean = new Muti3Bean<SysUser, Map<String, Object>, Void>();
				parameterbean.setDto1(syUserVo);
				parameterbean.setDto2(sessionParam);
				restClient.updateUserInfoRest(parameterbean);
			}
		} catch (Exception e) {
			throw e;
		}
	}
	
	private void deleteSysUsers(String[] userIds, String[] userDeptIds) throws Exception{
		try {
			Muti3Bean<String[], String[], Void> parameterbean = new Muti3Bean<String[], String[], Void>();
			parameterbean.setDto1(userIds);
			parameterbean.setDto2(userDeptIds);
			
			restClient.deleteOperationsRest(parameterbean);
		} catch (Exception e) {
			throw e;
		}
	}
	
}
