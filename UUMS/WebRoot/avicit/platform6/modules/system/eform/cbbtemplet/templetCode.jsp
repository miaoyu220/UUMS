<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>

		<div class="easyui-layout" data-options="fit:true"> 
		<div data-options="region:'north',split:true,title:''" style="height: 150px; padding:0px;">
			<table id="attrTable" class="easyui-datagrid"
				data-options=" 
					fit: true,
					border: false,
					rownumbers: true,
					animate: true,
					collapsible: false,
					fitColumns: true,
					autoRowHeight: false,
					idField :'id',
					singleSelect: true,
					checkOnSelect: true,
					selectOnCheck: false,
					
					striped:true
							
					">
				<thead>
					<tr>
						
						<th data-options="field:'type',align:'center'" width="320">类型</th>
						
					</tr>
				</thead>
			</table>
		</div>
		
		<div data-options="region:'center',split:true,title:''" style="padding:0px;">
			<table id="codeList" class="easyui-datagrid"
				data-options=" 
					fit: true,
					border: false,
					rownumbers: true,
					animate: false,
					collapsible: false,
					fitColumns: true,
					autoRowHeight: false,
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
						
						<th data-options="field:'lookupName',align:'center'" width="320">系统代码名称</th>
		        		<th data-options="field:'lookupCode',align:'center'" width="220">系统代码值</th>
						<th data-options="field:'displayOrder',align:'center'" width="120">排序</th>
						<th data-options="field:'description',align:'center'" width="220">描述</th>
						
					</tr>
				</thead>
			</table>
		</div>
		</div>
