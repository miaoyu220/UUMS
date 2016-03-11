package avicit.uums.appsys.synchmappermeta.uumssynchmappermetadata.dto;

import javax.persistence.Id;
//import javax.persistence.Transient;

import avicit.platform6.core.domain.BeanDTO;
import avicit.platform6.core.properties.PlatformConstant.LogType;
import avicit.platform6.core.annotation.log.LogField;
import avicit.platform6.core.annotation.log.FieldRemark;
import avicit.platform6.core.annotation.log.PojoRemark;

/**
 * bean UumsSynchMapperMetaData Title:
 * 表UUMS_SYNCH_MAPPER_META_DATA的PoJo类，也就是数据库映射类 Description:
 * 组织用户同步映射元数据，该表定义了需要同步给应用系统的组织和用户信息范围，支持数据库、LDAP同步范围，该表需要做数据初始化 Copyriht:
 * Copyright (c) 2012 Company: AVICIT Co., Ltd
 * 
 * @author AVICIT DEV
 * @version 1.0 Date: 2015-12-07 17:53
 * 
 */
@PojoRemark(table = "uums_synch_mapper_meta_data", object = "UumsSynchMapperMetaDataDTO", name = "组织用户同步映射元数据，该表定义了需要同步给应用系统的组织和用户信息范围，支持数据库、LDAP同步范围，该表需要做数据初始化")
public class UumsSynchMapperMetaDataDTO extends BeanDTO {
	private static final long serialVersionUID = 1L;

	@Id
	@LogField
	@FieldRemark(column = "id", field = "主键id", name = "主键ID")
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
	@FieldRemark(column = "data_type", field = "dataType", name = "字段数据类型")
	private java.lang.String dataType;

	@FieldRemark(column = "order_by", field = "orderBy", name = "排序")
	private long orderBy;

	@FieldRemark(column = "comments", field = "comments", name = "注释")
	private java.lang.String comments;
	@LogField
	@FieldRemark(column = "uums_attribute", field = "uumsAttribute", name = "UUMS字段")
	private java.lang.String uumsAttribute;

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

	public String getLogFormName() {
		if (super.logFormName == null || super.logFormName.equals("")) {
			return "组织用户同步映射元数据，该表定义了需要同步给应用系统的组织和用户信息范围，支持数据库、LDAP同步范围，该表需要做数据初始化";
		} else {
			return super.logFormName;
		}
	}

	public String getLogTitle() {
		if (super.logTitle == null || super.logTitle.equals("")) {
			return "组织用户同步映射元数据，该表定义了需要同步给应用系统的组织和用户信息范围，支持数据库、LDAP同步范围，该表需要做数据初始化";
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