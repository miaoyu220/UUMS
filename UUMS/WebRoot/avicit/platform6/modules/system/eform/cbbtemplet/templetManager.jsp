<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@page import="avicit.platform6.api.session.SessionHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>

<html>
	<head>
	<%
		String appId = SessionHelper.getApplicationId();
	%>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>模版管理</title>
		<base href="<%=ViewUtil.getRequestPath(request) %>">
		<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
		<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
		<script src="avicit/platform6/modules/system/eform/cbbtemplet/js/templetTree.js" type="text/javascript"></script>
		<script src="avicit/platform6/modules/system/eform/cbbtemplet/js/templetField.js" type="text/javascript"></script>
		<script type="text/javascript">
			var tree;
			var appId = "<%=appId%>";
			var templetField;
			$(function(){
				tree = new CbbTempletTree('templetTree','searchTempletTree','contextMenu');
				tree.setOnLoadSuccess(function(){
					//alert("${url}");
					templetField = new TempletField('fieldList','${url}','searchDialog','form1');
					templetField.setOnLoadSuccess(function(){
					});
					templetField.setOnSelectRow(function(rowIndex, rowData,id){
						if (rowData.colRuleName == "user"){
							$('#attrTable').datagrid({
								data: [
									{type:'用户选择'}
								]
							});
						}else if (rowData.colRuleName == "dept"){
							$('#attrTable').datagrid({
								data: [
									{type:'部门选择'}
								]
							});
						}else if (rowData.isLookup == true){
							$('#attrTable').datagrid({
								data: [
									{type:'通用代码'}
								]
							});

						}else{
							$('#attrTable').datagrid({
								data: [
									{type:'无'}
								]
							});
						}
						$('#attrTable').datagrid('selectRow',0);

						var url = "platform/cbbTemplet/"+id+"/"+appId+"/searchCodeByPage.json";
						$("#codeList").datagrid({url:url});

					});
					
				});
				tree.setOnSelect(function(_tree,node){
					templetField.loadByTreeId(node.id,appId);
				});
				tree.init(appId);
			});
			function closeImportData(){
				$("#importData").dialog('close');
			}
		</script>
		
	</head>
	
	<body class="easyui-layout" fit="true">
		<div data-options="region:'west',title:'模版树',split:true,iconCls:'icon-auth'" style="width:200px;background:#f5fafe;overflow-y:hidden;">
			<%@ include file ="templetTree.jsp"%>
		</div>
		<div data-options="region:'center',title:'基础字段表',iconCls:'icon-search'" style="background:#ffffff;">
			<%@ include file ="templetField.jsp"%>
		</div>
		<div data-options="region:'east',title:' 通用代码',split:true,iconCls:'icon-edit'" style="width:400px;background:#f5fafe;">
			<%@ include file ="templetCode.jsp"%>
		</div>
	</body>
	
</html>