package avicit.uums.synch.job;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import avicit.platform6.core.spring.SpringFactory;
import avicit.uums.synch.fromhr.service.SynchOrgFromHrService;
import avicit.uums.synch.fromhr.service.SynchUserFromHrService;
import avicit.uums.synch.toappsys.service.SynchOrgToAppsys;
import avicit.uums.synch.toappsys.service.SynchOrgToAppsysImp;
import avicit.uums.synch.toappsys.service.SynchUserToAppsys;
import avicit.uums.synch.toappsys.service.SynchUserToAppsysImp;

/**
 * 应用系统同步任务执行类
 * @author miaoyu
 * @since 2016-2-29
 */
@Service
public class UumsSynchJob {
	private static final Logger logger = LoggerFactory
			.getLogger(UumsSynchJob.class);
	
	private SynchOrgToAppsys synchOrgToAppsys = SpringFactory.getBean(SynchOrgToAppsysImp.class);
	private SynchUserToAppsys synchUserToAppsys = SpringFactory.getBean(SynchUserToAppsysImp.class);
	private SynchOrgFromHrService synchOrgFromHrService = SpringFactory.getBean(SynchOrgFromHrService.class);
	private SynchUserFromHrService synchUserFromHrService = SpringFactory.getBean(SynchUserFromHrService.class);
	
	/**
	 * 从HR同步组织和用户数据的同步任务
	 * 在配置定时任务的执行时间时，优先考虑从权威数据源HR同步数据的任务先执行
	 */
	public void synchFromHr(){
		logger.info("*******************开始执行同步任务：synchFromHr****************");
		try {
			//同步新增修改的组织
			logger.info("*************开始从HR同步新增修改的组织数据***************");
			//synchOrgFromHrService.synchOrgDeptFromHr();
			synchOrgFromHrService.synchOrgDeptFromHrForAddUpdate("2", "系统管理员");
			logger.info("*************从HR同步新增修改的组织数据完成***************");
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			//同步用户
			logger.info("*************开始从HR同步用户数据***************");
			synchUserFromHrService.synchUserFromHr("2", "系统管理员");
			logger.info("*************从HR同步用户数据完成***************");
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			//最后同步删除的组织
			logger.info("*************开始从HR同步删除的组织数据***************");
			//synchOrgFromHrService.synchOrgDeptFromHr();
			synchOrgFromHrService.synchOrgDeptFromHrForDel("2", "系统管理员");
			logger.info("*************从HR同步删除的组织数据完成***************");
		} catch (Exception e) {
			e.printStackTrace();
		}
		logger.info("*******************执行同步任务完成：synchFromHr****************");
	}
	
	/*
	 * 无指定同步应用系统范围的情况下，执行向所有应用系统进行数据同步定时任务
	 * 不建议使用该同步任务，或者设置为周期比较长的同步任务，比如周任务
	 * @throws Exception
	 */
	public void synchAllAppSys(){
		logger.info("*******************开始执行同步任务：synchAllAppSys****************");
		try {
			//同步组织
			logger.info("*************开始同步组织数据***************");
			synchOrgToAppsys.synchAllOrgDeptToAppByAllApp("2", "系统管理员");
			logger.info("*************同步组织数据完成***************");
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			//同步用户
			logger.info("*************开始同步用户数据***************");
			synchUserToAppsys.synchAllUserToAppByAllApp("2", "系统管理员");
			logger.info("*************同步用户数据完成***************");
		} catch (Exception e) {
			e.printStackTrace();
		}
		logger.info("*******************执行同步任务完成：synchAllAppSys****************");
	}
	
	/**
	 * 根据指定的应用系统编码，执行向指定应用系统进行数据同步定时任务，
	 * 建议为每个应用系统创建一个同步任务，合理分配同步时间策略，减少服务器压力
	 * @param appSysCode 应用系统编码集合
	 * @throws Exception
	 */
	public void synchAppSysByCode(Map<String, Object> appSysCode){
		if(appSysCode == null){
			return;
		}else{
			String appCode = "";
			for(Object obj : appSysCode.values()){
				try {
					appCode = (String)obj;
					logger.info("**************开始执行同步任务：synchAppSysByCode, appCode: "+ appCode +"****************");
					if(StringUtils.isNotEmpty(appCode)){
						try {
							//同步组织
							logger.info("*************开始同步组织数据***************");
							synchOrgToAppsys.synchAllOrgDeptToAppByAppCode((String)appCode, "2", "系统管理员");
							logger.info("*************同步组织数据完成***************");
							
						} catch (Exception e) {
							e.printStackTrace();
						}
						try {
							//同步用户
							logger.info("*************开始同步用户数据***************");
							synchUserToAppsys.synchAllUserToAppByAppCode((String)appCode, "2", "系统管理员");
							logger.info("*************同步用户数据完成***************");
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				logger.info("**************执行同步任务完成：synchAppSysByCode, appCode: "+ appCode +"****************");
			}
		}
		
	}
}
