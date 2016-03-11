package avicit.uums.synch.toappsys.service;

/**
 * 用户数据同步接口
 * @author miaoyu
 * @since 2016年1月9日
 *
 */
public interface SynchUserToAppsys {
	/**
	 * 初始化所有用户数据到应用系统
	 * @param appId 应用系统ID
	 * @param synchType 同步操作类型，1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception 
	 */
	public void initAllUserToAppByAppId(String appId) throws Exception;
	
	/**
	 * 同步所有新增、更新、删除的用户到已注册的应用系统中
	 * @param synchType 同步操作类型：1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception
	 */
	public void synchAllUserToAppByAllApp(String synchType, String operator) throws Exception;
	
	/**
	 * 同步新增、更新、删除的用户到应用系统
	 * @param appId 应用系统ID
	 * @param synchType 同步操作类型：1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception 
	 */
	public void synchAllUserToAppByAppId(String appId, String synchType, String operator) throws Exception;
	
	/**
	 * 同步新增用户到应用系统
	 * @param appId 应用系统ID
	 * @param synchType 同步操作类型：1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception 
	 */
	public void synchInsertedUserToAppByAppId(String appId, String synchType, String operator) throws Exception;
	
	/**
	 * 同步已更新用户到应用系统
	 * @param appId 应用系统ID
	 * @param synchType 同步操作类型：1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception 
	 */
	public void synchUpdatedUserToAppByAppId(String appId, String synchType, String operator) throws Exception;
	
	/**
	 * 同步已删除用户到应用系统
	 * @param appId 应用系统ID
	 * @param synchType 同步操作类型：1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception 
	 */
	public void synchDeletedUserToAppByAppId(String appId, String synchType, String operator) throws Exception;
	
	/**
	 * 初始化所有用户数据到应用系统
	 * @param appCode 应用系统编码
	 * @throws Exception 
	 */
	public void initAllUserToAppByAppCode(String appCode) throws Exception;
	
	/**
	 * 同步新增、更新、删除的用户到应用系统
	* @param appCode 应用系统编码
	 * @param synchType 同步操作类型：1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception 
	 */
	public void synchAllUserToAppByAppCode(String appCode, String synchType, String operator) throws Exception;
	
	/**
	 * 同步新增用户到应用系统
	 * @param appCode 应用系统编码
	 * @param synchType 同步操作类型：1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception 
	 */
	public void synchInsertedUserToAppByAppCode(String appCode, String synchType, String operator) throws Exception;
	
	/**
	 * 同步已更新用户到应用系统
	 * @param appCode 应用系统编码
	 * @param synchType 同步操作类型：1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception 
	 */
	public void synchUpdatedUserToAppByAppCode(String appCode, String synchType, String operator) throws Exception;
	
	/**
	 * 同步已删除用户到应用系统
	 * @param appCode 应用系统编码
	 * @param synchType 同步操作类型：1-手工同步，2-自动同步
	 * @param operator 操作人姓名
	 * @throws Exception 
	 */
	public void synchDeletedUserToAppByAppCode(String appCode, String synchType, String operator) throws Exception;
}
