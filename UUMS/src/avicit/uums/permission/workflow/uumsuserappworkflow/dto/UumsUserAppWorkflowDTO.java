package avicit.uums.permission.workflow.uumsuserappworkflow.dto;

import javax.persistence.Id;
//import javax.persistence.Transient;

import avicit.platform6.core.domain.BeanDTO;
import avicit.platform6.core.properties.PlatformConstant.LogType;
import avicit.platform6.core.annotation.log.LogField;
import avicit.platform6.core.annotation.log.FieldRemark;
import avicit.platform6.core.annotation.log.PojoRemark;

/**
 * bean UumsUserAppWorkflow Title: 表UUMS_USER_APP_WORKFLOW的PoJo类，也就是数据库映射类
 * Description: 用户应用系统权限审批表 Copyriht: Copyright (c) 2012 Company: AVICIT Co.,
 * Ltd
 * 
 * @author AVICIT DEV
 * @version 1.0 Date: 2015-12-25 09:44
 * 
 */
@PojoRemark(table = "uums_user_app_workflow", object = "UumsUserAppWorkflowDTO", name = "用户应用系统权限审批表")
public class UumsUserAppWorkflowDTO extends BeanDTO {
	private static final long serialVersionUID = 1L;
	private java.lang.String activityalias_; // 节点中文名称
	private java.lang.String activityname_; // 当前节点id
	private java.lang.String businessstate_; // 流程当前状态

	@Id
	@LogField
	@FieldRemark(column = "id", field = "id", name = "ID")
	private java.lang.String id;
	@LogField
	@FieldRemark(column = "app_id", field = "appId", name = "应用系统")
	private java.lang.String appId;
	@LogField
	@FieldRemark(column = "p_id", field = "pid", name = "用户权限ID")
	private java.lang.String pid;
	@LogField
	@FieldRemark(column = "work_flow_no", field = "workFlowNo", name = "流程编号")
	private java.lang.String workFlowNo;
	@LogField
	@FieldRemark(column = "submitter", field = "submitter", name = "提交人")
	private java.lang.String submitter;
	private java.lang.String submitterAlias;
	@LogField
	@FieldRemark(column = "submit_date", field = "submitDate", name = "提交日期")
	private java.util.Date submitDate;

	private java.util.Date submitDateBegin;

	private java.util.Date submitDateEnd;
	
	@LogField
	@FieldRemark(column = "oper_flag", field = "operFlag", name = "操作状态")
	private java.lang.String operFlag;

	@FieldRemark(column = "audit_status", field = "auditStatus", name = "审批状态")
	private java.lang.String auditStatus;

	@FieldRemark(column = "audit_opinion", field = "auditOpinion", name = "审批意见")
	private java.lang.String auditOpinion;

	@FieldRemark(column = "audit_date", field = "auditDate", name = "审批日期")
	private java.util.Date auditDate;

	private java.util.Date auditDateBegin;

	private java.util.Date auditDateEnd;

	@FieldRemark(column = "audit_person", field = "auditPerson", name = "审批人")
	private java.lang.String auditPerson;
	@FieldRemark(column = "user_id", field = "userId", name = "用户ID")
	private java.lang.String userId; //用户ID
	private java.lang.String userIdAlias;//用户姓名
	private String appCode;//应用系统编码
	private String appName;//应用系统名称
	private String submitDeptId;//提交人部门ID
	private String submitDeptName;//提交人部门名称
	private String operType;//用户权限操作类型：addP(新增)|editP(更新)|delP(删除)
	
	public java.lang.String getOperFlag() {
		return operFlag;
	}

	public void setOperFlag(java.lang.String operFlag) {
		this.operFlag = operFlag;
	}

	public String getOperType() {
		return operType;
	}

	public void setOperType(String operType) {
		this.operType = operType;
	}

	public String getAppName() {
		return appName;
	}

	public void setAppName(String appName) {
		this.appName = appName;
	}

	public String getSubmitDeptId() {
		return submitDeptId;
	}

	public void setSubmitDeptId(String submitDeptId) {
		this.submitDeptId = submitDeptId;
	}

	public String getSubmitDeptName() {
		return submitDeptName;
	}

	public void setSubmitDeptName(String submitDeptName) {
		this.submitDeptName = submitDeptName;
	}

	public String getAppCode() {
		return appCode;
	}

	public void setAppCode(String appCode) {
		this.appCode = appCode;
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

	public java.lang.String getPid() {
		return pid;
	}

	public void setPid(java.lang.String pid) {
		this.pid = pid;
	}

	public java.lang.String getWorkFlowNo() {
		return workFlowNo;
	}

	public void setWorkFlowNo(java.lang.String workFlowNo) {
		this.workFlowNo = workFlowNo;
	}

	public java.lang.String getSubmitter() {
		return submitter;
	}

	public void setSubmitter(java.lang.String submitter) {
		this.submitter = submitter;
	}

	public java.lang.String getSubmitterAlias() {
		return submitterAlias;
	}

	public void setSubmitterAlias(java.lang.String submitterAlias) {
		this.submitterAlias = submitterAlias;
	}

	public java.util.Date getSubmitDate() {
		return submitDate;
	}

	public void setSubmitDate(java.util.Date submitDate) {
		this.submitDate = submitDate;
	}

	public java.util.Date getSubmitDateBegin() {
		return submitDateBegin;
	}

	public void setSubmitDateBegin(java.util.Date submitDateBegin) {
		this.submitDateBegin = submitDateBegin;
	}

	public java.util.Date getSubmitDateEnd() {
		return submitDateEnd;
	}

	public void setSubmitDateEnd(java.util.Date submitDateEnd) {
		this.submitDateEnd = submitDateEnd;
	}

	public java.lang.String getAuditStatus() {
		return auditStatus;
	}

	public void setAuditStatus(java.lang.String auditStatus) {
		this.auditStatus = auditStatus;
	}

	public java.lang.String getAuditOpinion() {
		return auditOpinion;
	}

	public void setAuditOpinion(java.lang.String auditOpinion) {
		this.auditOpinion = auditOpinion;
	}

	public java.util.Date getAuditDate() {
		return auditDate;
	}

	public void setAuditDate(java.util.Date auditDate) {
		this.auditDate = auditDate;
	}

	public java.util.Date getAuditDateBegin() {
		return auditDateBegin;
	}

	public void setAuditDateBegin(java.util.Date auditDateBegin) {
		this.auditDateBegin = auditDateBegin;
	}

	public java.util.Date getAuditDateEnd() {
		return auditDateEnd;
	}

	public void setAuditDateEnd(java.util.Date auditDateEnd) {
		this.auditDateEnd = auditDateEnd;
	}

	public java.lang.String getAuditPerson() {
		return auditPerson;
	}

	public void setAuditPerson(java.lang.String auditPerson) {
		this.auditPerson = auditPerson;
	}

	public java.lang.String getUserId() {
		return userId;
	}

	public void setUserId(java.lang.String userId) {
		this.userId = userId;
	}

	public java.lang.String getUserIdAlias() {
		return userIdAlias;
	}

	public void setUserIdAlias(java.lang.String userIdAlias) {
		this.userIdAlias = userIdAlias;
	}

	public java.lang.String getActivityalias_() {
		return activityalias_;
	}

	public void setActivityalias_(java.lang.String activityalias_) {
		this.activityalias_ = activityalias_;
	}

	public java.lang.String getActivityname_() {
		return activityname_;
	}

	public void setActivityname_(java.lang.String activityname_) {
		this.activityname_ = activityname_;
	}

	public java.lang.String getBusinessstate_() {
		return businessstate_;
	}

	public void setBusinessstate_(java.lang.String businessstate_) {
		this.businessstate_ = businessstate_;
	}

	public String getLogFormName() {
		if (super.logFormName == null || super.logFormName.equals("")) {
			return "用户应用系统权限审批表";
		} else {
			return super.logFormName;
		}
	}

	public String getLogTitle() {
		if (super.logTitle == null || super.logTitle.equals("")) {
			return "用户应用系统权限审批表";
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