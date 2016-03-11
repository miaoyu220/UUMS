<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="avicit.platform6.api.session.SessionHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ page import="java.util.*"%>
<%@ page import="avicit.platform6.core.spring.SpringFactory"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<html>
<head>
<%
	long timestamp = System.currentTimeMillis();
	String language =SessionHelper.getCurrentLanguageCode(request);
	String appId = SessionHelper.getApplicationId();
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>群组添加用户</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<link href="static/css/platform/sysdept/icon.css" type="text/css" rel="stylesheet">
</head>

<body class="easyui-layout" fit="true">
<input  id="tableId"  value="${tableId}"   type="hidden"  />
<table id="tt" class="easyui-treegrid" style="height:0"   
        data-options="
        	url:'platform/cbbTemplet/<%=appId%>/ROOT/-1/${tableId}/getTempletTreegrid.json',
        	idField:'id',
        	treeField:'text',
        	singleSelect: true,
			checkOnSelect: true,
			selectOnCheck: false,
			fit: true,
			border: false,
			rownumbers: true,
			animate: true,
			collapsible: false,
			fitColumns: true,
			autoRowHeight: false,
        	loadFilter: function(data){
		         if (data.treeGridNodeList){	
		              return data.treeGridNodeList;
		          } else {
		              return data;
		          }
  			},
  			onBeforeExpand:function(node,param){
				 if(node){
					 $('#tt').treegrid('options').url = 'platform/cbbTemplet/<%=appId%>/'+node.id+'/1/getTempletTree.json'
				 }
		 	}
       		">   
    	<thead>
			<tr>
				<th data-options="field:'id', halign:'center',checkbox:true"		width="220">id</th>
				<th data-options="field:'text',required:true,halign:'center',align:'left'"	editor="{type:'text'}" width="220">模版名称</th>
				<th	data-options="field:'code',required:true,halign:'center',align:'left'" editor="{type:'text'}" width="220">模版编号</th>
				<th data-options="field:'type',halign:'center',align:'left',formatter:formatcombobox" width="220">模版类型</th>
			</tr>
		</thead>   
</table>

<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>	
					<td width="50%" align="right">
						<a href="javascript:void(0)" class="easyui-linkbutton"  onclick="saveUser()" >保存</a>
						<a href="javascript:void(0)" class="easyui-linkbutton"  onclick="javascript:parent.dlg_close('newtemplet')" >返回</a>
					</td>
				</tr>
			</table>
</div>


<script type="text/javascript">





function formatcombobox(value){
	if(value ==null ||value == ''){
		return '';
	}
	if(value == 'R'){
		return '根节点';
	}else if(value == 'F'){
		return '模板夹';
	}else if(value == 'C'){
		return '模板';
	}else if(value == 'S'){
		return '系统标识';
	}
};


function saveUser(){
	var url='platform/eform/tabledefine/savetemplet';
	var treeids='';
	var tableId=$('#tableId').val();
	var row = $('#tt').datagrid('getChecked');
	for(var i=0;i<row.length;i++){
		treeids=treeids+row[i].id+',';
	}
	$.post(url, {
		tableId:tableId,
		treeids:treeids
	}, function(result) {
		parent.dlg_close('newtemplet');
	}, 'json');
	
	//alert(row.text);
}


</script> 
</body> 