<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>导入数据错误信息</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<script type="text/javascript">
/**
 * 初始化数据
 */
$(function(){
	getErrorDate();
});
/**
 * 获取导入数据错误信息
 */
function getErrorDate(){
	
	$.ajax({
        cache: true,
        type: "POST",
        url:'platform/cc/sysCodingExcel/getImportErrorInfoData.json',
        dataType:"json",
        async: false,
        timeout:10000,
        error: function(request) {
        	
        },
        success: function(data) {

			var columnArray = new Array();
			
			for(var i = 0; i < data.columnTitleList.length; i++){
				var columnField = data.columnFieldList[i];
				var columnTitle = data.columnTitleList[i];
				var field = {field: columnField, title: columnTitle, align:'center', width:50};
				columnArray.push(field);
			}
			columnArray.push({field:'errorInfo',title: "错误信息", align:'left', width:120});
			
			$("#datagrid1").datagrid({
				data: data.rows,
				columns:[columnArray]
			});
        }
	});
}
</script>
</head>
<body class="easyui-layout">
<div region="center" border="false">
	<table id="datagrid1" class="easyui-datagrid" 
		data-options="
			fit: true,
			border: false,
			rownumbers: true,
			animate: true,
			collapsible: false,
			fitColumns: true,
			autoRowHeight: false,
			method: 'post',
			singleSelect: false,
			checkOnSelect: true,
			selectOnCheck: true
		">
	</table>
</div>
</body>
</html>
