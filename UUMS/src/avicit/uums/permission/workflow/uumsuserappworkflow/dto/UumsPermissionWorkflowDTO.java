package avicit.uums.permission.workflow.uumsuserappworkflow.dto;

import javax.persistence.Id;
//import javax.persistence.Transient;

import avicit.platform6.core.domain.BeanDTO;
import avicit.platform6.core.properties.PlatformConstant.LogType;
import avicit.platform6.core.annotation.log.LogField;
import avicit.platform6.core.annotation.log.FieldRemark;
import avicit.platform6.core.annotation.log.PojoRemark;

/**
 * bean UumsPermissionWorkflow Title: 表UUMS_PERMISSION_WORKFLOW的PoJo类，也就是数据库映射类
 * Description: 用户应用系统权限审批流程 Copyriht: Copyright (c) 2012 Company: AVICIT Co.,
 * Ltd
 * 
 * @author AVICIT DEV
 * @version 1.0 Date: 2015-12-25 09:44
 * 
 */
@PojoRemark(table = "uums_permission_workflow", object = "UumsPermissionWorkflowDTO", name = "用户应用系统权限审批流程")
public class UumsPermissionWorkflowDTO extends BeanDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@LogField
	@FieldRemark(column = "id", field = "id", name = "ID")
	private java.lang.String id;
	@LogField
	@FieldRemark(column = "wf_id", field = "wfId", name = "流程表单ID")
	private java.lang.String wfId;
	@LogField
	@FieldRemark(column = "up_id", field = "upId", name = "用户权限ID")
	private java.lang.String upId;
	
	public java.lang.String getId() {
		return id;
	}

	public void setId(java.lang.String id) {
		this.id = id;
	}

	public java.lang.String getWfId() {
		return wfId;
	}

	public void setWfId(java.lang.String wfId) {
		this.wfId = wfId;
	}

	public java.lang.String getUpId() {
		return upId;
	}

	public void setUpId(java.lang.String upId) {
		this.upId = upId;
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