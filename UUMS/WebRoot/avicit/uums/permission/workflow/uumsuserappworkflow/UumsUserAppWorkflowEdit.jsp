<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "uums/permission/workflow/uumsuserappworkflow/UumsUserAppWorkflowController/operation/Edit/id" -->
<title>修改</title>
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
		style="overflow: auto; padding-bottom: 35px;">
		<form id='form'>
			<input type="hidden" name="id" value='${uumsUserAppWorkflowDTO.id}' />
			<table width="100%" style="padding-top: 10px;">
				<tr>
					<th align="right"><span style="color: red;">*</span> 流程编号:</th>
					<td><input title="流程编号" class="inputbox" readonly="readonly"
						style="width: 180px;" type="text" name="workFlowNo"
						id="workFlowNo" value='${uumsUserAppWorkflowDTO.workFlowNo}' /></td>
					<th align="right"><span style="color: red;">*</span> 应用系统:</th>
					<td>
						<input type="hidden" name="appId" value="${uumsUserAppWorkflowDTO.appId}">
						<input title="应用系统" class="inputbox" readonly="readonly"
						style="width: 180px;" type="text" name="appName" id="appName"
						value='${uumsUserAppWorkflowDTO.appName}' /></td>
				</tr>
				<tr>
					<th align="right"><span style="color: red;">*</span> 提交人:</th>
					<td><input title="{param.field.comment}" class="inputbox" readonly="readonly"
						style="width: 182px;" type="hidden" name="submitter"
						id="submitter" value='${uumsUserAppWorkflowDTO.submitter}' />
						<input class="inputbox" name="submitterAlias"
							id="submitterAlias" readOnly="readOnly"
							value='${uumsUserAppWorkflowDTO.submitterAlias}'
							style="width: 179px;"></input>
					</td>
					<th align="right"><span style="color: red;">*</span> 提交人部门:</th>
					<td>
						<input title="提交人部门" class="inputbox" readonly="readonly"
						style="width: 180px;" type="text" name="submitDeptName" id="submitDeptName"
						value="${uumsUserAppWorkflowDTO.submitDeptName}"/>
					</td>
				</tr>
				<tr>
					<th align="right">选择用户:</th>
					<td colspan="3"><input title="{param.field.comment}" class="inputbox"
						style="width: 180px;" type="hidden" name="userId" id="userId" 
						value="${uumsUserAppWorkflowDTO.userId}"/>
						<div class="">
							<input class="easyui-validatebox" name="userIdAlias"
								id="userIdAlias" readOnly="readOnly" style="width: 483px;"
								value="${uumsUserAppWorkflowDTO.userIdAlias}"></input>
						</div></td>
				</tr>
				<%-- <tr>
					<th align="right"><span style="color: red;">*</span> 提交日期:</th>
					<td><input title="提交日期" class="easyui-datebox "
						data-options="required:true" style="width: 182px;" type="text"
						name="submitDate" id="submitDate"
						value='${uumsUserAppWorkflowDTO.submitDate}' /></td>
					<th align="right">审批状态:</th>
					<td><input title="审批状态" class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[100]'" style="width: 180px;"
						type="text" name="auditStatus" id="auditStatus"
						value='${uumsUserAppWorkflowDTO.auditStatus}' /></td>
				</tr>
				<tr>
					<th align="right">审批意见:</th>
					<td><input title="审批意见" class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[1000]'" style="width: 180px;"
						type="text" name="auditOpinion" id="auditOpinion"
						value='${uumsUserAppWorkflowDTO.auditOpinion}' /></td>
					<th align="right">审批日期:</th>
					<td><input title="审批日期" class="easyui-datebox"
						style="width: 182px;" type="text" name="auditDate" id="auditDate"
						value='${uumsUserAppWorkflowDTO.auditDate}' /></td>
				</tr>
				<tr>
					<th align="right">审批人:</th>
					<td><input title="审批人" class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[32]'" style="width: 180px;"
						type="text" name="auditPerson" id="auditPerson"
						value='${uumsUserAppWorkflowDTO.auditPerson}' /></td>
					<th align="right"><span style="color: red;">*</span> 应用系统编码:</th>
					<td><input title="应用系统编码" class="easyui-validatebox"
						data-options="required:true,validType:'maxLength[32]'"
						style="width: 180px;" type="text" name="pid" id="pid"
						value='' /></td>
				</tr> --%>
				<tr>
				</tr>
			</table>
		</form>
		<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>
					<td width="60%" align="right"><a title="保存" id="saveButton"
						class="easyui-linkbutton" onclick="saveForm();"
						href="javascript:void(0);">保存</a> <a title="返回" id="returnButton"
						class="easyui-linkbutton" onclick="closeForm();"
						href="javascript:void(0);">返回</a></td>
				</tr>
			</table>
		</div>
	</div>
	<script type="text/javascript">
		$.extend($.fn.validatebox.defaults.rules, {
			maxLength : {
				validator : function(value, param) {
					return param[0] >= value.length;

				},
				message : '请输入最多 {0} 字符.'
			}
		});
		$(function() {
			/* if (!"${uumsUserAppWorkflowDTO.submitDate}" == "") {
				$('#submitDate')
						.datebox(
								'setValue',
								parserColumnTime(
										"${uumsUserAppWorkflowDTO.submitDate}")
										.format("yyyy-MM-dd"));
			}
			if (!"${uumsUserAppWorkflowDTO.auditDate}" == "") {
				$('#auditDate').datebox(
						'setValue',
						parserColumnTime("${uumsUserAppWorkflowDTO.auditDate}")
								.format("yyyy-MM-dd"));
			}
			var submitterUserCommonSelector = new CommonSelector("user",
					"userSelectCommonDialog", "submitter", "submitterAlias");
			submitterUserCommonSelector.init(); */
			var userIdUserCommonSelector = new CommonSelector("user",
					"userSelectCommonDialog", "userId", "userIdAlias",null,null,null,false);
			userIdUserCommonSelector.init(null,null,'n');
		});
		function closeForm() {
			parent.uumsUserAppWorkflow.closeDialog("#edit");
		}
		function saveForm() {
			if ($('#form').form('validate') == false) {
				return;
			}
			parent.uumsUserAppWorkflow.save(serializeObject($('#form')),
					"#edit");
		}
	</script>
</body>
</html>