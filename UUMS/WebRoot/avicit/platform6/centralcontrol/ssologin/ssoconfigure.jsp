<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ page import="avicit.platform6.api.syssso.loder.SsoPropsLoader"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>sso配置</title>
<base href="<%=ViewUtil.getRequestPath(request) %>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<style type="text/css">
.required-icon {
	maring:0px;
	padding:0px;
	width: 10px;
	height: 23px;
	overflow: hidden;
	display: inline-block;
	vertical-align: top;
	/* opacity: 0.6; */
/* 	filter: alpha(opacity=60); */
	background: url('static/css/platform/themes/default/public/images/required.gif') no-repeat center center;
}
.table tr input{
	width: 95%;
	margin-left: 5px;
}
.table tr{
	line-height: 30px;
}
.table tr th{
	font-size: 12px;
	font-family: "Microsoft YaHei";
	color: #444;
	line-height:20px;
}
</style>
</head>
<body  class="easyui-layout" fit="true" onload="init();">
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
	 
	<div data-options="region:'center',split:true,title:'单点配置信息'" style="padding:0px;overflow:auto;">
		<div id="toolbarImportResult" class='datagrid-toolbar'>
					<table width="">
							<td><a title="保存" id="saveButton"  class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="saveForm();" href="javascript:void(0);">保存</a></td>
							<td><a title="取消" id="returnButton"  class="easyui-linkbutton" iconCls="icon-undo" plain="true" onclick="resetForm();" href="javascript:void(0);">取消</a></td>
					</table>	
		</div>
				<form id="formssologin" method="post">
					<table class="table" width="100%" style="padding-top: 4px;">
						<tr>
							<th width="120px" align="right">SSO登录URL</th>
							<td>
								<span class="required-icon"></span>
								<input title="sso登录url" class="easyui-validatebox" type="text" name="ssoLoginUrl" id="ssoLoginUrl" value="${ssoLoginUrl}"data-options="required:true"/>
							
							</td>
						</tr>
						<tr>
							<th align="right">SSO退出URL</th>
							<td>
								<span class="required-icon"></span>
								<input title="SSO退出URL" class="easyui-validatebox" type="text" name="ssoLogoutUrl" id="ssoLogoutUrl" value="${ssoLogoutUrl}" data-options="required:true" />
							</td>
						</tr>
						<tr>
							<th align="right">当前应用服务器名称</th>
							<td>
								<span class="required-icon"></span>
								<input title="当前应用服务器名称" class="easyui-validatebox" type="text" name="serverName" id="serverName" value="${serverName}" data-options="required:true"/>
							</td>
						</tr>
						<tr>
							<th align="right">当前应用登录URL</th>
							<td>
								<span class="required-icon"></span>
								<input title="当前应用登录URL" class="easyui-validatebox" type="text" name="serviceUrl" id="serviceUrl" value="${serviceUrl}" data-options="required:true"/>
							</td>
						</tr>
						<tr>
							<th align="right">SSO服务器</th>
							<td>
								<span class="required-icon"></span>
								<input title="ssoServerUrl" class="easyui-validatebox" type="text" name="ssoServerUrl" id="ssoServerUrl" value="${ssoServerUrl}" data-options="required:true"/>
							</td>
						</tr>
						<tr>
							<th align="right">SSO登录启用</th>
							<td>
								<span class="required-icon"></span>
								<input style="width: 25px;" title="ssoEnabled" class="easyui-numberbox" type="checkbox" name="ssoEnabled" id="ssoEnabled"/>
							</td>
						</tr>
						
					</table>
				</form>
			
	</div>
	<script src="avicit/platform6/centralcontrol/sysapp/js/SysAppTree.js" type="text/javascript"></script>
<script type="text/javascript">

	var sysMenu;
	var sysAppTree;
	var appId;
	$(function(){
		sysAppTree = new SysAppTree('apps','searchApp',APP_.PRIVATE);
		
		
		sysAppTree.setOnSelect(function(_sysAppTree,node){
			appId = node.id;
		
			$.ajax({
				url : 'platform/cc/ssoconfig/ssoconfiginfo/'+node.id,
				type : 'post',
				dataType : 'json',
				success : function(result) {
					$('#ssoLoginUrl').val(result.ssoLoginUrl);
					$('#ssoLogoutUrl').val(result.ssoLogoutUrl);
					$('#serverName').val(result.serverName);
					$('#serviceUrl').val(result.serviceUrl);
					$('#ssoServerUrl').val(result.ssoServerUrl);
					$('#ssoEnabled').val(result.ssoEnabled);
				}
				
			});
			
		});
		sysAppTree.init();
	});

/**
 * 
 */
function saveForm(){
	
	if ($('#formssologin').form('validate') == false) {
		return;
	}
	var dataVo = $('#formssologin').serializeArray();
	var dataJson = convertToJson(dataVo);
	dataVo = JSON.stringify(dataJson);
	$.ajax({
		url : 'platform/cc/ssoconfig/saveorupdate/'+appId,
		data : {
			datas : JSON.stringify(serializeObject($('#formssologin')))
		},
		type : 'post',
		dataType : 'json',
		success : function(result) {
			if (result.flag == "success") {
				showMessager("配置成功");
			}else {
				
				showMessager("配置失败");
			}
		}
	});
}
function resetForm(){
	$('#formssologin').form('clear');
	
}
/**
 * 
 */
function showMessager(msg){
	var scroll =-document.body.scrollTop-document.documentElement.scrollTop;
	$.messager.show({
		title : '提示',
		msg : msg,
		timeout:2000,  
        showType:'slide',
        style:{
        	left:'',
        	right:0,
        	top:'',
            bottom:scroll
        }  
	});
}
function init(){
	var falg = ${ssoEnabled};
	if(falg){
		document.getElementById("ssoEnabled").checked = true;
	}
}
</script>
</body>
</html>