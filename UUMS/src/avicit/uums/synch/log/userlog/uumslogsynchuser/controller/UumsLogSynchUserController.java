package avicit.uums.synch.log.userlog.uumslogsynchuser.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import avicit.platform6.commons.utils.JsonHelper;
import avicit.platform6.core.properties.PlatformConstant.OpResult;
import avicit.platform6.core.rest.msg.PageParameter;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;

import com.fasterxml.jackson.core.type.TypeReference;

import avicit.uums.appsys.register.uumsappsys.dto.UumsAppSysDTO;
import avicit.uums.appsys.register.uumsappsys.service.UumsAppSysService;
import avicit.uums.synch.log.userlog.uumslogsynchuser.dto.UumsLogSynchUserDTO;
import avicit.uums.synch.log.userlog.uumslogsynchuser.service.UumsLogSynchUserService;
import com.fasterxml.jackson.core.type.TypeReference;

/**
 * @classname: UumsLogSynchUserController
 * @description: 定义 用户同步日志表 控制层
 * @author: AVICIT DEV
 */
@Controller
@Scope("prototype")
@RequestMapping("uums/synch/log/userlog/uumslogsynchuser/UumsLogSynchUserController")
public class UumsLogSynchUserController implements LoaderConstant {
	private static final Logger logger = LoggerFactory
			.getLogger(UumsLogSynchUserController.class);

	@Autowired
	private UumsLogSynchUserService service;
	@Autowired
	private UumsAppSysService uumsAppSysService;

	/**
	 * 跳转到管理页面
	 * 
	 * @param request
	 *            请求
	 * @param reponse
	 *            响应
	 * @return
	 */
	@RequestMapping(value = "UumsLogSynchUserInfo")
	public ModelAndView toUumsLogSynchUser(HttpServletRequest request,
			HttpServletResponse reponse) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("avicit/uums/synch/log/userlog/uumslogsynchuser/UumsLogSynchUserManage");
		request.setAttribute(
				"url",
				"platform/uums/synch/log/userlog/uumslogsynchuser/UumsLogSynchUserController/operation/");
		return mav;
	}

	@RequestMapping(value = "/operation/getUumsLogSynchUsersByPage")
	@ResponseBody
	public Map<String, Object> togetUumsLogSynchUserByPage(
			PageParameter pageParameter, HttpServletRequest request) {
		QueryReqBean<UumsLogSynchUserDTO> queryReqBean = new QueryReqBean<UumsLogSynchUserDTO>();
		queryReqBean.setPageParameter(pageParameter);
		HashMap<String, Object> map = new HashMap<String, Object>();
		String json = ServletRequestUtils.getStringParameter(request, "param",
				"");
		String appId  = ServletRequestUtils.getStringParameter(request, "appId",
				"");
		UumsLogSynchUserDTO param = null;
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		QueryRespBean<UumsLogSynchUserDTO> result = null;
		if (json != null && !"".equals(json)) {
			param = JsonHelper.getInstance().readValue(json, dateFormat,
					new TypeReference<UumsLogSynchUserDTO>() {
					});
			queryReqBean.setSearchParams(param);
		}else{
			param = new UumsLogSynchUserDTO();
			param.setAppId(appId);
			queryReqBean.setSearchParams(param);
		}
		
		try {
			result = service.searchUumsLogSynchUserByPage(queryReqBean);
			
			for (UumsLogSynchUserDTO dto : result.getResult()) {
				UumsAppSysDTO appSys = uumsAppSysService.queryUumsAppSysByPrimaryKey(dto.getAppId());
				if(appSys != null){
					dto.setAppName(appSys.getAppName());
				}
			}
		} catch (Exception ex) {
			logger.debug(ex.getMessage());
			ex.printStackTrace();
			return map;
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
			UumsLogSynchUserDTO dto = service
					.queryUumsLogSynchUserByPrimaryKey(id);

			request.setAttribute("uumsLogSynchUserDTO", dto);
		}
		mav.setViewName("avicit/uums/synch/log/userlog/uumslogsynchuser/"
				+ "UumsLogSynchUser" + type);
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
	public ModelAndView toSaveUumsLogSynchUserDTO(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String jsonData = ServletRequestUtils.getStringParameter(request,
				"data", "");
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			UumsLogSynchUserDTO uumsLogSynchUserDTO = JsonHelper.getInstance()
					.readValue(jsonData, dateFormat,
							new TypeReference<UumsLogSynchUserDTO>() {
							});
			if ("".equals(uumsLogSynchUserDTO.getId())) {// 新增
				service.insertUumsLogSynchUser(uumsLogSynchUserDTO);
			} else {// 修改
				service.updateUumsLogSynchUserSensitive(uumsLogSynchUserDTO);
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
	public ModelAndView toDeleteUumsLogSynchUserDTO(@RequestBody String[] ids,
			HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			// LogBase logBase = LogBaseFactory.getLogBase( request);
			service.deleteUumsLogSynchUserByIds(ids);
			mav.addObject("flag", OpResult.success);
		} catch (Exception ex) {
			logger.debug(ex.getMessage());
			mav.addObject("error", ex.getMessage());
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}
}
