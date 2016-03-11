package avicit.uums.synch.fromhr.controller;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import avicit.uums.synch.fromhr.service.SynchUserFromHrService;

@Controller
@Scope("prototype")
@RequestMapping("uums/synch/fromhr/SynchUserFromHrController")
public class SynchUserFromHrController {
	private static final Logger logger = LoggerFactory
			.getLogger(SynchUserFromHrController.class);
	@Autowired
	private SynchUserFromHrService synchUserFromHrService;

	@RequestMapping(value = "/synchSysUserFromHr")
	public ModelAndView synchSysUserFromHr(HttpServletResponse response,
			HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			//当前登录人姓名
			String userName = getCurrLoginUserName(request);
			// 新增用户
			synchUserFromHrService.saveSysUser("1", userName);
			// 更新用户
			synchUserFromHrService.updateSysUser("1", userName);
			// 删除用户
			synchUserFromHrService.deleteSysUser("1", userName);
			
			mav.addObject("flag", OpResult.success);
		} catch (Exception e) {
			logger.debug(e.getMessage(), e);
			mav.addObject("flag", OpResult.failure);
			mav.addObject("error", e.getMessage());
		}
		return mav;
	}

	// 保存用户
	@RequestMapping(value = "/saveUserFromHr")
	public ModelAndView saveSysUserFromHr(HttpServletResponse response,
			HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();

		try {
			// {"id":"8a58bc0c51a9c27f0151a9f329560055","no":"TEST201","loginName":"TEST201","name":"测试201","nameEn"
			// :"","deptId":"8a58bc0c51a9ab500151a9bd35740051","deptName":"综合管理部04","secretLevel":"1","positionId":"1"
			// ,"positionName":"普通员工","isManager":"0","ruleId":"8a58ab5f4be29ef7014be2d442bd01ab","ruleName":"一般用户"
			// ,"type":"0","languageCode":"zh_CN","sex":"1","title":"","status":"1","nation":"1","birthAddress":"","polity"
			// :"1","workDate":"","degree":"001","birthday":"","education":"","mobile":"","officeTel":"","fax":"","email"
			// :"","workSpace":"","roomNo":"","homeAddress":"","homeZip":"","homeTel":"","orderBy":"","unitCode":""
			// ,"remark":""}
//			Map<String, Object> sessionParam = SessionParam.makeSessionParam(
//					request, new String[] { SessionParam.applicationId });

			//当前登录人姓名
			String userName = getCurrLoginUserName(request);
			// 新增用户
			synchUserFromHrService.saveSysUser("1", userName);

			mav.addObject("flag", OpResult.success);
		} catch (Exception e) {
			logger.debug(e.getMessage(), e);
			mav.addObject("flag", OpResult.failure);
			mav.addObject("error", e.getMessage());
		}
		return mav;
	}

	// 更新用户
	@RequestMapping(value = "/updateUserFromHr")
	public ModelAndView updateUserFromHr(HttpServletResponse response,
			HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();

		try {
			//当前登录人姓名
			String userName = getCurrLoginUserName(request);
			// 更新用户
			synchUserFromHrService.updateSysUser("1", userName);

			mav.addObject("flag", OpResult.success);
		} catch (Exception e) {
			logger.debug(e.getMessage(), e);
			mav.addObject("flag", OpResult.failure);
			mav.addObject("error", e.getMessage());
		}
		return mav;
	}

	// 删除用户
	@RequestMapping(value = "/deleteUserFromHr")
	public ModelAndView deleteSysUserFromHr(HttpServletResponse response,
			HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			//当前登录人姓名
			String userName = getCurrLoginUserName(request);
			// 删除用户
			synchUserFromHrService.deleteSysUser("1", userName);

			mav.addObject("flag", OpResult.success);
			return mav;
		} catch (Exception e) {
			logger.debug(e.getMessage(), e);
			mav.addObject("flag", OpResult.failure);
			mav.addObject("error", e.getMessage());
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
