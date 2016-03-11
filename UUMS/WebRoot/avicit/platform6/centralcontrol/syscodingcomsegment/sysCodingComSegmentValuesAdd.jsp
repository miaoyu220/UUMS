<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加通用码段码值</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<script type="text/javascript">

</script>
</head>
<body class="easyui-layout">
<div region="center" border="false">
	<form id="formSegmentValue" method="post" action="" style="margin-top: 15px;">
		<input id="segmentId" name="segmentId" type="hidden" value="${segment.id}"/>
		<table id="tableComSegment" border="0">
			<tr height="30px">
				<td width="90px" align="right">码名称</td>
				<td width="210px"><input id="segmentName" name="segmentName" class="easyui-validatebox" required="true" data-options="validType:'length[0,100]'" style="width: 180px" /></td>
			</tr>
			<tr height="30px">
				<td align="right">码值</td>
				<td>
					<c:choose>
						<c:when test="${segment.segmentLength gt 0}">
							<input id="segmentValue" name="segmentValue" class="easyui-validatebox" required="true" style="width: 180px;" data-options="invalidMessage:'码段长度必须为${segment.segmentLength }',validType:'length[${segment.segmentLength },${segment.segmentLength }]'" />
						</c:when>
						<c:otherwise>
							<input id="segmentValue" name="segmentValue" class="easyui-validatebox" required="true" style="width: 180px;" data-options="invalidMessage:'码段长度不能大于50',validType:'length[1,50]'"/>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>
