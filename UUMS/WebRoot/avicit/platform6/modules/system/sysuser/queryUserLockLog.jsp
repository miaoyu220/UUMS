<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ page import="java.util.*"%>
<%@ page import="avicit.platform6.core.spring.SpringFactory"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>群组添加用户</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="avicit/platform6/modules/system/sysuser/js/SysUserLockLog.js" type="text/javascript"></script>
<link href="static/css/platform/sysdept/icon.css" type="text/css" rel="stylesheet">

</head>

<body class="easyui-layout" fit="true">


		
	<div data-options="region:'north',split:false,title:''" style="height: 50px; padding:0px;margin-top:5px;">	
			<div id="searchUser" class="easyui-panel" data-options="iconCls:'icon-search'" 
			style=" visible: hidden">
			
			<div style="TEXT-ALIGN: center; ">
				<form id="searchUserForm">
		    		<table style=" MARGIN-RIGHT: auto; MARGIN-LEFT: auto;">
		    			<tr>
		    				<td>用户名:</td><td><input type='text' name="filter_LIKE_name" id="filter_LIKE_name" style="width:100px" value='${username}' readonly="readonly"/></td>
		    				<td>锁定次数:</td><td><input type='text' name="filter_LIKE_loginName" id="filter_LIKE_loginName" style="width:100px" readonly="readonly"/></td>
		    				<!-- 
		    				<td>是否有效:</td><td><input id="filter_EQ_status" class="easyui-combobox" name="filter_EQ_status" style="width:100px" 
	    						 data-options="panelHeight:'auto', editable:false,valueField:'lookupCode',textField:'lookupName', data: [{lookupCode:'1', lookupName: 'aaa'}]" /> </td>
		    				 -->
		    			</tr>
		    			
		    		</table>
		    	</form>
		    </div>	
	    </div>
	</div>
	
	<div data-options="region:'center',split:false,title:''" style="height:0; overflow:hidden; font-size:0;">				
		<table id="dgUserLockLog" class="easyui-datagrid"
			data-options=" 
				fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#toolbarUser',
				idField :'id',
				singleSelect: true,
				checkOnSelect: false,
				selectOnCheck: true,
				pagination:true,
				pageSize:dataOptions.pageSize,
				pageList:dataOptions.pageList,
				
				striped:true
				">
			<thead>
				<tr>
					
					<th data-options="field:'lockIp',required:true,halign:'center',align:'left'" editor="{type:'text'}" width="220">锁定IP</th>
					<th data-options="field:'lockDate',required:true,halign:'center',formatter:formatDate,align:'left'" editor="{type:'text'}" width="220">锁定时间</th>
					<th data-options="field:'lockContent',required:true,halign:'center',align:'left'" editor="{type:'text'}" width="220">锁定原因</th>
					
				</tr>
			</thead>
		</table>	
	</div>	
</body>
<script type="text/javascript">
	var sysUserLockLog;
	$(function(){
		sysUserLockLog =new SysUserLockLog('dgUserLockLog','searchDialog','${url}','${username}');
	});
	


	function formatDate(value){
		var newDate=new Date(value);
		return newDate.Format("yyyy-MM-dd hh:mm:ss");   
	};
</script>
</html>