<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>编辑编码体系</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<script type="text/javascript">
$(function(){
	getCodingSystem('${param.id}');
});

/**
 * 装载标准的值
 */
function getCodingSystem(id){
	$.ajax({
		url : 'platform/sysCodingSystemController/getCodingSystem',
		data : {id :id},
		type : 'post',
		dataType : 'json',
		async: false,
		success : function(result) {
			if(result && result.codingSystem){
				$('#systemName').val(result.codingSystem.systemName);
				$('#systemRemark').val(result.codingSystem.systemRemark);
			}
		}
	});
}
</script>
</head>
<body class="easyui-layout">
<div region="center" border="false">
   <form id="formCodingSystem">
		<input id="id" name="id" type="hidden" value="${param.id}"/>
		<table  width="100%" height="80px" border=0 align="center">
			<tr>
				<td width="50px" align="center">名称: </td>
				<td><input id="systemName" name="systemName" class="easyui-validatebox" data-options="validType:'length[0,100]'" style="width: 240px" value=""/></td>
			</tr>
			<tr>
				<td width="50px" align="center">描述: </td>
				<td><textarea id="systemRemark" name="systemRemark" style="width: 240px;height: 50px"  rows="" cols="" ></textarea></td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>
