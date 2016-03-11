<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "uums/appsys/register/uumsappsys/UumsAppSysController/operation/Edit/id" -->
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
			<input type="hidden" name="id" value='${uumsAppSysDTO.id}' />
			<table width="100%" style="padding-top: 10px;">
				<tr>
					<th align="right"><span style="color: red;">*</span> 应用系统编码:</th>
					<td><input title="应用系统编码" class="easyui-validatebox"
						data-options="required:true,validType:'maxLength[50]'"
						style="width: 180px;" type="text" name="appCode" id="appCode"
						value='${uumsAppSysDTO.appCode}' /></td>
					<th align="right"><span style="color: red;">*</span> 应用系统名称:</th>
					<td><input title="应用系统名称" class="easyui-validatebox"
						data-options="required:true,validType:'maxLength[200]'"
						style="width: 180px;" type="text" name="appName" id="appName"
						value='${uumsAppSysDTO.appName}' /></td>
				</tr>
				<tr>
					<th align="right"><span style="color: red;">*</span> 安全管理员:</th>
					<td><input title="{param.field.comment}" class="inputbox"
						style="width: 182px;" type="hidden" name="securitAdmin"
						id="securitAdmin" value='${uumsAppSysDTO.securitAdmin}' />
						<div class="">
							<input class="easyui-validatebox" name="securitAdminAlias"
								id="securitAdminAlias" readOnly="readOnly"
								value='<c:out  value='${uumsAppSysDTO.securitAdminAlias}'/>'
								style="width: 179px;"></input>
						</div></td>
					<th align="right">排序:</th>
					<td><input title="排序"
						class="easyui-numberbox easyui-validatebox"
						data-options="validType:'maxLength[22]'" style="width: 180px;"
						type="text" name="orderBy" id="orderBy"
						value='${uumsAppSysDTO.orderBy}' /></td>
				</tr>
				<tr>
					<th align="right"><span style="color: red;">*</span> 权威数据源:</th>
					<td>
						<select name="isDataSource" id="isDataSource" class="easyui-combobox" 
							data-options="width:180,editable:false,panelHeight:'auto',
							valueField:'id',textField:'typeName',onSelect: function(rec){    
						            changeShowHr(rec.id);
						        }">
							<option value="Y">是</option>
							<option value="N" >否</option>
						</select>
					</td>
					<th align="right"><span style="color: red;">*</span> 自动生成账号:</th>
					<td>
						<select name="isAutoCreateAccount" id="isAutoCreateAccount" class="easyui-combobox" 
							data-options="width:180,editable:false,panelHeight:'auto',
							valueField:'id',textField:'typeName',onSelect: function(rec){    
						            changeShow(rec.id);
						        }">
					        <option value="Y">是</option>
							<option value="N" >否</option>
						</select>
					</td>
				</tr>
				<tr>
					<th align="right"><span style="color: red;">*</span> 新增是否审批:</th>
					<td>
						<select name="addAuditFlag" id="addAuditFlag" class="easyui-combobox" 
							data-options="width:180,editable:false,panelHeight:'auto'">
							<option value="Y">是</option>
							<option value="N" >否</option>
						</select>
					</td>
					<th align="right"><span style="color: red;">*</span> 修改是否审批:</th>
					<td>
						<select name="editAuditFlag" id="editAuditFlag" class="easyui-combobox" 
							data-options="width:180,editable:false,panelHeight:'auto'">
							<option value="Y">是</option>
							<option value="N" >否</option>
						</select>
					</td>
				</tr>
				<tr>
					<th align="right"><span style="color: red;">*</span> 删除是否审批:</th>
					<td>
						<select name="delAuditFlag" id="delAuditFlag" class="easyui-combobox" 
							data-options="width:180,editable:false,panelHeight:'auto'">
							<option value="Y">是</option>
							<option value="N" >否</option>
						</select>
					</td>
					<%-- <th align="right">同步方式:</th>
					<td><pt6:syslookup name="synchType"
							lookupCode="UUMS_SYNCH_TYPE"
							defaultValue='${uumsAppSysDTO.synchType}'
							dataOptions="width:180,editable:false,panelHeight:'auto'">
						</pt6:syslookup></td> --%>
				</tr>
				<tr>
					<th align="right">应用系统简介:</th>
					<td colspan="3"><textarea title="应用系统简介" class="inputbox easyui-validatebox scrollbar"
						data-options="validType:'maxLength[3000]'" style="height:50px;width: 479px;"
						type="text" name="appDescribe" id="appDescribe"
						value='${uumsAppSysDTO.appDescribe}' ></textarea></td>
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
			if (!"${uumsAppSysDTO.createTime}" == "") {
				$('#createTime').datebox(
						'setValue',
						parserColumnTime("${uumsAppSysDTO.createTime}").format(
								"yyyy-MM-dd"));
			}
			if (!"${uumsAppSysDTO.updateTime}" == "") {
				$('#updateTime').datebox(
						'setValue',
						parserColumnTime("${uumsAppSysDTO.updateTime}").format(
								"yyyy-MM-dd"));
			}
			var securitAdminUserCommonSelector = new CommonSelector("user",
					"userSelectCommonDialog", "securitAdmin",
					"securitAdminAlias");
			securitAdminUserCommonSelector.init();
			
			//初始化下拉框的值
			var isDataSource = '${uumsAppSysDTO.isDataSource}';
			if(isDataSource == 'Y'){//如果是权威数据源，则其他选项的为否，且不可选择
				changeShowHr(isDataSource);
			}else{//如果非权威数据源，则正常显示
				$("#isDataSource").combobox('select', '${uumsAppSysDTO.isDataSource}');
				$("#isAutoCreateAccount").combobox('select', '${uumsAppSysDTO.isAutoCreateAccount}');
				$("#addAuditFlag").combobox('select', '${uumsAppSysDTO.addAuditFlag}');
				$("#editAuditFlag").combobox('select', '${uumsAppSysDTO.editAuditFlag}');
				$("#delAuditFlag").combobox('select', '${uumsAppSysDTO.delAuditFlag}');
			}
			
		});
		function closeForm() {
			parent.uumsAppSys.closeDialog("#edit");
		}
		function saveForm() {
			if ($('#form').form('validate') == false) {
				return;
			}
			parent.uumsAppSys.save(serializeObject($('#form')), "#edit");
		}
		//如果是权威数据源，则其他选项全为否且不可选择
		function changeShowHr(val){
			if(val == 'Y'){
				$("#isAutoCreateAccount").combobox('setValue', 'N');
				$("#isAutoCreateAccount").combobox('readonly', true);
				$("#addAuditFlag").combobox('setValue', 'N');
				$("#addAuditFlag").combobox('readonly', true);
				$("#editAuditFlag").combobox('setValue', 'N');
				$("#editAuditFlag").combobox('readonly', true);
				$("#delAuditFlag").combobox('setValue', 'N');
				$("#delAuditFlag").combobox('readonly', true);
			}else{
				$("#isAutoCreateAccount").combobox('readonly', false);
				$("#addAuditFlag").combobox('readonly', false);
				$("#editAuditFlag").combobox('readonly', false);
				$("#delAuditFlag").combobox('readonly', false);
			}
		}
		// 如果自动创建账号为：是，则新增是否需要审批为：否，且不可更改
		function changeShow(val){
			if(val == 'Y'){
				$("#addAuditFlag").combobox('setValue', 'N');
				$("#addAuditFlag").combobox('readonly', true);
			}else{
				$("#addAuditFlag").combobox('readonly', false);
			}
			
		}
	</script>
</body>
</html>