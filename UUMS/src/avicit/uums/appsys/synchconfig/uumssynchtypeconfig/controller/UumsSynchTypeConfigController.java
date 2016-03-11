package avicit.uums.appsys.synchconfig.uumssynchtypeconfig.controller;

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
import avicit.uums.appsys.synchconfig.uumssynchtypeconfig.dto.UumsSynchOrgUserMapperDTO;
import avicit.uums.appsys.synchconfig.uumssynchtypeconfig.dto.UumsSynchTypeConfigDTO;
import avicit.uums.appsys.synchconfig.uumssynchtypeconfig.service.UumsSynchOrgUserMapperService;
import avicit.uums.appsys.synchconfig.uumssynchtypeconfig.service.UumsSynchTypeConfigService;
import avicit.uums.appsys.synchmappermeta.uumssynchmappermetadata.dto.UumsSynchMapperMetaDataDTO;
import avicit.uums.appsys.synchmappermeta.uumssynchmappermetadata.service.UumsSynchMapperMetaDataService;

import com.fasterxml.jackson.core.type.TypeReference;

/**
 * @classname: UumsSynchTypeConfigController
 * @description: 定义 应用系统同步方式配置信息 控制层
 * @author: AVICIT DEV
 */
@Controller
@Scope("prototype")
@RequestMapping("uums/appsys/synchconfig/uumssynchtypeconfig/UumsSynchTypeConfigController")
public class UumsSynchTypeConfigController implements LoaderConstant {
	private static final Logger logger = LoggerFactory
			.getLogger(UumsSynchTypeConfigController.class);

	@Autowired
	private UumsSynchTypeConfigService service;
	@Autowired
	private UumsSynchOrgUserMapperService serviceSub;
	@Autowired
	private UumsAppSysService appsysService;
	@Autowired
	private UumsSynchMapperMetaDataService mapmetaService;

	/**
	 * 跳转到管理页面
	 * 
	 * @param request
	 *            请求
	 * @param reponse
	 *            响应
	 * @return
	 */
	@RequestMapping(value = "UumsSynchTypeConfigInfo")
	public ModelAndView toUumsSynchTypeConfigInfo(HttpServletRequest request,
			HttpServletResponse reponse) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("avicit/uums/appsys/synchconfig/uumssynchtypeconfig/UumsSynchTypeConfigManage");
		request.setAttribute(
				"url",
				"platform/uums/appsys/synchconfig/uumssynchtypeconfig/UumsSynchTypeConfigController/operation/");
		request.setAttribute(
				"surl",
				"platform/uums/appsys/synchconfig/uumssynchtypeconfig/UumsSynchTypeConfigController/operation/sub/");
		return mav;
	}

	@RequestMapping(value = "/operation/getUumsSynchTypeConfigsByPage")
	@ResponseBody
	public Map<String, Object> toGetUumsSynchTypeConfigByPage(
			PageParameter pageParameter, HttpServletRequest request) {
		
		QueryReqBean<UumsSynchTypeConfigDTO> queryReqBean = new QueryReqBean<UumsSynchTypeConfigDTO>();
		queryReqBean.setPageParameter(pageParameter);
		HashMap<String, Object> map = new HashMap<String, Object>();
		String json = ServletRequestUtils.getStringParameter(request, "param",
				"");
		UumsSynchTypeConfigDTO param = null;
		QueryRespBean<UumsSynchTypeConfigDTO> result = null;
		if (json != null && !"".equals(json)) {
			param = JsonHelper.getInstance().readValue(json,
					new TypeReference<UumsSynchTypeConfigDTO>() {
					});
			queryReqBean.setSearchParams(param);
		}
		try {
			result = service.searchUumsSynchTypeConfigByPage(queryReqBean);
			
			for (UumsSynchTypeConfigDTO dto : result.getResult()) {
				dto.setAppIdAlias(appsysService.queryUumsAppSysByPrimaryKey(dto.getAppId()).getAppName());
			}
		} catch (Exception ex) {
			logger.debug(ex.getMessage());
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
			UumsSynchTypeConfigDTO dto = service
					.queryUumsSynchTypeConfigByPrimaryKey(id);
			dto.setAppIdAlias(appsysService.queryUumsAppSysByPrimaryKey(dto.getAppId()).getAppName());
			
			request.setAttribute("uumsSynchTypeConfigDTO", dto);
		}
		List<UumsAppSysDTO> appSysList = appsysService.searchUumsAppSys(new QueryReqBean<UumsAppSysDTO>());
		request.setAttribute("appSysList", appSysList);
		
		mav.setViewName("avicit/uums/appsys/synchconfig/uumssynchtypeconfig/"
				+ "UumsSynchTypeConfig" + type);
		return mav;
	}
	
	/**
	 * 新增操作时，判断该应用系的同步配置是否已存在
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/operation/appsys/isexist")
	public ModelAndView toSearchAppSysIsExist(HttpServletRequest request){
		ModelAndView mav = new ModelAndView();
		try {
			String appid = ServletRequestUtils.getStringParameter(request,
					"appid", "");
			QueryReqBean<UumsSynchTypeConfigDTO> queryReqBean = new QueryReqBean<UumsSynchTypeConfigDTO>();
			UumsSynchTypeConfigDTO uumsSynchTypeConfigDTO = new UumsSynchTypeConfigDTO();
			uumsSynchTypeConfigDTO.setAppId(appid);
			queryReqBean.setSearchParams(uumsSynchTypeConfigDTO);
			
			List<UumsSynchTypeConfigDTO> dtoList = service.searchUumsSynchTypeConfig(queryReqBean);
			if(dtoList.size() > 0){
				mav.addObject("flag", "false");
			}else{
				mav.addObject("flag", "true");
			}
			
			return mav;
		} catch (Exception ex) {
			logger.debug(ex.getMessage());
			mav.addObject("error", ex.getMessage());
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
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
	public ModelAndView toSaveUumsSynchTypeConfigDTO(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			String jsonData = ServletRequestUtils.getStringParameter(request,
					"data", "");
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			UumsSynchTypeConfigDTO uumsSynchTypeConfigDTO = JsonHelper
					.getInstance().readValue(jsonData, dateFormat,
							new TypeReference<UumsSynchTypeConfigDTO>() {
							});
			if ("".equals(uumsSynchTypeConfigDTO.getId())) {// 新增
				service.insertUumsSynchTypeConfig(uumsSynchTypeConfigDTO);
			} else {// 修改
				service.updateUumsSynchTypeConfigSensitive(uumsSynchTypeConfigDTO);
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
	public ModelAndView toDeleteUumsSynchTypeConfigDTO(
			@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			service.deleteUumsSynchTypeConfigByIds(ids);
			mav.addObject("flag", OpResult.success);
		} catch (Exception ex) {
			logger.debug(ex.getMessage());
			mav.addObject("error", ex.getMessage());
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}

	/****************************
	 * 子表操作********* /** 按照pid和type查找子表数据
	 * 
	 * @param ids
	 *   id数组
	 * @return
	 */
	@RequestMapping(value = "/operation/sub/getUumsSynchOrgUserMapper/{pid}/{uumsType}")
	@ResponseBody
	public Map<String, Object> toGetUumsSynchOrgUserMapperByPid(@PathVariable String pid, 
			@PathVariable String uumsType,HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>(1);
		try {
			QueryReqBean<UumsSynchOrgUserMapperDTO> queryReqBean = new QueryReqBean<UumsSynchOrgUserMapperDTO>();
			UumsSynchOrgUserMapperDTO uumsSynchOrgUserMapperDTO = new UumsSynchOrgUserMapperDTO();
			uumsSynchOrgUserMapperDTO.setTypeId(pid);
			uumsSynchOrgUserMapperDTO.setMainType(uumsType);
			queryReqBean.setSearchParams(uumsSynchOrgUserMapperDTO);
			
			List<UumsSynchOrgUserMapperDTO> list = serviceSub
					.queryUumsSynchOrgUserMapperByPidAndMaintype(queryReqBean);

			// 如果还未进行数据初始化则从同步映射元数据范围中查询数据并进行数据转换
			String init = "false";
			if(list.size() == 0){
				init = "true";
				List<UumsSynchMapperMetaDataDTO> dtoList = mapmetaService.searchUumsSynchMapperMetaDataByType(uumsType);
				for(UumsSynchMapperMetaDataDTO metaDto : dtoList){
					UumsSynchOrgUserMapperDTO mapperDto = new UumsSynchOrgUserMapperDTO();
					mapperDto.setColumnCode(metaDto.getColumnCode());
					mapperDto.setColumnName(metaDto.getColumnName());
					mapperDto.setComments(metaDto.getComments());
					mapperDto.setDataType(metaDto.getDataType());
					mapperDto.setMainType(uumsType);
					mapperDto.setOrderBy(metaDto.getOrderBy());
					mapperDto.setTypeId(pid);
					mapperDto.setUumsAttribute(metaDto.getUumsAttribute());
					
					list.add(mapperDto);
				}
			}
			map.put("init", init);
			map.put("rows", list);
		} catch (Exception ex) {
			logger.debug(ex.getMessage());
			return map;
		}
		return map;
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
	@RequestMapping(value = "/operation/sub/{type}/{id}")
	public ModelAndView toOpertionSubPage(@PathVariable String type,
			@PathVariable String id, HttpServletRequest request)
			throws Exception {
		ModelAndView mav = new ModelAndView();
		if (!"Add".equals(type)) {// 编辑窗口或者详细页窗口
			// 主表数据
			UumsSynchOrgUserMapperDTO dto = serviceSub
					.queryUumsSynchOrgUserMapperByPrimaryKey(id);

			request.setAttribute("uumsSynchOrgUserMapperDTO", dto);
		} else {
			request.setAttribute("pid", id);
		}
		mav.setViewName("avicit/uums/appsys/synchconfig/uumssynchtypeconfig/"
				+ "UumsSynchOrgUserMapper" + type);
		return mav;
	}
	
	/**
	 * @description 按类型查询同步映射元数据
	 * @author miaoyu
	 * @param uumsType 主体类型
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/operation/sub/add/{uumsType}")
	public ModelAndView toGetMapperMetaData(@PathVariable String uumsType,
			 HttpServletRequest request)
			throws Exception {
		ModelAndView mav = new ModelAndView();
		try {
			List<UumsSynchMapperMetaDataDTO> dtoList = mapmetaService.searchUumsSynchMapperMetaDataByType(uumsType);
			mav.addObject("metaList", dtoList);
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
	 * 保存数据
	 * 
	 * @param id
	 *            主键id
	 * @param uumsSynchOrgUserMapperDTO
	 *            保存的对象
	 * @return
	 */
	@RequestMapping(value = "/operation/sub/save", method = RequestMethod.POST)
	public ModelAndView toSaveUumsSynchOrgUserMapperDTO(
			HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String jsonData = ServletRequestUtils.getStringParameter(request,
				"datas", "");
		try {
			UumsSynchOrgUserMapperDTO[] dtoArr = JsonHelper
					.getInstance().readValue(jsonData, 
							UumsSynchOrgUserMapperDTO[].class);
			for(UumsSynchOrgUserMapperDTO uumsSynchOrgUserMapperDTO : dtoArr){
				if ("".equals(uumsSynchOrgUserMapperDTO.getId()) || null == uumsSynchOrgUserMapperDTO.getId()) {// 新增
					if(StringUtils.isEmpty(uumsSynchOrgUserMapperDTO.getDataType())){
						uumsSynchOrgUserMapperDTO.setDataType("string");
					}
					serviceSub.insertUumsSynchOrgUserMapper(uumsSynchOrgUserMapperDTO);
				} else {// 修改
					serviceSub
							.updateUumsSynchOrgUserMapperSensitive(uumsSynchOrgUserMapperDTO);
				}
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
	@RequestMapping(value = "/operation/sub/delete", method = RequestMethod.POST)
	public ModelAndView toDeleteUumsSynchOrgUserMapperDTO(
			@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			serviceSub.deleteUumsSynchOrgUserMapperByIds(ids);
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
