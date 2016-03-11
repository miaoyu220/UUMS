package avicit.uums.appsys.synchconfig.uumssynchtypeconfig.dto;

import javax.persistence.Id;

import avicit.platform6.core.annotation.log.FieldRemark;
import avicit.platform6.core.annotation.log.LogField;
import avicit.platform6.core.annotation.log.PojoRemark;
import avicit.platform6.core.domain.BeanDTO;
import avicit.platform6.core.properties.PlatformConstant.LogType;

/**
 * bean UumsSynchOrgUserMapper Title:
 * 表UUMS_SYNCH_ORG_USER_MAPPER的PoJo类，也就是数据库映射类 Description: 应用系统组织和用户同步映射信息
 * Copyriht: Copyright (c) 2012 Company: AVICIT Co., Ltd
 * 
 * @author AVICIT DEV
 * @version 1.0 Date: 2015-11-27 15:38
 * 
 */
@PojoRemark(table = "uums_synch_org_user_mapper", object = "UumsSynchOrgUserMapperDTO", name = "应用系统组织和用户同步映射信息")
public class UumsSynchOrgUserMapperDTO extends BeanDTO {
	private static final long serialVersionUID = 1L;

	@Id
	@LogField
	@FieldRemark(column = "id", field = "id", name = "主键ID")
	private java.lang.String id;
	@LogField
	@FieldRemark(column = "main_type", field = "mainType", name = "主体类型")
	private java.lang.String mainType;
	@LogField
	@FieldRemark(column = "column_name", field = "columnName", name = "字段名称")
	private java.lang.String columnName;
	@LogField
	@FieldRemark(column = "column_code", field = "columnCode", name = "字段CODE")
	private java.lang.String columnCode;
	@LogField
	@FieldRemark(column = "data_type", field = "dataType", name = "数据类型")
	private java.lang.String dataType;

	@FieldRemark(column = "order_by", field = "orderBy", name = "排序")
	private long orderBy;

	@FieldRemark(column = "comments", field = "comments", name = "注释")
	private java.lang.String comments;
	@LogField
	@FieldRemark(column = "uums_attribute", field = "uumsAttribute", name = "UUMS字段")
	private java.lang.String uumsAttribute;

	@FieldRemark(column = "data_format", field = "dataFormat", name = "字段数据格式化")
	private java.lang.String dataFormat;
	@LogField
	@FieldRemark(column = "type_id", field = "typeId", name = "同步方式ID")
	private java.lang.String typeId;

	public java.lang.String getId() {
		return id;
	}

	public void setId(java.lang.String id) {
		this.id = id;
	}

	public java.lang.String getMainType() {
		return mainType;
	}

	public void setMainType(java.lang.String mainType) {
		this.mainType = mainType;
	}

	public java.lang.String getColumnName() {
		return columnName;
	}

	public void setColumnName(java.lang.String columnName) {
		this.columnName = columnName;
	}

	public java.lang.String getColumnCode() {
		return columnCode;
	}

	public void setColumnCode(java.lang.String columnCode) {
		this.columnCode = columnCode;
	}

	public java.lang.String getDataType() {
		return dataType;
	}

	public void setDataType(java.lang.String dataType) {
		this.dataType = dataType;
	}

	public long getOrderBy() {
		return orderBy;
	}

	public void setOrderBy(long orderBy) {
		this.orderBy = orderBy;
	}

	public java.lang.String getComments() {
		return comments;
	}

	public void setComments(java.lang.String comments) {
		this.comments = comments;
	}

	public java.lang.String getUumsAttribute() {
		return uumsAttribute;
	}

	public void setUumsAttribute(java.lang.String uumsAttribute) {
		this.uumsAttribute = uumsAttribute;
	}

	public java.lang.String getDataFormat() {
		return dataFormat;
	}

	public void setDataFormat(java.lang.String dataFormat) {
		this.dataFormat = dataFormat;
	}

	public java.lang.String getTypeId() {
		return typeId;
	}

	public void setTypeId(java.lang.String typeId) {
		this.typeId = typeId;
	}

	public String getLogFormName() {
		if (super.logFormName == null || super.logFormName.equals("")) {
			return "应用系统组织和用户同步映射信息";
		} else {
			return super.logFormName;
		}
	}

	public String getLogTitle() {
		if (super.logTitle == null || super.logTitle.equals("")) {
			return "应用系统组织和用户同步映射信息";
		} else {
			return super.logTitle;
		}
	}

	// @Transient
	public LogType getLogType() {
		if (super.logType == null || super.logType.equals("")) {
			return LogType.module_operate;
		} else {
			return super.logType;
		}
	}

}