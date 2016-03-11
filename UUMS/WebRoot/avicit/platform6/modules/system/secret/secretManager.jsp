<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>人员密级与文档密级关系管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
</head>
<script type="text/javascript">
	$(function() {
		$('#userList').datagrid({
			fit : true,
			url : 'platform/syssecret/getUserSecretList.json',
			idField : 'lookupCode',
			singleSelect : true,
			nowrap : false,
			striped : true,
			autoRowHeight : false,
			checkOnSelect : true,
			remoteSort : false,
			fitColumns : true,
			columns : [ [
			{
				field : 'lookupCode',
				title : '人员密级数值',
				width : 75,
				align : 'left',
				fit : true
			}, {
				field : 'lookupName',
				title : '人员密级',
				width : 60,
				align : 'left',
				fit : true
			} ] ],
			onClickRow : function(rowIndex, rowData) {
				$("#wordList").datagrid("options").url = "platform/syssecret/getWordSecretList.json?userSecret=" + rowData.lookupCode;
				$("#wordList").datagrid("load");
				window.SECRET_ID = rowData.lookupCode;
			}
		});

		$('#wordList').datagrid({
			fit : true,
			url : 'platform/syssecret/getWordSecretList.json',
			idField : 'lookupCode',
			singleSelect : true,
			nowrap : false,
			striped : true,
			autoRowHeight : false,
			checkOnSelect : true,
			remoteSort : false,
			fitColumns : true,
			columns : [ [
			{
				field : 'lookupCode',
				title : '文档密级数值',
				width : 75,
				align : 'left',
				fit : true
			}, {
				field : 'lookupName',
				title : '文档密级',
				width : 60,
				align : 'left',
				fit : true
			}, {
				field : 'remark',
				title : '访问权限',
				formatter : remarkformat,
				width : 40
			} ] ]
		});

		// 权限formatter
		function remarkformat(value, rowData, rowIndex) {
			if ("1" == value){
				return "<img src='static/images/platform/sysmenuaccesscontrol/ok.png' title='允许访问' onclick='window.changeSingleAuth(this);' alt="
				+ rowData.lookupCode + ">";
			}else{
				return "<img src='static/images/platform/sysmenuaccesscontrol/no.gif' title='禁止访问' onclick='window.changeSingleAuth(this);' alt="
				+ rowData.lookupCode + ">";
			}
		}
		
		window.changeSingleAuth = function(element) {
			var wordSecret = element.alt;
			if(!wordSecret)
				return;
			if(!window.SECRET_ID) {
				return;
			}
			$.ajax({
				url: "platform/syssecret/saveSingleSetAuth.json",
				type: "POST",
				dataType: "json",
				data: {
					userSecret: window.SECRET_ID,
					wordSecret: wordSecret
				},
				success: function(result) {
					if(!result || "success" != result.flag ){
						alert("操作失败");
						return;  // 操作失败
					}
					$("#wordList").datagrid("options").url = "platform/syssecret/getWordSecretList.json?userSecret=" + window.SECRET_ID;
					$("#wordList").datagrid("load");
				}
			});	
			
		};
	});
</script>
<body class="easyui-layout" fit="true">
	<div data-options="region:'west',title:' 人员密级',split:true" style="width:400px;">
		<table id="userList"></table>
	</div>
	<div data-options="region:'center',title:'文档密级'">
		<table id="wordList"></table>
	</div>
</body>
</html>