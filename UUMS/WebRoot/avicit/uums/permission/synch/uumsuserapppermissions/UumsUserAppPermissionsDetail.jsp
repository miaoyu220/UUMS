<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "uums/permission/synch/uumsuserapppermissions/UumsUserAppPermissionsController/operation/Detail/id" -->
<title>详情</title>
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
		style="overflow: hidden; padding-bottom: 35px;">
		<form id='form'>
			<input type="hidden" name="id"
				value='${uumsUserAppPermissionsDTO.id}' /> <input type="hidden"
				name="id" value='${uumsUserAppPermissionsDTO.id}' />
			<table width="100%" style="padding-top: 10px;">
				<tr>
					<th align="right"><span style="color: red;">*</span> 应用系统ID:</th>
					<td><input title="应用系统ID" class="easyui-validatebox"
						data-options="required:true" style="width: 180px;" type="text"
						name="appId" id="appId" readonly="readonly"
						value='${uumsUserAppPermissionsDTO.appId}' /></td>
					<th align="right"><span style="color: red;">*</span> 用户ID:</th>
					<td><input title="用户ID" class="easyui-validatebox"
						data-options="required:true" style="width: 180px;" type="text"
						name="userId" id="userId" readonly="readonly"
						value='${uumsUserAppPermissionsDTO.userId}' /></td>
				</tr>
				<tr>
					<th align="right"><span style="color: red;">*</span> 审批状态:</th>
					<td><input title="审批状态" class="easyui-validatebox"
						data-options="required:true" style="width: 180px;" type="text"
						name="auditFlag" id="auditFlag" readonly="readonly"
						value='${uumsUserAppPermissionsDTO.auditFlag}' /></td>
					<th align="right"><span style="color: red;">*</span> 同步状态:</th>
					<td><input title="同步状态" class="easyui-validatebox"
						data-options="required:true" style="width: 180px;" type="text"
						name="synchFlag" id="synchFlag" readonly="readonly"
						value='${uumsUserAppPermissionsDTO.synchFlag}' /></td>
				</tr>
				<tr>
					<th align="right"><span style="color: red;">*</span> 同步时间:</th>
					<td><input title="同步时间"
						class="easyui-datebox easyui-validatebox"
						data-options="required:true" style="width: 180px;" type="text"
						readonly="readonly" name="synchTime" id="synchTime"
						value='${uumsUserAppPermissionsDTO.synchTime}' /></td>
					<th align="right"><span style="color: red;">*</span> 操作状态:</th>
					<td><input title="操作状态" class="easyui-validatebox"
						data-options="required:true" style="width: 180px;" type="text"
						name="operFlag" id="operFlag" readonly="readonly"
						value='${uumsUserAppPermissionsDTO.operFlag}' /></td>
				</tr>
				<tr>
					<th align="right">同步方式:</th>
					<td><input title="同步方式" class="inputbox" style="width: 180px;"
						type="text" name="synchType" id="synchType" readonly="readonly"
						value='${uumsUserAppPermissionsDTO.synchType}' /></td>
					<th align="right"><span style="color: red;">*</span> 活动状态:</th>
					<td><input title="活动状态" class="easyui-validatebox"
						data-options="required:true" style="width: 180px;" type="text"
						name="actFlag" id="actFlag" readonly="readonly"
						value='${uumsUserAppPermissionsDTO.actFlag}' /></td>
				</tr>
				<tr>
				</tr>
			</table>
		</form>
	</div>
	<script type="text/javascript">
		$(function() {
			if (!"${uumsUserAppPermissionsDTO.synchTime}" == "") {
				$('#synchTime').datebox(
						'setValue',
						parserColumnTime(
								"${uumsUserAppPermissionsDTO.synchTime}")
								.format("yyyy-MM-dd"));
			}
		});
	</script>
</body>
</html>