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
<!-- ControllerPath = "uums/appsys/register/uumsappsys/UumsAppSysController/UumsAppSysInfo" -->
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
		<div id="toolbarUumsAppSys" class="datagrid-toolbar">
			<table>
				<tr>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_uumsAppSys_button_add" permissionDes="添加">
						<td><a class="easyui-linkbutton" iconCls="icon-add"
							plain="true" onclick="uumsAppSys.insert();"
							href="javascript:void(0);">添加</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_uumsAppSys_button_edit"
						permissionDes="编辑">
						<td><a class="easyui-linkbutton" iconCls="icon-edit"
							plain="true" onclick="uumsAppSys.modify();"
							href="javascript:void(0);">编辑</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_uumsAppSys_button_delete"
						permissionDes="删除">
						<td><a class="easyui-linkbutton" iconCls="icon-remove"
							plain="true" onclick="uumsAppSys.del();"
							href="javascript:void(0);">删除</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_uumsAppSys_button_query"
						permissionDes="查询">
						<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="uumsAppSys.openSearchForm();"
							href="javascript:void(0);">查询</a></td>
					</sec:accesscontrollist>
				</tr>
			</table>
		</div>
		<table id="dgUumsAppSys"
			data-options="
				fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#toolbarUumsAppSys',
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
					<th data-options="field:'appCode', halign:'center'" width="220">应用系统编码</th>
					<th data-options="field:'appName', halign:'center'" width="220">应用系统名称</th>
					<th data-options="field:'appDescribe', halign:'center'" width="220">应用系统简介</th>
					<th data-options="field:'securitAdminAlias',align:'center'"
						width="220">安全管理员</th>
					<th
						data-options="field:'isDataSource', halign:'center',formatter:formateisDataSource"
						width="220">权威数据源</th>
					<th
						data-options="field:'isAutoCreateAccount', halign:'center',formatter:formateisDataSource"
						width="220">自动生成账号</th>
					<th
						data-options="field:'addAuditFlag', halign:'center',formatter:formateisAutoCreAcc"
						width="220">新增是否审批</th>
					<th
						data-options="field:'editAuditFlag', halign:'center',formatter:formateeditAuditFlag"
						width="220">修改是否审批</th>
					<th
						data-options="field:'delAuditFlag', halign:'center',formatter:formatedelAuditFlag"
						width="220">删除是否审批</th>
					<!-- <th
						data-options="field:'synchType', halign:'center',formatter:formatesynchType"
						width="220">同步方式</th> -->
					<th
						data-options="field:'createTime', halign:'center',formatter:formateDate"
						width="220">创建时间</th>
					<th
						data-options="field:'updateTime', halign:'center',formatter:formateDate"
						width="220">修改时间</th>
					<th data-options="field:'orderBy', halign:'center'" width="220">排序</th>
				</tr>
			</thead>
		</table>
	</div>
	<!--*****************************搜索*********************************  -->
	<div id="searchDialog"
		data-options="iconCls:'icon-search',resizable:true,modal:false,buttons:'#searchBtns'"
		style="overflow: auto; padding-bottom: 35px;">
		<form id="uumsAppSys">
			<table style="padding-top: 10px; width: 600px; margin: 0 auto;">
				<tr>
					<td align="right">应用系统编码:</td>
					<td><input class="inputbox" style="width: 151px;" type="text"
						name="appCode" /></td>
					<td align="right">应用系统名称:</td>
					<td><input class="inputbox" style="width: 151px;" type="text"
						name="appName" /></td>
				</tr>
				<tr>
					<td align="right">应用系统简介:</td>
					<td><input class="inputbox" style="width: 151px;" type="text"
						name="appDescribe" /></td>
					<td align="right">安全管理员:</td>
					<td><input title="用户名称" class="inputbox" style="width: 180px;"
						type="hidden" name="securitAdmin" id="securitAdmin" />
						<div class="">
							<input class="easyui-validatebox" name="securitAdminAlias"
								id="securitAdminAlias" readOnly="readOnly" style="width: 150px;"></input>
						</div></td>
				</tr>
				<tr>
					<td align="right">是否权威数据源:</td>
					<td><pt6:syslookup name="isDataSource"
							lookupCode="UUMS_YES_OR_NO"
							dataOptions="width:151,editable:false,panelHeight:'auto'">
						</pt6:syslookup></td>
					<td align="right">新增是否审批:</td>
					<td><pt6:syslookup name="addAuditFlag"
							lookupCode="UUMS_YES_OR_NO"
							dataOptions="width:151,editable:false,panelHeight:'auto'">
						</pt6:syslookup></td>
				</tr>
				<tr>
					<td align="right">修改是否审批:</td>
					<td><pt6:syslookup name="editAuditFlag"
							lookupCode="UUMS_YES_OR_NO"
							dataOptions="width:151,editable:false,panelHeight:'auto'">
						</pt6:syslookup></td>
					<td align="right">删除是否审批:</td>
					<td><pt6:syslookup name="delAuditFlag"
							lookupCode="UUMS_YES_OR_NO"
							dataOptions="width:151,editable:false,panelHeight:'auto'">
						</pt6:syslookup></td>
				</tr>
				<tr>
					<td align="right">同步方式:</td>
					<td><pt6:syslookup name="synchType"
							lookupCode="UUMS_SYNCH_TYPE"
							dataOptions="width:151,editable:false,panelHeight:'auto'">
						</pt6:syslookup></td>
				</tr>
				<tr>
					<td align="right">创建时间从:</td>
					<td><input name="createTimeBegin" id="createTimeBegin"
						class="easyui-datebox" editable="false" style="width: 150px;" />
					<td align="right">创建时间(至):</td>
					<td><input name="createTimeEnd" id="createTimeEnd"
						class="easyui-datebox" editable="false" style="width: 150px;" />
					</td>
				</tr>
				</tr>
				<tr>
					<td align="right">修改时间从:</td>
					<td><input name="updateTimeBegin" id="updateTimeBegin"
						class="easyui-datebox" editable="false" style="width: 150px;" />
					<td align="right">修改时间(至):</td>
					<td><input name="updateTimeEnd" id="updateTimeEnd"
						class="easyui-datebox" editable="false" style="width: 150px;" />
					</td>
				</tr>
				<td align="right">排序:</td>
				<td><input class="inputbox" style="width: 151px;" type="text"
					name="orderBy" /></td>
				</tr>
				<tr>
				</tr>
			</table>
		</form>
		<div id="searchBtns">
			<a class="easyui-linkbutton" iconCls="" plain="false"
				onclick="uumsAppSys.searchData();" href="javascript:void(0);">查询</a>
			<a class="easyui-linkbutton" iconCls="" plain="false"
				onclick="uumsAppSys.clearData();" href="javascript:void(0);">清空</a>
			<a class="easyui-linkbutton" iconCls="" plain="false"
				onclick="uumsAppSys.hideSearchForm();" href="javascript:void(0);">返回</a>
		</div>
	</div>
	<script src=" avicit/uums/appsys/register/uumsappsys/js/UumsAppSys.js"
		type="text/javascript"></script>
	<script type="text/javascript">
		var uumsAppSys;
		$(function() {
			uumsAppSys = new UumsAppSys('dgUumsAppSys', '${url}',
					'searchDialog', 'uumsAppSys');
			var securitAdminUserCommonSelector = new CommonSelector("user",
					"userSelectCommonDialog", "securitAdmin",
					"securitAdminAlias");
			securitAdminUserCommonSelector.init();
		});
		function formateDate(value, row, index) {
			return uumsAppSys.formate(value);
		}
		function formateDateTime(value, row, index) {
			return uumsAppSys.formateTime(value);
		}
		//uumsAppSys.detail(\''+row.id+'\')
		function formateHref(value, row, inde) {
			return '<a href="javascript:void(0);" onclick="uumsAppSys.detail(\''
					+ row.id + '\');">' + value + '</a>';
		}
		function formateisDataSource(value) {
			return Platform6.fn.lookup.formatLookupType(value,
					uumsAppSys.isDataSource);
		}
		function formateisAutoCreAcc(value) {
			return Platform6.fn.lookup.formatLookupType(value,
					uumsAppSys.isAutoCreateAccount);
		}
		function formateaddAuditFlag(value) {
			return Platform6.fn.lookup.formatLookupType(value,
					uumsAppSys.addAuditFlag);
		}
		function formateeditAuditFlag(value) {
			return Platform6.fn.lookup.formatLookupType(value,
					uumsAppSys.editAuditFlag);
		}
		function formatedelAuditFlag(value) {
			return Platform6.fn.lookup.formatLookupType(value,
					uumsAppSys.delAuditFlag);
		}
		function formatesynchType(value) {
			return Platform6.fn.lookup.formatLookupType(value,
					uumsAppSys.synchType);
		}
	</script>
</body>
</html>