<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>更新通用码段码值</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<script type="text/javascript">
/**
 * 增加规则码值
 */
function addSegmentValue(){
	var segmentId = $('#segmentId').val();
	var usd = new CommonDialog("addSegmentValueDialog","380","200","platform/sysCodingComSegmentController/toAddComSegmentValueJsp?segmentId="+ segmentId,"添加码值",true);
	var buttons = [{
		text:'提交',
		id : 'formSubimt',
		iconCls : '',
		handler:function(){
			var frmId = $('#addSegmentValueDialog iframe').attr('id');
			var frm = document.getElementById(frmId).contentWindow;
			var r = frm.$('#formSegmentValue').form('validate');
			if(!r){
				return false;
			}
			$.ajax({
                cache: true,
                type: "POST",
                url:'platform/sysCodingComSegmentController/addSegmentValue',
                dataType:"json",
                data:frm.$('#formSegmentValue').serialize(),
                async: false,
                timeout:10000,
                error: function(request) {
                	alert("操作失败，服务请求状态："+request.status+" "+request.statusText+" 请检查服务是否可用！");
                },
                success: function(result) {
                	if (result.flag == 'success') {
						usd.close();
						$('#datagrid1').datagrid('reload');
						$.messager.show({title:'提示',msg :'保存成功！'});
					}else{
						if(result.isPublished == 'true'){
							$.messager.show({title:'提示',msg :'此规则已经发布，不能编辑码值'});
						}else if(result.isExistsName == 'true'){
							$.messager.show({title:'提示',msg :'保存失败！码名称重复'});
						}else if(result.isExistsValue == 'true'){
							$.messager.show({title:'提示',msg :'保存失败！码值重复'});
						}else{
							$.messager.show({title:'提示',msg :'保存失败！'});
						}
					}
                }
            });
		}
	}];
	usd.createButtonsInDialog(buttons);
	usd.show();
}

/**
 * 更新规则码值
 */
function updateSegmentValue(){
	var checked = $('#datagrid1').datagrid('getChecked');
	if(checked.length == 0) {
		$.messager.show({title : '提示',msg : "请选择记录!"});
		return false;
	}else if(checked.length > 1) {
		$.messager.show({title : '提示',msg : "请选择一条记录!"});
		return false;
	}
	
	var id = checked[0].id;
	var segmentId = $('#segmentId').val();
	var usd = new CommonDialog("updateSegmentValueDialog","380","200","platform/sysCodingComSegmentController/toUpdateComSegmentValueJsp?id="+ id +"&segmentId="+ segmentId,"编辑码值",true);
	var buttons = [{
		text:'提交',
		id : 'formSubimt',
		iconCls : '',
		handler:function(){
			var frmId = $('#updateSegmentValueDialog iframe').attr('id');
			var frm = document.getElementById(frmId).contentWindow;
			var r = frm.$('#formSegmentValue').form('validate');
			if(!r){
				return false;
			}
			$.ajax({
                cache: true,
                type: "POST",
                url:'platform/sysCodingComSegmentController/updateSegmentValue',
                dataType:"json",
                data:frm.$('#formSegmentValue').serialize(),
                async: false,
                timeout:10000,
                error: function(request) {
                	alert("操作失败，服务请求状态："+request.status+" "+request.statusText+" 请检查服务是否可用！");
                },
                success: function(result) {
                	if (result.flag == 'success') {
						usd.close();
						$('#datagrid1').datagrid('reload');
						$.messager.show({title:'提示',msg :'保存成功！'});
					}else{
						if(result.isPublished == 'true'){
							$.messager.show({title:'提示',msg :'保存失败！此规则已经发布，不能编辑码值'});
						}else if(result.isExistsName == 'true'){
							$.messager.show({title:'提示',msg :'保存失败！码名称重复'});
						}else if(result.isExistsValue == 'true'){
							$.messager.show({title:'提示',msg :'保存失败！码值重复'});
						}else{
							$.messager.show({title:'提示',msg :'保存失败！'});
						}
					}
                }
            });
		}
	}];
	usd.createButtonsInDialog(buttons);
	usd.show();
}

/**
 * 删除规则码值
 */
function deleteSegmentValue(){
	var checked = $('#datagrid1').datagrid('getChecked');
	if(checked.length == 0) {
		$.messager.show({title : '提示',msg : "请选择记录!"});
		return false;
	}
	
	$.messager.confirm('确认', '您确认删除吗?', function(r){
        if (r){
        	var segmentId = $('#segmentId').val();
        	var idArray = new Array();
        	for (var i = 0; i < checked.length; i++){
        		idArray[i] = checked[i].id;
        	}
        	var param = {
        		segmentId: segmentId,
        		ids: idArray.join(',')
        	};
        	
			$.ajax({
				url : 'platform/sysCodingComSegmentController/deleteSegmentValue',
				data : param,
				type : 'post',
				dataType : 'json',
				success : function(result) {
					if (result.flag == 'success') {
						$('#datagrid1').datagrid('uncheckAll');
						$('#datagrid1').datagrid('reload');
						$.messager.show({title:'提示',msg :'删除成功！'});
					} else {
						if(result.isPublished == 'true'){
							$.messager.show({title:'提示',msg :'删除失败！此规则已经发布，不能删除码值'});
						}else {
							$.messager.show({title:'提示',msg :'删除失败！'});
						}
					}
				}
			});
        }
    });	
}
</script>
</head>
<body class="easyui-layout" >
<input type="hidden" id="segmentId" name="segmentId" value="${param.id }">
<div region="center" border="false">
	<table id="datagrid1" class="easyui-datagrid" 
		data-options="
			fit: true,
			border: false,
			rownumbers: true,
			animate: true,
			collapsible: false,
			fitColumns: true,
			autoRowHeight: false,
			idField: 'id',
			toolbar:'#toolbar',
			singleSelect: false,
			checkOnSelect: true,
			selectOnCheck: true,
			method: 'post',
			url:'platform/sysCodingComSegmentController/getComSegmentValuesListData.json?segmentId=${param.id }'
		">
		<thead>
			<tr>
				<th data-options="field:'checkbox', checkbox: true, halign:'center', align:'center'" width="30"></th>
				<sec:accesscontrollist hasPermission="3" domainObject="sysCodingComSegmentValues_gridform_segmentName">
					<th data-options="field:'segmentName', halign:'center', align:'center'" width="100">码名称</th>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="sysCodingComSegmentValues_gridform_segmentValue">
					<th data-options="field:'segmentValue', halign:'center', align:'center'" width="100">码值</th>
				</sec:accesscontrollist>
			</tr>
		</thead>
	</table>
	<div id="toolbar" class="datagrid-toolbar" style="height: 28px; overflow: hidden;">
		<div style="padding:0 0 0 5px;">
			<sec:accesscontrollist hasPermission="3" domainObject="sysCodingComSegmentValues_button_addButton" >
				<a id="addButton" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addSegmentValue();" href="javascript:void(0);">添加</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="sysCodingComSegmentValues_button_updateButton" >
				<a id="updateButton" class="easyui-linkbutton" iconCls="icon-edit"  plain="true" onclick="updateSegmentValue();" href="javascript:void(0);">编辑</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="sysCodingComSegmentValues_button_deleteButton" >
				<a id="deleteButton" class="easyui-linkbutton" iconCls="icon-remove"  plain="true" onclick="deleteSegmentValue();" href="javascript:void(0);">删除</a>
			</sec:accesscontrollist>
		</div>
	</div>
</div>
</body>
</html>
