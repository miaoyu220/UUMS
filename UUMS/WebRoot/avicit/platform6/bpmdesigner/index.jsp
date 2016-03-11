<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ request.getContextPath() + "/";
	String skin = "skyblue";
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<base href="<%=basePath%>">
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<title>web流程设计器</title>
<link rel="stylesheet" href="<%=basePath%>static/js/platform/designer/dhtmlx/codebase/dhtmlx.css">
<script>
	//全局变量
	var _basePath = "<%=basePath%>";
	var _controlPath = _basePath + "platform/bpm/bpmdesigner/bpmWebDesigner/";
	var _skin = "<%=skin%>";
	var mxBasePath = _basePath + "static/js/platform/designer/";
	var _designerPath = _basePath + "static/js/platform/designer/";
	var _iconPath = _designerPath + "images/";
	var _imgPath = _designerPath + "dhtmlx/codebase/imgs/";
	var _formCode = "${formCode}";
	var _refreshFlg = '<%=request.getParameter("refreshFlg")%>';
</script>
<script src="<%=basePath%>static/js/platform/designer/dhtmlx/codebase/dhtmlx.js"></script>
<script src="<%=basePath%>static/js/platform/designer/jquery-1.11.3.min.js"></script>
<script src="<%=basePath%>static/js/platform/designer/mxClient.js"></script>
<script src="<%=basePath%>static/js/platform/designer/myExtend.js"></script>
<script src="<%=basePath%>static/js/platform/designer/ComUtils.js"></script>
<script src="<%=basePath%>static/js/platform/designer/indexPanel.js"></script>
<style> /* it's important to set width/height to 100% for full-screen init */
html,body {
	width: 100%;
	height: 100%;
	margin: 0px;
	overflow: hidden;
}
.showWin{
	width: 100%;
	height: 100%;
}
</style>
</head>
<body>
	<div id="myWindows" style="width:100%;height:100%;"></div>
</body>
</html>
