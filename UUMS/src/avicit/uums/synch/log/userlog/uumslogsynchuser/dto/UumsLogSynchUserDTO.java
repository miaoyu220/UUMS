package avicit.uums.synch.log.userlog.uumslogsynchuser.dto;

import javax.persistence.Id;
//import javax.persistence.Transient;

import avicit.platform6.core.domain.BeanDTO;
import avicit.platform6.core.properties.PlatformConstant.LogType;
import avicit.platform6.core.annotation.log.LogField;
import avicit.platform6.core.annotation.log.FieldRemark;
import avicit.platform6.core.annotation.log.PojoRemark;

/**
 * bean UumsLogSynchUser Title: 表UUMS_LOG_SYNCH_USER的PoJo类，也就是数据库映射类
 * Description: 用户同步日志表 Copyriht: Copyright (c) 2012 Company: AVICIT Co., Ltd
 * 
 * @author AVICIT DEV
 * @version 1.0 Date: 2016-03-08 14:59
 * 
 */
@PojoRemark(table = "uums_log_synch_user", object = "UumsLogSynchUserDTO", name = "用户同步日志表")
public class UumsLogSynchUserDTO extends BeanDTO {
	private static final long serialVersionUID = 1L;

	@Id
	@LogField
	@FieldRemark(column = "id", field = "id", name = "ID")
	private java.lang.String id;
	@LogField
	@FieldRemark(column = "app_id", field = "appId", name = "应用系统")
	private java.lang.String appId;
	@LogField
	@FieldRemark(column = "user_name", field = "userName", name = "用户姓名")
	private java.lang.String userName;
	@LogField
	@FieldRemark(column = "user_id", field = "userId", name = "用户ID")
	private java.lang.String userId;
	@LogField
	@FieldRemark(column = "synch_time", field = "synchTime", name = "同步时间")
	private java.util.Date synchTime;

	private java.util.Date synchTimeBegin;

	private java.util.Date synchTimeEnd;
	@LogField
	@FieldRemark(column = "synch_flag", field = "synchFlag", name = "同步结果")
	private java.lang.String synchFlag;
	@LogField
	@FieldRemark(column = "oper_flag", field = "operFlag", name = "操作类型")
	private java.lang.String operFlag;
	@LogField
	@FieldRemark(column = "synch_type", field = "synchType", name = "同步方式")
	private java.lang.String synchType;

	@FieldRemark(column = "faild_cause", field = "faildCause", name = "失败原因")
	private java.lang.String faildCause;

	@FieldRemark(column = "operator", field = "operator", name = "操作人")
	private java.lang.String operator;
	private String appName;

	public String getAppName() {
		return appName;
	}

	public void setAppName(String appName) {
		this.appName = appName;
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

	public java.lang.String getUserName() {
		return userName;
	}

	public void setUserName(java.lang.String userName) {
		this.userName = userName;
	}

	public java.lang.String getUserId() {
		return userId;
	}

	public void setUserId(java.lang.String userId) {
		this.userId = userId;
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

	public java.lang.String getSynchFlag() {
		return synchFlag;
	}

	public void setSynchFlag(java.lang.String synchFlag) {
		this.synchFlag = synchFlag;
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

	public java.lang.String getFaildCause() {
		return faildCause;
	}

	public void setFaildCause(java.lang.String faildCause) {
		this.faildCause = faildCause;
	}

	public java.lang.String getOperator() {
		return operator;
	}

	public void setOperator(java.lang.String operator) {
		this.operator = operator;
	}

	public String getLogFormName() {
		if (super.logFormName == null || super.logFormName.equals("")) {
			return "用户同步日志表";
		} else {
			return super.logFormName;
		}
	}

	public String getLogTitle() {
		if (super.logTitle == null || super.logTitle.equals("")) {
			return "用户同步日志表";
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