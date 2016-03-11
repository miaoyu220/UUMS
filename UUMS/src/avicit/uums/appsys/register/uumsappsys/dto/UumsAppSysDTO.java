package avicit.uums.appsys.register.uumsappsys.dto;

import javax.persistence.Id;
//import javax.persistence.Transient;

import avicit.platform6.core.domain.BeanDTO;
import avicit.platform6.core.properties.PlatformConstant.LogType;
import avicit.platform6.core.annotation.log.LogField;
import avicit.platform6.core.annotation.log.FieldRemark;
import avicit.platform6.core.annotation.log.PojoRemark;

/**
 * bean UumsAppSys Title: 表UUMS_APP_SYS的PoJo类，也就是数据库映射类 Description: 应用系统注册管理
 * Copyriht: Copyright (c) 2012 Company: AVICIT Co., Ltd
 * 
 * @author AVICIT DEV
 * @version 1.0 Date: 2015-11-27 15:02
 * 
 */
@PojoRemark(table = "uums_app_sys", object = "UumsAppSysDTO", name = "应用系统注册管理")
public class UumsAppSysDTO extends BeanDTO {
	private static final long serialVersionUID = 1L;

	@Id
	@LogField
	@FieldRemark(column = "id", field = "id", name = "主键ID")
	private java.lang.String id;
	@LogField
	@FieldRemark(column = "app_code", field = "appCode", name = "应用系统编码")
	private java.lang.String appCode;
	@LogField
	@FieldRemark(column = "app_name", field = "appName", name = "应用系统名称")
	private java.lang.String appName;

	@FieldRemark(column = "app_describe", field = "appDescribe", name = "应用系统简介")
	private java.lang.String appDescribe;
	@LogField
	@FieldRemark(column = "securit_admin", field = "securitAdmin", name = "系统安全管理员")
	private java.lang.String securitAdmin;
	private java.lang.String securitAdminAlias;
	@LogField
	@FieldRemark(column = "is_data_source", field = "isDataSource", name = "是否权威数据源")
	private java.lang.String isDataSource;
	@LogField
	@FieldRemark(column = "IS_AUTO_CREATE_ACCOUNT", field = "isAutoCreateAccount", name = "是否自动生成账号")
	private String isAutoCreateAccount;
	@LogField
	@FieldRemark(column = "add_audit_flag", field = "addAuditFlag", name = "新增是否审批")
	private java.lang.String addAuditFlag;
	@LogField
	@FieldRemark(column = "edit_audit_flag", field = "editAuditFlag", name = "修改是否审批")
	private java.lang.String editAuditFlag;
	@LogField
	@FieldRemark(column = "del_audit_flag", field = "delAuditFlag", name = "删除是否审批")
	private java.lang.String delAuditFlag;

	@FieldRemark(column = "synch_type", field = "synchType", name = "同步方式")
	private java.lang.String synchType;

	@FieldRemark(column = "create_time", field = "createTime", name = "创建时间")
	private java.util.Date createTime;

	private java.util.Date createTimeBegin;

	private java.util.Date createTimeEnd;

	@FieldRemark(column = "update_time", field = "updateTime", name = "修改时间")
	private java.util.Date updateTime;

	private java.util.Date updateTimeBegin;

	private java.util.Date updateTimeEnd;

	@FieldRemark(column = "order_by", field = "orderBy", name = "排序")
	private long orderBy;

	public java.lang.String getId() {
		return id;
	}

	public void setId(java.lang.String id) {
		this.id = id;
	}

	public java.lang.String getAppCode() {
		return appCode;
	}
	
	public String getIsAutoCreateAccount() {
		return isAutoCreateAccount;
	}

	public void setIsAutoCreateAccount(String isAutoCreateAccount) {
		this.isAutoCreateAccount = isAutoCreateAccount;
	}

	public void setAppCode(java.lang.String appCode) {
		this.appCode = appCode;
	}

	public java.lang.String getAppName() {
		return appName;
	}

	public void setAppName(java.lang.String appName) {
		this.appName = appName;
	}

	public java.lang.String getAppDescribe() {
		return appDescribe;
	}

	public void setAppDescribe(java.lang.String appDescribe) {
		this.appDescribe = appDescribe;
	}

	public java.lang.String getSecuritAdmin() {
		return securitAdmin;
	}

	public void setSecuritAdmin(java.lang.String securitAdmin) {
		this.securitAdmin = securitAdmin;
	}

	public java.lang.String getSecuritAdminAlias() {
		return securitAdminAlias;
	}

	public void setSecuritAdminAlias(java.lang.String securitAdminAlias) {
		this.securitAdminAlias = securitAdminAlias;
	}

	public java.lang.String getIsDataSource() {
		return isDataSource;
	}

	public void setIsDataSource(java.lang.String isDataSource) {
		this.isDataSource = isDataSource;
	}

	public java.lang.String getAddAuditFlag() {
		return addAuditFlag;
	}

	public void setAddAuditFlag(java.lang.String addAuditFlag) {
		this.addAuditFlag = addAuditFlag;
	}

	public java.lang.String getEditAuditFlag() {
		return editAuditFlag;
	}

	public void setEditAuditFlag(java.lang.String editAuditFlag) {
		this.editAuditFlag = editAuditFlag;
	}

	public java.lang.String getDelAuditFlag() {
		return delAuditFlag;
	}

	public void setDelAuditFlag(java.lang.String delAuditFlag) {
		this.delAuditFlag = delAuditFlag;
	}

	public java.lang.String getSynchType() {
		return synchType;
	}

	public void setSynchType(java.lang.String synchType) {
		this.synchType = synchType;
	}

	public java.util.Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(java.util.Date createTime) {
		this.createTime = createTime;
	}

	public java.util.Date getCreateTimeBegin() {
		return createTimeBegin;
	}

	public void setCreateTimeBegin(java.util.Date createTimeBegin) {
		this.createTimeBegin = createTimeBegin;
	}

	public java.util.Date getCreateTimeEnd() {
		return createTimeEnd;
	}

	public void setCreateTimeEnd(java.util.Date createTimeEnd) {
		this.createTimeEnd = createTimeEnd;
	}

	public java.util.Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(java.util.Date updateTime) {
		this.updateTime = updateTime;
	}

	public java.util.Date getUpdateTimeBegin() {
		return updateTimeBegin;
	}

	public void setUpdateTimeBegin(java.util.Date updateTimeBegin) {
		this.updateTimeBegin = updateTimeBegin;
	}

	public java.util.Date getUpdateTimeEnd() {
		return updateTimeEnd;
	}

	public void setUpdateTimeEnd(java.util.Date updateTimeEnd) {
		this.updateTimeEnd = updateTimeEnd;
	}

	public long getOrderBy() {
		return orderBy;
	}

	public void setOrderBy(long orderBy) {
		this.orderBy = orderBy;
	}

	public String getLogFormName() {
		if (super.logFormName == null || super.logFormName.equals("")) {
			return "应用系统注册管理";
		} else {
			return super.logFormName;
		}
	}

	public String getLogTitle() {
		if (super.logTitle == null || super.logTitle.equals("")) {
			return "应用系统注册管理";
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