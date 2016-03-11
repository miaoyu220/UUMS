<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>添加</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
</style>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false" style="overflow:hidden;padding-bottom:35px;">
		<form id='form'>
			<!-- <input type="hidden" name="sid" value=""/> -->
				<input type="hidden" id="id" name="id" value="${cbbTempletField.id}">
				<input type="hidden" id="sysApplicationId" name="sysApplicationId" value="${appId}">
				<input type="hidden" id="sysId" name="sysId" value="${appId}">
				<input type="hidden" id="secretLevel" name="secretLevel" value="${secretLevel}">
				<input type="hidden" id="templetId" name="templetId" value="${templetId}">
				<table width="100%" style="padding-top: 10px;">
					<tr>
						<th align="right">字段中文名:</th>
						<td><span style="padding:0px;margin: 0px;">
								<span style="padding:0px;margin: 0px;width: 5px;display: inline-block;">
									<span class="required-icon"></span>
								</span>
							  	<input title="字段中文名" class="inputbox" style="width: 180px;" type="text" name="colLabel" id="colLabel" value="${cbbTempletField.colLabel}"/>
							</span>
						</td>
						<th align="right">字段类型  :</th>
						<td>
							<span style="padding:0px;margin: 0px;width: 5px;display: inline-block;">
								<span class="required-icon"></span>
								</span>
							<select name="colType" class="easyui-combobox" data-options="width:173,editable:false,panelHeight:'auto'" value="${cbbTempletField.colType}">
							<c:forEach items="${colType}" var="colType">
								<option value="${colType.lookupCode}">${colType.lookupName}</option>
							</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th align="right">字段名 :</th>
						<td>
							<span style="padding:0px;margin: 0px;">
								<span style="padding:0px;margin: 0px;width: 5px;display: inline-block;">
									<span class="required-icon"></span>
								</span>
								<input title="字段名" class="inputbox" style="width: 180px;" type="text" name="colName" id="colName" value="${cbbTempletField.colName}"/></span>
						</td>
						<th align="right">是否必填  :</th>
						<td>
							<span style="padding:0px;margin: 0px;width: 5px;display: inline-block;">
								<span class="required-icon"></span>
								</span>
							<select name="colIsMust" class="easyui-combobox" data-options="width:173,editable:false,panelHeight:'auto'" value="${cbbTempletField.colIsMust}">
							<c:forEach items="${yesNoFlag}" var="yesNoFlag">
								<option value="${yesNoFlag.lookupCode}">${yesNoFlag.lookupName}</option>
							</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th align="right">长度:</th>
						<td>
							<span style="padding:0px;margin: 0px;">
								<span style="padding:0px;margin: 0px;width: 5px;display: inline-block;">
									<span class="required-icon"></span>
								</span>
								<input title="长度" class="easyui-numberbox" style="width: 180px;" type="text" name="colLength" id="colLength" value="${cbbTempletField.colLength}"/></span>
						</td>
						<th align="right">是否可见  :</th>
						<td>
							<span style="padding:0px;margin: 0px;width: 5px;display: inline-block;">
								<span class="required-icon"></span>
								</span>
							<select name="colIsVisible" class="easyui-combobox" data-options="width:173,editable:false,panelHeight:'auto'" value="${cbbTempletField.colIsVisible}">
							<c:forEach items="${yesNoFlag}" var="yesNoFlag">
								<option value="${yesNoFlag.lookupCode}">${yesNoFlag.lookupName}</option>
							</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th align="right">小数位数:</th>
						<td>
							<span style="padding:0px;margin: 0px;">
								<span style="padding:0px;margin: 0px;width: 5px;display: inline-block;">
								</span>
								<input title="小数位数" class="easyui-numberbox" style="width: 180px;" type="text" name="colDecimal" id="colDecimal" value="${cbbTempletField.colDecimal}"/></span>
						</td>
						<th align="right">是否是查询字段  :</th>
						<td>
							<span style="padding:0px;margin: 0px;width: 5px;display: inline-block;">
								<span class="required-icon"></span>
								</span>
							<select name="colIsSearch" class="easyui-combobox" data-options="width:173,editable:false,panelHeight:'auto'" value="${cbbTempletField.colIsSearch}>
							<c:forEach items="${yesNoFlag}" var="yesNoFlag">
								<option value="${yesNoFlag.lookupCode}">${yesNoFlag.lookupName}</option>
							</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th align="right">排序:</th>
						<td>
							<span style="padding:0px;margin: 0px;">
								<span style="padding:0px;margin: 0px;width: 5px;display: inline-block;">
									<span class="required-icon"></span>
								</span>
								<input title="排序" class="easyui-numberbox" style="width: 180px;" type="text" name="colOrder" id="colOrder" value="${cbbTempletField.colOrder}"/></span>
						</td>
						<th align="right">是否是系统字段  :</th>
						<td>
							<span style="padding:0px;margin: 0px;width: 5px;display: inline-block;">
								<span class="required-icon"></span>
								</span>
							<select name="colIsSys" class="easyui-combobox" data-options="width:173,editable:false,panelHeight:'auto'" value="${cbbTempletField.colIsSys}">
							<c:forEach items="${yesNoFlag}" var="yesNoFlag">
								<option value="${yesNoFlag.lookupCode}">${yesNoFlag.lookupName}</option>
							</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th align="right">编辑标识  :</th>
						<td>
						<span style="padding:0px;margin: 0px;width: 5px;display: inline-block;">
									<span class="required-icon"></span>
								</span>
						<select name="colIsEdit" class="easyui-combobox" data-options="width:180,editable:false,panelHeight:'auto'" value="${cbbTempletField.colIsEdit}">
							<c:forEach items="${yesNoFlag}" var="yesNoFlag">
								<option value="${yesNoFlag.lookupCode}">${yesNoFlag.lookupName}</option>
							</c:forEach>
							</select>
						</td>
						<th align="right">是否列表显示  :</th>
						<td>
							<span style="padding:0px;margin: 0px;width: 5px;display: inline-block;">
								<span class="required-icon"></span>
								</span>
							<select name="colIsTabVisible" class="easyui-combobox" data-options="width:173,editable:false,panelHeight:'auto'" value="${cbbTempletField.colIsTabVisible}">
							<c:forEach items="${yesNoFlag}" var="yesNoFlag">
								<option value="${yesNoFlag.lookupCode}">${yesNoFlag.lookupName}</option>
							</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th align="right">是否详细显示:</th>
						<td>
						<span style="padding:0px;margin: 0px;width: 5px;display: inline-block;">
									<span class="required-icon"></span>
								</span>
						<select name="colIsDetail" class="easyui-combobox" data-options="width:180,editable:false,panelHeight:'auto'" value="${cbbTempletField.colIsDetail}">
							<c:forEach items="${yesNoFlag}" var="yesNoFlag">
								<option value="${yesNoFlag.lookupCode}">${yesNoFlag.lookupName}</option>
							</c:forEach>
							</select>
						</td>
						<th align="right">下拉类型:</th>
						<td>
							<span style="padding:0px;margin: 0px;width: 5px;display: inline-block;">
								</span>
							<select name="colDropdownType" class="easyui-combobox" data-options="width:173,editable:false,panelHeight:'auto'" value="${cbbTempletField.colDropdownType}">
								<option value="0">无</option>
								<option value="1">只选</option>
								<option value="2">参选</option>
							</select>
						</td>
					</tr>
					<tr>
						<th align="right">生成方式:</th>
						<td>
						<span style="padding:0px;margin: 0px;width: 5px;display: inline-block;">
									<span class="required-icon"></span>
								</span>
						<select name="colGeneMethod" class="easyui-combobox" data-options="width:180,editable:false,panelHeight:'auto'" value="${cbbTempletField.colGeneMethod}">
							<c:forEach items="${colGeneMethod}" var="colGeneMethod">
								<option value="${colGeneMethod.lookupCode}">${colGeneMethod.lookupName}</option>
							</c:forEach>
							</select>
						</td>
						<th align="right">生成方式规则值 :</th>
						<td>
							<span style="padding:0px;margin: 0px;">
								<span style="padding:0px;margin: 0px;width: 5px;display: inline-block;">
								</span>
								<input title="生成方式规则值" class="inputbox" style="width: 173px;" type="text" name="colGeneMethodRule" id="colGeneMethodRule" value="${cbbTempletField.colGeneMethodRule}"/></span>
						</td>
						
					</tr>
					<tr>
						<th align="right">生成规则英文 :</th>
						<td>
							<span style="padding:0px;margin: 0px;">
								<span style="padding:0px;margin: 0px;width: 5px;display: inline-block;">
								</span>
								<input title="生成规则英文" class="inputbox" style="width: 180px;" type="text" name="colRuleName" id="colRuleName" value="${cbbTempletField.colRuleName}"/></span>
						</td>
						<th align="right">生成规则中文 :</th>
						<td>
							<span style="padding:0px;margin: 0px;">
								<span style="padding:0px;margin: 0px;width: 5px;display: inline-block;">
								</span>
								<input title="生成规则中文" class="inputbox" style="width: 173px;" type="text" name="colRuleTitle" id="colRuleTitle" value="${cbbTempletField.colRuleTitle}"/></span>
						</td>
					</tr>
					<tr>
						<th align="right">路径 :</th>
						<td>
							<span style="padding:0px;margin: 0px;">
								<span style="padding:0px;margin: 0px;width: 5px;display: inline-block;">
								</span>
								<input title="路径" class="inputbox" style="width: 180px;" type="text" name="customPath" id="customPath" value="${cbbTempletField.customPath}"/></span>
						</td>
						<th align="right">显示格式:</th>
						<td>
							<span style="padding:0px;margin: 0px;width: 5px;display: inline-block;">
								</span>
							<select name="colShowFormat" class="easyui-combobox" data-options="width:173,editable:false,panelHeight:'auto'" value="${cbbTempletField.colShowFormat}">
								<option value="0">无</option>
								<option value="1">日期</option>
								<option value="2">金额</option>
							</select>
						</td>
					</tr>
					<tr>
						<th align="right">说明:</th>
						<td colspan="4"><div style="padding-left: 10px;"><input title="描述" class="inputbox" style="width: 92%;" type="text" name="remark" id="remark" value="${cbbTempletField.remark}"/></div></td>
					</tr>
				</table>
		</form>
		<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>	
					<td align="right" width="60%">
					  	<a title="保存" id="saveButton"  class="easyui-linkbutton" plain="false" onclick="saveForm();" href="javascript:void(0);">保存</a>
						<a title="返回" id="returnButton"  class="easyui-linkbutton"  plain="false" onclick="closeForm();" href="javascript:void(0);">返回</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<script type="text/javascript">
	
	function closeForm(){
		parent.templetField.closeDialog("#edit");
	}
	function saveForm(){
		parent.templetField.save(serializeObject($('#form')),"#edit");
	}
	</script>
</body>
</html>