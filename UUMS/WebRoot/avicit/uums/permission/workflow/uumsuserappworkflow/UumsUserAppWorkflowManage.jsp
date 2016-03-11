<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "uums/permission/workflow/uumsuserappworkflow/UumsUserAppWorkflowController/UumsUserAppWorkflowInfo" -->
<title></title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<script src="static/js/platform/component/dialog/UserSelectDialog.js"
	type="text/javascript"></script>
<script src="static/js/platform/bpm/client/js/ToolBar.js"
	type="text/javascript"></script>
<jsp:include
	page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js"
	type="text/javascript"></script>
<link href="static/css/platform/sysdept/icon.css" type="text/css"
	rel="stylesheet">
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
		<div id="uumsWorkflowPermissionTab" class="easyui-tabs"
			data-options="fit:true">
			<div title="权限申请流程" id="workflowTab" data-options="fit:true">
				<div id="toolbarUumsUserAppWorkflow" class="datagrid-toolbar">
					<table>
						<tr>
							<sec:accesscontrollist hasPermission="3"
								domainObject="formdialog_uumsUserAppWorkflow_button_bpmAll"
								permissionDes="全部文件">
								<td width="105px;"><a href="javascript:void(0);"
									id="allMenu" name="bpm_all_menu" class='easyui-menubutton'
									data-options="menu:'#allmm',iconCls:'icon-all-file'">全部文件</a>
									<div id="allmm" style="width: 105px;">
										<div id='all_start' name="bpm_all_start"
											onclick="uumsUserAppWorkflow.initWorkFlow('start','all')">拟稿中</div>
										<div id='all_active' name="bpm_all_active"
											onclick="uumsUserAppWorkflow.initWorkFlow('active','all')">流转中</div>
										<div id='all_ended' name="bpm_all_ended"
											onclick="uumsUserAppWorkflow.initWorkFlow('ended','all')">已完成</div>
										<div id='all_all' name="bpm_all_all"
											onclick="uumsUserAppWorkflow.initWorkFlow('all','all')">全部文件</div>
									</div></td>
							</sec:accesscontrollist>
							<sec:accesscontrollist hasPermission="3"
								domainObject="formdialog_uumsUserAppWorkflow_button_bpmMyFile"
								permissionDes="我的文件">
								<td width="105px;"><a href="javascript:void(0);"
									id="myMenu" name="bpm_my_menu" class='easyui-menubutton'
									data-options="menu:'#mymm',iconCls:'icon-my-file'">我的文件</a>
									<div id="mymm" style="width: 105px;">
										<div id='my_start' name="bpm_my_start"
											onclick="uumsUserAppWorkflow.initWorkFlow('start','my')">我的拟稿</div>
										<div id='my_active' name="bpm_my_active"
											onclick="uumsUserAppWorkflow.initWorkFlow('active','my')">我的流转</div>
										<div id='my_ended' name="bpm_my_ended"
											onclick="uumsUserAppWorkflow.initWorkFlow('ended','my')">我的完成</div>
										<div id='my_all' name="bpm_my_all"
											onclick="uumsUserAppWorkflow.initWorkFlow('all','my')">我的全部</div>
									</div></td>
							</sec:accesscontrollist>
							<sec:accesscontrollist hasPermission="3"
								domainObject="formdialog_uumsUserAppWorkflow_button_add"
								permissionDes="添加用户">
								<td><a class="easyui-linkbutton" iconCls="icon-add"
									plain="true" onclick="showAdd();" href="javascript:void(0);">添加用户</a></td>
							</sec:accesscontrollist>
							<sec:accesscontrollist hasPermission="3"
								domainObject="formdialog_uumsUserAppWorkflow_button_edit"
								permissionDes="更新流程">
								<td id="tool_edit_td"><a class="easyui-linkbutton"
									iconCls="icon-edit" plain="true" onclick="showUpdate();"
									href="javascript:void(0);">更新用户</a></td>
							</sec:accesscontrollist>
							<sec:accesscontrollist hasPermission="3"
								domainObject="formdialog_uumsUserAppWorkflow_button_delete"
								permissionDes="删除用户">
								<td id="tool_del_td"><a class="easyui-linkbutton"
									iconCls="icon-remove" plain="true" onclick="showDel();"
									href="javascript:void(0);">删除用户 </a></td>
							</sec:accesscontrollist>
							<sec:accesscontrollist hasPermission="3"
								domainObject="formdialog_uumsUserAppWorkflow_button_edit"
								permissionDes="编辑流程">
								<td id="tool_edit_td"><a class="easyui-linkbutton"
									iconCls="icon-edit" plain="true" onclick="showModify();"
									href="javascript:void(0);">编辑流程</a></td>
							</sec:accesscontrollist>
							<sec:accesscontrollist hasPermission="3"
								domainObject="formdialog_uumsUserAppWorkflow_button_delete"
								permissionDes="删除流程">
								<td id="tool_del_td"><a class="easyui-linkbutton"
									iconCls="icon-remove" plain="true"
									onclick="uumsUserAppWorkflow.del();" href="javascript:void(0);">删除流程
								</a></td>
							</sec:accesscontrollist>
							<sec:accesscontrollist hasPermission="3"
								domainObject="formdialog_uumsUserAppWorkflow_button_query"
								permissionDes="查询">
								<td><a class="easyui-linkbutton" iconCls="icon-search"
									plain="true" onclick="uumsUserAppWorkflow.openSearchForm();"
									href="javascript:void(0);">查询</a></td>
							</sec:accesscontrollist>
						</tr>
					</table>
				</div>
				<table id="dgUumsUserAppWorkflow"
					data-options="
				fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#toolbarUumsUserAppWorkflow',
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
							<th
								data-options="field:'workFlowNo', halign:'center', formatter:formateHref"
								width="220">流程编号</th>
							<th data-options="field:'appName', halign:'center'" width="220">应用系统</th>
							<th data-options="field:'submitterAlias',align:'center'"
								width="220">提交人</th>
							<th
								data-options="field:'submitDate', halign:'center',formatter:formateDate"
								width="220">提交日期</th>
							<th data-options="field:'userIdAlias',align:'center'" width="220">用户</th>
							<th data-options="field:'activityalias_', halign:'center'"
								width="220px">流程当前步骤</th>
							<th data-options="field:'businessstate_', halign:'center'"
								width="220px">流程状态</th>
						</tr>
					</thead>
				</table>
			</div>
			<div title="权限列表" id="poermissionTab" data-options="fit:true">
				<div id="toolbarUumsUserAppPermissions" class="datagrid-toolbar">
					<table>
						<tr>
							<sec:accesscontrollist hasPermission="3"
								domainObject="formdialog_uumsUserAppPermissions_button_add"
								permissionDes="添加">
								<td><a class="easyui-linkbutton" iconCls="icon-add"
									plain="true" onclick="uumsUserAppPermissions.insert(currTreeNode.id);"
									href="javascript:void(0);">添加</a></td>
							</sec:accesscontrollist>
							<sec:accesscontrollist hasPermission="3"
								domainObject="formdialog_uumsUserAppPermissions_button_edit"
								permissionDes="编辑">
								<td><a class="easyui-linkbutton" iconCls="icon-edit"
									plain="true" onclick="uumsUserAppPermissions.modify(currTreeNode.id);"
									href="javascript:void(0);">编辑</a></td>
							</sec:accesscontrollist>
							<sec:accesscontrollist hasPermission="3"
								domainObject="formdialog_uumsUserAppPermissions_button_delete"
								permissionDes="删除">
								<td><a class="easyui-linkbutton" iconCls="icon-remove"
									plain="true" onclick="uumsUserAppPermissions.del(currTreeNode.id);"
									href="javascript:void(0);">删除</a></td>
							</sec:accesscontrollist>
							<sec:accesscontrollist hasPermission="3"
								domainObject="formdialog_uumsUserAppPermissions_button_query"
								permissionDes="查询">
								<td><a class="easyui-linkbutton" iconCls="icon-search"
									plain="true" onclick="uumsUserAppPermissions.openSearchForm(currTreeNode.id);"
									href="javascript:void(0);">查询</a></td>
							</sec:accesscontrollist>
							<sec:accesscontrollist hasPermission="3"
								domainObject="formdialog_uumsUserAppPermissions_button_synchInsert"
								permissionDes="同步新增">
								<td><a class="easyui-linkbutton" iconCls="icon-export"
									plain="true" onclick="uumsUserAppPermissions.synchUser(currTreeNode.id, 'insert');"
									href="javascript:void(0);">同步新增</a></td>
							</sec:accesscontrollist>
							<sec:accesscontrollist hasPermission="3"
								domainObject="formdialog_uumsUserAppPermissions_button_synchUpdate"
								permissionDes="同步修改">
								<td><a class="easyui-linkbutton" iconCls="icon-export"
									plain="true" onclick="uumsUserAppPermissions.synchUser(currTreeNode.id, 'update');"
									href="javascript:void(0);">同步修改</a></td>
							</sec:accesscontrollist>
							<sec:accesscontrollist hasPermission="3"
								domainObject="formdialog_uumsUserAppPermissions_button_synchDel"
								permissionDes="同步删除">
								<td><a class="easyui-linkbutton" iconCls="icon-export"
									plain="true" onclick="uumsUserAppPermissions.synchUser(currTreeNode.id, 'delete');"
									href="javascript:void(0);">同步删除</a></td>
							</sec:accesscontrollist>
							<sec:accesscontrollist hasPermission="3"
								domainObject="formdialog_uumsUserAppPermissions_button_synchAll"
								permissionDes="同步全部">
								<td><a class="easyui-linkbutton" iconCls="icon-export"
									plain="true" onclick="uumsUserAppPermissions.synchUser(currTreeNode.id, 'all');"
									href="javascript:void(0);">同步全部</a></td>
							</sec:accesscontrollist>
							<sec:accesscontrollist hasPermission="3"
								domainObject="formdialog_uumsUserAppPermissions_button_initUser"
								permissionDes="初始化">
								<td><a class="easyui-linkbutton" iconCls="icon-export"
									plain="true" onclick="uumsUserAppPermissions.initUser(currTreeNode.id);"
									href="javascript:void(0);">初始化</a></td>
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
							<!-- <th data-options="field:'appName', halign:'center'" width="220">应用系统</th> -->
							<th data-options="field:'loginName', halign:'center'" width="220">用户ID</th>
							<th data-options="field:'userName', halign:'center'" width="220">用户姓名</th>
							<th data-options="field:'deptName', halign:'center'" width="220">所在部门</th>
							<th
								data-options="field:'auditFlag', halign:'center',formatter:formateauditFlag"
								width="220">审批状态</th>
							<th
								data-options="field:'operFlag', halign:'center',formatter:formateoperFlag"
								width="200">操作状态</th>
							<th
								data-options="field:'synchFlag', halign:'center',formatter:formatesynchFlag"
								width="200">同步状态</th>
							<th
								data-options="field:'synchTime', halign:'center',formatter:formateDate"
								width="270">同步时间</th>
							
							<th data-options="field:'synchType', halign:'center',formatter:formatesynchType" width="200">同步方式</th>
							<th
								data-options="field:'actFlag', halign:'center',formatter:formateactFlag"
								width="200">活动状态</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
	</div>
	<!--*****************************流程搜索*********************************  -->
	<div id="searchDialog"
		data-options="iconCls:'icon-search',resizable:true,modal:false,buttons:'#searchBtns'"
		style="overflow: auto; padding-bottom: 35px;">
		<form id="uumsUserAppWorkflow">
			<table style="padding-top: 10px; width: 600px; margin: 0 auto;">
				<tr>
					<td align="right">应用系统:</td>
					<td><input class="inputbox" style="width: 151px;" type="text"
						name="appId" /></td>
					<td align="right">用户权限ID:</td>
					<td><input class="inputbox" style="width: 151px;" type="text"
						name="pId" /></td>
				</tr>
				<tr>
					<td align="right">流程编号:</td>
					<td><input class="inputbox" style="width: 151px;" type="text"
						name="workFlowNo" /></td>
					<td align="right">提交人:</td>
					<td><input title="用户名称" class="inputbox" style="width: 180px;"
						type="hidden" name="submitter" id="submitter" />
						<div class="">
							<input class="easyui-validatebox" name="submitterAlias"
								id="submitterAlias" readOnly="readOnly" style="width: 150px;"></input>
						</div></td>
				</tr>
				<tr>
					<td align="right">提交日期从:</td>
					<td><input name="submitDateBegin" id="submitDateBegin"
						class="easyui-datebox" editable="false" style="width: 150px;" />
					<td align="right">提交日期(至):</td>
					<td><input name="submitDateEnd" id="submitDateEnd"
						class="easyui-datebox" editable="false" style="width: 150px;" />
					</td>
				</tr>
				<tr>
					<!-- <td align="right">审批人:</td>
					<td><input class="inputbox" style="width: 151px;" type="text"
						name="auditPerson" /></td> -->
					<td align="right">选择用户:</td>
					<td colspan="3"><input title="用户名称" class="inputbox"
						style="width: 180px;" type="hidden" name="userId" id="userId" />
						<div id="userSelectCommonDialog">
							<input class="easyui-validatebox" name="userIdAlias"
								id="userIdAlias" readOnly="readOnly" style="width: 460px;"></input>
						</div></td>
				</tr>
				<tr>
				</tr>
			</table>
			<input type="hidden" name="bpmState" id="bpmState" value="all"></input>
			<input type="hidden" name="bpmType" id="bpmType" value="my"></input>
		</form>
		<div id="searchBtns">
			<a class="easyui-linkbutton" iconCls="" plain="false"
				onclick="uumsUserAppWorkflow.searchData();"
				href="javascript:void(0);">查询</a> <a class="easyui-linkbutton"
				iconCls="" plain="false" onclick="uumsUserAppWorkflow.clearData();"
				href="javascript:void(0);">清空</a> <a class="easyui-linkbutton"
				iconCls="" plain="false"
				onclick="uumsUserAppWorkflow.hideSearchForm();"
				href="javascript:void(0);">返回</a>
		</div>
	</div>
	<!--*****************************用户权限搜索*********************************  -->
	<div id="searchDialog2"
		data-options="iconCls:'icon-search',resizable:true,modal:false,buttons:'#searchBtns'"
		style="overflow: auto; padding-bottom: 35px;">
		<form id="uumsUserAppPermissions">
			<table style="padding-top: 10px; width: 600px; margin: 0 auto;">
				<tr>
					<input name="appId" type="hidden"/>
					<td align="right">选择用户:</td>
					<td ><input class="inputbox" type="hidden" name="userId" />
						<div id="userSelectCommonDialog2">
							<input class="inputbox" name="userName"
								data-options="validType:'maxLength[150]'"
								id="userName" readOnly="readOnly" style="width: 151px;"></input>
						</div></td>
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
		src="avicit/uums/permission/workflow/uumsuserappworkflow/js/UumsUserAppWorkflow.js"
		type="text/javascript"></script>
	<script type="text/javascript">
		var uumsUserAppWorkflow;
		var currTreeNode;
		var curDatagrid = $('#dgUumsUserAppWorkflow');
		var currTabIndex="workflowTab";
		var wfUrl = "${url}";
		var url1 = wfUrl + "getUumsUserAppWorkflowsByPage.json";
		var currUrl = url1;
		$(function() {
			uumsUserAppWorkflow = new UumsUserAppWorkflow(
					'dgUumsUserAppWorkflow', '${url}', 'searchDialog',
					'uumsUserAppWorkflow');
			/* var submitterUserCommonSelector = new CommonSelector("user",
					"userSelectCommonDialog", "submitter", "submitterAlias");
			submitterUserCommonSelector.init(); */
			var userIdUserCommonSelector = new CommonSelector("user",
					"userSelectCommonDialog", "userId", "userIdAlias");
			userIdUserCommonSelector.init();
			
			initTabContainer();
		});
		function loadTreeOk(node, data){
			currTreeNode = data[0].children[0];
		}
		function onClickNode(node) {
			currTreeNode = node;
			loadDatagridData();
		}
		function selectAppsys() {
			var selectNode = currTreeNode;
			if (!selectNode || selectNode.id == "root") {
				$.messager.alert('提示', "请选择应用系统！", 'warning');
				return;
			}
		}
		// 初始化TAB标签页，并添加选择事件处理
		function initTabContainer() {
			$('#uumsWorkflowPermissionTab').tabs({
				onSelect : function(title, index) {
					if (index == 0) {
						currTabIndex = "workflowTab";
						currUrl = url1;
						curDatagrid = $('#dgUumsUserAppWorkflow');
						loadDatagridData();
					}
					if (index == 1) {
						currTabIndex = "poermissionTab";
						currUrl = url2;
						curDatagrid = $('#dgUumsUserAppPermissions');
						loadDatagridData();
					}
				}});
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
		function showAdd() {
			selectAppsys();
			uumsUserAppWorkflow.insert(currTreeNode, "addP");
		}
		function showModify() {
			selectAppsys();
			uumsUserAppWorkflow.modify(currTreeNode);
		}
		function showDel() {
			selectAppsys();
			uumsUserAppWorkflow.insert(currTreeNode, "delP");
		}
		function showUpdate() {
			selectAppsys();
			uumsUserAppWorkflow.insert(currTreeNode, "editP");
		}
		function formateDate(value, row, index) {
			return uumsUserAppWorkflow.formate(value);
		}
		function formateHref(value, row, inde) {
			return "<a href='javascript:void(0);' onclick='uumsUserAppWorkflow.detail(\""
					+ row.id + "\",\"" + value + "\");'>" + value + "</a>";
		}
	</script>
	<script
		src="avicit/uums/permission/synch/uumsuserapppermissions/js/UumsUserAppPermissions.js"
		type="text/javascript"></script>
	<script type="text/javascript">
		var uumsUserAppPermissions;
		var purl = "platform/uums/permission/synch/uumsuserapppermissions/UumsUserAppPermissionsController/operation/";
		var url2 = purl+"getUumsUserAppPermissionssByPage.json";
		$(function() {
			uumsUserAppPermissions = new UumsUserAppPermissions(
					'dgUumsUserAppPermissions', purl, 'searchDialog2',
					'uumsUserAppPermissions');
			var userIdUserCommonSelector2 = new CommonSelector("user",
					"userSelectCommonDialog2", "userId", "userName");
			userIdUserCommonSelector2.init();
		});
		function formateDate(value, row, index) {
			return uumsUserAppPermissions.formateDateTime(value);
		}
		function formateauditFlag(value) {
			return Platform6.fn.lookup.formatLookupType(value,
					uumsUserAppPermissions.auditFlag);
		}
		function formatesynchFlag(value) {
			var val = Platform6.fn.lookup.formatLookupType(value,uumsUserAppPermissions.synchFlag);
			if(value == '0'){
				return "<font color='blue'>"+val+"</font>";
			}else if(value == '1'){
				return "<font color='green'>"+val+"</font>";
			}else{
				return "<font color='red'>"+val+"</font>";
			}
		}
		function formateoperFlag(value) {
			return Platform6.fn.lookup.formatLookupType(value,
					uumsUserAppPermissions.operFlag);
		}
		function formateactFlag(value) {
			return Platform6.fn.lookup.formatLookupType(value,
					uumsUserAppPermissions.actFlag);
		}
		function formatesynchType(value){
			return Platform6.fn.lookup.formatLookupType(value,
					uumsUserAppPermissions.synchType);
		}
	</script>
</body>
</html>