<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String sysCodingPath = request.getContextPath()+"/sysCodingSelectController";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>自编代码规则管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<script type="text/javascript">
/**
 * 查询数据
 */
function searchCoding(){
	var param = {
		searchCodingName : $('#searchCodingName').val(),
		searchCodingValue : $('#searchCodingValue').val(),
		searchModuleName: $('#searchModuleName').val()
	}; 
	$('#datagrid1').datagrid('reload', param);
}

/**
 * 导出查询的数据
 */
 function ExporterExcel() { 
	document.getElementById("form1").submit();
 }
</script>
</head>
<body class="easyui-layout">
<iframe name="loadFileIframe" style="display: none"></iframe>
<div region="north" border="false">
	<div id="toolbar" class="datagrid-toolbar" style="height:auto;display: block;">
		<div style="padding:0 0 0 10px;">
			<form id="form1" method="post" target="loadFileIframe" action="<%=request.getContextPath() %>/sysCodingSelectController/exportExcel4CodingSelectData.do">
				<table width="100%" border="0">
				   <tr>
				   	<td width="80px" align="right">规则名称</td>
				   	<td width="150px"><input id="searchCodingName" name="searchCodingName" style="width: 150px" value=""/></td>
				   	<td width="80px" align="right">编码值</td>
				   	<td width="150px"><input id="searchCodingValue" name="searchCodingValue" style="width: 150px" value=""/></td>
				   	<td width="80px" align="right">使用对象</td>
				   	<td width="150px"><input id="searchModuleName" name="searchModuleName" style="width: 150px" value=""/></td>
					<td width="70px">
						<sec:accesscontrollist hasPermission="3" domainObject="sysCodingSelectManager_button_searchRule" >
							<a class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="searchCoding();" href="javascript:void(0);">查询</a>
						</sec:accesscontrollist>
					</td>
					<td align="left">
						<sec:accesscontrollist hasPermission="3" domainObject="sysCodingSelectManager_button_exportExcel" >
							<a class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="ExporterExcel();" href="javascript:void(0);">导出</a> 
						</sec:accesscontrollist>
					</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</div>
<div region="center" border="false">
	<table id="datagrid1" class="easyui-datagrid" 
			data-options="
				fit: true,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				method: 'post',
				url:'platform/sysCodingSelectController/getUsedCodingData.json',
				singleSelect: false,
				checkOnSelect: true,
				selectOnCheck: true,
				pagination:true,
				pageSize:dataOptions.pageSize,
				pageList:dataOptions.pageList
			">
		<thead>
			<tr>
				<sec:accesscontrollist hasPermission="3" domainObject="sysCodingSelectManager_gridform_codingName">
					<th data-options="field:'codingName', halign:'center'" width="120">规则名称</th>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="sysCodingSelectManager_gridform_segmentNumber">
					<th data-options="field:'codingValue', halign:'center', align:'left'" width="100">编码值</th>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="sysCodingSelectManager_gridform_criterionCode">
					<th data-options="field:'moduleName', halign:'center', align:'left'" width="100">使用对象</th>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="sysCodingSelectManager_gridform_creationDate">
					<th data-options="field:'creationDate', halign:'center', align:'center', formatter: formatColumnTime" width="100">创建时间</th>
				</sec:accesscontrollist>
			</tr>
		</thead>
	</table>
</div>
</body>
</html>
