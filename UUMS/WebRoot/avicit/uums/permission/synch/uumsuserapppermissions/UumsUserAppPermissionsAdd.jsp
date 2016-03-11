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
<!-- ControllerPath = "uums/permission/synch/uumsuserapppermissions/UumsUserAppPermissionsController/operation/Add/null" -->
<title>添加</title>
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
			<input type="hidden" name="id" />
			<table width="100%" style="padding-top: 10px;">
				<tr>
					<input type="hidden" name="appId" value="${uumsUserAppPermissionsDTO.appId }"/>
					<th align="right"><span style="color: red;">*</span> 应用系统:</th>
					<td><input title="应用系统ID" class="easyui-validatebox" readonly="readonly"
						data-options="required:true,validType:'maxLength[50]'"
						style="width: 180px;" type="text" name="appName" id="appName" 
						value="${uumsUserAppPermissionsDTO.appName }"/></td>

					<th align="right"><span style="color: red;">*</span> 选择用户:</th>
					<td ><input title="{param.field.comment}"
						class="inputbox" style="width: 180px;" type="hidden" name="userId"
						id="userId" />
						<div class="">
							<input class="easyui-validatebox" name="userName"
								data-options="required:true,validType:'maxLength[1500]'"
								id="userName" readOnly="readOnly" style="width: 180px;"></input>
						</div></td>
				</tr>
				<tr>
					<th align="right"><span style="color: red;">*</span> 审批状态:</th>
					<td><pt6:syslookup name="auditFlag"
							lookupCode="UUMS_AUDIT_FLAG"
							dataOptions="width:180,editable:false,panelHeight:'auto'">
						</pt6:syslookup></td>

					<th align="right"><span style="color: red;">*</span> 同步状态:</th>
					<td><pt6:syslookup name="synchFlag"
							lookupCode="UUMS_SYNCH_FLAG"
							dataOptions="width:180,editable:false,panelHeight:'auto'">
						</pt6:syslookup></td>
				</tr>
				<tr>

					<th align="right"><span style="color: red;">*</span> 同步时间:</th>
					<td><input title="同步时间" class="easyui-datebox "
						editable="false" data-options="required:true"
						style="width: 182px;" type="text" name="synchTime" id="synchTime" />
					</td>

					<th align="right"><span style="color: red;">*</span> 操作状态:</th>
					<td><pt6:syslookup name="operFlag" lookupCode="UUMS_OPER_FLAG"
							dataOptions="width:180,editable:false,panelHeight:'auto'">
						</pt6:syslookup></td>
				</tr>
				<tr>

					<th align="right">同步方式:</th>
					<td><input title="同步方式" class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[1]'" style="width: 180px;"
						type="text" name="synchType" id="synchType" /></td>

					<th align="right"><span style="color: red;">*</span> 活动状态:</th>
					<td><pt6:syslookup name="actFlag" lookupCode="UUMS_ACT_FLAG"
							dataOptions="width:180,editable:false,panelHeight:'auto'">
						</pt6:syslookup></td>
				</tr>
				<tr>
				</tr>
			</table>
		</form>
		<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>
					<td width="50%" align="right"><a title="保存" id="saveButton"
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
			/* var userCommonSelector = new CommonSelector("user","userSelectCommonDialog","userName","userNameName");
			userCommonSelector.init();  */
			//选择部门
			/* var deptCommonSelector = new CommonSelector("dept","deptSelectCommonDialog","userName","userNameName");
			deptCommonSelector.init();  */
			//选择角色
			/* var roleCommonSelector = new CommonSelector("role","roleSelectCommonDialog","userName","userNameName",null,null,null);
			roleCommonSelector.init();  */
			/*  //选择群组
			 var groupCommonSelector = new CommonSelector("group","groupSelectCommonDialog","userName","userNameName",null,null,null);
			 groupCommonSelector.init(); 
			 //选择岗位
			 var positionCommonSelector = new CommonSelector("position","positionSelectCommonDialog","userName","userNameName");
			 positionCommonSelector.init();  */
			var userIdUserCommonSelector = new CommonSelector("user",
					"userSelectCommonDialog", "userId", "userName");
			userIdUserCommonSelector.init();
		});
		function closeForm() {
			parent.uumsUserAppPermissions.closeDialog("#insert");
		}
		function saveForm() {
			if ($('#form').form('validate') == false) {
				return;
			}
			parent.uumsUserAppPermissions.save(serializeObject($('#form')),
					"#insert", '${uumsUserAppPermissionsDTO.appId }');
		}
	</script>
</body>
</html>