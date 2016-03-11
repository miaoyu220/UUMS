<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<html>
<head>

<%
	String path = request.getContextPath();
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>流程正文综合管理</title>
<base href="<%=ViewUtil.getRequestPath(request) %>">
<jsp:include page="/avicit/platform6/bpmclient/bpm/ProcessCommonJsInclude.jsp"></jsp:include>
<script src="static/js/platform/component/common/exportData.js" type="text/javascript"></script>
</head>

<script type="text/javascript">
	var baseurl = '<%=request.getContextPath()%>';
	$(function(){
		$("#upDialog").css('display','block').dialog({
			title:'上传印章'
		});
		hideUpForm();
		loadWordSeal();
		$('#searchForm').find('input').on('keyup',function(e){
			if(e.keyCode == 13){
				searchFun();
			}
		});
	});
	
	function loadWordSeal(){
		var dataGridHeight = $(".easyui-layout").height() - 60;
		$('#wordSeallist').datagrid({
			toolbar:[
				{
				text:'添加',
				iconCls:'icon-add',
				handler:function(){
					insertWordSeal();
				}
			},'-',{
				text:'编辑',
				iconCls:'icon-edit',
				handler:function(){
					updateWordSeal();
				}
			},'-',{
				text:'删除',
				iconCls:'icon-remove',
				handler:function(){
					deleteWordSeal();
				}
			}],
			url: 'platform/bpm/bpmconsole/wordSealAction/getWordSealListByPage.json',
			width: '100%',
		    nowrap: false,
		    striped: true,
		    autoRowHeight:false,
		    singleSelect:true,
		    checkOnSelect:true,
		    selectOnCheck: false,
		    remoteSort : false,
			height: dataGridHeight,
			fitColumns: true,
			sortName: 'orderBy',  //排序字段,当表格初始化时候的排序字段
			sortOrder: 'asc',    //定义排序顺序
			pagination:true,
			rownumbers:true,
			queryParams:{"filter_EQ_id":""},
			loadMsg:' 处理中，请稍候…',
			columns:[[
				{field:'id',title:'操作',width:'20',align:'center',checkbox:true},
				{field:'sealName',title:'印章名称',width:'150',align:'left'},
				{field:'sealAdmins',title:'可访问的角色',width:'200',align:'left'},
				{field:'orderBy',title:'排序',width:'40',align:'left',sortable:true},
				{field:'readSeal',title:'查看印章',width:'80',align:'center',
	  				formatter:function(value,rec){
	  					return '<img onclick="javascript:readWordSeal(\''+rec.id+'\')" title="查看印章" src="static/images/platform/bpm/client/images/trackTask.gif" style="cursor:pointer"/>';
					}
				},
				{field:'upSeal',title:'上传印章',width:'80',align:'center',
	  				formatter:function(value,rec){
	  					return '<img onclick="javascript:editWordTemplet(\''+rec.id+'\')" title="上传印章" src="static/images/platform/bpm/client/images/trackTask.gif" style="cursor:pointer"/>';
					}
				},
				{field:'remark',title:'印章描述',width:'200',align:'left'}
			]]
		});
		//设置分页控件   
		var p = $('#wordSeallist').datagrid('getPager');
		$(p).pagination({
		    pageSize: 10,//每页显示的记录条数，默认为10
		    pageList: [5,10,15,20,25,30],//可以设置每页记录条数的列表
		    beforePageText: '第',//页数文本框前显示的汉字
		    afterPageText: '页    共 {pages} 页',
		    displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录'
		});
	}
	
	//查询
	function searchFun(){
		var queryParams = $('#wordSeallist').datagrid('options').queryParams; 
		queryParams.filter_LIKE_sealName = $('#filter_LIKE_sealName').attr('value');
	    $('#wordSeallist').datagrid('options').queryParams=queryParams;        
	    $("#wordSeallist").datagrid('load'); 
	}
	
	function clearFun(){
		$('#searchForm input').val('');
		$('#searchForm select').val('');
	}
	
	//查看印章
	function readWordSeal(id) {
		var url = "platform/bpm/bpmconsole/wordSealAction/getSysWordSealBody?wordId="+id;
		var t = new exportData('iframe','form',{},url);
		t.excuteExport();
	}
	//上传印章
	function editWordTemplet(id) {
		$("#upId").val(id);
		$("#pngFile").val("");
		$("#upDialog").dialog('open',true);
	}
	function hideUpForm(){
		$("#upDialog").dialog('close',true);
	}
	/*上传到服务器  */
	function uploadPng(){
		if(document.getElementById("pngFile").value != ''){
			if(checkfiletype('pngFile')){
				$.messager.progress();	// 显示进度条
				$('#uploadPngForm').form('submit', {
					url: 'platform/bpm/bpmconsole/wordSealAction/updateSysWordSealBody',
					success: function(r){
						$.messager.progress('close');	// 如果提交成功则隐藏进度条
						if(r){
							$.messager.alert('出错',r,'error');
							canImport=false;
						}else{
							$.messager.alert('提示','印章上传成功!','info');
							canImport=true;
						}
					}
				});
				return;
			}
		} else {
			$.messager.alert('警告','请选择上传的印章图片!','warning');
			return;
		}
	}
	//检查上传类型
	function checkfiletype(id){
	    var fileName = document.getElementById(id).value;
	    //设置文件类型数组
	    var extArray =[".esp"];
	   	//获取文件名称
	   	while (fileName.indexOf("//") != -1)
	    	fileName = fileName.slice(fileName.indexOf("//") + 1);
	       	//获取文件扩展名
	       	var ext = fileName.slice(fileName.indexOf(".")).toLowerCase();
	   		//遍历文件类型
	       	var count = extArray.length;
	   		for (;count--;){
	     		if (extArray[count] == ext){ 
	       			return true;
	     		}
	   		}  
	   		$.messager.alert('错误','只能上传下列类型的文件: '  + extArray.join(" "),'error');
	   return false;  
	}
	var usd;
	//新增
	function insertWordSeal(){
		usd = new UserSelectDialog("insertWordSealDialog","650","300","avicit/platform6/bpmconsole/word/WordSealAdd.jsp","新增印章");
		var buttons = [{
			text:'提交',
			id : 'wordSealSubimt',
			handler:function(){
				 var frmId = $('#insertWordSealDialog iframe').attr('id');
				 var frm = document.getElementById(frmId).contentWindow;
				 
				 var sealName = frm.$('#sealName').val();
				 var orderBy = frm.$('#orderBy').val();
				 if(sealName == ""){
					 $.messager.alert("提示", "印章名称不能为空！", "warning");
					 return;
				 }
				 if(orderBy != "" && isNaN(orderBy)){
					 $.messager.alert("提示", "排序应是数字！", "warning");
					 return;
				 }
				 
				 var dataVo = frm.$('#form1').serializeArray();
				 var dataJson =frm.convertToJson(dataVo);
				 dataVo = JSON.stringify(dataJson);
				 ajaxRequest("POST","dataVo="+dataVo,"platform/bpm/bpmconsole/wordSealAction/insertWordSeal","json","insertSealBack");
			}
		}];
		usd.createButtonsInDialog(buttons);
		usd.show();
	}
	function insertSealBack(result){
		if(result.success==true){
			$('#wordSeallist').datagrid('reload');	
			$.messager.show({title : '提示',msg : "保存成功。"});
			usd.close();
			usd=null;
		}else{
			$.messager.show({title : '提示',msg : "保存失败。"});
		}
	}
	
	//更新
	function updateWordSeal(){
		var datas = $('#wordSeallist').datagrid('getSelections');
		if(datas == null || datas.length == 0){
			$.messager.alert("操作提示", "请您选择一条记录!","info");
			return;
		}
		if(datas.length > 1){
			$.messager.alert("操作提示", "一次只能编辑一条记录!","info");
			return;
		}
		var id = datas[0].id;
		usd = new UserSelectDialog("insertWordSealDialog","650","300","avicit/platform6/bpmconsole/word/WordSealAdd.jsp?id="+id,"编辑印章");
		var buttons = [{
			text:'提交',
			id : 'wordSealSubimt',
			handler:function(){
				 var frmId = $('#insertWordSealDialog iframe').attr('id');
				 var frm = document.getElementById(frmId).contentWindow;
				 
				 var sealName = frm.$('#sealName').val();
				 var orderBy = frm.$('#orderBy').val();
				 if(sealName == ""){
					 $.messager.alert("提示", "印章名称不能为空！", "warning");
					 return;
				 }
				 if(orderBy != "" && isNaN(orderBy)){
					 $.messager.alert("提示", "排序应是数字！", "warning");
					 return;
				 }
				 
				 var dataVo = frm.$('#form1').serializeArray();
				 var dataJson =frm.convertToJson(dataVo);
				 dataVo = JSON.stringify(dataJson);
				 ajaxRequest("POST","dataVo="+dataVo,"platform/bpm/bpmconsole/wordSealAction/insertWordSeal","json","insertWordSealBack");
			}
		}];
		usd.createButtonsInDialog(buttons);
		usd.show();
	}
	function insertWordSealBack(result){
		if(result.success==true){
			$('#wordSeallist').datagrid('reload');	
			$.messager.show({title : '提示',msg : "保存成功。"});
			usd.close();
			usd=null;
		}else{
			$.messager.show({title : '提示',msg : "保存失败。"});
		}
	}
	
	//删除
	function deleteWordSeal(){
		var datas = $('#wordSeallist').datagrid('getChecked');
		if(datas == null){
			$.messager.alert("操作提示", "请您选择一条记录!","info");
			return;
		}
		var ids = '';
		for(var i=0;i<datas.length;i++){
			ids += datas[i].id + ';';
		}
		$.messager.confirm("操作提示", "您确认要删除选定的数据吗？", function (data) {
	        if (data) {
	        	easyuiMask();
	        	ajaxRequest("POST","id="+ids,"platform/bpm/bpmconsole/wordSealAction/deleteWordSeal","json","deleteWordSealBack");
	        }
		 });
	}
	function deleteWordSealBack(json){
	    $.messager.show({title : '提示',msg : "删除成功!"});
	    easyuiUnMask();
		$("#wordSeallist").datagrid('reload'); 
	}
	
</script>
<body class="easyui-layout" fit="true">
	<div region="center" border="false" style="overflow: hidden;">
		<div id="toolbar" class="datagrid-toolbar" style="height: auto;display: block;">
			<fieldset>
				<legend>查询条件</legend>
				<table class="tableForm" id="searchForm">
					<tr>
					    <td style="width:50px"></td>
						<td>印章名称</td>
						<td colspan="2"><input id="filter_LIKE_sealName" name="filter_LIKE_sealName"  class="easyui-inputbox" style="width: 150px;" /></td>
						
						<td style="width:50px"></td>
						<td ><a class="easyui-linkbutton"   iconCls="icon-search" plain="true" onclick="searchFun();" href="javascript:void(0);">查询</a><a class="easyui-linkbutton" iconCls="icon-cancel" plain="true" onclick="clearFun();" href="javascript:void(0);">清空</a>
						</td>
					</tr>
				</table>
			</fieldset>
		</div>
		<table id="wordSeallist"></table>
	</div>
	<div id="upDialog" data-options="iconCls:'icon-search',resizable:true,modal:false,buttons:'#btns'" style="width: 600px;height:200px;display: none;">
		<form id="uploadPngForm" style="padding-top:5px;" enctype="multipart/form-data" method="post">
			<table width="100%" border="0" cellspacing="1">
				<tr>
					<td align="right" width="80" style="padding-right:5px;">印章图片</td>
					<td align="left" width="155"><input type=file name="pngFile" id="pngFile"/></td>
				</tr>
			</table>
			<input type="hidden" value="" id="upId" name="upId"/>
		</form>
		<div id="btns">
    		<a class="easyui-linkbutton" plain="false" onclick="uploadPng();" href="javascript:void(0);">上传</a>
    		<a class="easyui-linkbutton" plain="false" onclick="hideUpForm();" href="javascript:void(0);">返回</a>
    	</div>
  </div>
</body>
</html>