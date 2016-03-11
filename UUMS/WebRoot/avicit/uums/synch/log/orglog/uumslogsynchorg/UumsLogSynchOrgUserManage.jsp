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
<!-- ControllerPath = "uums/synch/log/orglog/uumslogsynchorg/UumsLogSynchOrgController/UumsLogSynchOrgUserInfo" -->
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
			url:'platform/uums/appsys/register/uumsappsys/UumsAppSysController/operation/getAppSysTree.json?hr=ok',
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
		<div id="uumsLogOrgUserTab" class="easyui-tabs"
			data-options="fit:true">
			<div title="组织同步日志" id="orgLogTab" data-options="fit:true">
		<div id="toolbarUumsLogSynchOrg" class="datagrid-toolbar">
			<table>
				<tr>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_uumsLogSynchOrg_button_delete"
						permissionDes="删除">
						<td><a class="easyui-linkbutton" iconCls="icon-remove"
							plain="true" onclick="uumsLogSynchOrg.del();"
							href="javascript:void(0);">删除</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_uumsLogSynchOrg_button_query"
						permissionDes="查询">
						<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="uumsLogSynchOrg.openSearchForm();"
							href="javascript:void(0);">查询</a></td>
					</sec:accesscontrollist>
				</tr>
			</table>
		</div>
		<table id="dgUumsLogSynchOrg"
			data-options="
				fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#toolbarUumsLogSynchOrg',
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
						width="220">ID</th>
					<!-- <th data-options="field:'appId', halign:'center'" width="220">应用系统</th> -->
					<th data-options="field:'appName', halign:'center'" width="220">应用系统</th>
					<th data-options="field:'orgName', halign:'center'" width="220">组织名称</th>
					<th data-options="field:'orgCode', halign:'center'" width="220">组织编码</th>
					<th
						data-options="field:'synchTime', halign:'center',formatter:formateDateTime"
						width="250">同步时间</th>
					<th
						data-options="field:'operFlag', halign:'center',formatter:formateoperFlag"
						width="220">操作类型</th>
					<th
						data-options="field:'synchType', halign:'center',formatter:formatesynchType"
						width="200">同步方式</th>
						<th data-options="field:'operator', halign:'center'" width="200">操作人</th>
						<th
						data-options="field:'synchFlag', halign:'center',formatter:formatesynchFlag"
						width="200">同步结果</th>
					<th data-options="field:'faildCause', halign:'center'" width="220">失败原因</th>
				</tr>
			</thead>
		</table>
		</div>
			<div title="用户同步日志" id="userLogTab" data-options="fit:true">
			<div id="toolbarUumsLogSynchUser" class="datagrid-toolbar">
			<table>
				<tr>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_uumsLogSynchUser_button_delete"
						permissionDes="删除">
						<td><a class="easyui-linkbutton" iconCls="icon-remove"
							plain="true" onclick="uumsLogSynchUser.del();"
							href="javascript:void(0);">删除</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_uumsLogSynchUser_button_query"
						permissionDes="查询">
						<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="uumsLogSynchUser.openSearchForm();"
							href="javascript:void(0);">查询</a></td>
					</sec:accesscontrollist>
				</tr>
			</table>
		</div>
		<table id="dgUumsLogSynchUser"
			data-options="
				fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#toolbarUumsLogSynchUser',
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
						width="220">ID</th>
					<!-- <th data-options="field:'appId', halign:'center'" width="220">应用系统</th> -->
					<th data-options="field:'appName', halign:'center'" width="220">应用系统</th>
					<th data-options="field:'userName', halign:'center'" width="220">用户姓名</th>
					<th data-options="field:'userId', halign:'center'" width="220">用户ID</th>
					<th
						data-options="field:'synchTime', halign:'center',formatter:formateDateTime"
						width="250">同步时间</th>
					<th
						data-options="field:'operFlag', halign:'center',formatter:formateoperFlag"
						width="200">操作类型</th>
					<th
						data-options="field:'synchType', halign:'center',formatter:formatesynchType"
						width="200">同步方式</th>
						<th data-options="field:'operator', halign:'center'" width="220">操作人</th>
						<th
						data-options="field:'synchFlag', halign:'center',formatter:formatesynchFlag"
						width="200">同步结果</th>
					<th data-options="field:'faildCause', halign:'center'" width="220">失败原因</th>
				</tr>
			</thead>
		</table>
		</div>			
		</div>
	</div>
	<!--*****************************搜索*********************************  -->
	<div id="searchDialogOrg"
		data-options="iconCls:'icon-search',resizable:true,modal:false,buttons:'#searchBtns'"
		style="overflow: auto; padding-bottom: 35px;">
		<form id="uumsLogSynchOrg">
			<input type="hidden" name="appId" id="appId1">
			<table style="padding-top: 10px; width: 600px; margin: 0 auto;">
				<tr>
					<td align="right">应用系统:</td>
					<td><input class="inputbox" style="width: 151px;" type="text"
						name="appName" id="appName1" readonly="readonly"/></td>
					<td align="right">组织名称:</td>
					<td><input class="inputbox" style="width: 151px;" type="text"
						name="orgName" /></td>
				</tr>
				<tr>
					<td align="right">组织编码:</td>
					<td><input class="inputbox" style="width: 151px;" type="text"
						name="orgCode" /></td>
				</tr>
				<tr>
					<td align="right">同步时间从:</td>
					<td><input name="synchTimeBegin" id="synchTimeBegin"
						class="easyui-datebox" editable="false" style="width: 150px;" />
					<td align="right">同步时间(至):</td>
					<td><input name="synchTimeEnd" id="synchTimeEnd"
						class="easyui-datebox" editable="false" style="width: 150px;" />
					</td>
				</tr>
				<td align="right">同步结果:</td>
				<td><pt6:syslookup name="synchFlag"
						lookupCode="UUMS_SYNCH_RESULT"
						dataOptions="width:151,editable:false,panelHeight:'auto'">
					</pt6:syslookup></td>
				</tr>
				<tr>
					<td align="right">操作类型:</td>
					<td><pt6:syslookup name="operFlag" lookupCode="UUMS_OPER_FLAG"
							dataOptions="width:151,editable:false,panelHeight:'auto'">
						</pt6:syslookup></td>
					<td align="right">同步方式:</td>
					<td><pt6:syslookup name="synchType"
							lookupCode="UUMS_SYNCH_OPER_TYPE"
							dataOptions="width:151,editable:false,panelHeight:'auto'">
						</pt6:syslookup></td>
				</tr>
				<tr>
					<td align="right">失败原因:</td>
					<td><input class="inputbox" style="width: 151px;" type="text"
						name="faildCause" /></td>
					<td align="right">操作人:</td>
					<td><input class="inputbox" style="width: 151px;" type="text"
						name="operator" /></td>
				</tr>
				<tr>
				</tr>
			</table>
		</form>
		<div id="searchBtns">
			<a class="easyui-linkbutton" iconCls="" plain="false"
				onclick="uumsLogSynchOrg.searchData();" href="javascript:void(0);">查询</a>
			<a class="easyui-linkbutton" iconCls="" plain="false"
				onclick="uumsLogSynchOrg.clearData();" href="javascript:void(0);">清空</a>
			<a class="easyui-linkbutton" iconCls="" plain="false"
				onclick="uumsLogSynchOrg.hideSearchForm();"
				href="javascript:void(0);">返回</a>
		</div>
	</div>
	<!--*****************************搜索*********************************  -->
	<div id="searchDialogUser"
		data-options="iconCls:'icon-search',resizable:true,modal:false,buttons:'#searchBtns'"
		style="overflow: auto; padding-bottom: 35px;">
		<form id="uumsLogSynchUser">
			<input type="hidden" name="appId" id="appId2">
			<table style="padding-top: 10px; width: 600px; margin: 0 auto;">
				<tr>
					<td align="right">应用系统:</td>
					<td><input class="inputbox" style="width: 151px;" type="text"
						name="appName" id="appName2" readonly="readonly"/></td>
					<td align="right">用户姓名:</td>
					<td><input class="inputbox" style="width: 151px;" type="text"
						name="userName" /></td>
				</tr>
				<tr>
					<td align="right">用户ID:</td>
					<td><input class="inputbox" style="width: 151px;" type="text"
						name="userId" /></td>
				</tr>
				<tr>
					<td align="right">同步时间从:</td>
					<td><input name="synchTimeBegin" id="synchTimeBegin"
						class="easyui-datebox" editable="false" style="width: 150px;" />
					<td align="right">同步时间(至):</td>
					<td><input name="synchTimeEnd" id="synchTimeEnd"
						class="easyui-datebox" editable="false" style="width: 150px;" />
					</td>
				</tr>
				<td align="right">同步结果:</td>
				<td><pt6:syslookup name="synchFlag"
						lookupCode="UUMS_SYNCH_RESULT"
						dataOptions="width:151,editable:false,panelHeight:'auto'">
					</pt6:syslookup></td>
				</tr>
				<tr>
					<td align="right">操作类型:</td>
					<td><pt6:syslookup name="operFlag" lookupCode="UUMS_OPER_FLAG"
							dataOptions="width:151,editable:false,panelHeight:'auto'">
						</pt6:syslookup></td>
					<td align="right">同步方式:</td>
					<td><pt6:syslookup name="synchType"
							lookupCode="UUMS_SYNCH_OPER_TYPE"
							dataOptions="width:151,editable:false,panelHeight:'auto'">
						</pt6:syslookup></td>
				</tr>
				<tr>
					<td align="right">失败原因:</td>
					<td><input class="inputbox" style="width: 151px;" type="text"
						name="faildCause" /></td>
					<td align="right">操作人:</td>
					<td><input class="inputbox" style="width: 151px;" type="text"
						name="operator" /></td>
				</tr>
				<tr>
				</tr>
			</table>
		</form>
		<div id="searchBtns">
			<a class="easyui-linkbutton" iconCls="" plain="false"
				onclick="uumsLogSynchUser.searchData();" href="javascript:void(0);">查询</a>
			<a class="easyui-linkbutton" iconCls="" plain="false"
				onclick="uumsLogSynchUser.clearData();" href="javascript:void(0);">清空</a>
			<a class="easyui-linkbutton" iconCls="" plain="false"
				onclick="uumsLogSynchUser.hideSearchForm();"
				href="javascript:void(0);">返回</a>
		</div>
	</div>
	<script
		src=" avicit/uums/synch/log/orglog/uumslogsynchorg/js/UumsLogSynchOrg.js"
		type="text/javascript"></script>
	<script type="text/javascript">
		var uumsLogSynchOrg;
		var currTreeNode;
		var curDatagrid = $('#dgUumsLogSynchOrg');
		var currTabIndex="orgLogTab";
		var orgLogUrl = "${url}getUumsLogSynchOrgsByPage.json";
		var userLogUrl = "platform/uums/synch/log/userlog/uumslogsynchuser/UumsLogSynchUserController/operation/getUumsLogSynchUsersByPage.json";
		var currUrl = orgLogUrl;
		$(function() {
			uumsLogSynchOrg = new UumsLogSynchOrg('dgUumsLogSynchOrg',
					'${url}', 'searchDialogOrg', 'uumsLogSynchOrg',false); 
			
			initTabContainer();
		});
		// 初始化TAB标签页，并添加选择事件处理
		function initTabContainer() {
			$('#uumsLogOrgUserTab').tabs({
				onSelect : function(title, index) {
					if (index == 0) {
						currTabIndex = "orgLogTab";
						currUrl = orgLogUrl;
						curDatagrid = $('#dgUumsLogSynchOrg');
						loadDatagridData();
					}
					if (index == 1) {
						currTabIndex = "userLogTab";
						currUrl = userLogUrl;
						curDatagrid = $('#dgUumsLogSynchUser');
						loadDatagridData();
					}
				}});
		}
		function loadTreeOk(node, data){
			currTreeNode = data[0].children[0];
			//加载数据
			loadDatagridData();
		}
		function onClickNode(node) {
			currTreeNode = node;
			loadDatagridData();
		}
		// 加载数据
		function loadDatagridData(){
			curDatagrid.datagrid({
					url : currUrl,
					queryParams : {
						appId : currTreeNode.id
					}
				});
			curDatagrid.datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
		}
		function formateDate(value, row, index) {
			return uumsLogSynchOrg.formate(value);
		}
		function formateDateTime(value, row, index) {
			return uumsLogSynchOrg.formateDateTime(value);
		}
		function formatesynchFlag(value) {
			var ok = "<img src='static/images/platform/common/common/ok.gif' style='margin-bottom:-3px' border='0' width='15px' height='15px'>";
			var no = "<img src='static/images/platform/common/common/no.gif' style='margin-bottom:-3px' border='0' width='15px' height='15px'>";
			var val = Platform6.fn.lookup.formatLookupType(value,uumsLogSynchOrg.synchFlag);
			if(value == "1"){
				return ok + val;
			}else{
				return no + val;
			}
		}
		function formateoperFlag(value) {
			return Platform6.fn.lookup.formatLookupType(value,
					uumsLogSynchOrg.operFlag);
		}
		function formatesynchType(value) {
			return Platform6.fn.lookup.formatLookupType(value,
					uumsLogSynchOrg.synchType);
		}
	</script>
	<script
		src=" avicit/uums/synch/log/userlog/uumslogsynchuser/js/UumsLogSynchUser.js"
		type="text/javascript"></script>
	<script type="text/javascript">
		var uumsLogSynchUser;
		var ulogUrl = "platform/uums/synch/log/userlog/uumslogsynchuser/UumsLogSynchUserController/operation/";
		$(function() {
			uumsLogSynchUser = new UumsLogSynchUser('dgUumsLogSynchUser',
					ulogUrl, 'searchDialogUser', 'uumsLogSynchUser', false);
		});
	</script>
</body>
</html>