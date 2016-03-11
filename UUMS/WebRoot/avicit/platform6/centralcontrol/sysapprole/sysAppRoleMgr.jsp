<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>系统应用授权</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
</head>
<body class="easyui-layout" fit="true">
	<div region="center" border="false" style="height:0px;padding:0px;overflow:hidden;">
		<div id="toolbarSysApp">
			<td><a class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="sysApp.save();" href="javascript:void(0);">保存</a></td>
			<td><a class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="sysApp.openSearchForm();" href="javascript:void(0);">查询</a></td>
		</div>
		<table id="sysAppList"
			data-options=" 
						fit: true,
						border: false,
						rownumbers: true,
						animate: true,
						collapsible: false,
						fitColumns: true,
						autoRowHeight: false,
						toolbar:'#toolbarSysApp',
						singleSelect: true,
						checkOnSelect: true,
						selectOnCheck: false,
						striped:true">
			<thead>
				<tr>
					<th data-options="field:'sysappId',required:true,hidden:true,align:'center'" width="120">应用标识</th>
					<th data-options="field:'sysroleId',required:true,hidden:true,align:'center'" editor="{type:'text'}" width="120">可访问角色ID</th>
					<th data-options="field:'sysappName',align:'left'" width="120">应用名称</th>
					<th data-options="field:'sysroleName',align:'center',styler:styleCell"  editor="{type:'text'}" width="220">可访问角色</th>
				</tr>
			</thead>
		</table>
	</div>
	<div id="searchDialog" data-options="iconCls:'icon-search',resizable:true,modal:false,buttons:'#searchBtns'" style="width: 600px;height:200px;display: none;">
		<form id="form1">
    		<table style="padding-top: 10px;">
    			<tr>
    				<td>应用名称:</td>
    				<td><input class="easyui-validatebox" type="text" name="sysappName"/></td>
    				<td>角色名称:</td>
    				<td><input class="easyui-validatebox" type="text" name="sysroleName"/></td>
    			</tr>
    		</table>
    	</form>
    	<div id="searchBtns">
    		<a class="easyui-linkbutton" plain="false" onclick="sysApp.searchData();" href="javascript:void(0);">查询</a>
    		<a class="easyui-linkbutton"  plain="false" onclick="sysApp.clearData();" href="javascript:void(0);">清空</a>
    		<a class="easyui-linkbutton" plain="false" onclick="sysApp.hideSearchForm();" href="javascript:void(0);">返回</a>
    	</div>
  </div>
	<script src="avicit/platform6/centralcontrol/sysapprole/js/SysAppRole.js" type="text/javascript"></script>
	<script type="text/javascript">
		var sysApp;
		$(function(){
			sysApp =new SysAppRole('sysAppList','searchDialog','${url}','form1');
		});
		function format(value){
			return sysApp.format(value);
		};
		function formatId(value,row,index){
			return row.id;
		};
		function formatInit(value,row,index){
			return sysApp.formatInit(value,row,index);
		};
		function styleCell(){
			return "cursor:pointer;";
		};
		
	</script>
</body>
</html>