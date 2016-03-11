<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>自编代码规则管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<script type="text/javascript">
/**
 * 初始化数据
 */
$(function(){
	/*初始化查询框*/
	var p = $('#searchButton').offset();
	$('#searchDialog').dialog({
		left: p.left,
		top: p.top + $('#searchButton').height()
	});
	var searchForm = $('#formSearch').form();
	searchForm.find('input').on('keyup',function(e){
		if(e.keyCode == 13){
			searchData();
		}
	});
});

/**
 * 打开查询框
 */
function openSearchForm(){
	$('#searchDialog').dialog('open',true);
}
function openCodingSystem(){
	parent.addTab?parent.addTab('编码体系管理','avicit/platform6/modules/system/syscodingsystem/sysCodingSystemManager.jsp','static/css/platform/themes/default/index/style/images/folder_lightbulb.png','sysmgr','0px 0px'):window.open('avicit/platform6/modules/system/syscodingsystem/sysCodingSystemManager.jsp', '_self');
}
function openCodingSelect(){
	parent.addTab?parent.addTab('编码使用查询','avicit/platform6/modules/system/syscodingselect/sysCodingSelectManager.jsp','static/css/platform/themes/default/index/style/images/folder_lightbulb.png','search','0px 0px'):window.open('avicit/platform6/modules/system/syscodingselect/sysCodingSelectManager.jsp', '_self');
}
/**
 * 隐藏查询框
 */
function hideSearch(){
	$('#searchDialog').dialog('close',true);
}

/**
 * 清空查询条件
 */
function clearData(){
	$('#formSearch').find('input').val('');
};

/**
 * 查询数据
 */
function searchData(){
	searchRule();
}

/**
 * 查询数据
 */
function searchRule(){
	var param = {
		searchCodingName : $('#searchCodingName').val(),
		searchCriterionCode : $('#searchCriterionCode').val(),
		searchStatus: $('#searchStatus').combobox('getValue')
	}; 
	$('#datagrid1').datagrid('reload', param);
}

/**
 * 重置
 */
function clearSearch(){
	$('#searchCodingName').val('');
	$('#searchCriterionCode').val('');
	$('#searchStatus').combobox('reset');
}

/**
 * 增加规则
 */
function addRule(){
	var usd = new CommonDialog("addCodingRuleDialog","800","400","avicit/platform6/modules/system/syscodingrule/sysCodingRuleAdd.jsp","添加代码规则",true);
	var buttons = [{
		text:'保存',
		id : 'formSubimt',
		iconCls : '',
		handler:function(){
			$(this).linkbutton('disable');
			var frmId = $('#addCodingRuleDialog iframe').attr('id');
			var frm = document.getElementById(frmId).contentWindow;
			var tabs = frm.$('#tabRuleSegment').tabs('tabs');
			var tabsLength = tabs.length;
			var r = frm.$('#formRuleBase').form('validate');
			if(!r){
				$.messager.show({title:'提示',msg :'基本设置必填字段未填写！'});
				$(this).linkbutton('enable');
				return false;
			}
			
			var signImage = frm.$('#signImage').val();
			if(signImage == ''){
				$.messager.show({title:'提示',msg :'请选择规则标志图片！'});
				$(this).linkbutton('enable');
				return false;
			}
			
			for(var i = 1; i <= tabsLength; i++){
				var r = frm.$('#formRuleSegment_' + i).form('validate');
				if(!r){
					$.messager.show({title:'提示',msg :'码段'+ i +'必填字段未填写！'});
					$(this).linkbutton('enable');
					return false;
				}
			}
			//验证流水码段个数
			var serialNumber = 0;
			for(var i = 1; i <= tabsLength; i++){
				var ruleSegment = frm.$('#formRuleSegment_' + i).serializeArray();
				var ruleSegmentJson = convertToJson(ruleSegment);
				if(ruleSegmentJson.segmentType == '3'){
					serialNumber++;
				}
			}
			if(serialNumber > 1){
				$.messager.show({title:'提示',msg :'类型是流水码的码段最多只能有一个！'});
				$(this).linkbutton('enable');
				return false;
			}
			
			//基本设置
			var ruleBase = frm.$('#formRuleBase').serializeArray();
			var ruleBaseJson = convertToJson(ruleBase);
			ruleBase = JSON.stringify(ruleBaseJson);
			
			//编码规则设置
			var ruleSegments = new Array();
			for(var i = 1; i <= tabsLength; i++){
				var ruleSegment = frm.$('#formRuleSegment_' + i).serializeArray();
				var ruleSegmentJson = convertToJson(ruleSegment);
				ruleSegments.push(ruleSegmentJson);
			}
			ruleSegments = JSON.stringify(ruleSegments);
			var param = {
				ruleBase: ruleBase,
				ruleSegments: ruleSegments
			};
			
			$.ajax({
				url : 'platform/sysCodingRuleController/addRule',
				data : param,
				type : 'post',
				dataType : 'json',
				success : function(result) {
					if (result.flag == 'success') {
						var baseId = result.baseId;
						usd.close();
						$("#datagrid1").datagrid('reload');
						$.messager.show({title:'提示',msg :'保存成功！'});
					} else {
						if(result.isExistsName == 'true'){
							$.messager.show({title:'提示',msg :'保存失败！规则名称已存在。'});
						}else{
							$.messager.show({title:'提示',msg :'保存失败！'});
						}
						$('#formSubimt').linkbutton('enable');
					}
				}
			});
		}
	}];
	usd.createButtonsInDialog(buttons);
	usd.show();
}

/**
 * 更新规则
 */
function updateRule(){
	var checked = $('#datagrid1').datagrid('getChecked');
	if(checked.length == 0) {
		$.messager.show({title : '提示',msg : "请选择记录!"});
		return false;
	}else if(checked.length > 1) {
		$.messager.show({title : '提示',msg : "请选择一条记录!"});
		return false;
	}
	
	var status = checked[0].status;
	if(status != '1'){
		$.messager.show({title : '提示',msg : "状态不是编制中的不能编辑!"});
		return false;
	}
	
	var id = checked[0].id;
	
	var usd = new CommonDialog("updateCodingRuleDialog","800","400","platform/sysCodingRuleController/toUpdateRuleJsp.jsp?id="+id,"编辑代码规则",true);
	var buttons = [{
		text:'保存',
		id : 'formSubimt',
		iconCls : '',
		handler:function(){
			$(this).linkbutton('disable');
			var frmId = $('#updateCodingRuleDialog iframe').attr('id');
			var frm = document.getElementById(frmId).contentWindow;
			var tabs = frm.$('#tabRuleSegment').tabs('tabs');
			var tabsLength = tabs.length;
			var r = frm.$('#formRuleBase').form('validate');
			if(!r){
				$.messager.show({title:'提示',msg :'基本设置必填字段未填写！'});
				$(this).linkbutton('enable');
				return false;
			}
			
			var signImage = frm.$('#signImage').val();
			if(signImage == ''){
				$.messager.show({title:'提示',msg :'请选择规则标志图片！'});
				$(this).linkbutton('enable');
				return false;
			}
			
			for(var i = 1; i <= tabsLength; i++){
				var r = frm.$('#formRuleSegment_' + i).form('validate');
				if(!r){
					$.messager.show({title:'提示',msg :'码段'+ i +'必填字段未填写！'});
					$(this).linkbutton('enable');
					return false;
				}
			}
			//验证流水码段个数
			var serialNumber = 0;
			for(var i = 1; i <= tabsLength; i++){
				var ruleSegment = frm.$('#formRuleSegment_' + i).serializeArray();
				var ruleSegmentJson = convertToJson(ruleSegment);
				if(ruleSegmentJson.segmentType == '3'){
					serialNumber++;
				}
			}
			if(serialNumber > 1){
				$.messager.show({title:'提示',msg :'类型是流水码的码段最多只能有一个！'});
				$(this).linkbutton('enable');
				return false;
			}
			
			//基本设置
			var ruleBase = frm.$('#formRuleBase').serializeArray();
			var ruleBaseJson = convertToJson(ruleBase);
			ruleBase = JSON.stringify(ruleBaseJson);
			
			//编码规则设置
			var ruleSegments = new Array();
			for(var i = 1; i <= tabsLength; i++){
				var ruleSegment = frm.$('#formRuleSegment_' + i).serializeArray();
				var ruleSegmentJson = convertToJson(ruleSegment);
				ruleSegments.push(ruleSegmentJson);
			}
			ruleSegments = JSON.stringify(ruleSegments);
			var param = {
				ruleBase: ruleBase,
				ruleSegments: ruleSegments
			};
			
			$.ajax({
				url : 'platform/sysCodingRuleController/updateRule',
				data : param,
				type : 'post',
				dataType : 'json',
				success : function(result) {
					if (result.flag == 'success') {
						usd.close();
						$("#datagrid1").datagrid('reload');
						$.messager.show({title:'提示',msg :'保存成功！'});
					} else {
						if(result.isPublished == 'true'){
							$.messager.show({title:'提示',msg :'保存失败！已经发布的数据不能编辑'});
						}else if(result.isExistsName == 'true'){
							$.messager.show({title:'提示',msg :'保存失败！规则名称已存在。'});
						}else{
							$.messager.show({title:'提示',msg :'保存失败！'});
						}
						$('#formSubimt').linkbutton('enable');
					}
				}
			});
		}
	}];
	usd.createButtonsInDialog(buttons);
	usd.show();
}

/**
 * 复制规则
 */
function copyRule(){
	var checked = $('#datagrid1').datagrid('getChecked');
	if(checked.length == 0) {
		$.messager.show({title : '提示',msg : "请选择记录!"});
		return false;
	}else if(checked.length > 1) {
		$.messager.show({title : '提示',msg : "请选择一条记录!"});
		return false;
	}
	
	var id = checked[0].id;
	
	var usd = new CommonDialog("copyCodingRuleDialog","800","400","platform/sysCodingRuleController/toUpdateRuleJsp.jsp?id="+ id +"&isCopy=true","复制代码规则",true);
	var buttons = [{
		text:'保存',
		id : 'formSubimt',
		iconCls : '',
		handler:function(){
			$(this).linkbutton('disable');
			var frmId = $('#copyCodingRuleDialog iframe').attr('id');
			var frm = document.getElementById(frmId).contentWindow;
			var tabs = frm.$('#tabRuleSegment').tabs('tabs');
			var tabsLength = tabs.length;
			var r = frm.$('#formRuleBase').form('validate');
			if(!r){
				$.messager.show({title:'提示',msg :'基本设置必填字段未填写！'});
				$(this).linkbutton('enable');
				return false;
			}
			
			var signImage = frm.$('#signImage').val();
			if(signImage == ''){
				$.messager.show({title:'提示',msg :'请选择规则标志图片！'});
				$(this).linkbutton('enable');
				return false;
			}
			
			for(var i = 1; i <= tabsLength; i++){
				var r = frm.$('#formRuleSegment_' + i).form('validate');
				if(!r){
					$.messager.show({title:'提示',msg :'码段'+ i +'必填字段未填写！'});
					$(this).linkbutton('enable');
					return false;
				}
			}
			//验证流水码段个数
			var serialNumber = 0;
			for(var i = 1; i <= tabsLength; i++){
				var ruleSegment = frm.$('#formRuleSegment_' + i).serializeArray();
				var ruleSegmentJson = convertToJson(ruleSegment);
				if(ruleSegmentJson.segmentType == '3'){
					serialNumber++;
				}
			}
			if(serialNumber > 1){
				$.messager.show({title:'提示',msg :'类型是流水码的码段最多只能有一个！'});
				$(this).linkbutton('enable');
				return false;
			}
			
			//基本设置
			var ruleBase = frm.$('#formRuleBase').serializeArray();
			var ruleBaseJson = convertToJson(ruleBase);
			ruleBase = JSON.stringify(ruleBaseJson);
			
			//编码规则设置
			var ruleSegments = new Array();
			for(var i = 1; i <= tabsLength; i++){
				var ruleSegment = frm.$('#formRuleSegment_' + i).serializeArray();
				var ruleSegmentJson = convertToJson(ruleSegment);
				ruleSegments.push(ruleSegmentJson);
			}
			ruleSegments = JSON.stringify(ruleSegments);
			var param = {
				ruleBase: ruleBase,
				ruleSegments: ruleSegments
			};

			$.ajax({
				url : 'platform/sysCodingRuleController/copyRule',
				data : param,
				type : 'post',
				dataType : 'json',
				success : function(result) {
					if (result.flag == 'success') {
						var baseId = result.baseId;
						usd.close();
						$("#datagrid1").datagrid('reload');
						$.messager.show({title:'提示',msg :'保存成功！'});
					} else {
						if(result.isExistsName == 'true'){
							$.messager.show({title:'提示',msg :'保存失败！规则名称已存在。'});
						}else{
							$.messager.show({title:'提示',msg :'保存失败！'});
						}
						$('#formSubimt').linkbutton('enable');
					}
				}
			});
		}
	}];
	usd.createButtonsInDialog(buttons);
	usd.show();
}

/**
 * 修改码值
 */
function updateSegmentValues(){
	var checked = $('#datagrid1').datagrid('getChecked');
	if(checked.length == 0) {
		$.messager.show({title : '提示',msg : "请选择记录!"});
		return false;
	}else if(checked.length > 1) {
		$.messager.show({title : '提示',msg : "请选择一条记录!"});
		return false;
	}
	
	var id = checked[0].id;
	var usd = new CommonDialog("updateCodingRuleDialog","800","400","platform/sysCodingRuleController/toUpdateSegmentValuesJsp.jsp?id="+id,"代码规则码值管理",true,true,false);
	usd.show();
}

/**
 * 删除规则
 */
function deleteRule(){
	var checked = $('#datagrid1').datagrid('getChecked');
	if(checked.length == 0) {
		$.messager.show({title : '提示',msg : "请选择记录!"});
		return false;
	}
	for (var i = 0; i < checked.length; i++){
		var status = checked[i].status;
		if(status != '1'){
			$.messager.show({title : '提示',msg : "状态不是编制中的不能删除!"});
			return false;
		}
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
				url : 'platform/sysCodingRuleController/deleteRule',
				data : param,
				type : 'post',
				dataType : 'json',
				success : function(result) {
					if (result.flag == 'success') {
						$("#datagrid1").datagrid('uncheckAll'); 
						$("#datagrid1").datagrid('reload'); 
						$.messager.show({title:'提示',msg :'删除成功！'});
					} else {
						if(result.isPublished == 'true'){
							$.messager.show({title:'提示',msg :'删除失败！已经发布的数据不能删除'});
						}else{
							$.messager.show({title:'提示',msg :'删除失败！'});
						}
					}
				}
			});
        }
    });	
}

/**
 * 发布规则
 */
function publishRule(){
	var checked = $('#datagrid1').datagrid('getChecked');
	if(checked.length == 0) {
		$.messager.show({title : '提示',msg : "请选择记录!"});
		return false;
	}
	for (var i = 0; i < checked.length; i++){
		var status = checked[i].status;
		if(status != '1'){
			$.messager.show({title : '提示',msg : "状态不是编制中的不能发布!"});
			return false;
		}
	}
	$.messager.confirm('确认', '您确认发布吗?', function(r){
        if (r){
        	var idArray = new Array();
        	for (var i = 0; i < checked.length; i++){
        		idArray[i] = checked[i].id;
        	}
        	var param = {
        		ids: idArray.join(',')
        	};
        	
			$.ajax({
				url : 'platform/sysCodingRuleController/publishRule',
				data : param,
				type : 'post',
				dataType : 'json',
				success : function(result) {
					if (result.flag == 'success') {
						$("#datagrid1").datagrid('reload'); 
						$.messager.show({title:'提示',msg :'发布成功！'});
					} else {
						if(result.isLostValues == 'true'){
							$.messager.show({title:'提示',msg :'发布失败！规则码值缺失，请修改码值。'});
						}else{
							$.messager.show({title:'提示',msg :'发布失败！'});
						}
					}
				}
			});
        }
    });	
}

/**
 * 撤销规则
 */
function cancelRule(){
	var checked = $('#datagrid1').datagrid('getChecked');
	if(checked.length == 0) {
		$.messager.show({title : '提示',msg : "请选择记录!"});
		return false;
	}
	for (var i = 0; i < checked.length; i++){
		var status = checked[i].status;
		if(status != '3'){
			$.messager.show({title : '提示',msg : "状态不是已发布的不能撤销!"});
			return false;
		}
	}
	
	$.messager.confirm('确认', '您确认撤销吗?', function(r){
        if (r){
        	var idArray = new Array();
        	for (var i = 0; i < checked.length; i++){
        		idArray[i] = checked[i].id;
        	}
        	var param = {
        		ids: idArray.join(',')
        	};
        	
			$.ajax({
				url : 'platform/sysCodingRuleController/cancelRule',
				data : param,
				type : 'post',
				dataType : 'json',
				success : function(result) {
					if (result.flag == 'success') {
						$("#datagrid1").datagrid('reload'); 
						$.messager.show({title:'提示',msg :'撤销成功！'});
					} else {
						$.messager.show({title:'提示',msg :'撤销失败！'});
					}
				}
			});
        }
    });	
}

/**
 * 规则名称前边加图片
 */
 function formatterCodingName(value,row,index){
	 return '<img  alt="" style="cursor: pointer;width:30px;height:30px;" src="avicit/platform6/modules/system/syscodingrule/images/'+row.signImage+'.gif" >    '+value;
}

/**
 * 转到通用码段页面
 */
function toComSegment(){
	var usd = new CommonDialog("comSegmentDialog", 700, 400,"avicit/platform6/modules/system/syscodingcomsegment/sysCodingComSegmentManager.jsp","通用码段管理",true,true,false);
	usd.show();
}
</script>
</head>
<body class="easyui-layout">
<div region="north" border="false">
	<div id="toolbar" class="datagrid-toolbar" style="height:auto;overflow: hidden;">
		<div style="padding:0 0 0 10px;">
			<sec:accesscontrollist hasPermission="3" domainObject="sysCodingRuleManager_button_insertRule" >
				<a class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addRule();" href="javascript:void(0);">添加</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="sysCodingRuleManager_button_updateRule" >
				<a class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="updateRule();" href="javascript:void(0);">编辑</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="sysCodingRuleManager_button_deleteRule" >
				<a class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="deleteRule();" href="javascript:void(0);">删除</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="sysCodingRuleManager_button_copyRule" >
				<a class="easyui-linkbutton" iconCls="icon-filter" plain="true" onclick="copyRule();" href="javascript:void(0);">复制</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="sysCodingRuleManager_button_updateSegmentValues" >
				<a class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="updateSegmentValues();" href="javascript:void(0);">编辑码值</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="sysCodingRuleManager_button_publishRule" >
				<a class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="publishRule();" href="javascript:void(0);">发布</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="sysCodingRuleManager_button_cancelRule" >
				<a class="easyui-linkbutton" iconCls="icon-undo" plain="true" onclick="cancelRule();" href="javascript:void(0);">撤销</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="sysCodingRuleManager_button_cancelRule" >
				<a class="easyui-linkbutton" iconCls="icon-tools" plain="true" onclick="toComSegment();" href="javascript:void(0);">通用码段</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="sysCodingRuleManager_button_searchRule" >
				<a class="easyui-linkbutton" id="searchButton" iconCls="icon-search" plain="true" onclick="openSearchForm();" href="javascript:void(0);">查询</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="sysCodingRuleManager_button_codingSystem" >
				<a class="easyui-linkbutton" iconCls="icon-sum" plain="true" onclick="openCodingSystem();" href="javascript:void(0);">编码体系管理</a>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="sysCodingRuleManager_button_codingSelect" >
				<a class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="openCodingSelect();" href="javascript:void(0);">编码使用查询</a>
			</sec:accesscontrollist>
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
				url:'platform/sysCodingRuleController/getRuleListData.json',
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
				<sec:accesscontrollist hasPermission="3" domainObject="sysCodingRuleManager_gridform_codingName">
					<th data-options="field:'codingName', halign:'center',formatter:formatterCodingName" width="120">规则名称</th>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="sysCodingRuleManager_gridform_segmentNumber">
					<th data-options="field:'segmentNumber', halign:'center', align:'center'" width="20">码段个数</th>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="sysCodingRuleManager_gridform_criterionCode">
					<th data-options="field:'criterionCode', halign:'center', align:'left'" width="100">依赖标准号</th>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="sysCodingRuleManager_gridform_ruleRemark">
					<th data-options="field:'ruleRemark', halign:'center', align:'left'" width="100">说明</th>
				</sec:accesscontrollist>
				<sec:accesscontrollist hasPermission="3" domainObject="sysCodingRuleManager_gridform_status">
					<th data-options="field:'statusText', halign:'center', align:'center'" width="20">状态</th>
				</sec:accesscontrollist>
			</tr>
		</thead>
	</table>
</div>
<div id="searchDialog" class="easyui-dialog" data-options="title:'查询条件',closed:true,iconCls:'icon-search',resizable:true,modal:false,buttons:'#searchBtns'" style="width: 450px;height:170px;">
	<form id="formSearch">
		<table class="tableForm" width="98%" height="70px">
			<tr>
				<td width="80px;" align="right">规则名称</td>
				<td colspan="3">
					<input id="searchCodingName" name="searchCodingName" style="width: 300px" value=""/>
				</td>
			</tr>
			<tr>
				<td align="right">依赖标准号</td>
				<td width="160px;">
					<input id="searchCriterionCode" name="searchCriterionCode" style="width: 160px" value=""/>
				</td>
				<td width="50px;" align="right">状态</td>
				<td>
					<input id="searchStatus" name="searchStatus" class="easyui-combobox" data-options="editable:false,panelHeight:'auto',valueField:'code',textField:'name',url:'platform/sysCodingRuleController/getSegmentStatus.json'" style="width: 80px" value=""/>
				</td>
			</tr>
		</table>
	</form>
   	<div id="searchBtns">
   		<a class="easyui-linkbutton"  plain="false" onclick="searchData();" href="javascript:void(0);">查询</a>
   		<a class="easyui-linkbutton" plain="false" onclick="clearData();" href="javascript:void(0);">清空</a>
   		<a class="easyui-linkbutton" plain="false" onclick="hideSearch();" href="javascript:void(0);">返回</a>
   	</div>
</div>
</body>
</html>
