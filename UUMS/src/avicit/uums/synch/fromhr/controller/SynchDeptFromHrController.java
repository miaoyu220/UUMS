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
import avicit.uums.synch.fromhr.service.SynchDeptFromHrService;

@Controller
@Scope("prototype")
@RequestMapping("uums/synch/fromhr/SynchDeptFromHrController")
public class SynchDeptFromHrController {
	private static final Logger logger = LoggerFactory
			.getLogger(SynchDeptFromHrController.class);

	@Autowired
	private SynchDeptFromHrService deptService;
	
	@RequestMapping(value = "/synchDeptFromHr")
	public ModelAndView synchDeptFromHr(HttpServletRequest request)
			throws Exception {
		ModelAndView mav = new ModelAndView();
		try {
			//当前登录人姓名
			String userName = getCurrLoginUserName(request);
			deptService.synchDeptFromHr("1", userName);
			
			mav.addObject("flag", OpResult.success);
		} catch (Exception ex) {
			logger.debug(ex.getMessage());
			mav.addObject("error", ex.getMessage());
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}
	
	@RequestMapping(value = "/saveDeptFromHr")
	public ModelAndView saveDeptFromHr(HttpServletRequest request)
			throws Exception {
		ModelAndView mav = new ModelAndView();
		try {
			//当前登录人姓名
			String userName = getCurrLoginUserName(request);
			// 新增
			deptService.saveOrUpdateSysDept("1", "1", userName);
			
			mav.addObject("flag", OpResult.success);
		} catch (Exception ex) {
			logger.debug(ex.getMessage());
			mav.addObject("error", ex.getMessage());
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}

	@RequestMapping(value = "/upateDeptFromHr")
	public ModelAndView updateDeptFromHr(HttpServletRequest request)
			throws Exception {
		ModelAndView mav = new ModelAndView();
		try {
			//当前登录人姓名
			String userName = getCurrLoginUserName(request);
			// 更新
			deptService.saveOrUpdateSysDept("2", "1", userName);

			mav.addObject("flag", OpResult.success);
		} catch (Exception ex) {
			logger.debug(ex.getMessage());
			mav.addObject("error", ex.getMessage());
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}

	@RequestMapping(value = "/deleteDeptFromHr")
	public ModelAndView deleteDeptFromHr(HttpServletRequest request)
			throws Exception {
		ModelAndView mav = new ModelAndView();
		try {
			//当前登录人姓名
			String userName = getCurrLoginUserName(request);
			// 删除
			deptService.deleteSysDept("1", userName);

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
