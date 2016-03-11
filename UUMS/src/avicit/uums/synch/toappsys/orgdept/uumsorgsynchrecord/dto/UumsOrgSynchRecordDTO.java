package avicit.uums.synch.toappsys.orgdept.uumsorgsynchrecord.dto;

import javax.persistence.Id;
//import javax.persistence.Transient;

import avicit.platform6.core.domain.BeanDTO;
import avicit.platform6.core.properties.PlatformConstant.LogType;
import avicit.platform6.core.annotation.log.LogField;
import avicit.platform6.core.annotation.log.FieldRemark;
import avicit.platform6.core.annotation.log.PojoRemark;

/**
 * bean UumsOrgSynchRecord Title: 表UUMS_ORG_SYNCH_RECORD的PoJo类，也就是数据库映射类
 * Description: 组织信息同步记录表 Copyriht: Copyright (c) 2012 Company: AVICIT Co., Ltd
 * 
 * @author AVICIT DEV
 * @version 1.0 Date: 2016-01-06 11:07
 * 
 */
@PojoRemark(table = "uums_org_synch_record", object = "UumsOrgSynchRecordDTO", name = "组织信息同步记录表")
public class UumsOrgSynchRecordDTO extends BeanDTO {
	private static final long serialVersionUID = 1L;

	@Id
	@LogField
	@FieldRemark(column = "id", field = "id", name = "主键ID")
	private java.lang.String id;
	@LogField
	@FieldRemark(column = "org_code", field = "orgCode", name = "组织编码")
	private java.lang.String orgCode;

	@FieldRemark(column = "org_or_dept", field = "orgOrDept", name = "组织OR部门")
	private java.lang.String orgOrDept;
	@LogField
	@FieldRemark(column = "oper_flag", field = "operFlag", name = "操作状态")
	private java.lang.String operFlag;
	@LogField
	@FieldRemark(column = "synch_flag", field = "synchFlag", name = "同步状态")
	private java.lang.String synchFlag;

	@FieldRemark(column = "update_time", field = "updateTime", name = "更新时间")
	private java.util.Date updateTime;

	private java.util.Date updateTimeBegin;

	private java.util.Date updateTimeEnd;

	@FieldRemark(column = "synch_time", field = "synchTime", name = "同步时间")
	private java.util.Date synchTime;

	private java.util.Date synchTimeBegin;

	private java.util.Date synchTimeEnd;

	@FieldRemark(column = "synch_type", field = "synchType", name = "同步方式")
	private java.lang.String synchType;

	@FieldRemark(column = "parent_org_code", field = "parentOrgCode", name = "父组织编码")
	private java.lang.String parentOrgCode;
	@LogField
	@FieldRemark(column = "sys_org_id", field = "sysOrgId", name = "组织ID")
	private java.lang.String sysOrgId;
	@LogField
	@FieldRemark(column = "app_id", field = "appId", name = "应用系统")
	private java.lang.String appId;
	@LogField
	@FieldRemark(column = "org_name", field = "orgName", name = "组织名称")
	private String orgName;
	
	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}

	public java.lang.String getId() {
		return id;
	}

	public void setId(java.lang.String id) {
		this.id = id;
	}

	public java.lang.String getOrgCode() {
		return orgCode;
	}

	public void setOrgCode(java.lang.String orgCode) {
		this.orgCode = orgCode;
	}

	public java.lang.String getOrgOrDept() {
		return orgOrDept;
	}

	public void setOrgOrDept(java.lang.String orgOrDept) {
		this.orgOrDept = orgOrDept;
	}

	public java.lang.String getOperFlag() {
		return operFlag;
	}

	public void setOperFlag(java.lang.String operFlag) {
		this.operFlag = operFlag;
	}

	public java.lang.String getSynchFlag() {
		return synchFlag;
	}

	public void setSynchFlag(java.lang.String synchFlag) {
		this.synchFlag = synchFlag;
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

	public java.lang.String getSynchType() {
		return synchType;
	}

	public void setSynchType(java.lang.String synchType) {
		this.synchType = synchType;
	}

	public java.lang.String getParentOrgCode() {
		return parentOrgCode;
	}

	public void setParentOrgCode(java.lang.String parentOrgCode) {
		this.parentOrgCode = parentOrgCode;
	}

	public java.lang.String getSysOrgId() {
		return sysOrgId;
	}

	public void setSysOrgId(java.lang.String sysOrgId) {
		this.sysOrgId = sysOrgId;
	}

	public java.lang.String getAppId() {
		return appId;
	}

	public void setAppId(java.lang.String appId) {
		this.appId = appId;
	}

	public String getLogFormName() {
		if (super.logFormName == null || super.logFormName.equals("")) {
			return "组织信息同步记录表";
		} else {
			return super.logFormName;
		}
	}

	public String getLogTitle() {
		if (super.logTitle == null || super.logTitle.equals("")) {
			return "组织信息同步记录表";
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