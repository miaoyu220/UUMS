<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>集中授权管理</title>
		<base href="<%=ViewUtil.getRequestPath(request) %>">
		<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
		<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
		<script type="text/javascript">
			//获取某个认证实体的授权信息（所有的，包括菜单和组件）
			window.AUTH_INFO_URL = "platform/cc/securitycontrol/getauthinfo.json";
			window.TARGET_TYPE = "R"; // 目标类型； 角色(R)，用户(U)，部门(D)，群组(G)，岗位(P)。
			window.TARGET_ID = ""; // 目标ID
			window.REFLASH_TYPE = ""; //要刷新的组件类型，可能是MENU,也可能是COMPONENT,如果为“”，则同时刷新二者
			window.AUTH_DATA = eval("({menus:[],components:[]})");
			window.MENU_ID = "";  // 记录当前选中的菜单ID， 下次展开的时候用
			window.MENU_EVEL = ""; // 记录当前选中的菜单的层次，下次展开的时候用
		</script>
		
		<script src="avicit/platform6/centralcontrol/sysauthaccesscontrol/js/west.js" type="text/javascript"></script>
		<script src="avicit/platform6/centralcontrol/sysauthaccesscontrol/js/center.js" type="text/javascript"></script>
		<script src="avicit/platform6/centralcontrol/sysauthaccesscontrol/js/east.js" type="text/javascript"></script>
		<script src="avicit/platform6/centralcontrol/sysauthaccesscontrol/js/authManager.js" type="text/javascript"></script>
		<script src="avicit/platform6/centralcontrol/sysapp/js/SysAppTree.js" type="text/javascript"></script>
		<script type="text/javascript" charset="utf-8">
		<%
			//页面过来接收参数
			String showTab = request.getParameter("showTab");
			String extParameter = request.getParameter("extParameter");
			String singleSelect = request.getParameter("singleSelect");
	    %>	
			var sysAppTree;
			var _APPID;
			$(function(){

				var dataGridHeight = $(".easyui-layout").height();
				
				sysAppTree = new SysAppTree('apps','searchApp',APP_.PRIVATE,null,120);
				
				sysAppTree.setOnLoadSuccess(function(){
				});
				sysAppTree.setOnSelect(function(_sysAppTree,node){
					_APPID = node.id;
					window.loadAuthInfoData();
					reloadTabData();
				});
				sysAppTree.init();
				initTabContainer(dataGridHeight);
			});	
		</script>
	</head>
	
	<body class="easyui-layout" fit="true">
		<div data-options="region:'west',split:true,title:'应用列表',collapsible:false" style="width:150px">
		 	<div id="toolbarTree" class="datagrid-toolbar">
			 	<table width="100%">
			 		<tr>
			 			<td width="100%"><input type="text"  name="searchApp" id="searchApp"></input></td>
			 		</tr>
			 	</table>
	 	 	</div>
	 		<ul id="apps">正在加载应用列表...</ul>
 		</div>   
 		<div data-options="region:'center',split:true" style="padding:0px;">   
			<div id="area_center" class="easyui-layout" data-options="fit:true">   
				<div data-options="region:'west',title:' 授权选择',split:true,iconCls:'icon-auth'" style="width:375px;background:#f5fafe;overflow-y:hidden;">
					<%@ include file ="west.jsp"%>
				</div>
				<div data-options="region:'center',title:'菜单权限',iconCls:'icon-search'" style="background:#ffffff;">
					<%@ include file ="center.jsp"%>
				</div>
			</div>
		</div>
		<div data-options="region:'east',title:' 页面组件权限',split:true,iconCls:'icon-edit'" style="width:440px;background:#f5fafe;">
			<%@ include file ="east.jsp"%>
		</div>	
	</body>
</html>