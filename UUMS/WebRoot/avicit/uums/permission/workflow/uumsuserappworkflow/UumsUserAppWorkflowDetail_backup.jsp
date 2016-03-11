<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	String entryId = request.getParameter("entryId");
	String executionId = request.getParameter("executionId");
	String taskId = request.getParameter("taskId");
	String formId = request.getParameter("id");
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- ControllerPath = "uums/permission/workflow/uumsuserappworkflow/UumsUserAppWorkflowController/operation/Detail/id" -->
<title>详细</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/BpmJsInclude.jsp"></jsp:include>
<jsp:include
	page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
</head>
<script type="text/javascript">
	var baseurl = '<%=request.getContextPath()%>';
	var entryId = "<%=entryId%>";
	var executionId = "<%=executionId%>";
	var taskId = "<%=taskId%>";
	var formId = "<%=formId%>";

	$(function() {
		if (!"${uumsUserAppWorkflowDTO.submitDate}" == "") {
			$('#submitDate').datebox(
					'setValue',
					parserColumnTime("${uumsUserAppWorkflowDTO.submitDate}")
							.format("yyyy-MM-dd"));
		}
		if (!"${uumsUserAppWorkflowDTO.auditDate}" == "") {
			$('#auditDate').datebox(
					'setValue',
					parserColumnTime("${uumsUserAppWorkflowDTO.auditDate}")
							.format("yyyy-MM-dd"));
		}
		/* var submitterUserCommonSelector = new CommonSelector("user",
				"userSelectCommonDialog", "submitter", "submitterAlias");
		submitterUserCommonSelector.init();
		var userIdUserCommonSelector = new CommonSelector("user",
				"userSelectCommonDialog", "userId", "userIdAlias");
		userIdUserCommonSelector.init(); */
		
	})

	//初始化页面值
	function initFormData() {
		$.ajax({
			url : 'platform/uums/permission/workflow/uumsuserappworkflow/UumsUserAppWorkflowController/toDetailJsp.json',
			data : {id : formId},
			type : 'post',
			dataType : 'json',
			success : function(result) {
				if (result.flag == "success") {
					//进行时间转化
					result.uumsUserAppWorkflow.submitDate = formatDatebox(result.uumsUserAppWorkflow.submitDate);
					result.uumsUserAppWorkflow.auditDate = formatDatebox(result.uumsUserAppWorkflow.auditDate);
					$("#formDetail").form('load',result.uumsUserAppWorkflow);
				} else {
					$.messager.show({
						title : '提示',
						msg : "数据加载失败。"
					});
				}
			}
		});
	}

	/**
	 * 保存表单方法
	 * @param processInstanceId
	 * @param executionId
	 */
	window.saveFormData = function(processInstanceId, executionId) {
		var dataVo = $('#formDetail').serializeArray();
		var dataJson = convertToJson(dataVo);
		dataVo = JSON.stringify(dataJson);
		$.ajax({
			url : 'platform/uums/permission/workflow/uumsuserappworkflow/UumsUserAppWorkflowController/operation/save',
			data : {
				data : dataVo
			},
			type : 'post',
			dataType : 'json',
			success : function(result) {
				if (result.flag == "success") {
					initFormData();
					$.messager.show({
						title : '提示',
						msg : "操作成功。"
					});
				} else {
					$.messager.show({
						title : '提示',
						msg : "操作失败。"
					});
				}
			}
		});
	};

	//返回
	function doBack() {
		if (parent != null && parent.$('#tabs') != null) {
			var currTab = parent.$('#tabs').tabs('getSelected');
			var currTitle = currTab.panel('options').title;
			parent.$('#tabs').tabs('close', currTitle);
		}
	}
	//页面加载完成后入口
	$(function() {
		initFormData();
		//不控制表单权限
		//initBpmInfo(entryId,executionId,taskId,formId);
		//控制表单权限用这个
		initBpmInfoAndFormAccess(entryId, executionId, taskId, formId);
	});
	
</script>
<body class="easyui-layout" fit="true">
	<div region='center' border="false" style="overflow: hidden;">
		<!-- 流程按钮区域开始 -->
		<div class=datagrid-toolbar>
			<div id=bpmToolBar></div>
			<!-- 自定义按钮放到这里 -->
			<a class="easyui-linkbutton" iconCls="icon-undo" plain="true"
				onclick="doBack();" href="javascript:void(0);">返回</a>
		</div>
		<!-- 流程按钮区域结束 -->
		<fieldset>
			<form id='formDetail'>
				<input type="hidden" name="id" /> <input type="hidden" name="id" />
				<table width="100%" style="padding-top: 10px;">
					<tr>
						<th align="right"><label>流程编号</label></th>
						<td><input title="流程编号" class="inputbox"
							style="width: 180px;" type="text" name="workFlowNo"
							id="workFlowNo" disabled /></td>
						<th align="right"><label>应用系统</label></th>
						<td><input name="appId" type="hidden"/>
							<input title="应用系统" class="inputbox"
							style="width: 180px;" type="text" name="appName" id="appName"
							disabled /></td>
						<!-- <th align="right"><label>应用系统编码</label></th>
						<td><input title="应用系统编码" class="inputbox"
							style="width: 180px;" type="text" name="appCode" id="appCode"
							disabled /></td> -->
					</tr>
					<tr>
						<th align="right"><label>提交人</label></th>
						<td><input title="{param.field.comment}" class="inputbox"
							style="width: 180px;" type="hidden" name="submitter"
							id="submitter" />
							<input class="inputbox" name="submitterAlias"
								id="submitterAlias" disabled style="width: 179px;"></input>
							</td>
						<th align="right"><label>提交人部门</label></th>
						<td>
							<input title="提交人部门" class="inputbox" disabled style="width: 180px;" 
							type="text" name="submitDeptName" id="submitDeptName" />
						</td>
					</tr>
					<tr>
						<th align="right"><label>提交日期</label></th>
						<td><input title="提交日期" class="easyui-datebox"
							style="width: 180px;" type="text" name="submitDate"
							id="submitDate" disabled /></td>
						<th align="right"><label>用户</label></th>
						<td><input title="{param.field.comment}" class="inputbox"
							style="width: 180px;" type="hidden" name="userId" id="userId" />
							<input class="inputbox" name="userIdAlias"
								id="userIdAlias" disabled style="width: 179px;"></input>
						</td>
					</tr>
					<!-- <tr>
						<th align="right"><label>审批意见</label></th>
						<td><input title="审批意见" class="inputbox"
							style="width: 180px;" type="text" name="auditOpinion"
							id="auditOpinion" disabled /></td>
						<th align="right"><label>审批日期</label></th>
						<td><input title="审批日期" class="easyui-datebox"
							style="width: 180px;" type="text" name="auditDate" id="auditDate"
							disabled /></td>
					</tr>
					<tr>
						<th align="right"><label>审批人</label></th>
						<td><input title="审批人" class="inputbox" style="width: 180px;"
							type="text" name="auditPerson" id="auditPerson" disabled /></td>
						<th align="right"><label>审批状态</label></th>
						<td><input title="审批状态" class="inputbox"
							style="width: 180px;" type="text" name="auditStatus"
							id="auditStatus" disabled /></td>
					</tr> -->
					<tr>
					</tr>
				</table>
			</form>
		</fieldset>
		<div id="toolbarUumsUserAppPermissionsA" class="datagrid-toolbar">
			<table>
				<tr>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_uumsUserAppPermissionsA_button_add"
						permissionDes="通过">
						<td><a class="easyui-linkbutton" iconCls="icon-add"
							plain="true" onclick="auditAllow();"
							href="javascript:void(0);">通过</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_uumsUserAppPermissionsA_button_delete"
						permissionDes="不通过">
						<td><a class="easyui-linkbutton" iconCls="icon-remove"
							plain="true" onclick="auditRefuse();"
							href="javascript:void(0);">不通过</a></td>
					</sec:accesscontrollist>
				</tr>
			</table>
		</div>
		<table id="dgUserAppPermissions"
			data-options="
				fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
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
					<!-- <th data-options="field:'appId', halign:'center'" width="220">应用系统</th> -->
					<th data-options="field:'loginName', halign:'center'" width="220">用户ID</th>
					<th
						data-options="field:'userName', halign:'center'"
						width="220">用户姓名</th>
					<th
						data-options="field:'deptName', halign:'center'"
						width="220">所在部门</th>
					<!-- <th
						data-options="field:'auditFlag', halign:'center',formatter:formateauditFlag"
						width="220">审批状态</th>
					<th
						data-options="field:'synchFlag', halign:'center',formatter:formatesynchFlag"
						width="220">同步状态</th>
					<th
						data-options="field:'synchTime', halign:'center',formatter:formateDate"
						width="220">同步时间</th> -->
					<th
						data-options="field:'operFlag', halign:'center',formatter:formateoperFlag"
						width="220">操作类型</th>
					<!-- <th data-options="field:'synchType', halign:'center'" width="220">同步方式</th>
					<th
						data-options="field:'actFlag', halign:'center',formatter:formateactFlag"
						width="220">活动状态</th> -->
					<th data-options="field:'_d',halign:'center',align:'center',formatter:formatAudit"  width="100">审批</th>
				</tr>
			</thead>
		</table>
		<div id="idea"></div>
	</div>
	<script
		src="avicit/uums/permission/workflow/uumsuserappworkflow/js/UumsUserAppWorkflow.js"
		type="text/javascript"></script>
	<script type="text/javascript">
		var uumsUserAppWorkflowA;
		$(function() {
			uumsUserAppWorkflowA = new UumsUserAppWorkflowA();
			initPermissionDataGrid();
		});
		var permissionDg;
		function initPermissionDataGrid(){
			permissionDg = $("#dgUserAppPermissions").datagrid({
				url: "platform/uums/permission/synch/uumsuserapppermissions/UumsUserAppPermissionsController/operation/getUumsUserAppPermissionssByPage"
			});
		}
		function formateDate(value, row, index) {
			return uumsUserAppWorkflowA.formate(value);
		}
		function formateauditFlag(value) {
			return Platform6.fn.lookup.formatLookupType(value,
					uumsUserAppWorkflowA.auditFlag);
		}
		function formatesynchFlag(value) {
			return Platform6.fn.lookup.formatLookupType(value,
					uumsUserAppWorkflowA.synchFlag);
		}
		function formateoperFlag(value) {
			return Platform6.fn.lookup.formatLookupType(value,
					uumsUserAppWorkflowA.operFlag);
		}
		function formateactFlag(value) {
			return Platform6.fn.lookup.formatLookupType(value,
					uumsUserAppWorkflowA.actFlag);
		}
		//增加单选按钮
		function formatAudit(value,rowData,rowIndex){
			var col = "<input type='radio' name='"+ rowData.id +"' value='1' checked>通过</input>&nbsp;"
			+"<input type='radio' name='"+ rowData.id +"' value='0'>不通过</input>";
			return col;
		}
		//批量通过
		function auditAllow(){
			var rows = permissionDg.datagrid('getChecked');
			if(rows.length == 0){
				alert("请选择数据！");
				return false;
			}
			for(var i=0; i<rows.length; i++){
				$("input[name='"+ rows[i].id +"'][value='1']").attr("checked",true);
			}
			permissionDg.datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
		}
		//批量不通过
		function auditRefuse(){
			var rows = permissionDg.datagrid('getChecked');
			if(rows.length == 0){
				alert("请选择数据！");
				return false;
			}
			for(var i=0; i<rows.length; i++){
				$("input[name='"+ rows[i].id +"'][value='0']").attr("checked",true);
			}
			permissionDg.datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
		}
	</script>
</body>
</html>