package avicit.uums.permission.synch.uumsuserapppermissions.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import avicit.platform6.api.session.SessionHelper;
import avicit.platform6.api.syspermissionresource.permissionanalysis.core.support.LoaderConstant;
import avicit.platform6.api.sysuser.dto.SysDept;
import avicit.platform6.api.sysuser.dto.SysUser;
import avicit.platform6.commons.utils.JsonHelper;
import avicit.platform6.core.properties.PlatformConstant.OpResult;
import avicit.platform6.core.rest.msg.PageParameter;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.uums.appsys.register.uumsappsys.dto.UumsAppSysDTO;
import avicit.uums.appsys.register.uumsappsys.service.UumsAppSysService;
import avicit.uums.permission.synch.uumsuserapppermissions.dto.UumsUserAppPermissionsDTO;
import avicit.uums.permission.synch.uumsuserapppermissions.service.UumsUserAppPermissionsService;
import avicit.uums.permission.workflow.uumsuserappworkflow.dto.UumsPermissionWorkflowDTO;
import avicit.uums.permission.workflow.uumsuserappworkflow.service.UumsPermissionWorkflowService;
import avicit.uums.synch.toappsys.service.SynchUserToAppsys;

import com.fasterxml.jackson.core.type.TypeReference;

/**
 * @classname: UumsUserAppPermissionsController
 * @description: 定义 用户应用系统权限管理 控制层
 * @author: AVICIT DEV
 */
@Controller
@Scope("prototype")
@RequestMapping("uums/permission/synch/uumsuserapppermissions/UumsUserAppPermissionsController")
public class UumsUserAppPermissionsController implements LoaderConstant {
	private static final Logger logger = LoggerFactory
			.getLogger(UumsUserAppPermissionsController.class);

	@Autowired
	private UumsUserAppPermissionsService service;
//	@Autowired
//	private UumsUserAppWorkflowService workfolwService;
	@Autowired
	private UumsPermissionWorkflowService perWfService;
	@Autowired
	private UumsAppSysService appService;
	@Autowired
	private SynchUserToAppsys synchUserToAppsys;

	/**
	 * 跳转到管理页面
	 * 
	 * @param request
	 *            请求
	 * @param reponse
	 *            响应
	 * @return
	 */
	@RequestMapping(value = "UumsUserAppPermissionsInfo")
	public ModelAndView toUumsUserAppPermissions(HttpServletRequest request,
			HttpServletResponse reponse) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("avicit/uums/permission/synch/uumsuserapppermissions/UumsUserAppPermissionsManage");
		request.setAttribute(
				"url",
				"platform/uums/permission/synch/uumsuserapppermissions/UumsUserAppPermissionsController/operation/");
		return mav;
	}

	
	/**
	 * 查询所有应用系统用户权限并进行分页
	 * @param pageParameter
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/operation/getUumsUserAppPermissionssByPage")
	@ResponseBody
	public Map<String, Object> togetUumsUserAppPermissionsByPage(
			PageParameter pageParameter, HttpServletRequest request) {
		QueryReqBean<UumsUserAppPermissionsDTO> queryReqBean = new QueryReqBean<UumsUserAppPermissionsDTO>();
		queryReqBean.setPageParameter(pageParameter);
		HashMap<String, Object> map = new HashMap<String, Object>();
		String json = ServletRequestUtils.getStringParameter(request, "param",
				"");
		String appId  = ServletRequestUtils.getStringParameter(request, "appId",
				"");
		UumsUserAppPermissionsDTO param = null;
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		QueryRespBean<UumsUserAppPermissionsDTO> result = null;
		if (json != null && !"".equals(json)) {
			param = JsonHelper.getInstance().readValue(json, dateFormat,
					new TypeReference<UumsUserAppPermissionsDTO>() {
					});
		}else{
			param = new UumsUserAppPermissionsDTO();
		}
		param.setAppId(appId);
		queryReqBean.setSearchParams(param);
		try {
			result = service.searchUumsUserAppPermissionsByPage(queryReqBean);
			for (UumsUserAppPermissionsDTO dto : result.getResult()) {
				this.formatDto(dto);
			}

			map.put("total", result.getPageParameter().getTotalCount());
			map.put("rows", result.getResult());
			logger.debug("成功获取SysLookupType分页数据");
		} catch (Exception ex) {
			logger.debug(ex.getMessage());
			ex.printStackTrace();
			return map;
		}
		return map;
	}
	
	/**
	 * 根据审批流程查询用户权限并进行分页
	 * @param pageParameter
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/operation/getAuditPermissionssByPage")
	@ResponseBody
	public Map<String, Object> togetAuditPermissionsByPage(
			PageParameter pageParameter, HttpServletRequest request) {
		QueryReqBean<UumsUserAppPermissionsDTO> queryReqBean = new QueryReqBean<UumsUserAppPermissionsDTO>();
		queryReqBean.setPageParameter(pageParameter);
		HashMap<String, Object> map = new HashMap<String, Object>();
		String formId = ServletRequestUtils.getStringParameter(request, "formId",
				"");
		QueryRespBean<UumsUserAppPermissionsDTO> result = null;
		try {
			List<UumsPermissionWorkflowDTO> pwList = perWfService.searchUumsPermissionWorkflowByWorkflowId(formId);
			if(pwList != null){
				List<String> upidList = new ArrayList<String>();
				for(UumsPermissionWorkflowDTO dto : pwList){
					String upId = dto.getUpId();
					upidList.add(upId);
				}
				
				result = service.searchUumsUserAppPermissionsByIds(queryReqBean, upidList);
				for (UumsUserAppPermissionsDTO dto : result.getResult()) {
					this.formatDto(dto);
				}

				map.put("total", result.getPageParameter().getTotalCount());
				map.put("rows", result.getResult());
				logger.debug("成功获取SysLookupType分页数据");
			}
		} catch (Exception ex) {
			logger.debug(ex.getMessage());
			ex.printStackTrace();
			return map;
		}
		return map;
	}
	
	/**
	 * 保存审批结果
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/operation/saveAuditFlag")
	public ModelAndView saveAuditFlag(HttpServletRequest request)
			throws Exception {
		ModelAndView mav = new ModelAndView();
		try {
			String pids = ServletRequestUtils.getStringParameter(request, "data",
					"");
			String type = ServletRequestUtils.getStringParameter(request, "type",
					"");
			if(StringUtils.isNotEmpty(pids)){
				String[] pidArr = pids.split(",");
				for(String id : pidArr){
					//UumsUserAppPermissionsDTO dto = service.queryUumsUserAppPermissionsByPrimaryKey(id);
					UumsUserAppPermissionsDTO dto = new UumsUserAppPermissionsDTO();
					dto.setId(id);
					if("allow".equals(type)){
						dto.setAuditStatus("1");
					}else{
						dto.setAuditStatus("0");
					}
					service.updateUumsUserAppPermissionsSensitive(dto);
				}
			}
			
			mav.addObject("flag", OpResult.success);
		} catch (Exception ex) {
			ex.printStackTrace();
			logger.debug(ex.getMessage());
			mav.addObject("error", ex.getMessage());
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}

	/**
	 * 根据id选择跳转到新建页还是编辑页
	 * 
	 * @param type
	 *            操作类型新建还是编辑
	 * @param id
	 *            编辑数据的id
	 * @param request
	 *            请求
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/operation/{type}/{id}/{appId}")
	public ModelAndView toOpertionPage(@PathVariable String type,
			@PathVariable String id, @PathVariable String appId, HttpServletRequest request)
			throws Exception {
		ModelAndView mav = new ModelAndView();
		Assert.notNull(appId);
		
		UumsUserAppPermissionsDTO dto = new UumsUserAppPermissionsDTO();
		if (!"null".equals(id)) {// 编辑窗口或者详细页窗口
			// 主表数据
			// LogBase logBase = LogBaseFactory.getLogBase(request);
			dto = service.queryUumsUserAppPermissionsByPrimaryKey(id);
			this.formatDto(dto);
		}else{
			UumsAppSysDTO app = appService.queryUumsAppSysByPrimaryKey(appId);
			dto.setAppId(appId);
			dto.setAppName(app.getAppName());
		}
		
		request.setAttribute("uumsUserAppPermissionsDTO", dto);
		
		mav.setViewName("avicit/uums/permission/synch/uumsuserapppermissions/"
				+ "UumsUserAppPermissions" + type);
		return mav;
	}

	/**
	 * 保存数据
	 * 
	 * @param id
	 *            主键id
	 * @param demoBusinessTripDTO
	 *            保存的对象
	 * @return
	 */
	@RequestMapping(value = "/operation/save", method = RequestMethod.POST)
	public ModelAndView toSaveUumsUserAppPermissionsDTO(
			HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String jsonData = ServletRequestUtils.getStringParameter(request,
				"data", "");
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			UumsUserAppPermissionsDTO uumsUserAppPermissionsDTO = JsonHelper
					.getInstance().readValue(jsonData, dateFormat,
							new TypeReference<UumsUserAppPermissionsDTO>() {
							});
			// 先查询应用系统下该用户权限是否存在，如果不存在则新增，否则更新
			QueryReqBean<UumsUserAppPermissionsDTO> queryReqBean = new QueryReqBean<UumsUserAppPermissionsDTO>();
			UumsUserAppPermissionsDTO searchDto = new UumsUserAppPermissionsDTO();
			searchDto.setAppId(uumsUserAppPermissionsDTO.getAppId());
			searchDto.setUserId(uumsUserAppPermissionsDTO.getUserId());
			queryReqBean.setSearchParams(searchDto);
			List<UumsUserAppPermissionsDTO> resList = service.searchUumsUserAppPermissions(queryReqBean);
			
			if (resList.size() == 0) {// 新增
				SysUser user = sysUserLoader.getSysUserById(uumsUserAppPermissionsDTO.getUserId());
				if(user != null){
					uumsUserAppPermissionsDTO.setUnitCode(user.getUnitCode());
					uumsUserAppPermissionsDTO.setUserName(user.getName());
				}
				service.insertUumsUserAppPermissions(uumsUserAppPermissionsDTO);
			} else {// 修改
				service.updateUumsUserAppPermissionsSensitive(uumsUserAppPermissionsDTO);
			}
			mav.addObject("flag", OpResult.success);
		} catch (Exception ex) {
			logger.debug(ex.getMessage());
			mav.addObject("error", ex.getMessage());
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;

	}

	/**
	 * 按照id批量删除数据
	 * 
	 * @param ids
	 *            id数组
	 * @return
	 */
	@RequestMapping(value = "/operation/delete", method = RequestMethod.POST)
	public ModelAndView toDeleteUumsUserAppPermissionsDTO(
			@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			// LogBase logBase = LogBaseFactory.getLogBase( request);
			service.deleteUumsUserAppPermissionsByIds(ids);
			mav.addObject("flag", OpResult.success);
		} catch (Exception ex) {
			logger.debug(ex.getMessage());
			mav.addObject("error", ex.getMessage());
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}
	
	/**
	 * 初始化应用系统用户权限
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/operation/initUser", method = RequestMethod.POST)
	public ModelAndView toInitUserPermission(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			String appId = ServletRequestUtils.getStringParameter(request,
					"appId", "");
			
			synchUserToAppsys.initAllUserToAppByAppId(appId);
			
			mav.addObject("flag", OpResult.success);
		} catch (Exception ex) {
			logger.debug(ex.getMessage());
			mav.addObject("error", ex.getMessage());
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}
	
	/**
	 * 同步应用系统用户权限
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/operation/synchUser", method = RequestMethod.POST)
	public ModelAndView toSynchUserPermission(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			//当前登录人姓名
			String userName = getCurrLoginUserName(request);
			String appId = ServletRequestUtils.getStringParameter(request,
					"appId", "");
			String synchType = ServletRequestUtils.getStringParameter(request,
					"synchType", "");
			if("insert".equals(synchType)){
				synchUserToAppsys.synchInsertedUserToAppByAppId(appId, "1", userName);
			}else if("update".equals(synchType)){
				synchUserToAppsys.synchUpdatedUserToAppByAppId(appId, "1", userName);
			}else if("delete".equals(synchType)){
				synchUserToAppsys.synchDeletedUserToAppByAppId(appId, "1", userName);
			}else{
				synchUserToAppsys.synchAllUserToAppByAppId(appId, "1", userName);
			}
			
			mav.addObject("flag", OpResult.success);
		} catch (Exception ex) {
			logger.debug(ex.getMessage());
			mav.addObject("error", ex.getMessage());
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}
	
	private void formatDto(UumsUserAppPermissionsDTO dto) throws Exception{
		Assert.notNull(dto);
		UumsAppSysDTO app = appService.queryUumsAppSysByPrimaryKey(dto.getAppId());
		SysUser user = sysUserLoader.getSysUserById(dto.getUserId());
		dto.setAppName(app.getAppName());
		if(user != null){
			SysDept dept = sysUserDeptPositionLoader.getChiefDeptBySysUserId(dto.getUserId());
			String deptName = sysDeptLoader.getSysDeptNameBySysDeptId(dept.getId(), "zh_CN");
			dto.setUserName(user.getName());
			dto.setDeptName(deptName);
			dto.setLoginName(user.getLoginName());
		}else{
			dto.setLoginName(dto.getUnitCode());
		}
	}
	
	/**
	 * 获取当前登录人姓名
	 * @param request
	 * @return
	 */
	private String getCurrLoginUserName(HttpServletRequest request){
		String userName = "系统管理员";
		SysUser loginUser = SessionHelper.getLoginSysUser(request);
		if(loginUser != null){
			userName = loginUser.getName();
		}
		return userName;
	}
}
