<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>

<div id="fieldTool" class="datagrid-toolbar" style="display: block;">
				<table class="tableForm" id="roleSearchForm" width='100%'>
					<tr>
						<td >
							<a class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="templetField.insert(appId);" href="javascript:void(0);">添加</a>
							<a class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="templetField.modify(appId);" href="javascript:void(0);">编辑</a>
							<a class="easyui-linkbutton" iconCls="icon-setting" plain="true" onclick="templetField.openSyslookup(appId);" href="javascript:void(0);">添加通用代码</a>
							<a class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="templetField.delLookup();" href="javascript:void(0);">删除通用代码</a>
							<a class="easyui-linkbutton" iconCls="icon-setting" plain="true" onclick="templetField.import(appId);" href="javascript:void(0);">导入</a>
						    <a class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="templetField.del();" href="javascript:void(0);">删除</a>
						    <a class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="templetField.openSearchForm();" href="javascript:void(0);">查询</a>
						</td>
					</tr>
				</table>
			</div>
			<table id="fieldList" class="easyui-datagrid"
				data-options=" 
					fit: true,
					border: false,
					rownumbers: true,
					animate: true,
					collapsible: false,
					fitColumns: true,
					autoRowHeight: false,
					toolbar:'#fieldTool',
					idField :'id',
					singleSelect: true,
					checkOnSelect: true,
					selectOnCheck: false,
					
					pagination:true,
					pageSize:dataOptions.pageSize,
					pageList:dataOptions.pageList,
					
					striped:true
							
					">
				<thead>
					<tr>
						<th data-options="field:'id', halign:'center',checkbox:true" width="220">id</th>
						
						<th data-options="field:'colLabel',required:true,halign:'center',align:'left'" editor="{type:'text'}" width="220">字段中文名</th>
						<th data-options="field:'colName',required:true,halign:'center',align:'left'" editor="{type:'text'}" width="220">字段名</th>
						
						<th data-options="field:'colType',halign:'center',align:'left'" editor="{type:'combobox',options:{required:true,panelHeight:'auto',editable:false,valueField:'lookupCode',textField:'lookupName'}}"  width="220">字段类型</th>
						<th data-options="field:'colLength',halign:'center',align:'left'" editor="{type:'text'}"  width="220">长度</th>
						<th data-options="field:'colDecimal',halign:'center',align:'left'" editor="{type:'text'}"  width="220">小数位数</th>
						
					</tr>
				</thead>
			</table>
			<!--*****************************搜索*********************************  -->
	<div id="searchDialog" data-options="iconCls:'icon-search',resizable:true,modal:false,buttons:'#searchBtns'" style="width: 600px;height:200px;display: none;">
		<form id="form1">
    		<table style="padding-top: 10px;">
    			<tr>
    				<td>字段名:</td>
    				<td><input class="easyui-validatebox"  style="width: 151px;" type="text" name="colName"/></td>
    				<td>字段中文名:</td>
    				<td><input class="easyui-validatebox" style="width: 151px;" type="text" name="colLabel"/></td>
    			</tr>
    			
    		</table>
    	</form>
    	<div id="searchBtns">
    		<a class="easyui-linkbutton" plain="false" onclick="templetField.searchData();" href="javascript:void(0);">查询</a>
    		<a class="easyui-linkbutton" plain="false" onclick="templetField.clearData();" href="javascript:void(0);">清空</a>
    		<a class="easyui-linkbutton" plain="false" onclick="templetField.hideSearchForm();" href="javascript:void(0);">返回</a>
    	</div>
  </div>
