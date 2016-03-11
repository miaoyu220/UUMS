<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>代码规则码值管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<script type="text/javascript">
/**
 * 当前码段tab页签的切换时触发
 */
function fushTabByTabIndex(title, index){
	//关闭导入页面
	var panel = $('#importSegmentValuePanel');
	if(panel.length > 0){
		if (!panel.panel('options').closed){
			panel.panel('close');
		}
		var file = $('#importSegmentValueFile');
		file.after(file.clone().val(""));    
		file.remove();
	}
	//关闭查询页面
	var panel_search = $('#searchSegmentPanel');
	if(panel_search.length > 0){
		if (!panel_search.panel('options').closed){
			panel_search.panel('close');
		}
	}

	if(title != null ){
		loadData(index + 1);
	}
}

/**
 * 装载数据
 */
function loadData(segmentIndex){
	var baseId = $('#baseId').val();
	var searchParam = {
		baseId: baseId,
		segmentIndex: segmentIndex
	};

	$.ajax({
        cache: true,
        type: "POST",
        url:'platform/sysCodingRuleController/getSegmentValuesTableData.json',
        data : searchParam,
        dataType:"json",
        async: false,
        timeout:10000,
        error: function(request) {
        	
        },
        success: function(data) {
        	//根据类型得到码值的标题
        	var segmentType = data.segmentType;
        	if(segmentType == '3'){
        		var columnArray = new Array();
				
				if(data.columnTitleList.length > 0){
					for(var i = 0; i < data.columnTitleList.length; i++){
						var columnField = data.columnFieldList[i];
						var columnTitle = data.columnTitleList[i];
						var week = {field: columnField, title: columnTitle, align:'center', width:100};
						columnArray.push(week);
					}
					$("#datagrid" + segmentIndex).datagrid({
						data: data.rows,
						columns:[[{field:'checkbox',checkbox: true, align:'center', width:30, rowspan: 2},
						          {title: '依赖值', align:'center', colspan: data.columnTitleList.length},
						          {field:'segmentValue',title: '最大流水号', align:'center', width:100, rowspan: 2}],
						         columnArray]
					});
				}else{
					$("#datagrid" + segmentIndex).datagrid({
						data: data.rows,
						columns:[[{field:'checkbox',checkbox: true, align:'center', width:30},
						         {field:'segmentValue',title: '最大流水号', align:'center', width:100}]]
					});
				}
        	}else{
        		var columnArray = new Array();
				
				if(data.columnTitleList.length > 0){
					for(var i = 0; i < data.columnTitleList.length; i++){
						var columnField = data.columnFieldList[i];
						var columnTitle = data.columnTitleList[i];
						var week = {field: columnField, title: columnTitle, align:'center', width:100};
						columnArray.push(week);
					}
					$("#datagrid" + segmentIndex).datagrid({
						data: data.rows,
						columns:[[{field:'checkbox',checkbox: true, align:'center', width:30, rowspan: 2},
						          {title: '依赖值', align:'center', colspan: data.columnTitleList.length},
						          {field:'segmentName',title: '码名称', align:'center', width:100, rowspan: 2},
						          {field:'segmentValue',title: '码值', align:'center', width:100, rowspan: 2}],
						         columnArray]
					});
				}else{
					$("#datagrid" + segmentIndex).datagrid({
						data: data.rows,
						columns:[[{field:'checkbox',checkbox: true, align:'center', width:30},
						          {field:'segmentName',title: '码名称', align:'center', width:100},
						          {field:'segmentValue',title: '码值', align:'center', width:100}]]
					});
				}
        	}
        }
    });
}

/**
 * 刷新表格
 */
function reloadDatagrid(segmentIndex, searchSegmentName, searchSegmentValue){
	var baseId = $('#baseId').val();
	var searchParam = {
		baseId: baseId,
		segmentIndex: segmentIndex,
		searchSegmentName: searchSegmentName,
		searchSegmentValue: searchSegmentValue
	};
	$('#datagrid' + segmentIndex).datagrid('options').url = 'platform/sysCodingRuleController/getSegmentValuesTableData.json';
	$('#datagrid' + segmentIndex).datagrid('options').queryParams = searchParam;
	$('#datagrid' + segmentIndex).datagrid('uncheckAll');
	$('#datagrid' + segmentIndex).datagrid('reload');
}

/**
 * 查询
 */
function searchSegmentValue(self, segmentIndex){
	var panel = $('#searchSegmentPanel');
	if(panel.length == 0){
		panel = $(
			'<div id="searchSegmentPanel" class="combo-panel">'+
				'<div class="easyui-layout">'+
					'<div region="center" border="false" style="padding: 10px 0 0 0">' +
						'<table class="tableForm" width="95%" height="40px">' +
						   '<tr>' +
						      '<td width="60px;" align="right">码名称</td>' +
						      '<td width="100px;"><input type="text" style="width:100px" id="searchSegmentName" name="searchSegmentName" value="" /></td>' +
						      '<td width="60px;" align="right">码值</td>' +
						      '<td width="100px;"><input type="text" style="width:100px" id="searchSegmentValue" name="searchSegmentValue" value="" /></td>' +
						   '</tr>' +
						 '</table>' +
					'</div>'+
					'<div region="south" border="false" style="height: 30px;">'+
						'<div align="right" class="datagrid-toolbar" style="height: 26px;">'+
						'</div>'+
					'</div>'+
				'</div>'+
			'</div>').appendTo('body');
		
		panel.panel({
			doSize:false,
			closed:true,
			width:350,
			height:100,
			style:{
				position:'absolute',
				zIndex:10
			},
			onOpen:function(){
				$(this).panel('resize');
			},
			onClose:function(){
			}
		});
		
		var layout = panel.panel('panel').find(".easyui-layout");
		layout.layout({fit:true});
		
		var toolbar = panel.find('.datagrid-toolbar');
		var doSearchButton = $('<a id="doSearchButton" class="easyui-linkbutton" href="javascript:void(0);">确定</a>').appendTo(toolbar);
		doSearchButton.linkbutton({plain:"true", iconCls:"icon-ok"});
		var clearSearchButton = $('<a class="easyui-linkbutton" href="javascript:void(0);">清空</a>').appendTo(toolbar);
		clearSearchButton.linkbutton({plain:"true", iconCls:"icon-reload"});
		var buttonClose = $('<a class="easyui-linkbutton" href="javascript:void(0);">关闭</a>').appendTo(toolbar);
		buttonClose.linkbutton({plain:"true", iconCls:"icon-cancel"});
		
		doSearchButton.bind('click', function(){
			doSearch(segmentIndex);
	    }); 
		
		clearSearchButton.bind('click', function(){
			clearData();
	    });

		buttonClose.bind('click', function(){    
			panel.panel('close');
	    }); 
	}else{
		$("#doSearchButton").unbind();
		$('#doSearchButton').bind('click', function(){
			doSearch(segmentIndex);
	    }); 
	}

	panel.panel('move', {
		left: $(self).offset().left,
		top:getTop()
	});
	
	if (panel.panel('options').closed){
		panel.panel('open');
	}else{
		panel.panel('close');
	}
	
	function getTop(){
		var top = $(self).offset().top + $(self)._outerHeight();
		if (top + panel._outerHeight() > $(window)._outerHeight() + $(document).scrollTop()){
			top = $(self).offset().top - panel._outerHeight();
		}
		if (top < $(document).scrollTop()){
			top = $(self).offset().top + $(self)._outerHeight();
		}
		return top;
	}
}
/*清空查询条件*/
function clearData(){
	$('.tableForm').find('input').val('');
};

/**
 * 查询
 */
function doSearch(segmentIndex){
	var searchSegmentName = $('#searchSegmentName').val();
	var searchSegmentValue = $('#searchSegmentValue').val();
	
	reloadDatagrid(segmentIndex, searchSegmentName, searchSegmentValue);
}
/**
 * 增加规则码值
 */
function addSegmentValue(segmentIndex){
	var baseId = $('#baseId').val();
	var usd = new CommonDialog("addSegmentValueDialog","450","240","platform/sysCodingRuleController/toAddSegmentValueJsp?baseId="+ baseId +"&segmentIndex=" + segmentIndex,"添加码值",true);
	var buttons = [{
		text:'提交',
		id : 'formSubimt',
		iconCls : '',
		handler:function(){
			$(this).linkbutton('disable');
			var frmId = $('#addSegmentValueDialog iframe').attr('id');
			var frm = document.getElementById(frmId).contentWindow;
			var r = frm.$('#formSegmentValue').form('validate');
			if(!r){
				$(this).linkbutton('enable');
				return false;
			}
			$.ajax({
                cache: true,
                type: "POST",
                url:'platform/sysCodingRuleController/addSegmentValue',
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
						reloadDatagrid(segmentIndex);
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
 * 更新规则码值
 */
function updateSegmentValue(segmentIndex){
	var checked = $('#datagrid' + segmentIndex).datagrid('getChecked');
	if(checked.length == 0) {
		$.messager.show({title : '提示',msg : "请选择记录!"});
		return false;
	}else if(checked.length > 1) {
		$.messager.show({title : '提示',msg : "请选择一条记录!"});
		return false;
	}
	
	var id = checked[0].id;
	
	var baseId = $('#baseId').val();
	var usd = new CommonDialog("updateSegmentValueDialog","450","240","platform/sysCodingRuleController/toUpdateSegmentValueJsp?id="+ id +"&baseId="+ baseId +"&segmentIndex=" + segmentIndex,"编辑码值",true);
	var buttons = [{
		text:'提交',
		id : 'formSubimt',
		iconCls : '',
		handler:function(){
			$(this).linkbutton('disable');
			var frmId = $('#updateSegmentValueDialog iframe').attr('id');
			var frm = document.getElementById(frmId).contentWindow;
			var r = frm.$('#formSegmentValue').form('validate');
			if(!r){
				$(this).linkbutton('enable');
				return false;
			}
			$.ajax({
                cache: true,
                type: "POST",
                url:'platform/sysCodingRuleController/updateSegmentValue',
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
						reloadDatagrid(segmentIndex);
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
 * 删除规则码值
 */
function deleteSegmentValue(segmentIndex){
	var checked = $('#datagrid' + segmentIndex).datagrid('getChecked');
	if(checked.length == 0) {
		$.messager.show({title : '提示',msg : "请选择记录!"});
		return false;
	}
	
	$.messager.confirm('确认', '您确认删除吗?', function(r){
        if (r){
        	var baseId = $('#baseId').val();
        	var idArray = new Array();
        	for (var i = 0; i < checked.length; i++){
        		idArray[i] = checked[i].id;
        	}
        	var param = {
        		baseId: baseId,
        		ids: idArray.join(',')
        	};
        	
			$.ajax({
				url : 'platform/sysCodingRuleController/deleteSegmentValue',
				data : param,
				type : 'post',
				dataType : 'json',
				success : function(result) {
					if (result.flag == 'success') {
						reloadDatagrid(segmentIndex);
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

/**
 * 导出数据
 */
function exportSegmentValue(segmentIndex){
	var baseId = $('#baseId').val();
	$('#loadFileIframe').attr("src", getPath() +'/platform/sysCodingExcelController/exportSegmentValueData?baseId=' + baseId + '&segmentIndex=' + segmentIndex);
}

/**
 * 导入数据
 */
function importSegmentValue(self, segmentIndex){
	var panel = $('#importSegmentValuePanel');
	if(panel.length == 0){
		panel = $(
			'<div id="importSegmentValuePanel" class="combo-panel">'+
				'<div class="easyui-layout">'+
					'<div region="center" border="false" style="padding: 15px 0 0 10px">' +
						'<form id="formImportSegmentValue" method="post" enctype="multipart/form-data">' +
							'<input type="radio" style="width:20px" id="importType1" name="importType" value="1" checked="checked">完整性导入' +
							'<input type="radio" style="width:20px" id="importType2" name="importType" value="2">验证性导入' +
							'<input type="file" style="width:300px" id="importSegmentValueFile" name="importSegmentValueFile">' +
						'</form>' +
					'</div>'+
					'<div region="south" border="false" style="height: 30px;">'+
						'<div align="right" class="datagrid-toolbar" style="height: 26px;">'+
						'</div>'+
					'</div>'+
				'</div>'+
			'</div>').appendTo('body');
		
		panel.panel({
			doSize:false,
			closed:true,
			width:350,
			height:110,
			style:{
				position:'absolute',
				zIndex:10
			},
			onOpen:function(){
				$(this).panel('resize');
			},
			onClose:function(){
			}
		});
		
		var layout = panel.panel('panel').find(".easyui-layout");
		layout.layout({fit:true});
		
		var toolbar = panel.find('.datagrid-toolbar');
		var buttonConfrim = $('<a id="uploadValuesFileButton" class="easyui-linkbutton" href="javascript:void(0);">确定</a>').appendTo(toolbar);
		buttonConfrim.linkbutton({plain:"true", iconCls:"icon-ok"});
		var buttonClose = $('<a class="easyui-linkbutton" href="javascript:void(0);">关闭</a>').appendTo(toolbar);
		buttonClose.linkbutton({plain:"true", iconCls:"icon-cancel"});
		
		buttonConfrim.bind('click', function(){
			doImportSegmentValue(segmentIndex);
	    }); 
		buttonClose.bind('click', function(){    
			panel.panel('close');
	    }); 
	}else{
		$("#uploadValuesFileButton").unbind();
		$('#uploadValuesFileButton').bind('click', function(){
			doImportSegmentValue(segmentIndex);
	    }); 
	}

	panel.panel('move', {
		left: $(self).offset().left,
		top:getTop()
	});
	
	if (panel.panel('options').closed){
		panel.panel('open');
	}else{
		panel.panel('close');
	}
	
	function getTop(){
		var top = $(self).offset().top + $(self)._outerHeight();
		if (top + panel._outerHeight() > $(window)._outerHeight() + $(document).scrollTop()){
			top = $(self).offset().top - panel._outerHeight();
		}
		if (top < $(document).scrollTop()){
			top = $(self).offset().top + $(self)._outerHeight();
		}
		return top;
	}
}

/**
 * 导入文件
 */
function doImportSegmentValue(segmentIndex){
	if($('#importSegmentValueFile').val() != ''){
		var baseId = $('#baseId').val();
		$.messager.progress();	// 显示进度条
		$('#formImportSegmentValue').form('submit', {
			url:'platform/sysCodingExcelController/importSegmentValues.json?baseId='+ baseId + '&segmentIndex=' + segmentIndex,
			dataType:'json',
			success: function(result){
				$.messager.progress('close');
				
				if(typeof(result) == 'string'){
					result = eval("(" + result + ")");
				}
				if (result.flag == 'success') {
					reloadDatagrid(segmentIndex);
					var panel = $('#importSegmentValuePanel');
					if(panel.length > 0){
						if (!panel.panel('options').closed){
							panel.panel('close');
						}
					}
					$.messager.show({title:'提示',msg :'数据导入成功！'});
				}else{
					if(result.errorType == 'isPublished'){
						$.messager.show({title:'提示',msg :'此规则已经发布，不能编辑码值！'});
					}else if(result.errorType == 'isFileError'){
						$.messager.show({title:'提示',msg :'数据导入失败！文件格式不正确！'});
					}else if(result.errorType == 'isDataError'){
						$.messager.show({title:'提示',msg :'数据导入失败！文件数据不正确！<br/><a onclick="readImportErrorInfo();" href="javascript:void(0);">查看错误信息</a>',timeout: 0});
					}else{
						$.messager.show({title:'提示',msg :'数据导入失败！'});
					}
				}
			}
		});
	}else{
		$.messager.show({title : '提示',msg : "请选择文件!"});
	}
}

/**
 * 查看导入数据错误信息
 */
function readImportErrorInfo(){
	var usd = new CommonDialog("errorInfoDialog","770","320","avicit/platform6/modules/system/syscodingrule/sysCodingUpdateSegmentValuesErrorInfo.jsp","导入数据错误信息",true,true,false);
	usd.show();
}

/**
 * 模版下载
 */
function downloadTemplate(segmentIndex){
	var baseId = $('#baseId').val();
	$('#loadFileIframe').attr("src", getPath() +'/platform/sysCodingExcelController/downloadTemplate?baseId=' + baseId + '&segmentIndex=' + segmentIndex);
}
</script>
</head>
<body class="easyui-layout" >
<iframe id="loadFileIframe" style="display: none"></iframe>
<input type="hidden" id="baseId" name="baseId" value="${ruleBase.id }">
<div region="center" border="false">
<div id="tabRuleSegmentValues" data-options="onSelect: fushTabByTabIndex" class="easyui-tabs" tabPosition="top" fit="true" border="false" style="padding:0px;" >
	<c:forEach items="${segmentList}"  var="segment" varStatus="segmentStatus">
		<div title="${segment.segmentName}">
			<table id="datagrid${segment.segmentIndex}" class="easyui-datagrid" 
				data-options="
					fit: true,
					border: false,
					rownumbers: true,
					animate: true,
					collapsible: false,
					fitColumns: true,
					autoRowHeight: false,
					method: 'post',
					idField: 'id',
					<c:if test="${ruleBase.status == '1' && segment.segmentType != '3' && segment.segmentType != '4' && segment.comSegmentId == null}">toolbar:'#toolbar${segment.segmentIndex}',</c:if>
					singleSelect: false,
					checkOnSelect: true,
					selectOnCheck: true
				">
			</table>
			<div id="toolbar${segment.segmentIndex}" class="datagrid-toolbar" style="height: 28px; overflow: hidden;">
				<div style="padding:0 0 0 5px;">
					<sec:accesscontrollist hasPermission="3" domainObject="sysCodingUpdateSegmentValues_button_addButton" >
						<a id="searchButton${segment.segmentIndex}" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="searchSegmentValue(this,${segment.segmentIndex});" href="javascript:void(0);">查询</a>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3" domainObject="sysCodingUpdateSegmentValues_button_addButton" >
						<a id="addButton${segment.segmentIndex}" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addSegmentValue(${segment.segmentIndex});" href="javascript:void(0);">添加</a>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3" domainObject="sysCodingUpdateSegmentValues_button_updateButton" >
						<a id="updateButton${segment.segmentIndex}" class="easyui-linkbutton" iconCls="icon-edit"  plain="true" onclick="updateSegmentValue(${segment.segmentIndex});" href="javascript:void(0);">编辑</a>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3" domainObject="sysCodingUpdateSegmentValues_button_deleteButton" >
						<a id="deleteButton${segment.segmentIndex}" class="easyui-linkbutton" iconCls="icon-remove"  plain="true" onclick="deleteSegmentValue(${segment.segmentIndex});" href="javascript:void(0);">删除</a>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3" domainObject="sysCodingUpdateSegmentValues_button_exportButton" >
						<a id="exportButton${segment.segmentIndex}" class="easyui-linkbutton" iconCls="icon-redo"  plain="true" onclick="exportSegmentValue(${segment.segmentIndex});" href="javascript:void(0);">导出数据</a>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3" domainObject="sysCodingUpdateSegmentValues_button_importButton" >
						<a id="importButton${segment.segmentIndex}" class="easyui-linkbutton easyui-tooltip" title="每个码段的模板不一样,请先下载模版！" iconCls="icon-reload" position="right" plain="true" onclick="importSegmentValue(this, ${segment.segmentIndex});" href="javascript:void(0);">导入数据</a>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3" domainObject="sysCodingUpdateSegmentValues_button_importButton" >
						<a id="importButton${segment.segmentIndex}" class="easyui-linkbutton" iconCls="icon-back"  plain="true" onclick="downloadTemplate(${segment.segmentIndex});" href="javascript:void(0);">模版下载</a>
					</sec:accesscontrollist>
				</div>
			</div>
		</div>
	</c:forEach>
</div>
</div>
</body>
</html>
