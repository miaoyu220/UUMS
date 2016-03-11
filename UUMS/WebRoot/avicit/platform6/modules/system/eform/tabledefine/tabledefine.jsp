<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<%@page import="avicit.platform6.api.session.SessionHelper"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>菜单管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>

</head>
<%
	long timestamp = System.currentTimeMillis();
	String language =SessionHelper.getCurrentLanguageCode(request);
	String appId = SessionHelper.getApplicationId();
%>


<body class="easyui-layout" fit="true">
<div data-options="region:'west',split:true,title:'表信息维护'" style="width:550px;padding:0px;">

	 <table id="dg"  class="easyui-datagrid"  url="platform/eform/tabledefine/list.json" fit="true" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true" autoRowHeight="false" striped="true">
		<thead>
			<tr>
				<th data-options="field:'id', halign:'center',checkbox:true" width="50">id</th>
				<th data-options="field:'tableName',required:true,align:'center'"  width="80">表英文名</th>
				<th data-options="field:'tableTitle',required:true,align:'center'"  width="80">表中文名</th>
				<th data-options="field:'isVisible',required:true,align:'center'"  width="35">是否可见</th>
				<th data-options="field:'subTableName',required:true,align:'center'"  width="40">子表名</th>
				<th data-options="field:'subColumnName',required:true,align:'center'"  width="60">子表外键字段</th>
			</tr>
		</thead>
	</table>
	<!-- CRUD工具栏 -->
	<div id="toolbar">
		<table>
		<tr>
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newUser()">添加</a></td>
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editUser()">编辑</a></td>
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="deleteUser()">删除</a></td>
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="queryUser()">查询</a></td>
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="chooseUser()">模板</a></td>
		</tr>
		<tr>
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="createUser()">创建表</a></td>
		<!--  <td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="preModifyUser()">修改表</a></td>-->
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="dropUser()">废弃表</a></td>
		</tr>
		</table>
	</div>
	</div>
	
	<!-- CU表单 -->
	<div id="dlg" class="easyui-dialog" style="width: 400px; height: 380px; padding: 10px 20px" closed="true" buttons="#dlg-buttons">
		<div class="ftitle">表信息</div>
		<form id="fm" method="post" novalidate>
			<div class="fitem">
				<label>表英文名称:</label> <input name="tableName" class="easyui-textbox" required="true">
			</div>
			<div class="fitem">
				<label>表中文名称:</label> <input name="titleName" class="easyui-textbox" required="true">
			</div>
			<div class="fitem">
				<label>是否可见:</label> 
				<select name="isVisible" class="easyui-combobox" data-options="width:166,editable:false,panelHeight:'auto'">
								<option value="Y">是</option>
								<option value="N">否</option>
				</select>
			</div>
			<div class="fitem">
				<label>是否实表:</label> 
				<select name="isTrue" class="easyui-combobox" data-options="width:166,editable:false,panelHeight:'auto'">
								<option value="Y">是</option>
								<option value="N">否</option>
				</select>
			</div>
			<div class="fitem">
				<label>子表名:</label> <input name="subTableName" class="easyui-textbox" required="true">
			</div>
			<div class="fitem">
				<label>子表外键字段:</label> <input name="subColumnName" class="easyui-textbox" required="true">
			</div>
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton"  onclick="saveUser()" >保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton"  onclick="javascript:$('#dlg').dialog('close')" >返回</a>
	</div>
	
	
	
	<!-- CU表单1 -->
	<div id="dlgtable" class="easyui-dialog" style="width: 400px; height: 280px; padding: 10px 20px" closed="true" buttons="#dlgtable-buttons">
		<div class="ftitle">表信息</div>
		<form id="fmtable" method="post" novalidate>
			<div class="fitem">
				<label>表英文名称:</label> <input name="tableName" class="easyui-textbox" required="true">
			</div>
			<div class="fitem">
				<label>表中文名称:</label> <input name="titleName" class="easyui-textbox" required="true">
			</div>
		</form>
	</div>
	<div id="dlgtable-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton"  onclick="modifyUser()" >保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton"  onclick="javascript:$('#dlgtable').dialog('close')" >返回</a>
	</div>
	
	
	
	
	
	
	
	<!-- SEARCH表单 start-->
     <div id="searchdlg" class="easyui-dialog" data-options="iconCls:'icon-search',resizable:true,modal:false,buttons:'#searchBtns'"  style="width: 600px;height:250px; visible: hidden" title="搜索" closed="true" >
			<form id="searchfm" method="post">
	    		<table>
	    			<tr>
	    				<td>表英文名:</td> 
	    				<td><input id="q_tableName" name="tableName" class="easyui-textbox"  ></td>
	    			</tr>	
	    		</table>
	    	</form>
	    	<div id="searchBtns">
	    		<a class="easyui-linkbutton" plain="false" onclick="searchUser();" >查询</a>
	    		<a class="easyui-linkbutton" plain="false" onclick="javascript:$('#searchdlg').dialog('close')" >返回</a>
	    	</div>
	    </div>
	 <!-- SEARCH表单 end-->
	
	
	

<!-- 字段详细信息 -->
<div data-options="region:'center',split:true,title:'字段详细信息'" style="padding:0px;">
	
	 <table id="dg1"  class="easyui-datagrid"  url="platform/eform/tabledefine/listcolumn.json" fit="true" toolbar="#toolbar1" pagination="false" rownumbers="false" fitColumns="true" singleSelect="true" autoRowHeight="false" striped="true">
		<thead>
			<tr>
				<th data-options="field:'id', halign:'center',checkbox:true" width="50">id</th>
				<th data-options="field:'colName',required:true,align:'center'"  width="100">字段英文名</th>
				<th data-options="field:'colLabel',required:true,align:'center'"  width="100">字段中文名</th>
				<th data-options="field:'colType',required:true,align:'center'"  width="100">字段类型</th>
				<th data-options="field:'colLength',required:true,align:'center'"  width="100">字段长度</th>
				<th data-options="field:'colIsSearch',required:true,align:'center'"  width="100">是否查询字段</th>
				<th data-options="field:'colIsEdit',required:true,align:'center'"  width="100">是否编辑</th>
				<th data-options="field:'colIsTabVisible',required:true,align:'center'"  width="100">是否列表显示</th>
			</tr>
		</thead>
	</table>
	<!-- CRUD工具栏 -->
	<div id="toolbar1">
		<table>
		<tr>
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newUser1()">添加</a></td>
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editUser1()">编辑</a></td>
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="deleteUser1()">删除</a></td>
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="newlookup()">关联通用代码</a></td>
		</tr>
		<tr>
		<!--  <td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="createUser()">修改字段</a></td>
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="dropUser()">废弃字段</a></td>-->
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newIndex()">创建索引</a></td>
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="dropIndex()">废弃索引</a></td>
		</tr>
		</table>
	</div>
	
	<!-- CU表单 -->
	<div id="dlg1" class="easyui-dialog" style="width: 600px; height: 450px; padding: 10px 20px" closed="true" buttons="#dlg-buttons1">
		<div class="ftitle">字段信息</div>
		<form id="fm1" method="post" novalidate>
		<table>
		<tr>
		<th><label>字段英文名称:</label></th>
		<td><input name="colName" class="easyui-textbox" required="true"></td>
		<th><label>字段中文名称:</label></th>
		<td><input name="colLabel" class="easyui-textbox" required="true"></td>
		</tr>
		<tr>
		<th><label>字段类型:</label> </th>
		<td><select name="colType" class="easyui-combobox" data-options="width:166,editable:false,panelHeight:'auto'">
								<option value="DATE">日期时间</option>
								<option value="VARCHAR2">字符串</option>
								<option value="NUMBER">整型</option>
				</select>
		</td>
		<th><label>字段长度:</label> </th>
		<td><input name="colLength" class="easyui-textbox" required="true"></td>
		</tr>
		<tr>
		<th><label>是否必填:</label> </th>
		<td><select name="colIsMust" class="easyui-combobox" data-options="width:166,editable:false,panelHeight:'auto'">
								<option value="Y"  selected="selected">是</option>
								<option value="N">否</option>
				</select></td>
		<th><label>是否显示:</label> </th>
		<td><select name="colIsVisible" class="easyui-combobox" data-options="width:166,editable:false,panelHeight:'auto'"  >
								<option value="Y" >是</option>
								<option value="N">否</option> 
				</select></td>
		</tr>
		<tr>
		<th><label>是否查询字段:</label> </th>
		<td><select name="colIsSearch" class="easyui-combobox" data-options="width:166,editable:false,panelHeight:'auto'">
								<option value="Y"   selected="selected">是</option>
								<option value="N">否</option>
				</select></td>
		<th><label>是否编辑字段:</label> </th>
		<td><select name="colIsEdit" class="easyui-combobox" data-options="width:166,editable:false,panelHeight:'auto'">
								<option value="Y"   >是</option>
								<option value="N">否</option>
				</select></td>
		</tr>
		<tr>
		<th><label>是否列表显示:</label> </th>
		<td><select id="colIsTabVisible"  name="colIsTabVisible" class="easyui-combobox" data-options="width:166,editable:false,panelHeight:'auto'">
								<option value="Y"   >是</option>
								<option value="N">否</option>
				</select></td>
		<th><label>是否详细显示:</label> </th>
		<td><select name="colIsDetail" class="easyui-combobox" data-options="width:166,editable:false,panelHeight:'auto'">
								<option value="Y"   >是</option>
								<option value="N">否</option>
				</select></td>
		</tr>
			<tr>
				<th><label>下拉类型:</label> </th>
				<td><select name="colDropdownType" class="easyui-combobox" data-options="width:166,editable:false,panelHeight:'auto'"   value="'Y'">
								<option value="0">无</option>
								<option value="1">参选</option>
								<option value="2">只选</option>
								<option value="3">选择</option>
				</select>
				</td>
				<th><label>生成方式:</label> </th>
				<td><select name="colGeneMethod" class="easyui-combobox" data-options="width:166,editable:false,panelHeight:'auto'">
								<option value="0"   >空</option>
								<option value="1">默认值</option>
								<option value="2">序列</option>
								<option value="3">顺带</option>
								<option value="4">组合项</option>
								<option value="5">统计生成</option>
								<option value="6">选择</option>
				</select>
				</td>
			</tr>
			<tr>
				<th><label>生成规则英文:</label></th>
				<td><input name="colRuleName" class="easyui-textbox" required="true"></td>
				<th><label>生成规则中文:</label></th>
				<td><input name="colRuleTitle" class="easyui-textbox" required="true"></td>
			</tr>
			
			<tr>
				<th><label>路径:</label></th>
				<td><input name="customPath" class="easyui-textbox" required="true"></td>
				<th><label>说明:</label> </th>
				<td><input name="remark" class="easyui-textbox" required="true"></td>
			</tr>
			
			<tr>
				<th><label>生成方式规则:</label></th>
				<td><input name="colGeneMethodRule" class="easyui-textbox" required="true"></td>
				<th><label>显示格式:</label> </th>
				<td><select name="colShowFormat" class="easyui-combobox" data-options="width:166,editable:false,panelHeight:'auto'">
								<option value="0"   >无</option>
								<option value="1">日期</option>
								<option value="2">金额</option>
				</select></td>
			</tr>
			<tr>
			<th><label>是否可见:</label> </th>
			<td><select name="colIsDisplay" class="easyui-combobox" data-options="width:166,editable:false,panelHeight:'auto'">
								<option value="Y">是</option>
								<option value="N">否</option>
				</select></td>
			<th></th>
			<td></td>
			</tr>	
			</table>	
		</form>
	</div>
	<div id="dlg-buttons1">
		<a href="javascript:void(0)" class="easyui-linkbutton"  onclick="saveUser1()" >保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton"  onclick="javascript:$('#dlg1').dialog('close')" >返回</a>
	</div>
	
	
	
	
	<!-- 索引表单 -->
	<div id="dlgindex" class="easyui-dialog" style="width: 400px; height: 280px; padding: 10px 20px" closed="true" buttons="#dlgindex-buttons">
		<div class="ftitle">表信息</div>
		<form id="fmindex" method="post" novalidate>
			<div class="fitem">
				<label>索引名称:</label> <input name="indexName" class="easyui-textbox" required="true">
			</div>
		</form>
	</div>
	<div id="dlgindex-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton"  onclick="saveIndex()" >保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton"  onclick="javascript:$('#dlgindex').dialog('close')" >返回</a>
	</div>
	
</div>

	
<script type="text/javascript">
var baseurl = '<%=request.getContextPath()%>';
var url;


$('#dg').datagrid({
	onClickRow:function(index,data)
	{
		var row=$('#dg').datagrid('getSelected');
		var value=$('#q_userName').val();
		if(row){
			var tableId=row.id;
			url = 'platform/eform/tabledefine/listcolumn.html';
			$.post(url, {
				tableId:tableId
			}, function(result) {
				$('#dg1').datagrid('loadData',result);
			}, 'json');
		}
	}
})


function queryUser() {
			var tableId=$('#tableId').val();
			$('#searchdlg').dialog('open');
			$('#searchfm').form('clear');
}



function searchUser() {
	var value=$('#q_tableName').val();
	url = 'platform/eform/tabledefine/list.json';
	$.post(url, {
		tableName : value
	}, function(result) {
		$('#dg').datagrid('loadData',result);
		$('#searchdlg').dialog('close'); 
	}, 'json');
}

function newUser() {
	$('#dlg').dialog('open').dialog('setTitle', '添加表');
	$('#fm').form('clear');
	url = 'platform/eform/tabledefine/add.json';
}

function editUser() {
	var row = $('#dg').datagrid('getSelected');
	if (row) {
		$('#dlg').dialog('open').dialog('setTitle', '编辑表');
		$('#fm').form('load', row);
		url = 'platform/eform/tabledefine/edit.json?id=' + row.id;
	}
}

function saveUser() {
	$('#fm').form('submit', {
		url : url,
		onSubmit : function() {
			return $(this).form('validate');
		},
		success : function(result) {
			var result = eval('(' + result + ')');
			if (result.errorMsg) {
				$.messager.show({
					title : 'Error',
					msg : result.errorMsg
				});
			} else {
				$('#dlg').dialog('close'); 
				$('#dg').datagrid('reload'); 
			}
		}
	});
}

function deleteUser() {
	url='platform/eform/tabledefine/delete.json';
	var row = $('#dg').datagrid('getSelected');
	if (row) {
		$.messager.confirm('',
				'确认删除吗?',
				function(r) {
					if (r) {
						$.post(url, {
							id : row.id
						}, function(result) {
							if (result.success) {
								$('#dg').datagrid('reload');
							} else {
								$.messager.show({
									title : 'Error',
									msg : result.errorMsg
								});
							}
						}, 'json');
					}
		});
	}
}



//
function preModifyUser() {
	var row = $('#dg').datagrid('getSelected');
	if (row) {
		$('#dlgtable').dialog('open').dialog('setTitle', '修改表');
		$('#fm').form('load', row);
		url = 'platform/eform/tabledefine/modifytable.json?id=' + row.id;
	}
}


function modifyUser() {
	$('#fmtable').form('submit', {
		url : url,
		onSubmit : function() {
			return $(this).form('validate');
		},
		success : function(result) {
			var result = eval('(' + result + ')');
			if (result.errorMsg) {
				$.messager.show({
					title : 'Error',
					msg : result.errorMsg
				});
			} else {
				$('#dlgtable').dialog('close'); 
				$('#dg').datagrid('reload'); 
			}
		}
	});
}


function createUser() {
	url='platform/eform/tabledefine/createtable.json';
	var row = $('#dg').datagrid('getSelected');
	if (row) {
		$.messager.confirm('',
				'确认创建表吗?',
				function(r) {
					if (r) {
						$.post(url, {
							id : row.id
						}, function(result) {
							if (result.success) {
								$('#dg').datagrid('reload');
							} else {
								$.messager.show({
									title : 'Error',
									msg : result.errorMsg
								});
							}
						}, 'json');
					}
		});
	}
}


function dropUser() {
	url='platform/eform/tabledefine/droptable.json';
	var row = $('#dg').datagrid('getSelected');
	if (row) {
		$.messager.confirm('',
				'确认废弃表吗?',
				function(r) {
					if (r) {
						$.post(url, {
							id : row.id
						}, function(result) {
							if (result.success) {
								$('#dg').datagrid('reload');
							} else {
								$.messager.show({
									title : 'Error',
									msg : result.errorMsg
								});
							}
						}, 'json');
					}
		});
	}
}









function newUser1() {
	
	var row = $('#dg').datagrid('getSelected');
	if (row) {
		$('#dlg1').dialog('open').dialog('setTitle', '添加字段');
		$('#fm1').form('clear');
		$('#fm1').form('reset');
		//$("#aaa input[type='text']")
		url = 'platform/eform/tabledefine/addcolumn.json?tableId='+ row.id;;
	}else{
		alert('请选择表信息!');
	}
	
	
}

function editUser1() {
	var row = $('#dg1').datagrid('getSelected');
	if (row) {
		$('#dlg1').dialog('open').dialog('setTitle', '编辑字段');
		$('#fm1').form('load', row);
		url = 'platform/eform/tabledefine/editcolumn.json?id=' + row.id;
	}
}

function saveUser1() {
	$('#fm1').form('submit', {
		url : url,
		onSubmit : function() {
			return $(this).form('validate');
		},
		success : function(result) {
			var result = eval('(' + result + ')');
			if (result.errorMsg) {
				$.messager.show({
					title : 'Error',
					msg : result.errorMsg
				});
			} else {
				$('#dlg1').dialog('close'); 
				
				var row=$('#dg').datagrid('getSelected');
				if(row){
					var tableId=row.id;
					url = 'platform/eform/tabledefine/listcolumn.html';
					$.post(url, {
						tableId:tableId
					}, function(result) {
						$('#dg1').datagrid('loadData',result);
					}, 'json');
				}
				
				
			}
		}
	});
}

function deleteUser1() {
	url='platform/eform/tabledefine/deletecolumn.json';
	var row = $('#dg1').datagrid('getSelected');
	if (row) {
		$.messager.confirm('',
				'确认删除吗?',
				function(r) {
					if (r) {
						$.post(url, {
							id : row.id
						}, function(result) {
							if (result.success) {
								
								var row=$('#dg').datagrid('getSelected');
								if(row){
									var tableId=row.id;
									url = 'platform/eform/tabledefine/listcolumn.html';
									$.post(url, {
										tableId:tableId
									}, function(result) {
										$('#dg1').datagrid('loadData',result);
									}, 'json');
								}
								
							} else {
								$.messager.show({
									title : 'Error',
									msg : result.errorMsg
								});
							}
						}, 'json');
					}
		});
	}
}


function newIndex() {
	var row = $('#dg1').datagrid('getSelected');
	if (row) {
		$('#dlgindex').dialog('open').dialog('setTitle', '添加索引');
		$('#fmindex').form('clear');
		url = 'platform/eform/tabledefine/addindex.json?id='+row.id;
	}
}


function  newlookup(){
	var row = $('#dg1').datagrid('getSelected');
	if (row) {
		var columnId=row.id;
		url = 'platform/eform/tabledefine/newlookup?columnId='+columnId;
		var  dlg = new CommonDialog("newlookup","800","500",url,"添加",false,true,false);
		dlg.show();
	}
}



function saveIndex() {
	$('#fmindex').form('submit', {
		url : url,
		onSubmit : function() {
			return $(this).form('validate');
		},
		success : function(result) {
			var result = eval('(' + result + ')');
			if (result.errorMsg) {
				$.messager.show({
					title : 'Error',
					msg : result.errorMsg
				});
			} else {
				$('#dlgindex').dialog('close'); 
			}
		}
	});
}


function dropIndex() {
	
	url='platform/eform/tabledefine/dropindex.json';
	var row = $('#dg1').datagrid('getSelected');
	if (row) {
		$.messager.confirm('',
				'确认废弃索引吗?',
				function(r) {
					if (r) {
						$.post(url, {
							id : row.id
						}, function(result) {
							if (result.success) {
								$('#dg').datagrid('reload');
							} else {
								$.messager.show({
									title : 'Error',
									msg : result.errorMsg
								});
							}
						}, 'json');
					}
		});
	}
	
}



function chooseUser(){
	var row = $('#dg').datagrid('getSelected');
	if (row) {
		var tableId=row.id;
		url = 'platform/eform/tabledefine/newtemplet?tableId='+tableId;
		var  dlg = new CommonDialog("newtemplet","800","500",url,"添加",false,true,false);
		dlg.show();
	}
}


function dlg_close(id){
	$('#'+id).dialog('close');
}

function dg_reload(id){
$('#'+id).datagrid('reload'); 
}

$(function(){
	
})




</script>

<style type="text/css">
#fm {
	margin: 0;
	padding: 10px 30px;
}

.ftitle {
	font-size: 14px;
	font-weight: bold;
	padding: 5px 0;
	margin-bottom: 10px;
	border-bottom: 1px solid #ccc;
}

.fitem {
	margin-bottom: 5px;
}

.fitem label {
	display: inline-block;
	width: 80px;
}

.fitem input {
	width: 160px;
}
</style>

</body>
</html>