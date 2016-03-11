<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Enumeration"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录转向</title>

<%
	String indexPage = "";
	if(null != session.getAttribute("LOGINSUCCESSNEXTURL_")){
		indexPage = session.getAttribute("LOGINSUCCESSNEXTURL_").toString();
	}
	String baseurl = ViewUtil.getRequestPath(request);
	//没有值  
	if("".equals(indexPage)){
		indexPage= baseurl + "avicit/platform6/modules/system/sysdashboard/index.jsp";
	}else{
		if(indexPage.startsWith("/")){
			//如果indexPage存在斜杠，则截取掉斜杠：防止浏览器中出现两个斜杠
			indexPage = baseurl + indexPage.substring(1);
		}else{
			indexPage = baseurl + indexPage;
		}
	}
%>
<script language="javascript">
	location.href = "<%=indexPage%>";
</script>
</head>
<body>
</body>
</html>