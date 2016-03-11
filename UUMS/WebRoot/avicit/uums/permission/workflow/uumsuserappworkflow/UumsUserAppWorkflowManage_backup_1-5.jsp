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
<link href="static/css/platform/sysdept/icon.css" type="text/css" rel="stylesheet">
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'west',split:true,title:''" style="width:250px;padding:0px;">
	<ul id="appSysTree" class="easyui-tree" data-options="
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
       		onClick: onClickNode
       ">
    </ul>
</div>
	<div data-options="region:'center'" style="background: #ffffff;">
		<div id="toolbarUumsUserAppWorkflow" class="datagrid-toolbar">
			<table>
				<tr>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_uumsUserAppWorkflow_button_bpmAll"
						permissionDes="全部文件">
						<td width="105px;"><a href="javascript:void(0);" id="allMenu"
							name="bpm_all_menu" class='easyui-menubutton'
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
						<td width="105px;"><a href="javascript:void(0);" id="myMenu"
							name="bpm_my_menu" class='easyui-menubutton'
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
							plain="true" onclick="showAdd();"
							href="javascript:void(0);">添加用户</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_uumsUserAppWorkflow_button_edit"
						permissionDes="更新流程">
						<td id="tool_edit_td"><a class="easyui-linkbutton"
							iconCls="icon-edit" plain="true"
							onclick="showUpdate();"
							href="javascript:void(0);">更新用户</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_uumsUserAppWorkflow_button_delete"
						permissionDes="删除用户">
						<td id="tool_del_td"><a class="easyui-linkbutton"
							iconCls="icon-remove" plain="true"
							onclick="showDel();" href="javascript:void(0);">删除用户 </a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_uumsUserAppWorkflow_button_edit"
						permissionDes="编辑流程">
						<td id="tool_edit_td"><a class="easyui-linkbutton"
							iconCls="icon-edit" plain="true"
							onclick="showModify();"
							href="javascript:void(0);">编辑流程</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_uumsUserAppWorkflow_button_delete"
						permissionDes="删除流程">
						<td id="tool_del_td"><a class="easyui-linkbutton"
							iconCls="icon-remove" plain="true"
							onclick="uumsUserAppWorkflow.del();" href="javascript:void(0);">删除流程 </a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_uumsUserAppWorkflow_button_query"
						permissionDes="查询">
						<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="uumsUserAppWorkflow.openSearchForm();"
							href="javascript:void(0);">查询</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_uumsUserAppWorkflow_button_query"
						permissionDes="同步">
						<td><a class="easyui-linkbutton" iconCls="icon-export"
							plain="true" onclick="uumsUserAppWorkflow.openSearchForm();"
							href="javascript:void(0);">同步</a></td>
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
					<th data-options="field:'workFlowNo', halign:'center', formatter:formateHref" width="220">流程编号</th>
					<th
						data-options="field:'appName', halign:'center'"
						width="220">应用系统</th>
					<th data-options="field:'submitterAlias',align:'center'"
						width="220">提交人</th>
					<th
						data-options="field:'submitDate', halign:'center',formatter:formateDate"
						width="220">提交日期</th>
					<!-- <th data-options="field:'auditStatus', halign:'center'" width="220">审批状态</th>
					<th data-options="field:'auditOpinion', halign:'center'"
						width="220">同步状态</th>
					<th
						data-options="field:'auditDate', halign:'center',formatter:formateDate"
						width="220">审批日期</th>
					<th data-options="field:'auditPerson', halign:'center'" width="220">审批人</th> -->
					<th data-options="field:'userIdAlias',align:'center'" width="220">用户</th>
					<th data-options="field:'activityalias_', halign:'center'"
						width="220px">流程当前步骤</th>
					<th data-options="field:'businessstate_', halign:'center'"
						width="220px">流程状态</th>
				</tr>
			</thead>
		</table>
	</div>
	<!--*****************************搜索*********************************  -->
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
					<td><input title="用户名称" class="inputbox"
						style="width: 180px;" type="hidden" name="submitter"
						id="submitter" />
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
				<!-- <tr>
					<td align="right">审批状态:</td>
					<td><input class="inputbox" style="width: 151px;" type="text"
						name="auditStatus" /></td>
					<td align="right">审批意见:</td>
					<td><input class="inputbox" style="width: 151px;" type="text"
						name="auditOpinion" /></td>
				</tr>
				<tr>
					<td align="right">审批日期从:</td>
					<td><input name="auditDateBegin" id="auditDateBegin"
						class="easyui-datebox" editable="false" style="width: 150px;" />
					<td align="right">审批日期(至):</td>
					<td><input name="auditDateEnd" id="auditDateEnd"
						class="easyui-datebox" editable="false" style="width: 150px;" />
					</td>
				</tr> -->
				<tr>
					<!-- <td align="right">审批人:</td>
					<td><input class="inputbox" style="width: 151px;" type="text"
						name="auditPerson" /></td> -->
					<td align="right">选择用户:</td>
					<td colspan="3"><input title="用户名称" class="inputbox" style="width: 180px;"
						type="hidden" name="userId" id="userId" />
						<div class="">
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

	<script
		src="avicit/uums/permission/workflow/uumsuserappworkflow/js/UumsUserAppWorkflow.js"
		type="text/javascript"></script>
	<script type="text/javascript">
		var uumsUserAppWorkflow;
		$(function() {
			uumsUserAppWorkflow = new UumsUserAppWorkflow(
					'dgUumsUserAppWorkflow', '${url}', 'searchDialog',
					'uumsUserAppWorkflow');
			var submitterUserCommonSelector = new CommonSelector("user",
					"userSelectCommonDialog", "submitter", "submitterAlias");
			submitterUserCommonSelector.init();
			var userIdUserCommonSelector = new CommonSelector("user",
					"userSelectCommonDialog", "userId", "userIdAlias");
			userIdUserCommonSelector.init();
		});
		
		function formateDate(value, row, index) {
			return uumsUserAppWorkflow.formate(value);
		}
		function formateDateTime(value, row, index) {
			return uumsUserAppWorkflow.formateTime(value);
		}
		//demoBusinessFlow.detail(\''+row.id+'\')
		function formateHref(value, row, inde) {
			return "<a href='javascript:void(0);' onclick='uumsUserAppWorkflow.detail(\""
					+ row.id + "\",\"" + value + "\");'>" + value + "</a>";
		}
		
		var currTreeNode;
		function onClickNode(node){
			currTreeNode = node;
			$("#dgUumsUserAppWorkflow").datagrid("load", {appId : node.id});
		}
		function selectAppsys(){
			var selectNode = currTreeNode;
			if(!selectNode || selectNode.id=="root"){
				$.messager.alert('提示',"请选择应用系统！",'warning');
				return;
			}
		}
		function showAdd(){
			selectAppsys();
			uumsUserAppWorkflow.insert(currTreeNode, "addP");
		}
		function showModify(){
			selectAppsys();
			uumsUserAppWorkflow.modify(currTreeNode);
		}
		function showDel(){
			selectAppsys();
			uumsUserAppWorkflow.insert(currTreeNode, "delP");
		}
		function showUpdate(){
			selectAppsys();
			uumsUserAppWorkflow.insert(currTreeNode, "editP");
		}
	</script>
</body>
</html>