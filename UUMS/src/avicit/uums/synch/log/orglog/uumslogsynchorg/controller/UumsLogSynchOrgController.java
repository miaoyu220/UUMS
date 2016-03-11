package avicit.uums.synch.log.orglog.uumslogsynchorg.controller;

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

import avicit.platform6.api.syspermissionresource.permissionanalysis.core.support.LoaderConstant;
import avicit.platform6.commons.utils.JsonHelper;
import avicit.platform6.core.properties.PlatformConstant.OpResult;
import avicit.platform6.core.rest.msg.PageParameter;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.uums.appsys.register.uumsappsys.dto.UumsAppSysDTO;
import avicit.uums.appsys.register.uumsappsys.service.UumsAppSysService;
import avicit.uums.synch.log.orglog.uumslogsynchorg.dto.UumsLogSynchOrgDTO;
import avicit.uums.synch.log.orglog.uumslogsynchorg.service.UumsLogSynchOrgService;

import com.fasterxml.jackson.core.type.TypeReference;

/**
 * @classname: UumsLogSynchOrgController
 * @description: 定义 组织同步日志表 控制层
 * @author: AVICIT DEV
 */
@Controller
@Scope("prototype")
@RequestMapping("uums/synch/log/orglog/uumslogsynchorg/UumsLogSynchOrgController")
public class UumsLogSynchOrgController implements LoaderConstant {
	private static final Logger logger = LoggerFactory
			.getLogger(UumsLogSynchOrgController.class);

	@Autowired
	private UumsLogSynchOrgService service;
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
	@RequestMapping(value = "UumsLogSynchOrgInfo")
	public ModelAndView toUumsLogSynchOrg(HttpServletRequest request,
			HttpServletResponse reponse) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("avicit/uums/synch/log/orglog/uumslogsynchorg/UumsLogSynchOrgManage");
		request.setAttribute(
				"url",
				"platform/uums/synch/log/orglog/uumslogsynchorg/UumsLogSynchOrgController/operation/");
		return mav;
	}
	/**
	 * 跳转到组织用户日志管理界面
	 * @param request
	 * @param reponse
	 * @return
	 */
	@RequestMapping(value = "UumsLogSynchOrgUserInfo")
	public ModelAndView toUumsLogSynchOrgUser(HttpServletRequest request,
			HttpServletResponse reponse) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("avicit/uums/synch/log/orglog/uumslogsynchorg/UumsLogSynchOrgUserManage");
		request.setAttribute(
				"url",
				"platform/uums/synch/log/orglog/uumslogsynchorg/UumsLogSynchOrgController/operation/");
		return mav;
	}

	@RequestMapping(value = "/operation/getUumsLogSynchOrgsByPage")
	@ResponseBody
	public Map<String, Object> togetUumsLogSynchOrgByPage(
			PageParameter pageParameter, HttpServletRequest request) {
		QueryReqBean<UumsLogSynchOrgDTO> queryReqBean = new QueryReqBean<UumsLogSynchOrgDTO>();
		queryReqBean.setPageParameter(pageParameter);
		HashMap<String, Object> map = new HashMap<String, Object>();
		String json = ServletRequestUtils.getStringParameter(request, "param",
				"");
		String appId  = ServletRequestUtils.getStringParameter(request, "appId",
				"");
		UumsLogSynchOrgDTO param = null;
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		QueryRespBean<UumsLogSynchOrgDTO> result = null;
		if (json != null && !"".equals(json)) {
			param = JsonHelper.getInstance().readValue(json, dateFormat,
					new TypeReference<UumsLogSynchOrgDTO>() {
					});
			queryReqBean.setSearchParams(param);
		}else{
			param = new UumsLogSynchOrgDTO();
			param.setAppId(appId);
			queryReqBean.setSearchParams(param);
		}
		
		try {
			result = service.searchUumsLogSynchOrgByPage(queryReqBean);
			
			for (UumsLogSynchOrgDTO dto : result.getResult()) {
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
			UumsLogSynchOrgDTO dto = service
					.queryUumsLogSynchOrgByPrimaryKey(id);

			request.setAttribute("uumsLogSynchOrgDTO", dto);
		}
		mav.setViewName("avicit/uums/synch/log/orglog/uumslogsynchorg/"
				+ "UumsLogSynchOrg" + type);
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
	public ModelAndView toSaveUumsLogSynchOrgDTO(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String jsonData = ServletRequestUtils.getStringParameter(request,
				"data", "");
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			UumsLogSynchOrgDTO uumsLogSynchOrgDTO = JsonHelper.getInstance()
					.readValue(jsonData, dateFormat,
							new TypeReference<UumsLogSynchOrgDTO>() {
							});
			if ("".equals(uumsLogSynchOrgDTO.getId())) {// 新增
				service.insertUumsLogSynchOrg(uumsLogSynchOrgDTO);
			} else {// 修改
				service.updateUumsLogSynchOrgSensitive(uumsLogSynchOrgDTO);
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
	public ModelAndView toDeleteUumsLogSynchOrgDTO(@RequestBody String[] ids,
			HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			// LogBase logBase = LogBaseFactory.getLogBase( request);
			service.deleteUumsLogSynchOrgByIds(ids);
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
