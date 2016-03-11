<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加通用码段</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<script type="text/javascript">

</script>
</head>
<body class="easyui-layout">
<div region="center" border="false">
	<form id="formComSegment" method="post" action="" style="margin-top: 15px;">
		<table id="tableComSegment" border="0">
			<tr height="30px">
				<td width="70px" align="right">码段名称</td>
				<td width="210px"><input id="segmentName" name="segmentName" class="easyui-validatebox" required="true" data-options="validType:'length[0,100]'" style="width: 200px" /></td>
				<td width="60px" align="right">码段长度</td>
				<td width="110px"><input id="segmentLength" name="segmentLength" class="easyui-numberbox"  data-options="min:1,max:100" style="width: 100px"/></td>
			</tr>
			<tr height="45px">
				<td align="right">说明</td>
				<td colspan="4">
					<textarea class="easyui-validatebox" id="segmentRemark" name="segmentRemark" style="height:45px;width:380px;"></textarea>
				</td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>
