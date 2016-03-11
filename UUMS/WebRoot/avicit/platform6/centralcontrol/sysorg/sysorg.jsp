<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>组织管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<link href="static/css/platform/sysdept/icon.css" type="text/css" rel="stylesheet">
<script type="text/javascript">

var path="<%=ViewUtil.getRequestPath(request)%>";
var currTreeNode;

$(document).ready(function(){ 
	initForSearch();
});

function myOnBeforeExpand(row){
	$("#deptTree").tree("options").url = "platform/cc/sysdept/getChildOrgDeptById.json?type="+row.attributes.type;
	return true;
};
/**
 * 组织部门树单击事件
 */
function deptTreeOnClickRow(row){
	currTreeNode=row;
	if(row.attributes.type=="dept"){
		
		$("#btAddOrg").hide();
		
	}else{
		
		
		$("#btAddOrg").show();
	}
	loadSelectTabInfo(null);
};

/**
 * 加载部门信息
 */
function loadOrgDeptInfo(parentId, orgId){
	
	$("#dgOrgDept").datagrid("options").url ="platform/cc/sysorg/getSysOrgDeptList.json";
	
	if(parentId=='root' && orgId=='root')
		$('#dgOrgDept').datagrid("reload",{});
	else 
		$('#dgOrgDept').datagrid("reload", {parentId: parentId, orgId: orgId});
	
	$("#dgOrgDept").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');		
};

/**懒加载tab页Iframe**/
function loadSelectTabInfo(title){
	
	
	if(!currTreeNode) 
		currTreeNode=$('#deptTree').tree('getRoot');
	
	if(currTreeNode.attributes.type=="dept")
	{
		var parentId=currTreeNode.id;
		var orgId=currTreeNode.attributes.ORG_ID;
		
		loadOrgDeptInfo(parentId, orgId);
	}
	else if(currTreeNode.attributes.type=="org")
	{
		var parentId=currTreeNode.id;
		var orgId=currTreeNode.id;
					
		loadOrgDeptInfo(parentId, orgId);
	}
};


/**
 *查询
**/
function initForSearch(){
 $('#searchWord').searchbox({
	 	width: 200,
        searcher: function (value) {
        	var path="platform/cc/sysorg/searchOrg";
        	if(value==null||value==""){
        		path="platform/cc/sysdept/getChildOrgDeptById";
        	}
        	$.ajax({
                cache: true,
                type: "POST",
                url:path,
                dataType:"json",
                data:{search_text:value},
                async: false,
                error: function(request) {
                	alert('操作失败，服务请求状态：'+request.status+' '+request.statusText+' 请检查服务是否可用！');
                },
                success: function(data) {
					if(data.result==0){
						$('#deptTree').tree('loadData',data.data);
					}else{
						$.messager.alert('提示',data.msg,'warning');
					}
                }
            });
        },
        prompt: "请输入组织或部门名称！"
    });
};
/**
 * 刷新当前节点
 */
function updateCurrentNode(data){
	
	flushCurrentChildNodes();
	loadSelectTabInfo(null);
	
	$.messager.show({
		title : '提示',
		msg : '操作成功。',
		timeout:2000,  
        showType:'slide'  
	});
};

/**
 * 添加子节点
 */
function addChildNode(data){
		
	flushCurrentChildNodes();
	loadSelectTabInfo(null);
	
			
	$.messager.show({
		title : '提示',
		msg : '操作成功。',
		timeout:2000,  
        showType:'slide'  
	});
};
/**
 * 刷新子节点
 */
function flushCurrentChildNodes(){
	var node = currTreeNode;
	if(node){
		if(node.id=='root')
			$("#deptTree").tree('reload',null);
		else
			$("#deptTree").tree('reload',node.target);  //重新加载targer的子节点
	}
	else
	{
		$("#deptTree").tree('reload',null);
	}
};

function onTabSelect(title,index){
	loadSelectTabInfo(title);
};

/* 
	删除组织和部门

 */
function deleteOrgDepts()
{
	deleteMsg="";
	
	var rows = $('#dgOrgDept').datagrid('getChecked');
	//alert(rows.length);
	
	var ids = [];
	var types= [];
	var l=rows.length;
	if (rows.length > 0) {
		$.messager.confirm('请确认','您确定要删除当前所选的数据？',
			function(b){
				if(b){
					
					
					for (;l--;) {
						ids.push(rows[l].id);
						types.push(rows[l].type);
						
					}
					
					var idsStr=ids.join('@');
					var typesStr=types.join('@');
					
					$.ajax({
						 url:'platform/cc/sysorg/delete.json',
						 data : {ids : idsStr, types: typesStr},
						 type : 'post',
						 dataType : 'json',
						 success : function(data){
							 if(0==data.result){
								 $.messager.show({title : '提示',msg : '删除成功'});
								 flushCurrentChildNodes();
								 loadSelectTabInfo(null);
							 }else{
								 $.messager.alert('提示',data.msg,'warning');
							 }
						 }
					 });
				}
			});
	} else {
		$.messager.alert('提示', '请选择要删除的记录！', 'warning');
	}
};
function showEditDept(id)
{
	var usd = new CommonDialog("formEditDialog","800","500",path+"avicit/platform6/centralcontrol/sysorg/editDeptForm.jsp?id="+id,"编辑部门");
	var buttons = [{
		text:'提交',
		id : 'formSubimt',
		//iconCls : 'icon-submit',
		handler:function(){
			 var frmId = $('#formEditDialog iframe').attr('id');
			 var frm = document.getElementById(frmId).contentWindow;
			 if(!frm.$('#deptEditForm').form("validate")){
				 $.messager.alert('提示','请完善表单中的信息','warning');
				 return;
			 }
			 $.ajax({
			        cache: true,
			        type: "POST",
			        url:'platform/cc/sysdept/saveDept',
			        dataType:"json",
			        data:frm.$('#deptEditForm').serialize(),
			        error: function(request) {
			        	$.messager.alert('提示','操作失败，服务请求状态：'+request.status+' '+request.statusText+' 请检查服务是否可用！','warning');
			        },
			        success: function(data) {
						if(data.result==0){
							if(data.opType=="update"){
								updateCurrentNode(data.sysDept);	
							}else if(data.opType="insert"){
								addChildNode(data.sysDept);
							}
							usd.close();
						}else{
							$.messager.alert('提示',data.msg,'warning');
						}
			        }
			    });
		}
	}];
	usd.createButtonsInDialog(buttons);
	usd.show();
};
function showAddDept()
{
	var selectNode = currTreeNode;
	if(!selectNode || selectNode.id=="root"){
		$.messager.alert('提示',"请选择组织或部门！",'warning');
		return;
	}
	var usd = new CommonDialog("formAddDialog","800","500",path+"avicit/platform6/centralcontrol/sysorg/addDeptForm.jsp","添加部门");
	var buttons = [{
		text:'提交',
		id : 'formSubimt',
		//iconCls : 'icon-submit',
		handler:function(){
			 var frmId = $('#formAddDialog iframe').attr('id');
			 var frm = document.getElementById(frmId).contentWindow;
			 if(!frm.$('#deptEditForm').form("validate")){
				 $.messager.alert('提示','请完善表单中的信息','warning');
				 return;
			 }
			 $.ajax({
			        cache: true,
			        type: "POST",
			        url:'platform/cc/sysdept/saveDept',
			        dataType:"json",
			        data:frm.$('#deptEditForm').serialize(),
			        error: function(request) {
			        	$.messager.alert('提示','操作失败，服务请求状态：'+request.status+' '+request.statusText+' 请检查服务是否可用！','warning');
			        },
			        success: function(data) {
						if(data.result==0){
							if(data.opType=="update"){
								updateCurrentNode(data.sysDept);	
							}else if(data.opType="insert"){
								addChildNode(data.sysDept);
							}
							usd.close();
						}else{
							$.messager.alert('提示',data.msg,'warning');
						}
			        }
			    });
		}
	}];
	usd.createButtonsInDialog(buttons);
	usd.show();
};

function showAddOrg(){
	var selectNode = currTreeNode;
	if(!selectNode){
		$.messager.alert('提示',"请选择组织！",'warning');
		return;
	}
	var usd = new CommonDialog("formAddDialog","800","500",path+"avicit/platform6/centralcontrol/sysorg/addOrgForm.jsp","添加组织");
	var buttons = [{
		text:'提交',
		id : 'formSubimt',
		//iconCls : 'icon-submit',
		handler:function(){
			 var frmId = $('#formAddDialog iframe').attr('id');
			 var frm = document.getElementById(frmId).contentWindow;
			 
			 // validate the form
			 var orgForm=frm.$('#orgAddForm');
			 if(!orgForm.form('validate'))
			 {
				 $.messager.alert('提示','请完善表单中的信息','warning');
				 return;
			 }
			 
			 $.ajax({
			        cache: true,
			        type: "POST",
			        url:'platform/cc/sysorg/saveSysOrg',
			        dataType:"json",
			        data:frm.$('#orgAddForm').serialize(),
			        error: function(request) {
			        	$.messager.alert('提示','操作失败，服务请求状态：'+request.status+' '+request.statusText+' 请检查服务是否可用！','warning');
			        },
			        success: function(data) {
						if(data.result==0){
							if(data.opType=="update"){
								updateCurrentNode(data.sysOrg);	
							}else if(data.opType="insert"){
								addChildNode(data.sysOrg);
															
							}
							usd.close();
						}else{
							$.messager.alert('提示',data.msg,'warning');
						}
			        }
			    });
		}
	}];
	usd.createButtonsInDialog(buttons);
	usd.show();
};
function showEditOrg(id)
{
	var usd = new CommonDialog("formEditDialog","800","400",path+"avicit/platform6/centralcontrol/sysorg/editOrgForm.jsp?id="+id,"编辑组织");
	var buttons = [{
		text:'提交',
		id : 'formSubimt',
		//iconCls : 'icon-submit',
		handler:function(){
			 var frmId = $('#formEditDialog iframe').attr('id');
			 var frm = document.getElementById(frmId).contentWindow;
			 
			// validate the form
			 var orgForm=frm.$('#orgEditForm');
			 if(!orgForm.form('validate'))
			 {
				 $.messager.alert('提示','请完善表单中的信息','warning');
				 return;
			 }
			 
			 $.ajax({
			        cache: true,
			        type: "POST",
			        url:'platform/cc/sysorg/saveSysOrg',
			        dataType:"json",
			        data:frm.$('#orgEditForm').serialize(),
			        error: function(request) {
			        	$.messager.alert('提示','操作失败，服务请求状态：'+request.status+' '+request.statusText+' 请检查服务是否可用！','warning');
			        },
			        success: function(data) {
						if(data.result==0){
							if(data.opType=="update"){
								updateCurrentNode(data.sysOrg);	
							}else if(data.opType="insert"){
								addChildNode(data.sysOrg);
							}
														
							usd.close();
						}else{
							$.messager.alert('提示',data.msg,'warning');
						}
			        }
			    });
		}
	}];
	usd.createButtonsInDialog(buttons);
	usd.show();
};


function setValidFlag(){
	var rows = $("#dgOrgDept").datagrid('getChecked');
	var ids = [];
	if (rows.length == 1) {
		$.messager.confirm('请确认','您确定执行该操作？',function(b){
			if(b){
				var rowData = rows[0];
			   $.ajax({
				 url:'platform/cc/sysorg/setValidFlag',
				 data : {id : rows[0].id, type: rows[0].type},
				 type : 'post',
				 dataType : 'json',
				 success : function(data){
					 if(0==data.result){
						 $("#dgOrgDept").datagrid('reload');
						 $("#dgOrgDept").datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
						 $.messager.show({title : '提示',msg : '操作成功'});
						 //是否将部门下的人员置为无效
						 if(rowData.type == "dept" && rowData.validFlag == "1"){
							 $.messager.confirm('请确认','是否将部门下的人员置为无效？',function(_flg){
								 if(_flg){
									 $.ajax({
										 url:'platform/cc/sysorg/setUserValidByDept',
										 data : {id : rowData.id},
										 type : 'post',
										 dataType : 'json',
										 success : function(_data){
											 if(0==_data.result){
												 $.messager.show({title : '提示',msg : '操作成功'});
											 }else{
												 $.messager.alert('提示',_data.msg,'warning');
											 }
										 }
									 });
								 }
							 });
						 }
					 }else{
						 $.messager.alert('提示',data.msg,'warning');
					 }
				 }
			 });
			}
		});
	}else{
		$.messager.alert('提示',"请选择一个组织或部门！",'warning');
	}
};

function importOrg()
{
	var imp = new CommonDialog("importData","700","400",'platform/excelImportController/excelimport/importOrgInfo/xls',"Excel数据导入",false,true,false);
	imp.show();
};

function importDept()
{
	var imp = new CommonDialog("importData","700","400",'platform/excelImportController/excelimport/importDeptInfo/xls',"Excel数据导入",false,true,false);
	imp.show();
};


function closeImportData(){
	$("#importData").dialog('close');
};

var _defaultOpenRoot_flg = false;
function defaultOpenRoot(node, data){
	if(_defaultOpenRoot_flg){
		return;
	}
	$("#deptTree").tree("expandAll");
	_defaultOpenRoot_flg = true;
};

function formatStatus(value,rowData,rowIndex){
	if(value==1)
		return "<span class='icon-valid'></span>";
	else 
		return "<span class='icon-invalid'></span>";	
};

function formatCode(value,rowData,rowIndex){
	if(rowData['type']=="org")
		return "<div><span class='icon-org'></span><span class='tree-title'>"+value+"</span></div>";
	else if(rowData['type']=="dept")
		return "<div><span class='icon-dept'></span><span class='tree-title'>"+value+"</span></div>";
};
function formatEdit(value,rowData,rowIndex){
	 if(rowData['type']=="org"){
		 return "<span class='icon-edit' onclick='javascript: showEditOrg(\""+ rowData.id +"\");'></span>";
	 }else{
		 return "<span class='icon-edit' onclick='javascript: showEditDept(\""+ rowData.id +"\");'></span>";
	 }
};
</script>
</head>

<body class="easyui-layout" fit="true">
<div data-options="region:'west',split:true,title:''" style="width:250px;padding:0px;">
	 <div id="toolbar" class="datagrid-toolbar">
	 	<table width="100%">
	 		<tr>
	 			<td width="100%"><input  type="text"  name="searchWord" id="searchWord"></input></td>
	 		</tr>
	 	</table>
	 </div>
	<ul id="deptTree" class="easyui-tree" data-options="
			onLoadSuccess:defaultOpenRoot,
			url:'platform/cc/sysdept/getChildOrgDeptById.json',
			loadFilter: function(data){
	            if (data.data){	
	                return data.data;
	            } else {
	                return data;
	            }
       		},
       		lines:true,
       		dataType:'json',
       		animate:true,
       		onBeforeExpand:myOnBeforeExpand,
       		onClick:deptTreeOnClickRow">数据加载中...</ul>
</div>
<div data-options="region:'center',split:true,title:''" style="padding:0px;">
	
	<div id="toolbarOrg" class="datagrid-toolbar">
			<a id="btAddOrg"  class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="showAddOrg();" href="javascript:void(0);">添加组织</a>
			<a id="btAddDept"  class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="showAddDept();" href="javascript:void(0);">添加部门</a>
			<a id="btSetValid" class="easyui-linkbutton" iconCls="icon-my-file"  plain="true" onclick="setValidFlag();" href="javascript:void(0);">有(无)效设置</a>
			<a id="btImportOrg" class="easyui-linkbutton" iconCls="icon-import"  plain="true" onclick="importOrg();" href="javascript:void(0);">组织导入</a>
			<a id="btImportDept" class="easyui-linkbutton" iconCls="icon-import"  plain="true" onclick="importDept();" href="javascript:void(0);">部门导入</a>
			<a id="btDeleteOrgDept" class="easyui-linkbutton" iconCls="icon-remove"  plain="true" onclick="deleteOrgDepts();" href="javascript:void(0);">删除</a>
		
	</div>
	
	<table id="dgOrgDept" class="easyui-datagrid"
		data-options=" 
			fit: true,
			border: false,
			rownumbers: true,
			animate: true,
			collapsible: false,
			fitColumns: true,
			autoRowHeight: false,
			toolbar:'#toolbarOrg',
			idField :'id',
			singleSelect: true,
			checkOnSelect: true,
			selectOnCheck: false,
			striped:true,
			url:'platform/cc/sysorg/getSysOrgDeptList.json'
			">
		<thead>
			<tr>
				<th data-options="field:'id', halign:'center',checkbox:true" width="220">id</th>
				<th data-options="field:'validFlag', halign:'center',align:'center',formatter:formatStatus" >状态</th>
				<th data-options="field:'code',required:true,halign:'center',align:'left',formatter:formatCode" width="220">代码</th>
				<th data-options="field:'name',required:true,halign:'center',align:'center'" width="220">名称</th>
				<th data-options="field:'tel',required:true,halign:'center',align:'left'" width="220">电话</th>
				<th data-options="field:'fax',halign:'center',align:'left'" width="220">传真</th>
				<th data-options="field:'email',halign:'center',align:'left'" width="220">邮箱</th>
				<th data-options="field:'place',halign:'center',align:'left'"  width="220">办公地点</th>
				<th data-options="field:'orderBy',halign:'center',align:'left'" width="220">排序</th>
				<th data-options="field:'_d',halign:'center',align:'center',formatter:formatEdit"  width="60">编辑</th>
			</tr>
		</thead>
	</table>
</div>
</body>
</html>