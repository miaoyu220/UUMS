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
<!-- ControllerPath = "uums/appsys/synchmappermeta/uumssynchmappermetadata/UumsSynchMapperMetaDataController/UumsSynchMapperMetaDataInfo" -->
<title></title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include
	page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js"
	type="text/javascript"></script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center'" style="background: #ffffff;">
		<div id="toolbarUumsSynchMapperMetaData" class="datagrid-toolbar">
			<table>
				<tr>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_uumsSynchMapperMetaData_button_add"
						permissionDes="添加">
						<td><a class="easyui-linkbutton" iconCls="icon-add"
							plain="true" onclick="uumsSynchMapperMetaData.insert();"
							href="javascript:void(0);">添加</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_uumsSynchMapperMetaData_button_edit"
						permissionDes="编辑">
						<td><a class="easyui-linkbutton" iconCls="icon-edit"
							plain="true" onclick="uumsSynchMapperMetaData.modify();"
							href="javascript:void(0);">编辑</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_uumsSynchMapperMetaData_button_delete"
						permissionDes="删除">
						<td><a class="easyui-linkbutton" iconCls="icon-remove"
							plain="true" onclick="uumsSynchMapperMetaData.del();"
							href="javascript:void(0);">删除</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_uumsSynchMapperMetaData_button_query"
						permissionDes="查询">
						<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="uumsSynchMapperMetaData.openSearchForm();"
							href="javascript:void(0);">查询</a></td>
					</sec:accesscontrollist>
				</tr>
			</table>
		</div>
		<table id="dgUumsSynchMapperMetaData"
			data-options="
				fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#toolbarUumsSynchMapperMetaData',
				idField :'id',
				singleSelect: true,
				checkOnSelect: true,
				selectOnCheck: false,
				pagination:true,
				pageSize:dataOptions.pageSize,
				pageList:dataOptions.pageList,
				striped:true">
			<thead>
				<tr>
					<th data-options="field:'主键id', halign:'center',checkbox:true"
						width="220">主键ID</th>
					<th data-options="field:'mainType', halign:'center'" width="220">主体类型</th>
					<th data-options="field:'columnName', halign:'center'" width="220">字段名称</th>
					<th data-options="field:'columnCode', halign:'center'" width="220">字段CODE</th>
					<th data-options="field:'dataType', halign:'center'" width="220">字段数据类型</th>
					<th data-options="field:'uumsAttribute', halign:'center'" width="220">UUMS字段</th>
					<th data-options="field:'orderBy', halign:'center'" width="220">排序</th>
					<th data-options="field:'comments', halign:'center'" width="220">注释</th>
				</tr>
			</thead>
		</table>
	</div>
	<!--*****************************搜索*********************************  -->
	<div id="searchDialog"
		data-options="iconCls:'icon-search',resizable:true,modal:false,buttons:'#searchBtns'"
		style="overflow: auto; padding-bottom: 35px;">
		<form id="uumsSynchMapperMetaData">
			<table style="padding-top: 10px; width: 600px; margin: 0 auto;">
				<tr>
					<td align="right">主体类型:</td>
					<td><input class="inputbox" style="width: 151px;" type="text"
						name="mainType" /></td>
					<td align="right">字段名称:</td>
					<td><input class="inputbox" style="width: 151px;" type="text"
						name="columnName" /></td>
				</tr>
				<tr>
					<td align="right">字段CODE:</td>
					<td><input class="inputbox" style="width: 151px;" type="text"
						name="columnCode" /></td>
					<td align="right">字段数据类型:</td>
					<td><input class="inputbox" style="width: 151px;" type="text"
						name="dataType" /></td>
				</tr>
				<tr>
					<td align="right">排序:</td>
					<td><input class="inputbox" style="width: 151px;" type="text"
						name="orderBy" /></td>
					<td align="right">注释:</td>
					<td><input class="inputbox" style="width: 151px;" type="text"
						name="comments" /></td>
				</tr>
				<tr>
				</tr>
			</table>
		</form>
		<div id="searchBtns">
			<a class="easyui-linkbutton" iconCls="" plain="false"
				onclick="uumsSynchMapperMetaData.searchData();"
				href="javascript:void(0);">查询</a> <a class="easyui-linkbutton"
				iconCls="" plain="false"
				onclick="uumsSynchMapperMetaData.clearData();"
				href="javascript:void(0);">清空</a> <a class="easyui-linkbutton"
				iconCls="" plain="false"
				onclick="uumsSynchMapperMetaData.hideSearchForm();"
				href="javascript:void(0);">返回</a>
		</div>
	</div>
	<script
		src=" avicit/uums/appsys/synchmappermeta/uumssynchmappermetadata/js/UumsSynchMapperMetaData.js"
		type="text/javascript"></script>
	<script type="text/javascript">
		var uumsSynchMapperMetaData;
		$(function() {
			uumsSynchMapperMetaData = new UumsSynchMapperMetaData(
					'dgUumsSynchMapperMetaData', '${url}', 'searchDialog',
					'uumsSynchMapperMetaData');
		});
		function formateDate(value, row, index) {
			return uumsSynchMapperMetaData.formate(value);
		}
		function formateDateTime(value, row, index) {
			return uumsSynchMapperMetaData.formateTime(value);
		}
		//uumsSynchMapperMetaData.detail(\''+row.id+'\')
		function formateHref(value, row, inde) {
			return '<a href="javascript:void(0);" onclick="uumsSynchMapperMetaData.detail(\''
					+ row.id + '\');">' + value + '</a>';
		}
	</script>
</body>
</html>