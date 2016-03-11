<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "uums/appsys/synchmappermeta/uumssynchmappermetadata/UumsSynchMapperMetaDataController/operation/Detail/id" -->
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
				value='${uumsSynchMapperMetaDataDTO.id}' /> <input type="hidden"
				name="id" value='${uumsSynchMapperMetaDataDTO.id}' />
			<table width="100%" style="padding-top: 10px;">
				<tr>
					<th align="right"><span style="color: red;">*</span> 主体类型:</th>
					<td><input title="主体类型" class="easyui-validatebox"
						data-options="required:true" style="width: 180px;" type="text"
						name="mainType" id="mainType" readonly="readonly"
						value='${uumsSynchMapperMetaDataDTO.mainType}' /></td>
					<th align="right"><span style="color: red;">*</span> 字段名称:</th>
					<td><input title="字段名称" class="easyui-validatebox"
						data-options="required:true" style="width: 180px;" type="text"
						name="columnName" id="columnName" readonly="readonly"
						value='${uumsSynchMapperMetaDataDTO.columnName}' /></td>
				</tr>
				<tr>
					<th align="right"><span style="color: red;">*</span> 字段CODE:</th>
					<td><input title="字段CODE" class="easyui-validatebox"
						data-options="required:true" style="width: 180px;" type="text"
						name="columnCode" id="columnCode" readonly="readonly"
						value='${uumsSynchMapperMetaDataDTO.columnCode}' /></td>
					<th align="right"><span style="color: red;">*</span> 字段数据类型:</th>
					<td><input title="字段数据类型" class="easyui-validatebox"
						data-options="required:true" style="width: 180px;" type="text"
						name="dataType" id="dataType" readonly="readonly"
						value='${uumsSynchMapperMetaDataDTO.dataType}' /></td>
				</tr>
				<tr>
					<th align="right">排序:</th>
					<td><input title="排序" class="easyui-numberbox"
						style="width: 180px;" type="text" name="orderBy" id="orderBy"
						readonly="readonly" value='${uumsSynchMapperMetaDataDTO.orderBy}' />
					</td>
					<th align="right">注释:</th>
					<td><input title="注释" class="inputbox" style="width: 180px;"
						type="text" name="comments" id="comments" readonly="readonly"
						value='${uumsSynchMapperMetaDataDTO.comments}' /></td>
				</tr>
				<tr>
					<th align="right">UUMS字段:</th>
					<td><input title="UUMS字段"
						class="easyui-numberbox easyui-validatebox"
						data-options="validType:'maxLength[22]'" style="width: 180px;"
						type="text" name="uumsAttribute" id="uumsAttribute"
						value='${uumsSynchMapperMetaDataDTO.uumsAttribute}' /></td>
					
				</tr>
				<tr>
				</tr>
			</table>
		</form>
	</div>
	<script type="text/javascript">
		$(function() {
		});
	</script>
</body>
</html>