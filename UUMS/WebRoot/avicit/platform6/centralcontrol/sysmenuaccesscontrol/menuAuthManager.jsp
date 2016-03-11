<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>菜单授权管理</title>
		<base href="<%=ViewUtil.getRequestPath(request) %>">
		<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
		<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
		<script src="avicit/platform6/centralcontrol/sysmenuaccesscontrol/js/center.js" type="text/javascript"></script>
		<script src="avicit/platform6/centralcontrol/sysmenuaccesscontrol/js/menutree.js" type="text/javascript"></script>
		<script src="avicit/platform6/centralcontrol/sysapp/js/SysAppTree.js" type="text/javascript"></script>
		<script type="text/javascript" charset="utf-8">
		var currentMenuId="root";
		var curComId="none";
		var comDatagrid;
		var _APPID;
		var currTabIndex=0;
		var TARGET_TYPE = "R"; // 目标类型； 角色(R)，用户(U)，部门(D)，群组(G)，岗位(P)。
		window.TARGET_ID = ""; // 目标ID
		var sysAppTree;
		$(function(){
			sysAppTree = new SysAppTree('apps','searchApp',APP_.PRIVATE);
			
			sysAppTree.setOnLoadSuccess(function(){
				 //sysMenu = new SysMenu('menu','${url}','searchWord','form');
			});
			sysAppTree.setOnSelect(function(_sysAppTree,node){
				_APPID  = node.id;
				meuntreeReload(node.id);
				$('#searchWord').searchbox('setValue', null);
				//selectRootNode();
			});
			sysAppTree.init();
			initMemuSearch();
			initTabContainer();
		});
		function myOnBeforeExpand(row) {
			$("#memuTree").tree("options").url = "platform/cc/permissiontree/listMemuTreeById.json?id=" + row.id+"&appId="+_APPID;
			return true;
		}
		function clickTreeRow(row){
			currentMenuId = row.id;
			reloadTabData(currTabIndex);
		}
		function meuntreeReload(appId){
			$("#memuTree").tree("options").url = "platform/cc/permissiontree/listMemuTreeById.json?appId="+appId;
			$("#memuTree").tree('reload');
		}
		function selectRootNode(){
			var rootnode = $("#memuTree").tree('find', "root");
			rootnode&&$("#memuTree").tree('select', rootnode.target);
		}
		function reloadTabData(index){
			if(index==0){
				loadRole(currentMenuId);
			}else if(index==1){
				loadUser(currentMenuId);
			}else if(index==2){
				loadDept(currentMenuId);
			}else if(index==3){
				loadGroup(currentMenuId);
			}else if(index==4){
				loadPosition(currentMenuId);
			}
		}
		/**
		 *菜单查询
		 **/
		function initMemuSearch() {
			$('#searchWord').searchbox({
				width : 200,
				searcher : function(value) {
					var path = "platform/cc/permissiontree/searchMemu.json";
					if (value == null || value == "") {
						path = "platform/cc/permissiontree/listMemuTreeById.json?appId="+_APPID;
					}
					$.ajax({
						type : "POST",
						url : path,
						dataType : "json",
						data : {
							search_text : value,
							appid:_APPID
						},
						async : false,
						error : function(request) {
							alert('操作失败，服务请求状态：' + request.status
									+ ' ' + request.statusText
									+ ' 请检查服务是否可用！');
						},
						success : function(data) {
							if (data.result == 0) {
								$('#memuTree').tree('loadData',
										data.data);
							} else {
								$.messager.alert('提示', data.msg,
										'warning');
							}
						}
					});
				},
				prompt : "请输入菜单名称！"
			});
		}
		
		
		
		</script>
	</head>
	
	<body class="easyui-layout" fit="true">
	<div data-options="region:'west',split:true,title:'应用列表',collapsible:false" style="width:200px">
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
	<div class="easyui-layout" data-options="fit:true">   
		<div data-options="region:'west',title:' 菜单资源信息',split:true,iconCls:'icon-save'" style="width:350px;background:#f5fafe;overflow-y:hidden;">
				<%@ include file ="menutree.jsp"%>
		</div> 
		<div data-options="region:'center',iconCls:'icon-search',title:'权限设置'" style="background:#ffffff; height:0; overflow:hidden; font-size:0;">
			 <%@ include file ="center.jsp"%>
		</div>
	</div>
 </div>
	
	</body>
</html>