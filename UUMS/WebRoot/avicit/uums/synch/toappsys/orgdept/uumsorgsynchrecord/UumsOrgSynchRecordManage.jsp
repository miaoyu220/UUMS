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
<!-- ControllerPath = "uums/synch/toappsys/orgdept/uumsorgsynchrecord/UumsOrgSynchRecordController/UumsOrgSynchRecordInfo" -->
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
	<div data-options="region:'west',split:true,title:''"
		style="width: 250px; padding: 0px;">
		<ul id="appSysTree" class="easyui-tree"
			data-options="
			url:'platform/uums/appsys/register/uumsappsys/UumsAppSysController/operation/getAppSysTree.json',
			loadFilter: function(data){
	            if (data.data){
	                return data.data;
	            } else {
	                return data;
	            }
       		},
       		lines:true,
       		dataType:'json',
       		animate:true,
       		onClick: onClickNode,
       		onLoadSuccess: loadTreeOk
       ">
		</ul>
	</div>
	<div data-options="region:'center'" style="background: #ffffff;">
		<div id="toolbarUumsOrgSynchRecord" class="datagrid-toolbar">
			<table>
				<tr>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_uumsOrgSynchRecord_button_add"
						permissionDes="添加">
						<td><a class="easyui-linkbutton" iconCls="icon-add"
							plain="true" onclick="uumsOrgSynchRecord.insert();"
							href="javascript:void(0);">添加</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_uumsOrgSynchRecord_button_edit"
						permissionDes="编辑">
						<td><a class="easyui-linkbutton" iconCls="icon-edit"
							plain="true" onclick="uumsOrgSynchRecord.modify();"
							href="javascript:void(0);">编辑</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_uumsOrgSynchRecord_button_delete"
						permissionDes="删除">
						<td><a class="easyui-linkbutton" iconCls="icon-remove"
							plain="true" onclick="uumsOrgSynchRecord.del();"
							href="javascript:void(0);">删除</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_uumsOrgSynchRecord_button_query"
						permissionDes="查询">
						<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="uumsOrgSynchRecord.openSearchForm();"
							href="javascript:void(0);">查询</a></td>
					</sec:accesscontrollist>
					<!--*************************** 同步操作按钮********************************* -->
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_uumsOrgSynchRecord_button_synchInsert"
						permissionDes="同步新增">
						<td><a class="easyui-linkbutton" iconCls="icon-export"
							plain="true" onclick="uumsOrgSynchRecord.synchOrg(currTreeNode.id, 'insert');"
							href="javascript:void(0);">同步新增</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_uumsOrgSynchRecord_button_synchUpdate"
						permissionDes="同步修改">
						<td><a class="easyui-linkbutton" iconCls="icon-export"
							plain="true" onclick="uumsOrgSynchRecord.synchOrg(currTreeNode.id, 'update');"
							href="javascript:void(0);">同步修改</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_uumsOrgSynchRecord_button_synchDel"
						permissionDes="同步删除">
						<td><a class="easyui-linkbutton" iconCls="icon-export"
							plain="true" onclick="uumsOrgSynchRecord.synchOrg(currTreeNode.id, 'delete');"
							href="javascript:void(0);">同步删除</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_uumsOrgSynchRecord_button_synchAll"
						permissionDes="同步全部">
						<td><a class="easyui-linkbutton" iconCls="icon-export"
							plain="true" onclick="uumsOrgSynchRecord.synchOrg(currTreeNode.id, 'all');"
							href="javascript:void(0);">同步全部</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_uumsOrgSynchRecord_button_initOrg"
						permissionDes="初始化">
						<td><a class="easyui-linkbutton" iconCls="icon-export"
							plain="true" onclick="uumsOrgSynchRecord.initOrg(currTreeNode.id);"
							href="javascript:void(0);">初始化</a></td>
					</sec:accesscontrollist>
				</tr>
			</table>
		</div>
		<table id="dgUumsOrgSynchRecord"
			data-options="
				fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#toolbarUumsOrgSynchRecord',
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
					<th data-options="field:'orgName', halign:'center'" width="220">名称</th>
					<th data-options="field:'orgCode', halign:'center'" width="220">编码</th>
					<th
						data-options="field:'orgOrDept', halign:'center',formatter:formateorgOrDept"
						width="220">组织OR部门</th>
					<th
						data-options="field:'operFlag', halign:'center',formatter:formateoperFlag"
						width="220">操作状态</th>
					<th
						data-options="field:'synchFlag', halign:'center',formatter:formatesynchFlag"
						width="220">同步状态</th>
					<th
						data-options="field:'updateTime', halign:'center',formatter:formateDateTime"
						width="220">更新时间</th>
					<th
						data-options="field:'synchTime', halign:'center',formatter:formateDateTime"
						width="220">同步时间</th>
					<th
						data-options="field:'synchType', halign:'center',formatter:formatesynchType"
						width="220">同步方式</th>
					<!-- <th data-options="field:'parentOrgCode', halign:'center'"
						width="220">父组织编码</th>
					<th data-options="field:'sysOrgId', halign:'center'" width="220">组织ID</th>
					<th data-options="field:'appId', halign:'center'" width="220">应用系统ID</th> -->
				</tr>
			</thead>
		</table>
	</div>
	<!--*****************************搜索*********************************  -->
	<div id="searchDialog"
		data-options="iconCls:'icon-search',resizable:true,modal:false,buttons:'#searchBtns'"
		style="overflow: auto; padding-bottom: 35px;">
		<form id="uumsOrgSynchRecord">
			<table style="padding-top: 10px; width: 600px; margin: 0 auto;">
				<tr>
					<td align="right">组织编码:</td>
					<td><input class="inputbox" style="width: 151px;" type="text"
						name="orgCode" /></td>
					<td align="right">组织OR部门:</td>
					<td><pt6:syslookup name="orgOrDept"
							lookupCode="UUMS_ORG_OR_DEPT"
							dataOptions="width:151,editable:false,panelHeight:'auto'">
						</pt6:syslookup></td>
				</tr>
				<tr>
					<td align="right">操作状态:</td>
					<td><pt6:syslookup name="operFlag" lookupCode="UUMS_OPER_FLAG"
							dataOptions="width:151,editable:false,panelHeight:'auto'">
						</pt6:syslookup></td>
					<td align="right">同步状态:</td>
					<td><pt6:syslookup name="synchFlag"
							lookupCode="UUMS_SYNCH_FLAG"
							dataOptions="width:151,editable:false,panelHeight:'auto'">
						</pt6:syslookup></td>
				</tr>
				<tr>
				<tr>
					<td align="right">更新时间从:</td>
					<td><input name="updateTimeBegin" id="updateTimeBegin"
						class="easyui-datebox" editable="false" style="width: 150px;" />
					<td>更新时间(至):</td>
					<td><input name="updateTimeEnd" id="updateTimeEnd"
						class="easyui-datebox" editable="false" style="width: 150px;" />
					</td>
				</tr>
				<tr>
					<td align="right">同步时间从:</td>
					<td><input name="synchTimeBegin" id="synchTimeBegin"
						class="easyui-datebox" editable="false" style="width: 150px;" />
					<td>同步时间(至):</td>
					<td><input name="synchTimeEnd" id="synchTimeEnd"
						class="easyui-datebox" editable="false" style="width: 150px;" />
					</td>
				</tr>
				<td align="right">同步方式:</td>
				<td><pt6:syslookup name="synchType"
						lookupCode="UUMS_SYNCH_OPER_TYPE"
						dataOptions="width:151,editable:false,panelHeight:'auto'">
					</pt6:syslookup></td>
				<td align="right">父组织编码:</td>
				<td><input class="inputbox" style="width: 151px;" type="text"
					name="parentOrgCode" /></td>
				</tr>
				<tr>
					<td align="right">组织ID:</td>
					<td><input class="inputbox" style="width: 151px;" type="text"
						name="sysOrgId" /></td>
					<td align="right">应用系统ID:</td>
					<td><input class="inputbox" style="width: 151px;" type="text"
						name="appId" /></td>
				</tr>
				<tr><font color="red"></font>
				</tr>
			</table>
		</form>
		<div id="searchBtns">
			<a class="easyui-linkbutton" iconCls="" plain="false"
				onclick="uumsOrgSynchRecord.searchData();"
				href="javascript:void(0);">查询</a> <a class="easyui-linkbutton"
				iconCls="" plain="false" onclick="uumsOrgSynchRecord.clearData();"
				href="javascript:void(0);">清空</a> <a class="easyui-linkbutton"
				iconCls="" plain="false"
				onclick="uumsOrgSynchRecord.hideSearchForm();"
				href="javascript:void(0);">返回</a>
		</div>
	</div>
	<script
		src=" avicit/uums/synch/toappsys/orgdept/uumsorgsynchrecord/js/UumsOrgSynchRecord.js"
		type="text/javascript"></script>
	<script type="text/javascript">
		var uumsOrgSynchRecord;
		var currTreeNode;
		var curDatagrid = $('#dgUumsOrgSynchRecord');
		/* $(function() {
			uumsOrgSynchRecord = new UumsOrgSynchRecord('dgUumsOrgSynchRecord',
					'${url}', 'searchDialog', 'uumsOrgSynchRecord');
		}); */
		function loadTreeOk(node, data){
			currTreeNode = data[0].children[0];
			uumsOrgSynchRecord = new UumsOrgSynchRecord('dgUumsOrgSynchRecord',
					'${url}', 'searchDialog', 'uumsOrgSynchRecord');
		}
		function onClickNode(node) {
			currTreeNode = node;
			
			loadDatagridData();
		}
		// 加载数据
		function loadDatagridData(){
			curDatagrid.datagrid({
					url : "${url}getUumsOrgSynchRecordsByPage.json",
					queryParams : {
						appId : currTreeNode.id
					}
				});
			curDatagrid.datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
		}
		function formateDate(value, row, index) {
			return uumsOrgSynchRecord.formate(value);
		}
		function formateDateTime(value, row, index) {
			return uumsOrgSynchRecord.formateDateTime(value);
		}
		//uumsOrgSynchRecord.detail(\''+row.id+'\')
		function formateHref(value, row, inde) {
			return '<a href="javascript:void(0);" onclick="uumsOrgSynchRecord.detail(\''
					+ row.id + '\');">' + value + '</a>';
		}
		function formateorgOrDept(value) {
			return Platform6.fn.lookup.formatLookupType(value,
					uumsOrgSynchRecord.orgOrDept);
		}
		function formateoperFlag(value) {
			return Platform6.fn.lookup.formatLookupType(value,
					uumsOrgSynchRecord.operFlag);
		}
		function formatesynchFlag(value) {
			var val = Platform6.fn.lookup.formatLookupType(value,
					uumsOrgSynchRecord.synchFlag);
			if(value == '0'){
				return "<font color='blue'>"+val+"</font>";
			}else if(value == '1'){
				return "<font color='green'>"+val+"</font>";
			}else{
				return "<font color='red'>"+val+"</font>";
			}
		}
		function formatesynchType(value) {
			return Platform6.fn.lookup.formatLookupType(value,
					uumsOrgSynchRecord.synchType);
		}
		
	</script>
</body>
</html>