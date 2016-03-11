<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "uums/appsys/synchconfig/uumssynchtypeconfig/UumsSynchTypeConfigController/operation/Edit/id" -->
<title>修改</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include
	page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js"
	type="text/javascript"></script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false"
		style="overflow: auto; padding-bottom: 35px;">
		<form id='form'>
			<input type="hidden" name="id" value='${uumsSynchTypeConfigDTO.id}' />
			<table width="100%" style="padding-top: 3px;">
				<tr>
					<th align="right"><span style="color: red;">*</span>应用系统:</th>
					<td><input type="hidden" name="appId" id="appId" value='${uumsSynchTypeConfigDTO.appId}' />
						<input title="应用系统" class="easyui-validatebox" readonly="readonly"
							data-options="required:true,validType:'maxLength[50]'"
							style="width: 180px;" type="text" name="appIdAlias" id="appIdAlias"
							value='${uumsSynchTypeConfigDTO.appIdAlias}' />
						<%-- <select name="appIds" id="appId" class="easyui-combobox" data-options="width:180,editable:false,panelHeight:'auto'">
							<c:forEach items="${appSysList}" var="t">
								<c:choose>
									<c:when test="${t.id eq uumsSynchTypeConfigDTO.appId}">
										<option value="${t.id}" selected="selected">${t.appName}</option>
									</c:when>
									<c:otherwise>
										<option value="${t.id}">${t.appName}</option>
									</c:otherwise>
								</c:choose>  
							</c:forEach>
						</select> --%>
					</td>
				</tr>
				<tr>
					<th align="right"><span style="color: red;">*</span>同步方式:</th>
					<td><pt6:syslookup name="synchType" 
							lookupCode="UUMS_SYNCH_TYPE"
							defaultValue='${uumsSynchTypeConfigDTO.synchType}'
							dataOptions="width:180,editable:false,panelHeight:'auto',
							valueField:'id',textField:'typeName',onSelect: function(rec){    
						            changeShow(rec.id);
						        }">
						</pt6:syslookup></td>
				</tr>
				<!-- 数据库同步方式配置输入项 -->
				<tr id="db1">
					<th align="right"><span style="color: red;">*</span>数据库类型:</th>
					<td><pt6:syslookup name="dbType" lookupCode="UUMS_DB_TYPE"
							defaultValue='${uumsSynchTypeConfigDTO.dbType}'
							dataOptions="width:180,editable:false,panelHeight:'auto',
							valueField:'db',textField:'dbName',onSelect: function(rec){    
						            changeDriver(rec.db);
						        }">
						</pt6:syslookup></td>
				</tr>
				<tr id="host">
					<th align="right"><span style="color: red;">*</span>主机地址:</th>
					<td><input title="主机地址" class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[20]'" style="width: 180px;"
						type="text" name="hostIp" id="hostIp"
						value='${uumsSynchTypeConfigDTO.hostIp}' /></td>
				</tr>
				<tr id="port">
					<th align="right"><span style="color: red;">*</span>端口:</th>
					<td><input title="端口" class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[10]'" style="width: 180px;"
						type="text" name="hostPort" id="hostPort"
						value='${uumsSynchTypeConfigDTO.hostPort}' /></td>
				</tr>
				<tr id="db6">
					<th align="right"><span style="color: red;">*</span>数据库ID:</th>
					<td><input title="数据库ID" class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[10]'" style="width: 180px;"
						type="text" name="dbname" id="dbname" 
						value='${uumsSynchTypeConfigDTO.dbname}'/></td>
				</tr>
				<tr id="uname">
					<th align="right"><span style="color: red;">*</span>用户名:</th>
					<td><input title="用户名" class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[50]'" style="width: 180px;"
						type="text" name="userName" id="userName"
						value='${uumsSynchTypeConfigDTO.userName}' /></td>
				</tr>
				<tr id="pwd">
					<th align="right"><span style="color: red;">*</span>密码:</th>
					<td><input title="密码" class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[64]'" style="width: 180px;"
						type="text" name="password" id="password"
						value='${uumsSynchTypeConfigDTO.password}' /></td>
				</tr>
				<tr id="db2">
					<th align="right">JDBC驱动类:</th>
					<td><input title="JDBC驱动类" class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[200]'" style="width: 180px;"
						type="text" name="driverClass" id="driverClass"
						value='${uumsSynchTypeConfigDTO.driverClass}' /></td>
				</tr>
				<tr id="db3">
					<th align="right">JDBC连接串:</th>
					<td><input title="JDBC连接串" class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[200]'" style="width: 180px;"
						type="text" name="connectStr" id="connectStr"
						value='${uumsSynchTypeConfigDTO.connectStr}' /></td>
				</tr>
				<tr id="db4">
					<th align="right"><span style="color: red;">*</span>组织机构表CODE:</th>
					<td><input title="组织机构表CODE"
						class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[200]'" style="width: 180px;"
						type="text" name="orgTable" id="orgTable"
						value='${uumsSynchTypeConfigDTO.orgTable}' /></td>
				</tr>
				<tr id="db5">
					<th align="right"><span style="color: red;">*</span>用户表CODE:</th>
					<td><input title="用户表CODE" class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[200]'" style="width: 180px;"
						type="text" name="userTable" id="userTable"
						value='${uumsSynchTypeConfigDTO.userTable}' /></td>
				</tr>
				<!-- LDAP同步方式配置输入项 -->
				<tr id="ldap1">
					<th align="right">组织扩展对象类:</th>
					<td><input title="组织扩展对象类" class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[300]'" style="width: 180px;"
						type="text" name="orgObject" id="orgObject"
						value='${uumsSynchTypeConfigDTO.orgObject}' /></td>
				</tr>
				<tr id="ldap2">
					<th align="right"><span style="color: red;">*</span>组织根路径:</th>
					<td><input title="组织根路径" class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[300]'" style="width: 180px;"
						type="text" name="orgOu" id="orgOu"
						value='${uumsSynchTypeConfigDTO.orgOu}' /></td>
				</tr>
				<tr id="ldap3">
					<th align="right">用户扩展对象类:</th>
					<td><input title="用户扩展对象类" class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[300]'" style="width: 180px;"
						type="text" name="userObject" id="userObject"
						value='${uumsSynchTypeConfigDTO.userObject}' /></td>
				</tr>
				<tr id="ldap4">
					<th align="right"><span style="color: red;">*</span>用户根路径:</th>
					<td><input title="用户根路径" class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[300]'" style="width: 180px;"
						type="text" name="userOu" id="userOu"
						value='${uumsSynchTypeConfigDTO.userOu}' /></td>
				</tr>
				<!-- WebService同步方式配置输入项 -->
				<tr id="ws">
					<th align="right"><span style="color: red;">*</span>WSDL地址:</th>
					<td><input title="WSDL地址" class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[3000]'" style="width: 180px;"
						type="text" name="wsUrl" id="wsUrl"
						value='${uumsSynchTypeConfigDTO.wsUrl}' /></td>
				</tr>
				<tr>
				</tr>
			</table>
		</form>
		<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>
					<td width="50%" align="right"><a title="保存" id="saveButton"
						class="easyui-linkbutton" onclick="saveForm();"
						href="javascript:void(0);">保存</a> <a title="返回" id="returnButton"
						class="easyui-linkbutton" onclick="closeForm();"
						href="javascript:void(0);">返回</a></td>
				</tr>
			</table>
		</div>
	</div>
	<script type="text/javascript">
		var type = $("select[name='synchType']").find("option:selected").val();
		changeShow(type);
		
		$.extend($.fn.validatebox.defaults.rules, {
			maxLength : {
				validator : function(value, param) {
					return param[0] >= value.length;

				},
				message : '请输入最多 {0} 字符.'
			}
		});
		$(function() {
		})
		function closeForm() {
			parent.uumsSynchTypeConfig.closeDialog("#edit");
		}
		function saveForm() {
			if ($('#form').form('validate') == false) {
				return;
			}
			parent.uumsSynchTypeConfig.save(serializeObject($('#form')),
					"#edit");
		}
		
		//切换同步方式输入项
		function changeShow(type){
			if(type == 'db'){
				dbShow("show");
				ldapShow("hide");
				wsShow("hide");
			}else if(type == 'ldap'){
				dbShow("hide");
				ldapShow("show");
				wsShow("hide");
			}else{
				dbShow("hide");
				ldapShow("hide");
				wsShow("show");
			}
			
		}
		function dbShow(flag){
			if(flag=="show"){
				$('#db1').show();
				$('#db2').show();
				$('#db3').show();
				$('#db4').show();
				$('#db5').show();
				$('#db6').show();
			}else{
				$('#db1').hide();
				$('#db2').hide();
				$('#db3').hide();
				$('#db4').hide();
				$('#db5').hide();
				$('#db6').hide();
			}
		}
		function ldapShow(flag){
			if(flag=="show"){
				$('#ldap1').show();
				$('#ldap2').show();
				$('#ldap3').show();
				$('#ldap4').show();
			}else{
				$('#ldap1').hide();
				$('#ldap2').hide();
				$('#ldap3').hide();
				$('#ldap4').hide();
			}
		} 
		function wsShow(flag){
			if(flag=="show"){
				$('#ws').show();
				hostShow('hide');
			}else{
				$('#ws').hide();
				hostShow('show');
			}
		} 
		function hostShow(flag){
			if(flag=="show"){
				$('#host').show();
				$('#port').show();
				$('#uname').show();
				$('#pwd').show();
			}else{
				$('#host').hide();
				$('#port').hide();
				$('#uname').hide();
				$('#pwd').hide();
			}
		}
		
		//选择不同的数据库类型，自动填写JDBC驱动类和连接串
		var hostip;
		var portStr;
		var dbnameStr;
		var _db = "oracle";
		function changeDriver(db){
			_db = db;
			getValues();
			if(db == "oracle"){
				$('#driverClass').val("oracle.jdbc.driver.OracleDriver");
				$('#connectStr').val("jdbc:oracle:thin:@"+hostip+":"+portStr+":"+dbnameStr);
			}else if(db == "mysql"){
				$('#driverClass').val("com.mysql.jdbc.Driver");
				$('#connectStr').val("jdbc:mysql://"+hostip+":"+portStr+"/"+dbnameStr);
			}else if(db == "sqlserver"){
				$('#driverClass').val("com.microsoft.jdbc.sqlserver.SQLServerDriver");
				$('#connectStr').val("jdbc:microsoft:sqlserver://"+hostip+":"+portStr+";DatabaseName="+dbnameStr);
			}else if(db == "db2"){
				$('#driverClass').val("com.ibm.db2.jcc.DB2Driver");
				$('#connectStr').val("jdbc:db2://"+hostip+":"+portStr+"/"+dbnameStr);
			}
		}
		
		//当主机地址、端口号、数据库ID输入框失去焦点时自动拼写数据库连接字符串
		$('#hostIp').blur(function(){
			setConnStr();
		});
		$('#hostPort').blur(function(){
			setConnStr();
		});
		$('#dbname').blur(function(){
			setConnStr();
		});
		
		function getValues(){
			hostip = $('#hostIp').val();
			portStr = $('#hostPort').val();
			dbnameStr = $('#dbname').val();
		}
		function setConnStr(){
			getValues();
			changeDriver(_db);
		}
	</script>
</body>
</html>