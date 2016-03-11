<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>系统参数配置</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">

<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<script src="avicit/platform6/centralcontrol/sysapp/js/SysAppTree.js" type="text/javascript"></script>
<script src="avicit/platform6/centralcontrol/sysprofile/js/SysProfile.js" type="text/javascript"></script>
<script src="avicit/platform6/centralcontrol/sysprofile/js/SysProfileValue.js" type="text/javascript"></script>
</head>
<body class="easyui-layout" fit="true">
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
		<div data-options="region:'center',title:'配置文件'" style="background:#ffffff;height:0px;padding:0px;overflow:hidden;">
			<div id="toolbarSysPro" class="datagrid-toolbar">
			 	<table>
			 		<tr>
						<td><a class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="sysPro.insert();" href="javascript:void(0);">添加</a></td>
						<td><a class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="sysPro.modify();" href="javascript:void(0);">编辑</a></td>
						<td><a class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="sysPro.del();" href="javascript:void(0);">删除</a></td>
						<td><a class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="sysPro.openSearchForm();" href="javascript:void(0);">查询</a></td>
					</tr>
			 	</table>
		 	</div>
		 	<table id="dgPro" 
				data-options="
					fit: true,
					border: false,
					rownumbers: true,
					animate: true,
					collapsible: false,
					fitColumns: true,
					autoRowHeight: false,
					toolbar:'#toolbarSysPro',
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
						<th data-options="field:'profileOptionCode', required:true,align:'center'" width="220">配置文件代码</th>
						<th data-options="field:'profileOptionName',required:true,align:'center'" width="220">配置文件名称</th>
						<th data-options="field:'usageModifier',align:'center',formatter:formatModifier"  width="120">使用级别</th>
						<th data-options="field:'sysApplicationId',formatter:formatSysApp,align:'center'"  width="220">应用程序名称</th>
						<th data-options="field:'validFlag',formatter:formatValid,align:'center'"  width="100">有效标识</th>
					</tr>
				</thead>
			</table>
		</div>
		<div data-options="region:'east',title:'配置文件值'" style="width:450px;background:#f5fafe;">
			<div id="toolbarSysProValue" class="datagrid-toolbar">
			 	<table>
			 		<tr>
						<td><a class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="sysProVal.insert();" href="javascript:void(0);">添加</a></td>
						<td><a class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="sysProVal.save(sysPro._selectId);" href="javascript:void(0);">保存</a></td>
						<td><a class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="sysProVal.del();" href="javascript:void(0);">删除</a></td>
					</tr>
			 	</table>
		 	</div>
			<table id='dgProValue' 
	       	 		data-options="
	        		fit: true,
					border: false,
					rownumbers: true,
					animate: true,
					collapsible: false,
					fitColumns: true,
					autoRowHeight: false,
					idField :'id',
					toolbar:'#toolbarSysProValue',
					singleSelect: true,
					checkOnSelect: true,
					selectOnCheck: false,
					method:'get',
					striped:true">
			    <thead>   
			        <tr> 
			        	<th data-options="field:'id', halign:'center',checkbox:true" width="220">id</th>
						<th data-options="field:'profileLevelCode',align:'center',formatter:formatLevel" 
							editor="{type:'combobox',options:{panelHeight:'auto',editable:false,valueField:'key',textField:'value',onHidePanel:function(){sysProVal.endEditing();}}}" width="220"><font color="red">*</font>级别 </th>
						<th data-options="field:'levelValue',align:'center',hidden:true" width="220">&nbps;</th>
						<th data-options="field:'levelValueName',align:'center',styler:function(value,row,index){
								return 'cursor:pointer;';
							}" width="220"><font color="red">*</font>级别值</th>
						<th data-options="field:'profileOptionValue',align:'center',styler:function(value,row,index){
								return sysProVal.styleOptionValue();
							},formatter:function(value,row,index){
								return sysProVal.formateOptionValue(value,row,index);
							}" editor="{type:'text'}" width="220">配置文件值</th>
			        </tr>   
			    </thead>   
			</table>  
		</div>
 </div>
 </div>
	<!--*****************************搜索*********************************  -->
	<div id="searchDialog" data-options="iconCls:'icon-search',resizable:true,modal:false,buttons:'#searchBtns'" style="width: 600px;height:200px;display: none;">
		<form id="form1">
    		<table style="padding-top: 10px;">
    			<tr>
    				<td>配置文件代码:</td>
    				<td><input class="easyui-validatebox" type="text" name="filter-LIKE-PROFILE_OPTION_CODE"/></td>
    				<td>配置文件名称:</td>
    				<td><input class="easyui-validatebox" type="text" name="filter-LIKE-PROFILE_OPTION_NAME"/></td>
    			</tr>
    		</table>
    	</form>
    	<div id="searchBtns">
    		<a class="easyui-linkbutton" plain="false" onclick="sysPro.searchData();" href="javascript:void(0);">查询</a>
    		<a class="easyui-linkbutton"  plain="false" onclick="sysPro.clearData();" href="javascript:void(0);">清空</a>
    		<a class="easyui-linkbutton" plain="false" onclick="sysPro.hideSearchForm();" href="javascript:void(0);">返回</a>
    	</div>
  </div>
	<script type="text/javascript">
		var sysAppTree;
		var sysPro;
		var sysProVal;
		$(function(){
			sysAppTree = new SysAppTree('apps','searchApp',APP_.PUBLIC);
			sysAppTree.setOnLoadSuccess(function(){
				sysPro= new SysProfile('dgPro','${url}','searchDialog','form1');
				sysPro.setOnLoadSuccess(function(){
					sysProVal = new SysProfileValue('dgProValue','${subUrl}'); 
				});
				sysPro.setOnSelectRow(function(rowIndex, rowData,id){
					sysProVal.loadById(id);
				});
				
			});
			sysAppTree.setOnSelect(function(_sysAppTree,node){
				sysPro.loadByAppId(node.id);
			});
			
			sysAppTree.init();
			
		});
		//格式化信息
		
		//格式化信息
		function formatSysApp(value){
			return sysPro.formatSysApp(value);
		}
		
		function formatLevel(value){
			return sysProVal.formatLevelCode(value);
		};
		function formatValid(value){
			return Platform6.fn.lookup.formatLookupType(value,sysPro.VALIDATION);
		};
		function formatModifier(value){
			return Platform6.fn.lookup.formatLookupType(value,sysPro.MODIFIER);
		};
	</script>
</body>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
</html>