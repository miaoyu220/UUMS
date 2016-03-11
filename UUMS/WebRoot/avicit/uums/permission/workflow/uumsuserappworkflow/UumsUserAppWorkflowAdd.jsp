<%@page import="avicit.platform6.api.session.SessionHelper"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "uums/permission/workflow/uumsuserappworkflow/UumsUserAppWorkflowController/operation/Add/null" -->
<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/BpmJsInclude.jsp"></jsp:include>
<jsp:include
	page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js"
	type="text/javascript"></script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false"
		style="overflow: auto; padding-bottom: 35px;">
		<form id='form'>
			<input type="hidden" name="id" /> <input type="hidden"
				name="operType" value="${operType}" />
			<table width="100%" style="padding-top: 10px;">
				<tr>
					<th align="right"><span style="color: red;">*</span> 流程编号:</th>
					<td><input title="流程编号" class="inputbox" readonly="readonly"
						data-options="required:true,validType:'maxLength[100]'"
						style="width: 180px;" type="text" name="workFlowNo"
						id="workFlowNo" value="${workFlowNo }" /></td>
					<th align="right"><span style="color: red;">*</span> 应用系统:</th>
					<td><input type="hidden" name="appId" value="${app.id}">
						<input title="应用系统" class="inputbox"
						data-options="required:true,validType:'maxLength[32]'"
						style="width: 180px;" type="text" name="appName" id="appName"
						value="${app.appName}" readonly="readonly" /></td>
				</tr>
				<tr>
					<th align="right"><span style="color: red;">*</span> 提交人:</th>
					<td><input name="submitter" type="hidden"
						value="<%=SessionHelper.getSecurityUser(request).getUser().getId()%>" />
						<input title="提交人" class="inputbox" style="width: 180px;"
						name="submitterAlias" readonly="readonly" id="submitterAlias"
						value="<%=SessionHelper.getSecurityUser(request).getUser().getName()%>" />
					</td>
					<th align="right"><span style="color: red;">*</span> 提交人部门:</th>
					<td><input type="hidden" name="submitDeptId"
						value="<%=SessionHelper.getSecurityUser(request).getUser().getDeptId()%>">
						<input title="提交人部门" class="inputbox"
						data-options="required:true,validType:'maxLength[32]'"
						readonly="readonly" style="width: 180px;" type="text"
						name="submitDeptName" id="submitDeptName"
						value="<%=SessionHelper.getSecurityUser(request).getUser().getDeptName()%>" />
					</td>
				</tr>
				<tr>
					<th align="right"><span style="color: red;">*</span> 选择用户:</th>
					<td colspan="3"><input title="{param.field.comment}"
						class="inputbox" style="width: 180px;" type="hidden" name="userId"
						id="userId" />
						<div class="">
							<input class="easyui-validatebox" name="userIdAlias"
								data-options="required:true,validType:'maxLength[1500]'"
								id="userIdAlias" readOnly="readOnly" style="width: 483px;"></input>
						</div></td>
				</tr>
				<tr>
				</tr>
			</table>
		</form>
		<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>
					<td width="60%" align="right">
					<c:choose>
						<c:when test="${operType eq 'addP'}">
							<c:if test="${app.addAuditFlag eq 'Y'}">
								<a title="保存" id="saveButton"
									class="easyui-linkbutton" onclick="saveForm();"
									href="javascript:void(0);">保存并启动流程</a>
							</c:if>
							<c:if test="${app.addAuditFlag eq 'N'}">
								<a title="保存" id="saveButton"
									class="easyui-linkbutton" onclick="saveFormNoStartFlow();"
									href="javascript:void(0);">保存</a>
							</c:if>
						</c:when>
						<c:when test="${operType eq 'delP'}">
							<c:if test="${app.delAuditFlag eq 'Y'}">
								<a title="保存" id="saveButton"
									class="easyui-linkbutton" onclick="saveForm();"
									href="javascript:void(0);">保存并启动流程</a>
							</c:if>
							<c:if test="${app.delAuditFlag eq 'N'}">
								<a title="保存" id="saveButton"
									class="easyui-linkbutton" onclick="saveFormNoStartFlow();"
									href="javascript:void(0);">保存</a>
							</c:if>
						</c:when>
						<c:otherwise>
							<c:if test="${app.editAuditFlag eq 'Y'}">
								<a title="保存" id="saveButton"
									class="easyui-linkbutton" onclick="saveForm();"
									href="javascript:void(0);">保存并启动流程</a>
							</c:if>
							<c:if test="${app.editAuditFlag eq 'N'}">
								<a title="保存" id="saveButton"
									class="easyui-linkbutton" onclick="saveFormNoStartFlow();"
									href="javascript:void(0);">保存</a>
							</c:if>
						</c:otherwise>
					</c:choose>
					 <a title="返回"
						id="returnButton" class="easyui-linkbutton" onclick="closeForm();"
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
			/* var submitterUserCommonSelector = new CommonSelector("user",
					"userSelectCommonDialog", "submitter", "submitterAlias");
			submitterUserCommonSelector.init(); */
			var userIdUserCommonSelector = new CommonSelector("user",
					"userSelectCommonDialog", "userId", "userIdAlias", null,
					null, null, false);
			userIdUserCommonSelector.init(null,null,'n');
		});
		function closeForm() {
			parent.uumsUserAppWorkflow.closeDialog("#insert");
		}
		//保存并启动流程
		function saveForm() {
			if ($('#form').form('validate') == false) {
				return;
			}
			parent.uumsUserAppWorkflow.saveFormAndStartFlow(
					serializeObject($('#form')), "#insert");
		}
		//保存不启动流程
		function saveFormNoStartFlow(){
			if ($('#form').form('validate') == false) {
				return;
			}
			parent.uumsUserAppWorkflow.save(
					serializeObject($('#form')), "#insert");
		}
	</script>
</body>
</html>