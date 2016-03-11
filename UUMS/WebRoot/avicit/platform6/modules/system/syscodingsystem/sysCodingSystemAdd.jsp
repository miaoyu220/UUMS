<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加编码体系</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
</head>
<body class="easyui-layout">
<div region="center" border="false">
   <form id="formCodingSystem" fit="true">
		<input id="parentId" name="parentId" type="hidden" value="${param.id}"/>
		<table class="table"  width="100%" height="80px" border=0 align="center">
			<tr>
				<th nowrap><span style="color:red">*</span>名称: </th>
				<td><input id="systemName" name="systemName" class="easyui-validatebox" data-options="validType:'length[0,100]'" style="width: 260px;"/></td>
			</tr>
			<tr>
				<td width="50px" align="center">描述: </td>
				<td><textarea id="systemRemark" name="systemRemark" style="width: 260px;height: 60px"  rows="" cols="" ></textarea></td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>
