package avicit.uums.appsys.synchconfig.uumssynchtypeconfig.dto;

import javax.persistence.Id;

import avicit.platform6.core.annotation.log.FieldRemark;
import avicit.platform6.core.annotation.log.LogField;
import avicit.platform6.core.annotation.log.PojoRemark;
import avicit.platform6.core.domain.BeanDTO;
import avicit.platform6.core.properties.PlatformConstant.LogType;

/**
 * bean UumsSynchTypeConfig Title: 表UUMS_SYNCH_TYPE_CONFIG的PoJo类，也就是数据库映射类
 * Description: 应用系统同步方式配置信息 Copyriht: Copyright (c) 2012 Company: AVICIT Co.,
 * Ltd
 * 
 * @author AVICIT DEV
 * @version 1.0 Date: 2015-11-27 15:38
 * 
 */
@PojoRemark(table = "uums_synch_type_config", object = "UumsSynchTypeConfigDTO", name = "应用系统同步方式配置信息")
public class UumsSynchTypeConfigDTO extends BeanDTO {
	private static final long serialVersionUID = 1L;

	@Id
	@LogField
	@FieldRemark(column = "id", field = "id", name = "主键ID")
	private java.lang.String id;
	@LogField
	@FieldRemark(column = "app_id", field = "appId", name = "应用系统")
	private java.lang.String appId;
	private java.lang.String appIdAlias;

	@FieldRemark(column = "db_type", field = "dbType", name = "数据库类型")
	private java.lang.String dbType;

	@FieldRemark(column = "driver_class", field = "driverClass", name = "JDBC驱动类")
	private java.lang.String driverClass;

	@FieldRemark(column = "connect_str", field = "connectStr", name = "JDBC连接串")
	private java.lang.String connectStr;

	@FieldRemark(column = "user_name", field = "userName", name = "用户名")
	private java.lang.String userName;

	@FieldRemark(column = "password", field = "password", name = "密码")
	private java.lang.String password;

	@FieldRemark(column = "org_table", field = "orgTable", name = "组织机构表CODE")
	private java.lang.String orgTable;

	@FieldRemark(column = "user_table", field = "userTable", name = "用户表CODE")
	private java.lang.String userTable;

	@FieldRemark(column = "host_ip", field = "hostIp", name = "主机地址")
	private java.lang.String hostIp;

	@FieldRemark(column = "host_port", field = "hostPort", name = "端口")
	private java.lang.String hostPort;

	@FieldRemark(column = "org_object", field = "orgObject", name = "组织扩展对象类")
	private java.lang.String orgObject;

	@FieldRemark(column = "org_ou", field = "orgOu", name = "组织根路径")
	private java.lang.String orgOu;

	@FieldRemark(column = "user_object", field = "userObject", name = "用户扩展对象类")
	private java.lang.String userObject;

	@FieldRemark(column = "user_ou", field = "userOu", name = "用户根路径")
	private java.lang.String userOu;

	@FieldRemark(column = "ws_url", field = "wsUrl", name = "WS服务地址")
	private java.lang.String wsUrl;

	@FieldRemark(column = "synch_type", field = "synchType", name = "同步方式")
	private java.lang.String synchType;
	
	@FieldRemark(column = "db_name", field = "dbname", name = "数据库ID")
	private String dbname;
	

	public String getDbname() {
		return dbname;
	}

	public void setDbname(String dbname) {
		this.dbname = dbname;
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
	
	public java.lang.String getAppIdAlias() {
		return appIdAlias;
	}

	public void setAppIdAlias(java.lang.String appIdAlias) {
		this.appIdAlias = appIdAlias;
	}

	public void setAppId(java.lang.String appId) {
		this.appId = appId;
	}

	public java.lang.String getDbType() {
		return dbType;
	}

	public void setDbType(java.lang.String dbType) {
		this.dbType = dbType;
	}

	public java.lang.String getDriverClass() {
		return driverClass;
	}

	public void setDriverClass(java.lang.String driverClass) {
		this.driverClass = driverClass;
	}

	public java.lang.String getConnectStr() {
		return connectStr;
	}

	public void setConnectStr(java.lang.String connectStr) {
		this.connectStr = connectStr;
	}

	public java.lang.String getUserName() {
		return userName;
	}

	public void setUserName(java.lang.String userName) {
		this.userName = userName;
	}

	public java.lang.String getPassword() {
		return password;
	}

	public void setPassword(java.lang.String password) {
		this.password = password;
	}

	public java.lang.String getOrgTable() {
		return orgTable;
	}

	public void setOrgTable(java.lang.String orgTable) {
		this.orgTable = orgTable;
	}

	public java.lang.String getUserTable() {
		return userTable;
	}

	public void setUserTable(java.lang.String userTable) {
		this.userTable = userTable;
	}

	public java.lang.String getHostIp() {
		return hostIp;
	}

	public void setHostIp(java.lang.String hostIp) {
		this.hostIp = hostIp;
	}

	public java.lang.String getHostPort() {
		return hostPort;
	}

	public void setHostPort(java.lang.String hostPort) {
		this.hostPort = hostPort;
	}

	public java.lang.String getOrgObject() {
		return orgObject;
	}

	public void setOrgObject(java.lang.String orgObject) {
		this.orgObject = orgObject;
	}

	public java.lang.String getOrgOu() {
		return orgOu;
	}

	public void setOrgOu(java.lang.String orgOu) {
		this.orgOu = orgOu;
	}

	public java.lang.String getUserObject() {
		return userObject;
	}

	public void setUserObject(java.lang.String userObject) {
		this.userObject = userObject;
	}

	public java.lang.String getUserOu() {
		return userOu;
	}

	public void setUserOu(java.lang.String userOu) {
		this.userOu = userOu;
	}

	public java.lang.String getWsUrl() {
		return wsUrl;
	}

	public void setWsUrl(java.lang.String wsUrl) {
		this.wsUrl = wsUrl;
	}

	public java.lang.String getSynchType() {
		return synchType;
	}

	public void setSynchType(java.lang.String synchType) {
		this.synchType = synchType;
	}

	public String getLogFormName() {
		if (super.logFormName == null || super.logFormName.equals("")) {
			return "应用系统同步方式配置信息";
		} else {
			return super.logFormName;
		}
	}

	public String getLogTitle() {
		if (super.logTitle == null || super.logTitle.equals("")) {
			return "应用系统同步方式配置信息";
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