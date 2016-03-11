package avicit.uums.appsys.register.uumsappsys.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
import avicit.platform6.commons.utils.web.TreeNode;
import avicit.platform6.core.properties.PlatformConstant.OpResult;
import avicit.platform6.core.rest.msg.PageParameter;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;

import com.fasterxml.jackson.core.type.TypeReference;

import avicit.uums.appsys.register.uumsappsys.dto.UumsAppSysDTO;
import avicit.uums.appsys.register.uumsappsys.service.UumsAppSysService;
import com.fasterxml.jackson.core.type.TypeReference;

/**
 * @classname: UumsAppSysController
 * @description: 定义 应用系统注册管理 控制层
 * @author: AVICIT DEV
 */
@Controller
@Scope("prototype")
@RequestMapping("uums/appsys/register/uumsappsys/UumsAppSysController")
public class UumsAppSysController implements LoaderConstant {
	private static final Logger logger = LoggerFactory
			.getLogger(UumsAppSysController.class);

	@Autowired
	private UumsAppSysService service;

	/**
	 * 跳转到管理页面
	 * 
	 * @param request
	 *            请求
	 * @param reponse
	 *            响应
	 * @return
	 */
	@RequestMapping(value = "UumsAppSysInfo")
	public ModelAndView toUumsAppSys(HttpServletRequest request,
			HttpServletResponse reponse) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("avicit/uums/appsys/register/uumsappsys/UumsAppSysManage");
		request.setAttribute("url",
				"platform/uums/appsys/register/uumsappsys/UumsAppSysController/operation/");
		return mav;
	}

	@RequestMapping(value = "/operation/getUumsAppSyssByPage")
	@ResponseBody
	public Map<String, Object> togetUumsAppSysByPage(
			PageParameter pageParameter, HttpServletRequest request) {
		QueryReqBean<UumsAppSysDTO> queryReqBean = new QueryReqBean<UumsAppSysDTO>();
		queryReqBean.setPageParameter(pageParameter);
		HashMap<String, Object> map = new HashMap<String, Object>();
		String json = ServletRequestUtils.getStringParameter(request, "param",
				"");
		UumsAppSysDTO param = null;
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		QueryRespBean<UumsAppSysDTO> result = null;
		if (json != null && !"".equals(json)) {
			param = JsonHelper.getInstance().readValue(json, dateFormat,
					new TypeReference<UumsAppSysDTO>() {
					});
			queryReqBean.setSearchParams(param);
		}
		try {
			result = service.searchUumsAppSysByPage(queryReqBean);
		} catch (Exception ex) {
			logger.debug(ex.getMessage());
			ex.printStackTrace();
			return map;
		}

		for (UumsAppSysDTO dto : result.getResult()) {

			dto.setSecuritAdminAlias(sysUserLoader.getSysUserById(
					dto.getSecuritAdmin()).getName());

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
			UumsAppSysDTO dto = service.queryUumsAppSysByPrimaryKey(id);

			dto.setSecuritAdminAlias(sysUserLoader.getSysUserById(
					dto.getSecuritAdmin()).getName());

			request.setAttribute("uumsAppSysDTO", dto);
		}
		mav.setViewName("avicit/uums/appsys/register/uumsappsys/"
				+ "UumsAppSys" + type);
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
	public ModelAndView toSaveUumsAppSysDTO(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String jsonData = ServletRequestUtils.getStringParameter(request,
				"data", "");
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			UumsAppSysDTO uumsAppSysDTO = JsonHelper.getInstance().readValue(
					jsonData, dateFormat, new TypeReference<UumsAppSysDTO>() {
					});
			if ("".equals(uumsAppSysDTO.getId())) {// 新增
				service.insertUumsAppSys(uumsAppSysDTO);
			} else {// 修改
				service.updateUumsAppSysSensitive(uumsAppSysDTO);
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
	public ModelAndView toDeleteUumsAppSysDTO(@RequestBody String[] ids,
			HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			// LogBase logBase = LogBaseFactory.getLogBase( request);
			service.deleteUumsAppSysByIds(ids);
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
	 * 获取应用系统导航树，同时过滤掉权威数据源HR节点
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/operation/getAppSysTree")
	public ModelAndView toGetAppSysTree(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			String hrStr  = ServletRequestUtils.getStringParameter(request, "hr",
					"");
			QueryReqBean<UumsAppSysDTO> queryReqBean = new QueryReqBean<>();
			UumsAppSysDTO dto = new UumsAppSysDTO();
			//判断是否过滤权威数据源HR系统
			if(!"ok".equals(hrStr)){
				dto.setIsDataSource("N");
			}
			queryReqBean.setSearchParams(dto);
			List<UumsAppSysDTO> dtoList = service.searchUumsAppSys(queryReqBean);
			// 应用系统根节点
			TreeNode tree = new TreeNode();
			List<TreeNode> treeList = new ArrayList<TreeNode>();
			tree.setId("root");
			tree.setText("应用系统");
			//tree.setState("open");
			//tree.setIconCls("icon-org");
			
			List<TreeNode> childrenList = new ArrayList<>();
			for(UumsAppSysDTO appSys : dtoList){
				TreeNode node = new TreeNode();
				node.setId(appSys.getId());
				node.setText(appSys.getAppName());
				//node.setIconCls("icon-org");
				childrenList.add(node);
			}
			tree.setChildren(childrenList);
			treeList.add(tree);
			
			// 注意：返回的必须是包含树节点的List类型,否则树无法渲染出来。
			mav.addObject("data", treeList);
		} catch (Exception ex) {
			logger.debug(ex.getMessage());
			mav.addObject("error", ex.getMessage());
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}
}
