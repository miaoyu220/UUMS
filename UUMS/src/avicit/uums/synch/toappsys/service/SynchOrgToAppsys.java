package avicit.uums.synch.toappsys.service;

/**
 * 
 * 组织信息同步接口
 * @author miaoyu
 * @since 2016年1月6日
 *
 */
public interface SynchOrgToAppsys {

	/**
	 * 初始化所有组织数据到应用系统
	 * @param appId 应用系统ID
	 * @param synchType 同步操作类型，1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception 
	 */
	public void initAllOrgDeptToAppByAppId(String appId, String synchType, String operator) throws Exception;
	
	/**
	 * 同步所有新增、更新、删除的组织到已注册的应用系统中
	 * @param synchType 同步操作类型：1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception
	 */
	public void synchAllOrgDeptToAppByAllApp(String synchType, String operator) throws Exception;
	
	/**
	 * 同步新增、更新、删除的组织到应用系统
	 * @param appId 应用系统ID
	 * @param synchType 同步操作类型：1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception 
	 */
	public void synchAllOrgDeptToAppByAppId(String appId, String synchType, String operator) throws Exception;
	
	/**
	 * 同步新增组织到应用系统
	 * @param appId 应用系统ID
	 * @param synchType 同步操作类型：1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception 
	 */
	public void synchInsertedOrgDeptToAppByAppId(String appId, String synchType, String operator) throws Exception;
	
	/**
	 * 同步已更新组织到应用系统
	 * @param appId 应用系统ID
	 * @param synchType 同步操作类型：1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception 
	 */
	public void synchUpdatedOrgDeptToAppByAppId(String appId, String synchType, String operator) throws Exception;
	
	/**
	 * 同步已删除组织到应用系统
	 * @param appId 应用系统ID
	 * @param synchType 同步操作类型：1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception 
	 */
	public void synchDeletedOrgDeptToAppByAppId(String appId, String synchType, String operator) throws Exception;

	/**
	 * 初始化所有组织数据到应用系统
	 * @param appCode 应用系统编码
	 * @param synchType 同步操作类型：1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception 
	 */
	public void initAllOrgDeptToAppByAppCode(String appCode, String synchType, String operator) throws Exception;
	
	/**
	 * 同步新增、更新、删除的组织到应用系统
	 * @param appCode 应用系统编码
	 * @param synchType 同步操作类型：1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception 
	 */
	public void synchAllOrgDeptToAppByAppCode(String appCode, String synchType, String operator) throws Exception;
	
	/**
	 * 同步新增组织到应用系统
	 * @param appCode 应用系统编码
	 * @param synchType 同步操作类型：1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception 
	 */
	public void synchInsertedOrgDeptToAppByAppCode(String appCode, String synchType, String operator) throws Exception;
	
	/**
	 * 同步已更新组织到应用系统
	 * @param appCode 应用系统编码
	 * @param synchType 同步操作类型：1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception 
	 */
	public void synchUpdatedOrgDeptToAppByAppCode(String appCode, String synchType, String operator) throws Exception;
	
	/**
	 * 同步已删除组织到应用系统
	 * @param appCode 应用系统编码
	 * @param synchType 同步操作类型：1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception 
	 */
	public void synchDeletedOrgDeptToAppByAppCode(String appCode, String synchType, String operator) throws Exception;

}
