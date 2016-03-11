<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>编码体系维护</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<script src="avicit/platform6/centralcontrol/sysapp/js/SysAppTree.js" type="text/javascript"></script>
<style type="text/css">
.icon-system {
    background: url("static/images/platform/common/org-1.gif") no-repeat scroll 0 0 transparent;
}
.icon-criterion {
    background: url("static/images/platform/common/icons/page.png") no-repeat scroll 0 0 transparent;
}
</style>
<script type="text/javascript">

$(function(){
	setFormReadOnly(true);
});

/**
 * 返回tab页签高度
 * @returns
 */
function getTabWidth(){
	return parseInt($(window).width()*0.3);
}

/**
 * 选择事件
 */
function doClick(node){
	//1:编码体系；2：编码体系下的标准
	var type = node.attributes.type;
	if(type == '1'){
		$("#formCriterion").form('clear');
		$('#documentFile').html(' ');
		$('#saveCriterion').linkbutton('disable');
		$('#deleteCriterion').linkbutton('disable');
		
		var sMenu = $('#codingSystemMenu');
		sMenu.menu('enableItem', sMenu.menu('findItem', '添加子节点').target);
		sMenu.menu('enableItem', sMenu.menu('findItem', '编辑').target);
		sMenu.menu('enableItem', sMenu.menu('findItem', '删除').target);

		$.ajax({
			url : 'platform/cc/sysCodingSystem/isHasChildren',
			data : {id : node.id},
			type : 'post',
			dataType : 'json',
			success : function(result) {
				if(result && result.isHasChildren == false){
					$('#saveCriterion').linkbutton('enable');
					setFormReadOnly(false);
				}else{
					setFormReadOnly(true);
				}
			}
		});
	}else if(type == '2'){
		setFormReadOnly(false);
		loadCriterionData(node.id);
		$('#saveCriterion').linkbutton('enable');
		$('#deleteCriterion').linkbutton('enable');
		
		var sMenu = $('#codingSystemMenu');
		sMenu.menu('disableItem', sMenu.menu('findItem', '添加子节点').target);
		sMenu.menu('disableItem', sMenu.menu('findItem', '编辑').target);
		sMenu.menu('disableItem', sMenu.menu('findItem', '删除').target);
	}
}

/**
 * 控制表单元素只读
 * @param flag
 */
function setFormReadOnly(flag){
	$('#criterionName').attr("readonly", flag);
	$('#criterionLevel').combobox("readonly", flag);
	$('#criterionCode').attr("readonly", flag);
	$('#publishDate').datebox("readonly", flag);
	$('#implementDate').datebox("readonly", flag);
	$('#status').combobox("readonly", flag);
	$('#dept').attr("readonly", flag);
	
	if (flag){
		$('#criterionName').parent().addClass('input-readonly');
		$('#criterionLevel').parent().addClass('input-readonly');
		$('#criterionCode').parent().addClass('input-readonly');
		$('#publishDate').parent().addClass('input-readonly');
		$('#implementDate').parent().addClass('input-readonly');
		$('#status').parent().addClass('input-readonly');
		$('#dept').parent().addClass('input-readonly');
		
	}else{
		$('#criterionName').parent().removeClass('input-readonly');
		$('#criterionLevel').parent().removeClass('input-readonly');
		$('#criterionCode').parent().removeClass('input-readonly');
		$('#publishDate').parent().removeClass('input-readonly');
		$('#implementDate').parent().removeClass('input-readonly');
		$('#status').parent().removeClass('input-readonly');
		$('#dept').parent().removeClass('input-readonly');
	}
}

/**
 * 装载标准的值
 */
function loadCriterionData(id){
	$.ajax({
		url : 'platform/cc/sysCodingSystem/getCriterionData',
		data : {id :id},
		type : 'post',
		dataType : 'json',
		async: false,
		success : function(result) {
			if(result && result.obj){
				if (result.publishDate){
					result.obj.publishDate = result.publishDate;
				}
				if (result.implementDate){
					result.obj.implementDate = result.implementDate;
				}
				//更新数据
				$("#formCriterion").form('clear');
				$("#formCriterion").form('load',result.obj);
				
				var fileName = result.obj.fileName;
				var fileId = result.obj.fileId;
				
				if(fileName == undefined || fileName == ""){
					$('#documentFile').html(' ');
				}else{
					$('#documentFile').html(' ');
					$('#documentFile').html("<a href='platform/cc/sysCodingSystem/loadDocumentFile?id="+fileId+"' target='loadFileIframe'>"+fileName+"</a>");
				}

			}
		}
	});
}

/**
 * 增加编码体系根节点
 */
function addRoot(){
	var usd = new CommonDialog("addCodingSystemDialog","400","200","avicit/platform6/modules/system/syscodingsystem/sysCodingSystemAdd.jsp?id=-1","添加编码体系根节点",true);
	var buttons = [{
		text:'提交',
		id : 'formSubimt',
		iconCls : '',
		handler:function(){
			var frmId = $('#addCodingSystemDialog iframe').attr('id');
			var frm = document.getElementById(frmId).contentWindow;
			var r = frm.$('#formCodingSystem').form('validate');
			if(!r){
				return false;
			}
			
			var dataVo = frm.$('#formCodingSystem').serializeArray();
			var dataJson = convertToJson(dataVo);
			
			var systemName = dataJson.systemName;
			if(systemName == null || systemName == ""){
				$.messager.alert('提示','请填写名称！','info');
				return false;
			}
			
			var systemRemark = dataJson.systemRemark;
			if(systemRemark.length > 2000){
				$.messager.alert('提示','描述字段超过长度！','info');
				return false;
			}
			
			var param = {
				parentId: dataJson.parentId,
				systemName: systemName,
				systemRemark: systemRemark,
				appId: $appId
			};
			
			$.ajax({
                cache: true,
                type: "POST",
                url:'platform/cc/sysCodingSystem/addCodingSystem',
                dataType:"json",
                data:param,
                async: false,
                timeout:10000,
                error: function(request) {
                	alert("操作失败，服务请求状态："+request.status+" "+request.statusText+" 请检查服务是否可用！");
                },
                success: function(result) {
                	if (result.flag == 'success') {
						var treeNode = {
							id: result.obj.id,
							text: result.obj.systemName,
							iconCls: 'icon-system',
							attributes: {type: '1'}
						};
						$('#codingSystemTree').tree('append',{
							data: [treeNode]
						});
						usd.close();
						$.messager.show({title:'提示',msg :'保存成功！'});
					}else{
						if(result.isHasCriterion == 'true'){
							$.messager.show({title:'提示',msg :'此节点下已经存在标准，不能再添加子节点！'});
						}else if(result.isExistsSystemName == 'true'){
							$.messager.show({title:'提示',msg :'保存失败！名称重复！'});
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
 * 增加编码体系
 */
function addCodingSystem(){
	var node = $('#codingSystemTree').tree('getSelected');
	if (node){
		var isLeaf = $('#codingSystemTree').tree('isLeaf',node.target);
		if(!isLeaf){
			$('#codingSystemTree').tree('expand', node.target);	
		}
		var id = node.id;
		var usd = new CommonDialog("addCodingSystemDialog","400","200","avicit/platform6/modules/system/syscodingsystem/sysCodingSystemAdd.jsp?id=" + id,"添加编码体系",true);
		var buttons = [{
			text:'提交',
			id : 'formSubimt',
			iconCls : '',
			handler:function(){
				var frmId = $('#addCodingSystemDialog iframe').attr('id');
				var frm = document.getElementById(frmId).contentWindow;
				var r = frm.$('#formCodingSystem').form('validate');
				if(!r){
					return false;
				}
				
				var dataVo = frm.$('#formCodingSystem').serializeArray();
				var dataJson = convertToJson(dataVo);
				
				var systemName = dataJson.systemName;
				if(systemName == null || systemName == ""){
					$.messager.alert('提示','请填写名称！','info');
					return false;
				}
				
				var systemRemark = dataJson.systemRemark;
				if(systemRemark.length > 2000){
					$.messager.alert('提示','描述字段超过长度！','info');
					return false;
				}

				var param = {
					parentId: dataJson.parentId,
					systemName: systemName,
					systemRemark: systemRemark,
					appId: $appId
				};
				
				$.ajax({
	                cache: true,
	                type: "POST",
	                url:'platform/cc/sysCodingSystem/addCodingSystem',
	                dataType:"json",
	                data:param,
	                async: false,
	                timeout:10000,
	                error: function(request) {
	                	alert("操作失败，服务请求状态："+request.status+" "+request.statusText+" 请检查服务是否可用！");
	                },
	                success: function(result) {
	                	if (result.flag == 'success') {
							var treeNode = {
								id: result.obj.id,
								text: result.obj.systemName,
								iconCls: 'icon-system',
								attributes: {type: '1'}
							};
							$('#codingSystemTree').tree('append',{
								parent: node.target,
								data: [treeNode]
							});
							usd.close();
							$.messager.show({title:'提示',msg :'保存成功！'});
						}else{
							if(result.isHasCriterion == 'true'){
								$.messager.show({title:'提示',msg :'此节点下已经存在标准，不能再添加子节点！'});
							}else if(result.isExistsSystemName == 'true'){
								$.messager.show({title:'提示',msg :'保存失败！名称重复！'});
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
	}else{
		$.messager.show({title:'提示',msg :'请选择树节点！'});
	}
}

/**
 * 修改编码体系
 */
function editCodingSystem(){
	var node = $('#codingSystemTree').tree('getSelected');
	if (node){
		var id = node.id;
		var usd = new CommonDialog("editCodingSystemDialog","400","200","avicit/platform6/modules/system/syscodingsystem/sysCodingSystemEdit.jsp?id=" + id,"编辑编码体系",true);
		var buttons = [{
			text:'提交',
			id : 'formSubimt',
			iconCls : '',
			handler:function(){
				var frmId = $('#editCodingSystemDialog iframe').attr('id');
				var frm = document.getElementById(frmId).contentWindow;
				var r = frm.$('#formCodingSystem').form('validate');
				if(!r){
					return false;
				}
				
				var dataVo = frm.$('#formCodingSystem').serializeArray();
				var dataJson = convertToJson(dataVo);
				
				var systemName = dataJson.systemName;
				if(systemName == null || systemName == ""){
					$.messager.alert('提示','请填写名称！','info');
					return false;
				}
				
				var systemRemark = dataJson.systemRemark;
				if(systemRemark.length > 2000){
					$.messager.alert('提示','描述字段超过长度！','info');
					return false;
				}
				
				$.ajax({
	                cache: true,
	                type: "POST",
	                url:'platform/cc/sysCodingSystem/updateCodingSystem',
	                dataType:"json",
	                data:frm.$('#formCodingSystem').serialize(),
	                async: false,
	                timeout:10000,
	                error: function(request) {
	                	alert("操作失败，服务请求状态："+request.status+" "+request.statusText+" 请检查服务是否可用！");
	                },
	                success: function(result) {
	                	if (result.flag == 'success') {

							$('#codingSystemTree').tree('update',{
								target:node.target,
								text: result.obj.systemName
							});
							usd.close();

							$.messager.show({title:'提示',msg :'保存成功！'});
						}else{
							if(result.isExistsSystemName == 'true'){
								$.messager.show({title:'提示',msg :'保存失败！名称重复！'});
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
	}else{
		$.messager.show({title:'提示',msg :'请选择树节点！'});
	}
}

/**
 * 删除编码体系
 */
function removeCodingSystem(){
	var node = $('#codingSystemTree').tree('getSelected');
	if (node){
		$.messager.confirm('确认', '您确认删除吗?', function(r){
            if (r){
            	var id = node.id;
        		$.ajax({
                    cache: true,
                    type: "POST",
                    url:'platform/cc/sysCodingSystem/deleteCodingSystem',
                    data:{id:id},
                    async: false,
                    timeout:10000,
                    dataType:"json",
                    error: function(request) {
                    	alert("操作失败，服务请求状态："+request.status+" "+request.statusText+" 请检查服务是否可用！");
                    },
                    dataType:"json",
                    success: function(result) {
        				if (result.flag == 'success') { 
							$('#codingSystemTree').tree('remove', node.target);
							$.messager.show({title:'提示',msg :'删除成功！'});
						}else{
							if(result.msg == 'isHasChildren'){
								$.messager.show({title:'提示',msg :'此节点下已经存在子节点，不能删除！'});
							}else if(result.msg == 'isHasCriterion'){
								$.messager.show({title:'提示',msg :'此节点下已经存在标准，不能删除！'});
							}else{
								$.messager.show({title:'提示',msg :'删除失败！'});
							}
						}
                    }
                });
            }
		});
	}else{
		$.messager.show({title:'提示',msg :'请选择树节点！'});
	}
}

/**
 * 保存标准
 */
function saveCriterion(){
	var node = $('#codingSystemTree').tree('getSelected');
	if (node){
		//1:编码体系；2：编码体系下的标准
		var type = node.attributes.type;
		if(type == '1'){
			addCriterion();
		}else if(type == '2'){
			editCriterion();
		}
	}
}

/**
 * 增加标准
 */
function addCriterion(){
	
	var node = $('#codingSystemTree').tree('getSelected');
	if (node){
		//1:编码体系；2：编码体系下的标准
		var type = node.attributes.type;
		if(type == '1'){
			$('#parentId').val(node.id);
		}
		
		var r = $('#formCriterion').form('validate');
		if(!r){
			return false;
		}
		
		var dataVo = $('#formCriterion').serializeArray();
		var dataJson = this.convertToJson(dataVo);
		
		var criterionName = dataJson.criterionName;
		if(criterionName == null || criterionName == ""){
			$.messager.alert('提示','请填写名称！','info');
			return false;
		}
		
		var criterionLevel = dataJson.criterionLevel;
		if(criterionLevel == null || criterionLevel == ""){
			$.messager.alert('提示','请填写标准级别！','info');
			return false;
		}
		
		var criterionCode = dataJson.criterionCode;
		if(criterionCode == null || criterionCode == ""){
			$.messager.alert('提示','请填写标准号！','info');
			return false;
		}
		
		var publishDate = dataJson.publishDate;
		if(publishDate == null || publishDate == ""){
			$.messager.alert('提示','请填写发布日期！','info');
			return false;
		}
		
		var status = dataJson.status;
		if(status == null || status == ""){
			$.messager.alert('提示','请填写状态！','info');
			return false;
		}

		dataVo = JSON.stringify(dataJson);

		var param = {
			dataVo: dataVo,
			appId: $appId
		};
	
		$.ajax({
			url : 'platform/cc/sysCodingSystem/addCriterion',
			data : param,
			type : 'post',
			dataType : 'json',
			success : function(result) {
				if (result.flag == 'success') {
					var treeNode = {
						id: result.obj.id,
						text: result.obj.criterionName,
						iconCls: 'icon-criterion',
						attributes: {type: '2'}
					};
					$('#codingSystemTree').tree('append',{
						parent: node.target,
						data: [treeNode]
					});
					
					$('#id').val(result.obj.id);
					$.messager.show({title:'提示',msg :'保存成功！'});
				} else {
					if(result.msg == 'isHasChildren'){
						$.messager.show({title:'提示',msg :'此节点下已经存在子节点，不能添加标准！'});
					}else if(result.msg == 'isExistsCriterionName'){
						$.messager.show({title:'提示',msg :'保存失败！标准名称已经存在！'});
					}else if(result.msg == 'isExistsCriterionCode'){
						$.messager.show({title:'提示',msg :'保存失败！标准号已经存在！'});
					}else{
						$.messager.show({title:'提示',msg :'保存失败！'});
					}
				}
			}
		});
	}
}

/**
 * 保存标准
 */
function editCriterion(){
	var r = $('#formCriterion').form('validate');
	if(!r){
		return false;
	}
	
	var dataVo = $('#formCriterion').serializeArray();
	var dataJson = this.convertToJson(dataVo);
	var criterionName = dataJson.criterionName;
	if(criterionName == null || criterionName == ""){
		$.messager.alert('提示','请填写名称！','info');
		return false;
	}
	
	var criterionLevel = dataJson.criterionLevel;
	if(criterionLevel == null || criterionLevel == ""){
		$.messager.alert('提示','请填写标准级别！','info');
		return false;
	}
	
	var criterionCode = dataJson.criterionCode;
	if(criterionCode == null || criterionCode == ""){
		$.messager.alert('提示','请填写标准号！','info');
		return false;
	}
	
	var publishDate = dataJson.publishDate;
	if(publishDate == null || publishDate == ""){
		$.messager.alert('提示','请填写发布日期！','info');
		return false;
	}
	
	var status = dataJson.status;
	if(status == null || status == ""){
		$.messager.alert('提示','请填写状态！','info');
		return false;
	}
	
	dataVo = JSON.stringify(dataJson);

	var param = {
		dataVo: dataVo
	};

	$.ajax({
		url : 'platform/cc/sysCodingSystem/updateCriterion',
		data : param,
		type : 'post',
		dataType : 'json',
		success : function(result) {
			if (result.flag == 'success') {
				var node = $('#codingSystemTree').tree('getSelected');
				if (node){
					$('#codingSystemTree').tree('update',{
						target:node.target,
						text: result.obj.criterionName
					});
				}
				$.messager.show({title:'提示',msg :'保存成功！'});
			} else {
				if(result.msg == 'isExistsCriterionName'){
					$.messager.show({title:'提示',msg :'保存失败！标准名称已经存在！'});
				}else if(result.msg == 'isExistsCriterionCode'){
					$.messager.show({title:'提示',msg :'保存失败！标准号已经存在！'});
				}else{
					$.messager.show({title:'提示',msg :'保存失败！'});
				}
			}
		
		}
	});
}

/**
 * 删除标准
 */
function deleteCriterion(){
	$.messager.confirm('确认', '您确认删除吗?', function(r){
	  if (r){
		 var id = $('#id').val();
			
		 if(id != null && id != ""){
			$.ajax({
				url : 'platform/cc/sysCodingSystem/deleteCriterion',
				data : {id: id},
				type : 'post',
				dataType : 'json',
				success : function(result) {
					if (result.flag == 'success') {
						var node = $('#codingSystemTree').tree('getSelected');
						if (node){
							$('#codingSystemTree').tree('remove', node.target);
						}
						$("#formCriterion").form('clear');
						$('#documentFile').html(' ');
						$.messager.show({title:'提示',msg :'删除成功！'});
					} else {
						$.messager.show({title:'提示',msg :'删除失败！'});
					}
				}
			});
		}
	  }
	});
}

/**
 * 初始化应用列表
 */
var sysAppTree;
$(function(){
	sysAppTree = new SysAppTree('apps','searchApp',APP_.PUBLIC);
	sysAppTree.setOnLoadSuccess(function(){
	});
	sysAppTree.setOnSelect(function(_sysAppTree,node){
		loadCodingSystem(node.id);
	});
	
	sysAppTree.init();
	
});

$appId = '';
function loadCodingSystem(appId){
	$appId = appId;
	$('#codingSystemTree').tree('options').url = 'platform/cc/sysCodingSystem/getCodingSystemTreeData.json?appId='+ appId;
	$('#codingSystemTree').tree('reload');
}
</script>
</head>
<body class="easyui-layout" style="font-family:'微软雅黑'; ">
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
		<div region="west" border="true" title="编码体系维护" data-options="width: getTabWidth()" split="true">
			<div class="easyui-layout" fit="true">
				<div region="north" border="false">
					<div class="datagrid-toolbar">
						<a href="javascript:void(0);" class='easyui-menubutton' data-options="menu:'#codingSystemMenu',iconCls:'icon-all-file'">操作</a>
						<div id="codingSystemMenu" class="easyui-menu" style="width:150px;">
							<div onclick="addRoot()" data-options="iconCls:'icon-add'">添加根节点</div>
							<div class="menu-sep"></div>
							<div onclick="addCodingSystem();" data-options="name:'addCodingSystemButton',iconCls:'icon-add'">添加子节点</div>
							<div onclick="editCodingSystem();" data-options="name:'editCodingSystemButton',iconCls:'icon-edit'">编辑</div>
							<div onclick="removeCodingSystem();" data-options="name:'removeCodingSystemButton',iconCls:'icon-remove'">删除</div>
						</div>
					</div>
				</div>
				<div region="center" border="false">
				<ul id="codingSystemTree" class="easyui-tree" data-options="
					lines : true,
					method : 'post',
					loadFilter: function(data){
			            if (data.data){	
			                return data.data;
			            } else {
			                return data;
			            }
			      	},
					onSelect: doClick
					"></ul>
				<iframe name="loadFileIframe" style="display: none"></iframe>
				</div>
			</div>
		</div>
		<div region="center" border="true" title="标准信息" style="padding:0;">
			<div class="easyui-layout" fit="true">
				<div region="north" border="false">
					<div class="datagrid-toolbar">
						<!-- 按钮显示区域 -->
				   		<sec:accesscontrollist hasPermission="3" domainObject="sysCodingSystemManager_button_saveCriterion" >
				   			<a class="easyui-linkbutton" id="saveCriterion" iconCls="icon-save" disabled="true" plain="true" onclick="saveCriterion();" href="javascript:void(0);">保存</a>
				   		</sec:accesscontrollist>
				   		<sec:accesscontrollist hasPermission="3" domainObject="sysCodingSystemManager_button_deleteCriterion" >
				   			<a class="easyui-linkbutton" id="deleteCriterion" iconCls="icon-no" disabled="true" plain="true" onclick="deleteCriterion();" href="javascript:void(0);">删除</a>
				   		</sec:accesscontrollist>
					</div>
				</div>
				<div region="center" border="false">
				   <form id="formCriterion" method="post" enctype="multipart/form-data"> 
						<input id="id" name="id" type="hidden" value=""/>
						<input id="parentId" name="parentId" type="hidden" value=""/>
						<input id="version" name="version" type="hidden" value=""/>
						<input id="fileId" name="fileId" type="hidden" value=""/>
						<input id="fileName" name="fileName" type="hidden" value=""/>
						<div class="formExtendBase">
							<sec:accesscontrollist hasPermission="3" domainObject="sysCodingSystemManager_form_criterionName">
							<div class="formUnit column1">
								<label class="labelbg">名称</label>
								<div class="inputContainer">
									<input style="width:400px" id="criterionName" name="criterionName" class="easyui-validatebox" data-options="validType:'length[0,100]'" value=""/>
									<span style="color:red">*</span>名称要求唯一
								</div>
							</div>
							</sec:accesscontrollist>
							<sec:accesscontrollist hasPermission="3" domainObject="sysCodingSystemManager_form_criterionLevel">
							<div class="formUnit column1">
								<label class="labelbg">标准级别</label>
								<div class="inputContainer">
									<input style="width:400px" id="criterionLevel" name="criterionLevel" class="easyui-combobox"
										data-options="
											url:'platform/syslookuptype/getLookUpCode/PLATFORM_CODING_CRITERION_LEVEL',
											editable:false,
											method:'get',
											panelHeight:'auto',
											valueField:'lookupCode',
											textField:'lookupName'"/>
								</div>
							</div>
							</sec:accesscontrollist>
							<sec:accesscontrollist hasPermission="3" domainObject="sysCodingSystemManager_form_criterionCode">
							<div class="formUnit column1">
								<label class="labelbg">标准号</label>
								<div class="inputContainer">
									<input style="width:400px" id="criterionCode" name="criterionCode" class="easyui-validatebox" data-options="validType:'length[0,50]'" value=""/>
									<span style="color:red">*</span>标准号要求唯一
								</div>
							</div>
							</sec:accesscontrollist>
							<sec:accesscontrollist hasPermission="3" domainObject="sysCodingSystemManager_form_publishDate">
							<div class="formUnit column1">
								<label class="labelbg">发布日期</label>
								<div class="inputContainer">
									<input style="width:400px" id="publishDate" name="publishDate" class="easyui-datebox" type="text" value="" />
								</div>
							</div>
							</sec:accesscontrollist>
							<sec:accesscontrollist hasPermission="3" domainObject="sysCodingSystemManager_form_implementDate">
							<div class="formUnit column1">
								<label>实施日期</label>
								<div class="inputContainer">
									<input style="width:400px;" id="implementDate" name="implementDate" class="easyui-datebox" type="text" value="" />
								</div>
							</div>
							</sec:accesscontrollist>
							<sec:accesscontrollist hasPermission="3" domainObject="sysCodingSystemManager_form_status">
							<div class="formUnit column1">
								<label class="labelbg">状态</label>
								<div class="inputContainer input-readonly">
									<input style="width:400px" id="status" name="status" class="easyui-combobox"
										data-options="
											url:'platform/sysCodingSystemController/getCriterionStatus.json',
											editable:false,
											panelHeight:'auto',
											valueField:'code',
											textField:'name'"/>
								</div>
							</div>
							</sec:accesscontrollist>
							<sec:accesscontrollist hasPermission="3" domainObject="sysCodingSystemManager_form_dept">
							<div class="formUnit column1">
								<label>归口单位</label>
								<div class="inputContainer input-readonly">
									<input style="width:400px" id="dept" name="dept" type="text" class="easyui-validatebox" data-options="validType:'length[0,100]'" value=""/>
								</div>
							</div>
							</sec:accesscontrollist>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>		
</body>
</html>
