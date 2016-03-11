<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="avicit.platform6.commons.utils.ComUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>默认首页配置</title>
<base href="<%=ComUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="avicit/platform6/centralcontrol/sysapp/js/SysAppTree.js" type="text/javascript"></script>
</head>
<body class="easyui-layout">
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
	<div data-options="region:'center',split:true,border:false" style="padding:0px;overflow:hidden;height:0; overflow:hidden;">
		<div id="toolbar" class="datagrid-toolbar" style="display: block;">
				<table>  
					<tr>
						<td><a class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="insert();" href="javascript:void(0);">添加</a></td>
						<td><a class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="save(_appid);" href="javascript:void(0);">保存</a></td>
						<td><a class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="del();" href="javascript:void(0);">删除</a></td>
					</tr>
				</table>
	     </div>
		<table id="portalconfig" class="easyui-datagrid" 
			data-options=" 
				fit: true,
				border: false,
				rownumbers: true,
				idField :'id',
				animate: true,
				collapsible: false,
				toolbar:'#toolbar',
				fitColumns: true,
				autoRowHeight: false,
				singleSelect: true,
				checkOnSelect: true,
				selectOnCheck: false,
				striped:true,
				onClickCell:clickCell
				">
			<thead>
				<th data-options="field:'id',halign:'center',checkbox:true" width="220">id</th>
				<th data-options="field:'name',halign:'center'" editor="{type:'text'}" width="220">名称</th>
				<th data-options="field:'userid',halign:'center',hidden:true" width="220"></th>
				<th data-options="field:'userName',align:'center',halign:'center',styler:styler" width="100">创建者用户名</th>
				<th data-options="field:'roleId',halign:'center',hidden:true" width="320"></th>
				<th data-options="field:'layoutExtends',halign:'center',styler:styler" width="220">继承角色</th>
				<th data-options="field:'layout',halign:'center'" editor="{type:'text'}" width="220">布局</th>
				<th data-options="field:'orderBy',halign:'center'" editor="{type:'numberbox'}" width="50">优先级</th>
				<th data-options="field:'usageModifier',hidden:true, halign:'center',align:'left', formatter: formatcombobox" editor="{type:'combobox',options:{required:true,panelHeight:'auto',editable:false,valueField:'lookupCode',textField:'lookupName'}}" width="220">应用范围</th>
				<th data-options="field:'content',halign:'center',formatter:formatContent,styler:styler" width="100">配置内容</th>
				<th data-options="field:'f',hidden:true" width="220"></th>
			</thead>
		</table>
	</div>
	</div>
	</div>
<script type="text/javascript">
var datagrid;
var sysAppTree;
var _appid;
var unableModifyComboData = {};
var isFirst = true;
$(function(){
	sysAppTree = new SysAppTree('apps','searchApp',APP_.PRIVATE);
	sysAppTree.setOnLoadSuccess(function(){
		intiCombo();
	});
	sysAppTree.setOnSelect(function(_sysAppTree,node){
		if (!isFirst){
			setFirstPage();
		}
		_appid=node.id;
		loadByAppId(node.id);
		isFirst = false;
	});
	
	sysAppTree.init();
 });
function styler(){
	return 'cursor:pointer;';
};
function formatContent(value,row,index){
	return "<span style='vertical-align:middle;font-color:green;cursor:pointer;line-height:1.5em;border-bottom:1px solid #eeeeee;'>配置</span>";
};
function intiCombo(){
	$.ajax({
		url: 'platform/syslookuptype/getLookUpCode/PLATFORM_USAGE_MODIFIER.json',
		type :'get',
		dataType :'json',
		success : function(r){
			r&&(unableModifyComboData =r);
		}
	});
}

function formatcombobox(value){
	if(value ==null ||value == ''){
		return '';
	}
	for(var i =0 ,length = unableModifyComboData.length; i<length;i++){
		if(unableModifyComboData[i].lookupCode == value){
			return unableModifyComboData[i].lookupName;
		}
	}
};

function loadByAppId(appid){
	$("#portalconfig").datagrid("options").url ="platform/cc/sysportal/getData.json";
	$('#portalconfig').datagrid("reload", {appId: appid});
	$("#portalconfig").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');		
}

function setFirstPage(){
	var opts = $("#portalconfig").datagrid('options');
	var pager = $("#portalconfig").datagrid('getPager');
	opts.pageNumber = 1;
    opts.pageSize = opts.pageSize;
	pager.pagination('refresh',{
	    	pageNumber:1,
	    	pageSize:opts.pageSize
	});
}

function insert(){
	endEditing();
	$("#portalconfig").datagrid('insertRow',{
		index: 0,
		row:{id:"",
				userid:'${sessionScope.CURRENT_LOGINUSER.id}',
				userName:'${sessionScope.CURRENT_LOGINUSER.name}',
				layoutExtends:'请选择角色',
				f:true,
				layout:'layout1.xml'}
	}); 
};
//保存
var save=function(appId){
	if(!this.endEditing()){
		return false;
	}
	var allRows = $("#portalconfig").datagrid('getRows');
	$.ajax({
		 url:'platform/cc/sysportal/save.json',
		 data : {datas:JSON.stringify(allRows),appId:appId},
		 type : 'post',
		 dataType : 'json',
		 success : function(r){
			 if (r.flag == "success"){
				 $("#portalconfig").datagrid('reload',{appId:_appid});
				 $("#portalconfig").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
				$.messager.show({
					 title : '提示',
					 msg : '保存成功！'
				 });
			 }else{
				 $.messager.show({
					 title : '提示',
					 msg : r.error
				});
			 } 
		 }
	 });
};
//删除
var del=function(){
	var rows = $("#portalconfig").datagrid('getChecked');
	var ids = [];
	var l =rows.length;
  	if(l > 0){
	  $.messager.confirm('请确认','您确定要删除当前所选的数据？',function(b){
		 if(b){
			 for(;l--;){
				 ids.push(rows[l].id);
			 }
			 $.ajax({
				 url:'platform/cc/sysportal/delte.json',
				 data:	JSON.stringify(ids),
				 contentType : 'application/json',
				 type : 'post',
				 dataType : 'json',
				 success : function(r){
					 if (r.flag == "success") {
						 $("#portalconfig").datagrid('load',{});
						 $("#portalconfig").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
						 $.messager.show({
							 title : '提示',
							 msg : '删除成功！'
						});
					}else{
						$.messager.show({
							 title : '提示',
							 msg : r.error
						});
					}
				 }
			 });
		 } 
	  });
  	}else{
	  $.messager.alert('提示','请选择要删除的记录！','warning');
  	}
};
var editIndex = undefined;
var clickCell = function(index, field,value){
	var comSelect;
	var nowRow=$('#portalconfig').datagrid('getRows')[index];
	if(field ==='layoutExtends' && endEditing()){//员工
		comSelect = new GridCommonSelector("role",'portalconfig',index,"roleId",{targetId:'roleId'},function(rowIndex,resultData){
			var roleId =[],roleName=[];
			var l =resultData.length;
			for(;l--;){
				roleId.push(resultData[l].id);
				roleName.push(resultData[l].roleName);
			}
			
			$('#portalconfig').datagrid('updateRow',{
					index: index,
					row: {
						roleId: roleId.join(','),
						layoutExtends:roleName.join(','),
						f:true
					}
				});
			},null,null,null,false);
		comSelect.init(nowRow);
	}else if(field ==='content' &&endEditing()){
		if(!nowRow.id){
			alert("请保存再配置！");
			return;
		}
		window.open('<%=ComUtil.getRequestPath(request)%>/avicit/platform6/centralcontrol/sysportal/indexAdmin.jsp?appId='+_appid+'&sysPortletConfigId='+nowRow.id+'&j='+ Math.random());
	}else if(endEditing()){
		$('#portalconfig').datagrid('selectRow', index).datagrid('editCell', {index:index,field:field});
		editIndex = index;
	}
};
//扩展easyui单元格编辑
$.extend($.fn.datagrid.methods, {
    editCell: function(jq,param){
        return jq.each(function(){
            var opts = $(this).datagrid('options');
            var fields = $(this).datagrid('getColumnFields',true).concat($(this).datagrid('getColumnFields'));
            for(var i=0; i<fields.length; i++){
                var col = $(this).datagrid('getColumnOption', fields[i]);
                col.editor1 = col.editor;
                if (fields[i] != param.field){
                    col.editor = null;
                }
            }
            $(this).datagrid('beginEdit', param.index);
            if (param.field == "usageModifier"){
	            var ed = $(this).datagrid('getEditor',{index:param.index,field: 'usageModifier'});
	    		$(ed.target).combobox('loadData', unableModifyComboData);
            }
            for(var i=0; i<fields.length; i++){
                var col = $(this).datagrid('getColumnOption', fields[i]);
                col.editor = col.editor1;
            }
        });
    }
});
var endEditing=function(){
    if (editIndex == undefined){return true}
   	$('#portalconfig').datagrid('endEdit', editIndex).datagrid('unselectRow',editIndex);
    editIndex = undefined;
    return true;
};
</script>
</body>
</html>