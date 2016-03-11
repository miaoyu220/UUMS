package avicit.uums.permission.synch.uumsuserapppermissions.dto;

import javax.persistence.Id;
//import javax.persistence.Transient;

import avicit.platform6.core.domain.BeanDTO;
import avicit.platform6.core.properties.PlatformConstant.LogType;
import avicit.platform6.core.annotation.log.LogField;
import avicit.platform6.core.annotation.log.FieldRemark;
import avicit.platform6.core.annotation.log.PojoRemark;

/**
 * bean UumsUserAppPermissions Title: 表UUMS_USER_APP_PERMISSIONS的PoJo类，也就是数据库映射类
 * Description: 用户应用系统权限管理 Copyriht: Copyright (c) 2012 Company: AVICIT Co., Ltd
 * 
 * @author AVICIT DEV
 * @version 1.0 Date: 2015-12-29 14:17
 * 
 */
@PojoRemark(table = "uums_user_app_permissions", object = "UumsUserAppPermissionsDTO", name = "用户应用系统权限管理")
public class UumsUserAppPermissionsDTO extends BeanDTO {
	private static final long serialVersionUID = 1L;

	@Id
	@LogField
	@FieldRemark(column = "id", field = "id", name = "主键ID")
	private java.lang.String id;
	@LogField
	@FieldRemark(column = "app_id", field = "appId", name = "应用系统")
	private java.lang.String appId;
	@LogField
	@FieldRemark(column = "user_id", field = "userId", name = "用户ID")
	private java.lang.String userId;

	@FieldRemark(column = "app_account", field = "appAccount", name = "映射账号")
	private java.lang.String appAccount;

	@FieldRemark(column = "app_pwd", field = "appPwd", name = "映射密码")
	private java.lang.String appPwd;
	@LogField
	@FieldRemark(column = "audit_flag", field = "auditFlag", name = "审批状态")
	private java.lang.String auditFlag;
	@LogField
	@FieldRemark(column = "synch_flag", field = "synchFlag", name = "同步状态")
	private java.lang.String synchFlag;
	@LogField
	@FieldRemark(column = "synch_time", field = "synchTime", name = "同步时间")
	private java.util.Date synchTime;

	private java.util.Date synchTimeBegin;

	private java.util.Date synchTimeEnd;
	@LogField
	@FieldRemark(column = "oper_flag", field = "operFlag", name = "操作状态")
	private java.lang.String operFlag;

	@FieldRemark(column = "synch_type", field = "synchType", name = "同步方式")
	private java.lang.String synchType;
	@LogField
	@FieldRemark(column = "act_flag", field = "actFlag", name = "活动状态")
	private java.lang.String actFlag;
	private String loginName;
	@FieldRemark(column = "user_name", field = "userName", name = "用户姓名")
	private String userName;
	private String deptName;
	@FieldRemark(column = "audit_status", field = "auditStatus", name = "审批结果")
	private String auditStatus;
	private String appName;
	private String unitCode;
	
	public String getUnitCode() {
		return unitCode;
	}

	public void setUnitCode(String unitCode) {
		this.unitCode = unitCode;
	}

	public String getAppName() {
		return appName;
	}

	public void setAppName(String appName) {
		this.appName = appName;
	}

	public String getAuditStatus() {
		return auditStatus;
	}

	public void setAuditStatus(String auditStatus) {
		this.auditStatus = auditStatus;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public java.lang.String getId() {
		return id;
	}

	public void setId(java.lang.String id) {
		this.id = id;
	}

	public java.lang.String getAppId() {
		return appId;
	}

	public void setAppId(java.lang.String appId) {
		this.appId = appId;
	}

	public java.lang.String getUserId() {
		return userId;
	}

	public void setUserId(java.lang.String userId) {
		this.userId = userId;
	}

	public java.lang.String getAppAccount() {
		return appAccount;
	}

	public void setAppAccount(java.lang.String appAccount) {
		this.appAccount = appAccount;
	}

	public java.lang.String getAppPwd() {
		return appPwd;
	}

	public void setAppPwd(java.lang.String appPwd) {
		this.appPwd = appPwd;
	}

	public java.lang.String getAuditFlag() {
		return auditFlag;
	}

	public void setAuditFlag(java.lang.String auditFlag) {
		this.auditFlag = auditFlag;
	}

	public java.lang.String getSynchFlag() {
		return synchFlag;
	}

	public void setSynchFlag(java.lang.String synchFlag) {
		this.synchFlag = synchFlag;
	}

	public java.util.Date getSynchTime() {
		return synchTime;
	}

	public void setSynchTime(java.util.Date synchTime) {
		this.synchTime = synchTime;
	}

	public java.util.Date getSynchTimeBegin() {
		return synchTimeBegin;
	}

	public void setSynchTimeBegin(java.util.Date synchTimeBegin) {
		this.synchTimeBegin = synchTimeBegin;
	}

	public java.util.Date getSynchTimeEnd() {
		return synchTimeEnd;
	}

	public void setSynchTimeEnd(java.util.Date synchTimeEnd) {
		this.synchTimeEnd = synchTimeEnd;
	}

	public java.lang.String getOperFlag() {
		return operFlag;
	}

	public void setOperFlag(java.lang.String operFlag) {
		this.operFlag = operFlag;
	}

	public java.lang.String getSynchType() {
		return synchType;
	}

	public void setSynchType(java.lang.String synchType) {
		this.synchType = synchType;
	}

	public java.lang.String getActFlag() {
		return actFlag;
	}

	public void setActFlag(java.lang.String actFlag) {
		this.actFlag = actFlag;
	}

	public String getLogFormName() {
		if (super.logFormName == null || super.logFormName.equals("")) {
			return "用户应用系统权限管理";
		} else {
			return super.logFormName;
		}
	}

	public String getLogTitle() {
		if (super.logTitle == null || super.logTitle.equals("")) {
			return "用户应用系统权限管理";
		} else {
			return super.logTitle;
		}
	}

	public LogType getLogType() {
		if (super.logType == null || super.logType.equals("")) {
			return LogType.module_operate;
		} else {
			return super.logType;
		}
	}

}