package avicit.uums.synch.toappsys.orgdept.uumsorgsynchrecord.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import avicit.platform6.api.session.SessionHelper;
import avicit.platform6.api.syspermissionresource.permissionanalysis.core.support.LoaderConstant;
import avicit.platform6.api.sysuser.dto.SysUser;
import avicit.platform6.commons.utils.JsonHelper;
import avicit.platform6.core.properties.PlatformConstant.OpResult;
import avicit.platform6.core.rest.msg.PageParameter;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.uums.synch.toappsys.orgdept.uumsorgsynchrecord.dto.UumsOrgSynchRecordDTO;
import avicit.uums.synch.toappsys.orgdept.uumsorgsynchrecord.service.UumsOrgSynchRecordService;
import avicit.uums.synch.toappsys.service.SynchOrgToAppsys;

import com.fasterxml.jackson.core.type.TypeReference;

/**
 * @classname: UumsOrgSynchRecordController
 * @description: 定义 组织信息同步记录表 控制层
 * @author: AVICIT DEV
 */
@Controller
@Scope("prototype")
@RequestMapping("uums/synch/toappsys/orgdept/uumsorgsynchrecord/UumsOrgSynchRecordController")
public class UumsOrgSynchRecordController implements LoaderConstant {
	private static final Logger logger = LoggerFactory
			.getLogger(UumsOrgSynchRecordController.class);

	@Autowired
	private UumsOrgSynchRecordService service;
	@Autowired
	private SynchOrgToAppsys synchOrg;

	/**
	 * 跳转到管理页面
	 * 
	 * @param request
	 *            请求
	 * @param reponse
	 *            响应
	 * @return
	 */
	@RequestMapping(value = "UumsOrgSynchRecordInfo")
	public ModelAndView toUumsOrgSynchRecord(HttpServletRequest request,
			HttpServletResponse reponse) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("avicit/uums/synch/toappsys/orgdept/uumsorgsynchrecord/UumsOrgSynchRecordManage");
		request.setAttribute(
				"url",
				"platform/uums/synch/toappsys/orgdept/uumsorgsynchrecord/UumsOrgSynchRecordController/operation/");
		return mav;
	}

	@RequestMapping(value = "/operation/getUumsOrgSynchRecordsByPage")
	@ResponseBody
	public Map<String, Object> togetUumsOrgSynchRecordByPage(
			PageParameter pageParameter, HttpServletRequest request) {
		QueryReqBean<UumsOrgSynchRecordDTO> queryReqBean = new QueryReqBean<UumsOrgSynchRecordDTO>();
		queryReqBean.setPageParameter(pageParameter);
		HashMap<String, Object> map = new HashMap<String, Object>();
		String json = ServletRequestUtils.getStringParameter(request, "param",
				"");
		String appId = ServletRequestUtils.getStringParameter(request, "appId",
				"");
		UumsOrgSynchRecordDTO param = null;
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		QueryRespBean<UumsOrgSynchRecordDTO> result = null;
		if (json != null && !"".equals(json)) {
			param = JsonHelper.getInstance().readValue(json, dateFormat,
					new TypeReference<UumsOrgSynchRecordDTO>() {
					});
			param.setAppId(appId);
		}else if(StringUtils.isNotEmpty(appId)){
			param = new UumsOrgSynchRecordDTO();
			param.setAppId(appId);
		}
		queryReqBean.setSearchParams(param);
		try {
			result = service.searchUumsOrgSynchRecordByPage(queryReqBean);
		} catch (Exception ex) {
			logger.debug(ex.getMessage());
			ex.printStackTrace();
			return map;
		}

		for (UumsOrgSynchRecordDTO dto : result.getResult()) {
//			if("3".equals(dto.getOperFlag())){
//				dto.setOrgName("");
//				continue;
//			}
//			String orgName = "";
//			try {//如果数据已被删除情况下的处理
//				if("1".equals(dto.getOrgOrDept())){
//					orgName = sysOrgLoader.getSysOrgNameBySysOrgId(dto.getSysOrgId(), "zh_CN");
//				}else{
//					orgName = sysDeptLoader.getSysDeptNameBySysDeptId(dto.getSysOrgId(), "zh_CN");
//				}
//				dto.setOrgName(orgName);
//			} catch (NullPointerException e) {
//				dto.setOrgName("");
//			}
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
	@RequestMapping(value = "/operation/{type}/{id}")
	public ModelAndView toOpertionPage(@PathVariable String type,
			@PathVariable String id, HttpServletRequest request)
			throws Exception {
		ModelAndView mav = new ModelAndView();
		if (!"null".equals(id)) {// 编辑窗口或者详细页窗口
			// 主表数据
			// LogBase logBase = LogBaseFactory.getLogBase(request);
			UumsOrgSynchRecordDTO dto = service
					.queryUumsOrgSynchRecordByPrimaryKey(id);

			request.setAttribute("uumsOrgSynchRecordDTO", dto);
		}
		mav.setViewName("avicit/uums/synch/toappsys/orgdept/uumsorgsynchrecord/"
				+ "UumsOrgSynchRecord" + type);
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
	public ModelAndView toSaveUumsOrgSynchRecordDTO(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String jsonData = ServletRequestUtils.getStringParameter(request,
				"data", "");
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			UumsOrgSynchRecordDTO uumsOrgSynchRecordDTO = JsonHelper
					.getInstance().readValue(jsonData, dateFormat,
							new TypeReference<UumsOrgSynchRecordDTO>() {
							});
			if ("".equals(uumsOrgSynchRecordDTO.getId())) {// 新增
				service.insertUumsOrgSynchRecord(uumsOrgSynchRecordDTO);
			} else {// 修改
				service.updateUumsOrgSynchRecordSensitive(uumsOrgSynchRecordDTO);
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
	public ModelAndView toDeleteUumsOrgSynchRecordDTO(
			@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			// LogBase logBase = LogBaseFactory.getLogBase( request);
			service.deleteUumsOrgSynchRecordByIds(ids);
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
	 * 初始化应用系统组织数据
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/operation/initOrg", method = RequestMethod.POST)
	public ModelAndView toInitUserPermission(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			String appId = ServletRequestUtils.getStringParameter(request,
					"appId", "");
			//当前登录人姓名
			String userName = getCurrLoginUserName(request);
			synchOrg.initAllOrgDeptToAppByAppId(appId, "1", userName);
			
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
	 * 同步应用系统组织数据
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/operation/synchOrg", method = RequestMethod.POST)
	public ModelAndView toSynchUserPermission(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			String appId = ServletRequestUtils.getStringParameter(request,
					"appId", "");
			String synchType = ServletRequestUtils.getStringParameter(request,
					"synchType", "");
			//当前登录人姓名
			String userName = getCurrLoginUserName(request);
			
			if("insert".equals(synchType)){
				synchOrg.synchInsertedOrgDeptToAppByAppId(appId, "1", userName);
			}else if("update".equals(synchType)){
				synchOrg.synchUpdatedOrgDeptToAppByAppId(appId, "1", userName);
			}else if("delete".equals(synchType)){
				synchOrg.synchDeletedOrgDeptToAppByAppId(appId, "1", userName);
			}else{
				synchOrg.synchAllOrgDeptToAppByAppId(appId, "1", userName);
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
