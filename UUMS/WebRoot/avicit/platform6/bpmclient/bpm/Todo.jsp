<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>我的待办事物</title>
<%
	String userId = (String)session.getAttribute("userId");
	String url = "/platform/bpm/clientbpmdisplayaction/gettodonew3.do?userId=" + userId + "&taskFinished=0&rows=10";
%>
<script type="text/javascript">
	var userId = '<%=userId%>';
	var baseurl = '<%=request.getContextPath()%>';
</script>
<jsp:forward page='<%=url%>' /> 