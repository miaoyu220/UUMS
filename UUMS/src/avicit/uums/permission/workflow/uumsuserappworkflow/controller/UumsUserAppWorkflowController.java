package avicit.uums.permission.workflow.uumsuserappworkflow.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
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
import avicit.platform6.commons.utils.DateUtil;
import avicit.platform6.commons.utils.JsonHelper;
import avicit.platform6.core.domain.BeanProcess;
import avicit.platform6.core.properties.PlatformConstant.OpResult;
import avicit.platform6.core.rest.msg.PageParameter;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.uums.appsys.register.uumsappsys.dto.UumsAppSysDTO;
import avicit.uums.appsys.register.uumsappsys.service.UumsAppSysService;
import avicit.uums.permission.synch.uumsuserapppermissions.dto.UumsUserAppPermissionsDTO;
import avicit.uums.permission.synch.uumsuserapppermissions.service.UumsUserAppPermissionsService;
import avicit.uums.permission.workflow.uumsuserappworkflow.dto.UumsPermissionWorkflowDTO;
import avicit.uums.permission.workflow.uumsuserappworkflow.dto.UumsUserAppWorkflowDTO;
import avicit.uums.permission.workflow.uumsuserappworkflow.service.UumsPermissionWorkflowService;
import avicit.uums.permission.workflow.uumsuserappworkflow.service.UumsUserAppWorkflowService;

import com.fasterxml.jackson.core.type.TypeReference;

/**
 * @classname: UumsUserAppWorkflowController
 * @description: 定义用户应用系统权限审批表 流程表单控制层
 * @author: AVICIT DEV
 */
@Controller
@Scope("prototype")
@RequestMapping("uums/permission/workflow/uumsuserappworkflow/UumsUserAppWorkflowController")
public class UumsUserAppWorkflowController implements LoaderConstant {
	private static final Logger logger = LoggerFactory
			.getLogger(UumsUserAppWorkflowController.class);

	@Autowired
	private UumsUserAppWorkflowService service;
	@Autowired
	private UumsAppSysService appService;
	@Autowired
	private UumsUserAppPermissionsService permissionService;

	/**
	 * 跳转到管理页面
	 * 
	 * @param request
	 *            请求
	 * @param reponse
	 *            响应
	 * @return
	 */
	@RequestMapping(value = "UumsUserAppWorkflowInfo")
	public ModelAndView toDemoBusinessFlow(HttpServletRequest request,
			HttpServletResponse reponse) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("avicit/uums/permission/workflow/uumsuserappworkflow/UumsUserAppWorkflowManage");
		request.setAttribute(
				"url",
				"platform/uums/permission/workflow/uumsuserappworkflow/UumsUserAppWorkflowController/operation/");
		return mav;
	}

	@RequestMapping(value = "/operation/getUumsUserAppWorkflowsByPage")
	@ResponseBody
	public Map<String, Object> togetUumsUserAppWorkflowByPage(
			PageParameter pageParameter, HttpServletRequest request)
			throws Exception {
		QueryReqBean<Map<String, Object>> queryReqBean = new QueryReqBean<Map<String, Object>>();
		queryReqBean.setPageParameter(pageParameter);
		HashMap<String, Object> map = new HashMap<String, Object>();
		String json = ServletRequestUtils.getStringParameter(request, "param",
				"");
		String appId = ServletRequestUtils.getStringParameter(request, "appId");
		Map<String, Object> param = null;
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		QueryRespBean<UumsUserAppWorkflowDTO> result = null;
		if (json != null && !"".equals(json)) {
			param = JsonHelper.getInstance().readValue(json, dateFormat,
					new TypeReference<HashMap<String, Object>>() {
					});
			param.put("currUserId", SessionHelper.getLoginSysUserId(request));
			queryReqBean.setSearchParams(param);
		}else if(StringUtils.isNotEmpty(appId)){
			param = new HashMap<String, Object>();
			param.put("appId", appId);
			queryReqBean.setSearchParams(param);
		}
		 try {
		result = service.searchUumsUserAppWorkflowByPage(queryReqBean);
		 } catch (Exception ex) {
		 logger.debug(ex.getMessage());
		 ex.printStackTrace();
		 return map;
		 }
		for (UumsUserAppWorkflowDTO dto : result.getResult()) {
			dto = this.formatDto(dto);
		}
		map.put("total", result.getPageParameter().getTotalCount());
		map.put("rows", result.getResult());
		logger.debug("成功获取SysLookupType分页数据");
		return map;
	}

	// 打开编辑或者添加页
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
	@RequestMapping(value = "/operation/Edit/{id}/{appId}")
	public ModelAndView toOpertionPage(@PathVariable String id, @PathVariable String appId, HttpServletRequest request)
			throws Exception {
		ModelAndView mav = new ModelAndView();
		Assert.notNull(id);
		UumsUserAppWorkflowDTO dto = service
				.queryUumsUserAppWorkflowByPrimaryKey(id);
	
		dto = this.formatDto(dto);
		request.setAttribute("uumsUserAppWorkflowDTO", dto);
		request.setAttribute("id", id);
		
		mav.setViewName("avicit/uums/permission/workflow/uumsuserappworkflow/UumsUserAppWorkflowEdit");
		return mav;
	}
	
	@RequestMapping(value = "/operation/{type}/{appId}")
	public ModelAndView toAddOperPage(@PathVariable String type,
			@PathVariable String appId, HttpServletRequest request)
			throws Exception {
		ModelAndView mav = new ModelAndView();
		// 生成流程编号
		String workFlowNo = service.generatorWorkFlowNo();
		request.setAttribute("workFlowNo", workFlowNo);
		
		UumsAppSysDTO app = appService.queryUumsAppSysByPrimaryKey(appId);
		request.setAttribute("app", app);
		request.setAttribute("operType", type);
		
		mav.setViewName("avicit/uums/permission/workflow/uumsuserappworkflow/"
				+ "UumsUserAppWorkflowAdd");
		return mav;
	}

	/**
	 * 新增并启动流程
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/operation/saveAndStartProcess", method = RequestMethod.POST)
	public ModelAndView saveAndStartProcess(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();

		String processDefId = ServletRequestUtils.getStringParameter(request,
				"processDefId", "");
		String formCode = ServletRequestUtils.getStringParameter(request,
				"formCode", "");
		String jsonString = ServletRequestUtils.getStringParameter(request,
				"jsonString", "");
		String datas = ServletRequestUtils.getStringParameter(request, "datas",
				"");
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			UumsUserAppWorkflowDTO uumsUserAppWorkflow = JsonHelper
					.getInstance().readValue(datas, dateFormat,
							new TypeReference<UumsUserAppWorkflowDTO>() {
							});
			uumsUserAppWorkflow.setSubmitDate(DateUtil.getToday());
			
			String userId = (String) request.getSession()
					.getAttribute("userId");
			String deptId = (String) request.getSession()
					.getAttribute("deptId");
			// ///////////////启动流程所需要的参数///////////////////
			Map<String, Object> parameter = new HashMap<String, Object>();
			parameter.put("processDefId", processDefId);
			parameter.put("formCode", formCode);
			parameter.put("jsonString", jsonString);
			parameter.put("userId", userId);
			parameter.put("deptId", deptId);

			BeanProcess bp = service.insertUumsUserAppWorkflowAndStartProcess(
					uumsUserAppWorkflow, parameter);

			mav.addObject("flag", OpResult.success);
			mav.addObject("bp", bp);
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("flag", OpResult.failure);
			mav.addObject("msg", e.getMessage());
		}
		return mav;
	}

	/**
	 * 保存数据不启动流程
	 * 
	 * @param id
	 *            主键id
	 * @param demoBusinessTripDTO
	 *            保存的对象
	 * @return
	 */
	@RequestMapping(value = "/operation/save", method = RequestMethod.POST)
	public ModelAndView toSaveUumsUserAppWorkflowDTO(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String jsonData = ServletRequestUtils.getStringParameter(request,
				"data", "");
		try {
			UumsUserAppWorkflowDTO dto = JsonHelper
					.getInstance().readValue(jsonData,
							new TypeReference<UumsUserAppWorkflowDTO>() {
							});
			dto.setSubmitDate(DateUtil.getToday());
			
			if ("".equals(dto.getId())) {// 新增
				//service.insertUumsUserAppWorkflow(uumsUserAppWorkflowDTO);
				String[] userIds = dto.getUserId().split(",");
				for(String uid : userIds){
					UumsUserAppPermissionsDTO permission = new UumsUserAppPermissionsDTO();
					permission.setAppId(dto.getAppId());
					permission.setAuditFlag("2");//审批状态：审批通过 
					if("addP".equals(dto.getOperType())){
						permission.setOperFlag("1");//操作状态：新增
					}else if("delP".equals(dto.getOperType())){
						permission.setOperFlag("3");//操作状态：删除
					}else{
						permission.setOperFlag("2");//操作状态：更新
					}
					
					permission.setSynchFlag("0");//同步状态：未同步
					permission.setUserId(uid);
					permission.setAuditStatus("3");//审批结果：不需要审批
					
					//保存或更新
					permissionService.insertOrUpdatePermission(permission, false);
				}
			} else {// 修改
				service.updateUumsUserAppWorkflowSensitive(dto);
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
	public ModelAndView toDeleteUumsUserAppWorkflowDTO(
			@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			// LogBase logBase = LogBaseFactory.getLogBase( request);
			service.deleteUumsUserAppWorkflowByIds(ids);
			
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
	 * 转向detail页面
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/toDetailJsp")
	public ModelAndView toDetailJsp(HttpServletRequest request)
			throws Exception {
		ModelAndView mav = new ModelAndView();
		String id = request.getParameter("id");
		UumsUserAppWorkflowDTO dto = service
				.queryUumsUserAppWorkflowByPrimaryKey(id);

		dto = this.formatDto(dto);

		mav.addObject("flag", OpResult.success);
		mav.addObject("uumsUserAppWorkflow", dto);
		return mav;
	}
	
	/**
	 * 转换页面显示内容
	 * @param dto
	 * @return
	 * @throws Exception
	 */
	private UumsUserAppWorkflowDTO formatDto(UumsUserAppWorkflowDTO dto) throws Exception{
		UumsAppSysDTO app = appService.queryUumsAppSysByPrimaryKey(dto.getAppId());
		dto.setAppCode(app.getAppCode());
		dto.setAppName(app.getAppName());
		SysUser user = sysUserLoader.getSysUserById(
				dto.getSubmitter());
		SysDept dept = sysUserDeptPositionLoader.getChiefDeptBySysUserId(dto.getSubmitter());
		String deptName = sysDeptLoader.getSysDeptNameBySysDeptId(dept.getId(), "zh_CN");
		dto.setSubmitterAlias(user.getName());
		dto.setSubmitDeptId(user.getDeptId());
		dto.setSubmitDeptName(deptName);

		//List<UumsPermissionWorkflowDTO> pwList = pwfService.searchUumsPermissionWorkflowByWorkflowId(dto.getId());
		String[] userIds = dto.getUserId().split(",");
		String userNames = "";
		for(String uid : userIds){
			userNames += sysUserLoader.getSysUserById(uid).getName() + ",";
		}
		userNames = StringUtils.removeEnd(userNames, ",");
		dto.setUserIdAlias(userNames);
		
		return dto;
	}
}
