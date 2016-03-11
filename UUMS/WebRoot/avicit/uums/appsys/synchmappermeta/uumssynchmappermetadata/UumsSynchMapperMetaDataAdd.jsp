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
<!-- ControllerPath = "uums/appsys/synchmappermeta/uumssynchmappermetadata/UumsSynchMapperMetaDataController/operation/Add/null" -->
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
					<th align="right"><span style="color: red;">*</span> 主体类型:</th>
					<td>
						<select title="主体类型" name="mainType" id="mainType" class="easyui-combobox" 
							data-options="width:180,editable:false,panelHeight:'auto'">
							<option value="UUMS_ORG">组织信息</option>
							<option value="UUMS_USER">用户信息</option>
						</select>
					</td>
					<th align="right"><span style="color: red;">*</span> 字段名称:</th>
					<td><input title="字段名称" class="inputbox easyui-validatebox"
						data-options="required:true,validType:'maxLength[1000]'"
						style="width: 180px;" type="text" name="columnName"
						id="columnName" /></td>
				</tr>
				<tr>
					<th align="right"><span style="color: red;">*</span> UUMS字段:</th>
					<td><input title="UUMS字段"
						class="inputbox easyui-validatebox"
						data-options="required:true,validType:'maxLength[22]'" style="width: 180px;"
						type="text" name="uumsAttribute" id="uumsAttribute" /></td>
					<th align="right">字段CODE:</th>
					<td><input title="字段CODE" class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[100]'"
						style="width: 180px;" type="text" name="columnCode"
						id="columnCode" /></td>
				</tr>
				<tr>
					<th align="right">字段数据类型:</th>
					<td><input title="字段数据类型" class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[100]'"
						style="width: 180px;" type="text" name="dataType" id="dataType" />
					</td>
					<th align="right">排序:</th>
					<td><input title="排序"
						class="inputbox easyui-numberbox easyui-validatebox"
						data-options="validType:'maxLength[22]'" style="width: 180px;"
						type="text" name="orderBy" id="orderBy" /></td>
				</tr>
				<tr>
					<th align="right">注释:</th>
					<td><input title="注释" class="inputbox easyui-validatebox"
						data-options="validType:'maxLength[3000]'" style="width: 180px;"
						type="text" name="comments" id="comments" /></td>
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
		});
		function closeForm() {
			parent.uumsSynchMapperMetaData.closeDialog("#insert");
		}
		function saveForm() {
			if ($('#form').form('validate') == false) {
				return;
			}
			parent.uumsSynchMapperMetaData.save(serializeObject($('#form')),
					"#insert");
		}
	</script>
</body>
</html>