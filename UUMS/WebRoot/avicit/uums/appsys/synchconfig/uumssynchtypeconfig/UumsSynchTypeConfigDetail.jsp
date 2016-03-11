<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "uums/appsys/synchconfig/uumssynchtypeconfig/UumsSynchTypeConfigController/operation/Detail/id" -->
<title>详情</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js" type="text/javascript"></script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false" style="overflow:hidden;padding-bottom:35px;">
		<form id='form'>
						<input type="hidden" name="id" value='${uumsSynchTypeConfigDTO.id}'/>
								<input type="hidden" name="id" value='${uumsSynchTypeConfigDTO.id}'/>
																																																																						<table width="100%" style="padding-top: 10px;">
	<tr>
																						<th align="right">
									<span style="color:red;">*</span>
								应用系统:</th>
				<td>
															<input title="应用系统" class="easyui-validatebox" data-options="required:true" style="width: 180px;" type="text" name="appId" id="appId" readonly="readonly" value='${uumsSynchTypeConfigDTO.appId}'/>
													</td>
																			<th align="right">
												数据库类型:</th>
				<td>
															<input title="数据库类型" class="inputbox" style="width: 180px;" type="text" name="dbType" id="dbType" readonly="readonly" value='${uumsSynchTypeConfigDTO.dbType}'/>
													</td>
									</tr>
					<tr>
																			<th align="right">
												JDBC驱动类:</th>
				<td>
															<input title="JDBC驱动类" class="inputbox" style="width: 180px;" type="text" name="driverClass" id="driverClass" readonly="readonly" value='${uumsSynchTypeConfigDTO.driverClass}'/>
													</td>
																			<th align="right">
												JDBC连接串:</th>
				<td>
															<input title="JDBC连接串" class="inputbox" style="width: 180px;" type="text" name="connectStr" id="connectStr" readonly="readonly" value='${uumsSynchTypeConfigDTO.connectStr}'/>
													</td>
									</tr>
					<tr>
																			<th align="right">
												用户名:</th>
				<td>
															<input title="用户名" class="inputbox" style="width: 180px;" type="text" name="userName" id="userName" readonly="readonly" value='${uumsSynchTypeConfigDTO.userName}'/>
													</td>
																			<th align="right">
												密码:</th>
				<td>
															<input title="密码" class="inputbox" style="width: 180px;" type="text" name="password" id="password" readonly="readonly" value='${uumsSynchTypeConfigDTO.password}'/>
													</td>
									</tr>
					<tr>
																			<th align="right">
												组织机构表CODE:</th>
				<td>
															<input title="组织机构表CODE" class="inputbox" style="width: 180px;" type="text" name="orgTable" id="orgTable" readonly="readonly" value='${uumsSynchTypeConfigDTO.orgTable}'/>
													</td>
																			<th align="right">
												用户表CODE:</th>
				<td>
															<input title="用户表CODE" class="inputbox" style="width: 180px;" type="text" name="userTable" id="userTable" readonly="readonly" value='${uumsSynchTypeConfigDTO.userTable}'/>
													</td>
									</tr>
					<tr>
																			<th align="right">
												主机地址:</th>
				<td>
															<input title="主机地址" class="inputbox" style="width: 180px;" type="text" name="hostIp" id="hostIp" readonly="readonly" value='${uumsSynchTypeConfigDTO.hostIp}'/>
													</td>
																			<th align="right">
												端口:</th>
				<td>
															<input title="端口" class="inputbox" style="width: 180px;" type="text" name="hostPort" id="hostPort" readonly="readonly" value='${uumsSynchTypeConfigDTO.hostPort}'/>
													</td>
									</tr>
					<tr>
																			<th align="right">
												组织扩展对象类:</th>
				<td>
															<input title="组织扩展对象类" class="inputbox" style="width: 180px;" type="text" name="orgObject" id="orgObject" readonly="readonly" value='${uumsSynchTypeConfigDTO.orgObject}'/>
													</td>
																			<th align="right">
												组织根路径:</th>
				<td>
															<input title="组织根路径" class="inputbox" style="width: 180px;" type="text" name="orgOu" id="orgOu" readonly="readonly" value='${uumsSynchTypeConfigDTO.orgOu}'/>
													</td>
									</tr>
					<tr>
																			<th align="right">
												用户扩展对象类:</th>
				<td>
															<input title="用户扩展对象类" class="inputbox" style="width: 180px;" type="text" name="userObject" id="userObject" readonly="readonly" value='${uumsSynchTypeConfigDTO.userObject}'/>
													</td>
																			<th align="right">
												用户根路径:</th>
				<td>
															<input title="用户根路径" class="inputbox" style="width: 180px;" type="text" name="userOu" id="userOu" readonly="readonly" value='${uumsSynchTypeConfigDTO.userOu}'/>
													</td>
									</tr>
					<tr>
																			<th align="right">
												WS服务地址:</th>
				<td>
															<input title="WS服务地址" class="inputbox" style="width: 180px;" type="text" name="wsUrl" id="wsUrl" readonly="readonly" value='${uumsSynchTypeConfigDTO.wsUrl}'/>
													</td>
																																					<th align="right">
												同步方式:</th>
				<td>
															<input title="同步方式" class="inputbox" style="width: 180px;" type="text" name="synchType" id="synchType" readonly="readonly" value='${uumsSynchTypeConfigDTO.synchType}'/>
													</td>
									</tr>
					<tr>
															</tr>
				</table>
		</form>
	</div>
	<script type="text/javascript">
	$(function(){
																																																																																																																																																																																																																																																																																																																																																																																																																																								});
	</script>
</body>
</html>