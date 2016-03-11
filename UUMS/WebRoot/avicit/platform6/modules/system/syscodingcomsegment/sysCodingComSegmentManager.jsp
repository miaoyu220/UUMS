<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>通用码段管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<script type="text/javascript">
/**
 * 查询数据
 */
function searchComSegment(){
	var param = {
		searchName : $('#searchName').val()
	}; 
	$('#datagrid1').datagrid('reload', param);
}

/**
 * 重置
 */
function clearSearch(){
	$('#searchName').val('');
}

/**
 * 添加通用码段
 */
function addComSegment(){
	var usd = new CommonDialog("addComSegmentDialog","520","200","avicit/platform6/modules/system/syscodingcomsegment/sysCodingComSegmentAdd.jsp","添加通用码段",true);
	var buttons = [{
		text:'保存',
		id : 'formSubimt',
		iconCls : '',
		handler:function(){
			var frmId = $('#addComSegmentDialog iframe').attr('id');
			var frm = document.getElementById(frmId).contentWindow;
			var r = frm.$('#formComSegment').form('validate');
			if(!r){
				return false;
			}
			
			//获取form中的值
			var comSegment = frm.$('#formComSegment').serializeArray();
			var comSegmentJson = convertToJson(comSegment);
			comSegment = JSON.stringify(comSegmentJson);

			var param = {
				comSegment: comSegment
			};
			
			$.ajax({
				url : 'platform/sysCodingComSegmentController/addComSegment',
				data : param,
				type : 'post',
				dataType : 'json',
				success : function(result) {
					if (result.flag == 'success') {
						usd.close();
						$("#datagrid1").datagrid('reload');
						$.messager.show({title:'提示',msg :'保存成功！'});
					} else {
						if(result.isExistsName == 'true'){
							$.messager.show({title:'提示',msg :'保存失败！规则名称已存在。'});
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
 * 更新通用码段
 */
function updateComSegment(){
	var checked = $('#datagrid1').datagrid('getChecked');
	if(checked.length == 0) {
		$.messager.show({title : '提示',msg : "请选择记录!"});
		return false;
	}else if(checked.length > 1) {
		$.messager.show({title : '提示',msg : "请选择一条记录!"});
		return false;
	}

	var id = checked[0].id;
	
	var usd = new CommonDialog("updateComSegmentDialog","520","200","platform/sysCodingComSegmentController/toUpdateComSegmentJsp.jsp?id="+id,"编辑通用码段",true);
	var buttons = [{
		text:'保存',
		id : 'formSubimt',
		iconCls : '',
		handler:function(){
			var frmId = $('#updateComSegmentDialog iframe').attr('id');
			var frm = document.getElementById(frmId).contentWindow;
			var r = frm.$('#formComSegment').form('validate');
			if(!r){
				return false;
			}

			//获取form中的值
			var comSegment = frm.$('#formComSegment').serializeArray();
			var comSegmentJson = convertToJson(comSegment);
			comSegment = JSON.stringify(comSegmentJson);

			var param = {
				comSegment: comSegment
			};
			
			$.ajax({
				url : 'platform/sysCodingComSegmentController/updateComSegment',
				data : param,
				type : 'post',
				dataType : 'json',
				success : function(result) {
					if (result.flag == 'success') {
						usd.close();
						$("#datagrid1").datagrid('reload');
						$.messager.show({title:'提示',msg :'保存成功！'});
					} else {
						if(result.isExistsName == 'true'){
							$.messager.show({title:'提示',msg :'保存失败！码段名称已存在。'});
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
 * 删除通用码段
 */
function deleteComSegment(){
	var checked = $('#datagrid1').datagrid('getChecked');
	if(checked.length == 0) {
		$.messager.show({title : '提示',msg : "请选择记录!"});
		return false;
	}

	$.messager.confirm('确认', '您确认删除吗?', function(r){
        if (r){
        	var idArray = new Array();
        	for (var i = 0; i < checked.length; i++){
        		idArray[i] = checked[i].id;
        	}
        	var param = {
        		ids: idArray.join(',')
        	};
        	
			$.ajax({
				url : 'platform/sysCodingComSegmentController/deleteComSegment',
				data : param,
				type : 'post',
				dataType : 'json',
				success : function(result) {
					if (result.flag == 'success') {
						$("#datagrid1").datagrid('uncheckAll'); 
						$("#datagrid1").datagrid('reload'); 
						$.messager.show({title:'提示',msg :'删除成功！'});
					} else {
						$.messager.show({title:'提示',msg :'删除失败！'});
					}
				}
			});
        }
    });	
}

/**
 * 编辑码值
 */
function updateComSegmentValues(){
	var checked = $('#datagrid1').datagrid('getChecked');
	if(checked.length == 0) {
		$.messager.show({title : '提示',msg : "请选择记录!"});
		return false;
	}else if(checked.length > 1) {
		$.messager.show({title : '提示',msg : "请选择一条记录!"});
		return false;
	}
	
	var id = checked[0].id;
	
	var usd = new CommonDialog("updateComSegmentValuesDialog","600","320","avicit/platform6/modules/system/syscodingcomsegment/sysCodingComSegmentValues.jsp?id="+id,"通用码段码值管理",true,true,false);
	usd.show();
}

</script>
</head>
<body class="easyui-layout">
<div region="north" border="false">
	<div id="toolbar" class="datagrid-toolbar" style="height:auto;display: block;">
		<div style="padding:0 0 0 2px;">
			<table width="100%">
			   <tr>
			   	<td width="60px" align="right">码段名称</td>
			   	<td width="150px"><input id="searchName" name="searchName" style="width: 150px" value=""/></td>
				<td width="100px">
					<sec:accesscontrollist hasPermission="3" domainObject="sysCodingComSegmentManager_button_searchComSegment" >
						<a class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="searchComSegment();" href="javascript:void(0);">查询</a>
					</sec:accesscontrollist>
				</td>
				<td>
					<sec:accesscontrollist hasPermission="3" domainObject="sysCodingComSegmentManager_button_insertComSegment" >
						<a class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addComSegment();" href="javascript:void(0);">添加</a>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3" domainObject="sysCodingComSegmentManager_button_updateComSegment" >
						<a class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="updateComSegment();" href="javascript:void(0);">编辑</a>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3" domainObject="sysCodingComSegmentManager_button_deleteComSegment" >
						<a class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="deleteComSegment();" href="javascript:void(0);">删除</a>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3" domainObject="sysCodingComSegmentManager_button_updateComSegmentValues" >
						<a class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="updateComSegmentValues();" href="javascript:void(0);">编辑码值</a>
					</sec:accesscontrollist>
				</td></tr>
			</table>
		</div>
	</div>
</div>
<div region="center" border="false">
	<table id="datagrid1" class="easyui-datagrid" 
			data-options="
				fit: true,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: true,
				method: 'post',
				url:'platform/sysCodingComSegmentController/getComSegmentListData.json',
				idField: 'id',
				singleSelect: false,
				checkOnSelect: true,
				selectOnCheck: true,
				pagination:true,
				pageSize:dataOptions.pageSize,
				pageList:dataOptions.pageList
			">
		<thead>
			<tr>
				<th data-options="field:'checkbox', checkbox: true, halign:'center', align:'center'" width="30"></th>
				<sec:accesscontrollist hasPermission="3" domainObject="sysCodingComSegmentManager_gridform_segmentName">
					<th data-options="field:'segmentName', halign:'center', align:'left'" width="100">码段名称</th>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="sysCodingComSegmentManager_gridform_segmentLength">
					<th data-options="field:'segmentLength', halign:'center', align:'center'" width="30">码段长度</th>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="sysCodingComSegmentManager_gridform_segmentRemark">
					<th data-options="field:'segmentRemark', halign:'center', align:'left'" width="100">说明</th>
				</sec:accesscontrollist>
			</tr>
		</thead>
	</table>
</div>
</body>
</html>
