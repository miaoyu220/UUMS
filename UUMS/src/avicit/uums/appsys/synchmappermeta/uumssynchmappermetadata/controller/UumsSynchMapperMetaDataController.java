package avicit.uums.appsys.synchmappermeta.uumssynchmappermetadata.controller;

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
import avicit.platform6.api.sysuser.dto.SysOrg;
import avicit.platform6.api.sysuser.dto.SysUser;
import avicit.platform6.commons.utils.JsonHelper;
import avicit.platform6.core.properties.PlatformConstant.OpResult;
import avicit.platform6.core.rest.msg.PageParameter;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;

import com.fasterxml.jackson.core.type.TypeReference;

import avicit.uums.appsys.synchmappermeta.uumssynchmappermetadata.dto.UumsSynchMapperMetaDataDTO;
import avicit.uums.appsys.synchmappermeta.uumssynchmappermetadata.service.UumsSynchMapperMetaDataService;
import com.fasterxml.jackson.core.type.TypeReference;

/**
 * @classname: UumsSynchMapperMetaDataController
 * @description: 定义
 *               组织用户同步映射元数据，该表定义了需要同步给应用系统的组织和用户信息范围，支持数据库、LDAP同步范围，该表需要做数据初始化
 *               控制层
 * @author: AVICIT DEV
 */
@Controller
@Scope("prototype")
@RequestMapping("uums/appsys/synchmappermeta/uumssynchmappermetadata/UumsSynchMapperMetaDataController")
public class UumsSynchMapperMetaDataController implements LoaderConstant {
	private static final Logger logger = LoggerFactory
			.getLogger(UumsSynchMapperMetaDataController.class);

	@Autowired
	private UumsSynchMapperMetaDataService service;

	/**
	 * 跳转到管理页面
	 * 
	 * @param request
	 *            请求
	 * @param reponse
	 *            响应
	 * @return
	 */
	@RequestMapping(value = "UumsSynchMapperMetaDataInfo")
	public ModelAndView toUumsSynchMapperMetaData(HttpServletRequest request,
			HttpServletResponse reponse) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("avicit/uums/appsys/synchmappermeta/uumssynchmappermetadata/UumsSynchMapperMetaDataManage");
		request.setAttribute(
				"url",
				"platform/uums/appsys/synchmappermeta/uumssynchmappermetadata/UumsSynchMapperMetaDataController/operation/");
		return mav;
	}

	@RequestMapping(value = "/operation/getUumsSynchMapperMetaDatasByPage")
	@ResponseBody
	public Map<String, Object> togetUumsSynchMapperMetaDataByPage(
			PageParameter pageParameter, HttpServletRequest request) {
		QueryReqBean<UumsSynchMapperMetaDataDTO> queryReqBean = new QueryReqBean<UumsSynchMapperMetaDataDTO>();
		queryReqBean.setPageParameter(pageParameter);
		HashMap<String, Object> map = new HashMap<String, Object>();
		String json = ServletRequestUtils.getStringParameter(request, "param",
				"");
		UumsSynchMapperMetaDataDTO param = null;
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		QueryRespBean<UumsSynchMapperMetaDataDTO> result = null;
		if (json != null && !"".equals(json)) {
			param = JsonHelper.getInstance().readValue(json, dateFormat,
					new TypeReference<UumsSynchMapperMetaDataDTO>() {
					});
			queryReqBean.setSearchParams(param);
		}
		try {
			result = service.searchUumsSynchMapperMetaDataByPage(queryReqBean);
		} catch (Exception ex) {
			logger.debug(ex.getMessage());
			ex.printStackTrace();
			return map;
		}
		
		for (UumsSynchMapperMetaDataDTO dto : result.getResult()) {
				
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
			UumsSynchMapperMetaDataDTO dto = service
					.queryUumsSynchMapperMetaDataByPrimaryKey(id);

			request.setAttribute("uumsSynchMapperMetaDataDTO", dto);
		}
		mav.setViewName("avicit/uums/appsys/synchmappermeta/uumssynchmappermetadata/"
				+ "UumsSynchMapperMetaData" + type);
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
	public ModelAndView toSaveUumsSynchMapperMetaDataDTO(
			HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String jsonData = ServletRequestUtils.getStringParameter(request,
				"data", "");
		System.out.println("jsonData========"+jsonData);
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			UumsSynchMapperMetaDataDTO uumsSynchMapperMetaDataDTO = JsonHelper
					.getInstance().readValue(jsonData, dateFormat,
							new TypeReference<UumsSynchMapperMetaDataDTO>() {
							});
			if ("".equals(uumsSynchMapperMetaDataDTO.getId())) {// 新增
				service.insertUumsSynchMapperMetaData(uumsSynchMapperMetaDataDTO);
			} else {// 修改
				service.updateUumsSynchMapperMetaDataSensitive(uumsSynchMapperMetaDataDTO);
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
	public ModelAndView toDeleteUumsSynchMapperMetaDataDTO(
			@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			// LogBase logBase = LogBaseFactory.getLogBase( request);
			service.deleteUumsSynchMapperMetaDataByIds(ids);
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
