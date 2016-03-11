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
<!-- ControllerPath = "uums/permission/synch/uumsuserapppermissions/UumsUserAppPermissionsController/UumsUserAppPermissionsInfo" -->
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
		<div id="toolbarUumsUserAppPermissions" class="datagrid-toolbar">
			<table>
				<tr>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_uumsUserAppPermissions_button_add"
						permissionDes="添加">
						<td><a class="easyui-linkbutton" iconCls="icon-add"
							plain="true" onclick="uumsUserAppPermissions.insert();"
							href="javascript:void(0);">添加</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_uumsUserAppPermissions_button_edit"
						permissionDes="编辑">
						<td><a class="easyui-linkbutton" iconCls="icon-edit"
							plain="true" onclick="uumsUserAppPermissions.modify();"
							href="javascript:void(0);">编辑</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_uumsUserAppPermissions_button_delete"
						permissionDes="删除">
						<td><a class="easyui-linkbutton" iconCls="icon-remove"
							plain="true" onclick="uumsUserAppPermissions.del();"
							href="javascript:void(0);">删除</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_uumsUserAppPermissions_button_query"
						permissionDes="查询">
						<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="uumsUserAppPermissions.openSearchForm();"
							href="javascript:void(0);">查询</a></td>
					</sec:accesscontrollist>
				</tr>
			</table>
		</div>
		<table id="dgUumsUserAppPermissions"
			data-options="
				fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#toolbarUumsUserAppPermissions',
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
					<th data-options="field:'id', halign:'center',checkbox:true"
						width="220">主键ID</th>
					<th data-options="field:'appName', halign:'center'" width="220">应用系统</th>
					<th data-options="field:'loginName', halign:'center'" width="220">用户ID</th>
					<th
						data-options="field:'userName', halign:'center'"
						width="220">用户姓名</th>
					<th
						data-options="field:'deptName', halign:'center'"
						width="220">所在部门</th>
					<th
						data-options="field:'auditFlag', halign:'center',formatter:formateauditFlag"
						width="220">审批状态</th>
					<th
						data-options="field:'synchFlag', halign:'center',formatter:formatesynchFlag"
						width="220">同步状态</th>
					<th
						data-options="field:'synchTime', halign:'center',formatter:formateDate"
						width="220">同步时间</th>
					<th
						data-options="field:'operFlag', halign:'center',formatter:formateoperFlag"
						width="220">操作状态</th>
					<th data-options="field:'synchType', halign:'center'" width="220">同步方式</th>
					<th
						data-options="field:'actFlag', halign:'center',formatter:formateactFlag"
						width="220">活动状态</th>
				</tr>
			</thead>
		</table>
	</div>
	<!--*****************************搜索*********************************  -->
	<div id="searchDialog"
		data-options="iconCls:'icon-search',resizable:true,modal:false,buttons:'#searchBtns'"
		style="overflow: auto; padding-bottom: 35px;">
		<form id="uumsUserAppPermissions">
			<table style="padding-top: 10px; width: 600px; margin: 0 auto;">
				<tr>
					<td align="right">应用系统ID:</td>
					<td><input class="inputbox" style="width: 151px;" type="text"
						name="appId" /></td>
					<td align="right">用户ID:</td>
					<td><input class="inputbox" style="width: 151px;" type="text"
						name="userId" /></td>
				</tr>
				<tr>
					<td align="right">映射账号:</td>
					<td><input class="inputbox" style="width: 151px;" type="text"
						name="appAccount" /></td>
					<td align="right">同步状态:</td>
					<td><pt6:syslookup name="synchFlag"
							lookupCode="UUMS_SYNCH_FLAG"
							dataOptions="width:151,editable:false,panelHeight:'auto'">
						</pt6:syslookup></td>
				</tr>
				<tr>
				<tr>
					<td align="right">同步时间从:</td>
					<td><input name="synchTimeBegin" id="synchTimeBegin"
						class="easyui-datebox" editable="false" style="width: 150px;" />
					<td>同步时间(至):</td>
					<td><input name="synchTimeEnd" id="synchTimeEnd"
						class="easyui-datebox" editable="false" style="width: 150px;" />
					</td>
				</tr>
				<td align="right">操作状态:</td>
				<td><pt6:syslookup name="operFlag" lookupCode="UUMS_OPER_FLAG"
						dataOptions="width:151,editable:false,panelHeight:'auto'">
					</pt6:syslookup></td>
				<td align="right">同步方式:</td>
				<td><input class="inputbox" style="width: 151px;" type="text"
					name="synchType" /></td>
				</tr>
				<tr>
					<td align="right">活动状态:</td>
					<td><pt6:syslookup name="actFlag" lookupCode="UUMS_ACT_FLAG"
							dataOptions="width:151,editable:false,panelHeight:'auto'">
						</pt6:syslookup></td>
				</tr>
			</table>
		</form>
		<div id="searchBtns">
			<a class="easyui-linkbutton" iconCls="" plain="false"
				onclick="uumsUserAppPermissions.searchData();"
				href="javascript:void(0);">查询</a> <a class="easyui-linkbutton"
				iconCls="" plain="false"
				onclick="uumsUserAppPermissions.clearData();"
				href="javascript:void(0);">清空</a> <a class="easyui-linkbutton"
				iconCls="" plain="false"
				onclick="uumsUserAppPermissions.hideSearchForm();"
				href="javascript:void(0);">返回</a>
		</div>
	</div>
	<script
		src="avicit/uums/permission/synch/uumsuserapppermissions/js/UumsUserAppPermissions.js"
		type="text/javascript"></script>
	<script type="text/javascript">
		var uumsUserAppPermissions;
		$(function() {
			uumsUserAppPermissions = new UumsUserAppPermissions(
					'dgUumsUserAppPermissions', '${url}', 'searchDialog',
					'uumsUserAppPermissions');
		});
		function formateDate(value, row, index) {
			return uumsUserAppPermissions.formate(value);
		}
		function formateDateTime(value, row, index) {
			return uumsUserAppPermissions.formateTime(value);
		}
		//uumsUserAppPermissions.detail(\''+row.id+'\')
		function formateHref(value, row, inde) {
			return '<a href="javascript:void(0);" onclick="uumsUserAppPermissions.detail(\''
					+ row.id + '\');">' + value + '</a>';
		}
		function formateauditFlag(value) {
			return Platform6.fn.lookup.formatLookupType(value,
					uumsUserAppPermissions.auditFlag);
		}
		function formatesynchFlag(value) {
			return Platform6.fn.lookup.formatLookupType(value,
					uumsUserAppPermissions.synchFlag);
		}
		function formateoperFlag(value) {
			return Platform6.fn.lookup.formatLookupType(value,
					uumsUserAppPermissions.operFlag);
		}
		function formateactFlag(value) {
			return Platform6.fn.lookup.formatLookupType(value,
					uumsUserAppPermissions.actFlag);
		}
	</script>
</body>
</html>