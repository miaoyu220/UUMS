package avicit.uums.synch.fromhr.controller;
import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import avicit.platform6.api.session.SessionHelper;
import avicit.platform6.api.sysuser.dto.SysUser;
import avicit.platform6.core.properties.PlatformConstant.OpResult;
import avicit.uums.synch.fromhr.service.SynchOrgFromHrService;

@Controller
@Scope("prototype")
@RequestMapping("uums/synch/fromhr/SynchOrgFromHrController")
public class SynchOrgFromHrController {
	private static final Logger logger = LoggerFactory
			.getLogger(SynchOrgFromHrController.class);

	@Autowired
	private SynchOrgFromHrService orgService;

	@RequestMapping(value = "/synchOrgFromHr")
	public ModelAndView synchOrgFromHr(HttpServletRequest request)
			throws Exception {
		ModelAndView mav = new ModelAndView();
		try {
			//当前登录人姓名
			String userName = getCurrLoginUserName(request);
			// 同时同步组织和部门数据
			orgService.synchOrgDeptFromHr("1", userName);

			mav.addObject("flag", OpResult.success);
		} catch (Exception ex) {
			logger.debug(ex.getMessage());
			mav.addObject("error", ex.getMessage());
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}

	@RequestMapping(value = "/saveOrgFromHr")
	public ModelAndView saveOrgFromHr(HttpServletRequest request)
			throws Exception {
		ModelAndView mav = new ModelAndView();
		try {
			//当前登录人姓名
			String userName = getCurrLoginUserName(request);
			// 新增组织
			orgService.saveUpdateSysOrg("1", "1", userName);

			mav.addObject("flag", OpResult.success);
		} catch (Exception ex) {
			logger.debug(ex.getMessage());
			mav.addObject("error", ex.getMessage());
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}

	@RequestMapping(value = "/updateOrgFromHr")
	public ModelAndView updateOrgFromHr(HttpServletRequest request)
			throws Exception {
		ModelAndView mav = new ModelAndView();
		try {
			//当前登录人姓名
			String userName = getCurrLoginUserName(request);
			 // 更新组织
			orgService.saveUpdateSysOrg("2", "1", userName);

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

	@RequestMapping(value = "/deleteOrgFromHr")
	public ModelAndView deleteOrgFromHr(HttpServletRequest request)
			throws Exception {
		ModelAndView mav = new ModelAndView();
		try {
			//当前登录人姓名
			String userName = getCurrLoginUserName(request);
			 // 删除组织
			 orgService.deleteSysOrg("1", userName);

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
