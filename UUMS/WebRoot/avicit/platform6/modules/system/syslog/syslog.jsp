<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="avicit.platform6.commons.utils.ComUtil"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>日志审计信息</title>
<base href="<%=ComUtil.getRequestPath(request) %>">
<link href="static/css/platform/sysdept/icon.css" type="text/css" rel="stylesheet">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>

</head>
<body class="easyui-layout" fit="true">
	<c:if test= "${m}">
		<div data-options="region:'west',split:true,title:'应用列表',collapsible:false" style="width:150px;">
			 	<div id="toolbarTree" class="datagrid-toolbar">
				 	<table width="100%">
				 		<tr>
				 			<td width="100%"><input type="text"  name="searchApp" id="searchApp"></input></td>
				 		</tr>
				 	</table>
		 	 	</div>
		 		<ul id="apps">正在加载应用列表...</ul>
	 	</div>
 	</c:if>
 	<div data-options="region:'center',split:true" style="padding:0px;">
      <div class="easyui-layout" data-options="fit:true">     	  
		<div id="toolbar" class="datagrid-toolbar" style="height:auto;display: block;">
			<table >
				<tr>
					<td>
						<a class="easyui-menubutton"  data-options="menu:'#export',iconCls:'icon-export'" href="javascript:void(0);">导出日志</a>
						<a id="btSearch" class="easyui-linkbutton" iconCls="icon-search"  plain="true" onclick="showSearch();" href="javascript:void(0);">查询</a>
					</td>
				</tr>
			</table>
			<div id="export" style="width:150px;display: none;">
				<div data-options="iconCls:'icon-excel'" onclick="exportClientData();">Excel导出(客户端)</div>
				<div data-options="iconCls:'icon-excel'" onclick="exportServerData();">Excel导出(服务器端)</div>
			</div>
		</div>
		
	<div data-options="region:'center',split:true,title:''" style="padding:0px;">	
		<table id="sysLoglist" class="easyui-datagrid"
			data-options=" 
				fit: true,
				border: false,
				rownumbers: false,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#toolbar',
				idField :'id',
				singleSelect: true,
				checkOnSelect: true,
				selectOnCheck: false,
				
				pagination:true,
				pageSize:dataOptions.pageSize,
				pageList:dataOptions.pageList,
				onLoadSuccess:cellTip,
				striped:true,
				queryParams:{'':''}		
				">
			<thead>
				<tr>
					<th data-options="field:'id', hidden:true" >id</th>
					<th data-options="field:'syslogUsernameZh',halign:'center',align:'left'" width="100">操作人</th>
					<th data-options="field:'syslogIp',required:true,halign:'center',align:'left',sortable:true" width="150">操作人IP</th>
					<th data-options="field:'syslogTime',required:true,halign:'center',align:'left', formatter: formatDate,sortable:true" editor="{type:'text'}" width="220">操作时间</th>
					<th data-options="field:'syslogModule',halign:'center',align:'left',sortable:true"  width="150">模块名称</th>
					<th data-options="field:'syslogTitle',halign:'center',align:'left',sortable:true" width="600">日志内容</th>
					<th data-options="field:'syslogOp',halign:'center',align:'left',sortable:true"  width="100">操作类型</th>
					<th data-options="field:'syslogType',halign:'center',align:'left'"  width="150">日志类型</th>
					<th data-options="field:'sysApplicationId',halign:'center',align:'left',formatter: formatApp"  width="150">来源</th>
				</tr>
			</thead>
		</table>	
	 </div>
	 
	</div>
  </div>
  <div id="searchDialog" class="easyui-dialog" data-options="iconCls:'icon-search',resizable:true,modal:false,buttons:'#searchUserBtns'" 
			style="width: 500px;height:220px; visible: hidden" title="搜索用户">
			<form id="searchForm">
	    		<table class="tableForm" id="searchForm" width='100%'>
					<tr>
						<td >操作人：</td>
						<td><input name="syslogUsernameZh" id="syslogUsernameZh" editable="false" style="width: 150px;" />
						<td>操作类型：</td>
						<!-- ,{label: 'logout',value: '注销'} 去除注销类型查询 -->
						<td><input name="syslogOp" id="syslogOp" class="easyui-combobox" style="width: 150px;" data-options="editable:false,panelHeight:'auto',valueField: 'label',textField: 'value',data: [{label: 'insert',value: '插入'},{label: 'delete',value: '删除'},{label: 'update',value: '修改'},{label: 'select',value: '查看'},{label: 'login',value: '登录'}]"/>
						</td>
					</tr>
					<tr>	
						<td>日志类型：</td>
						<td><input name="syslogType" id="syslogType" class="easyui-combobox" style="width: 150px;" data-options="
							valueField:'lookupCode',
							textField:'lookupName',
							editable:false,
							panelHeight:'auto',
							url:'platform/syslog/initSysLogType.json'
						"/>
						     
						</td>
						<td>模块名称：</td>
						<td><input name="syslogModule" id="syslogModule" editable="false" style="width: 150px;" />
					</tr>
					
					<tr>
						<td>操作时间从：</td>
						<td><input name="startDateBegin" id="startDateBegin" class="easyui-datetimebox" editable="false" style="width:150px;" />
						</td>
						<td>操作时间(至)：</td>
						<td><input name="startDateEnd" id="startDateEnd"  class="easyui-datetimebox" editable="false" style="width: 150px;" />
						</td>
					</tr>
					<tr>
						<td>日志内容：</td>
						<td><input name="syslogTitle" id="syslogTitle"  editable="false" style="width: 150px;" />
						</td>
						<td>操作人IP：</td>
						<td><input name="syslogIp" id="syslogIp"  editable="false" style="width: 150px;" />
						</td>
						
					</tr>
					
				</table>
	    	</form>
	    	<div id="searchUserBtns">
	    		<a class="easyui-linkbutton" plain="false" onclick="searchFun();" href="javascript:void(0);">查询</a>
	    		<a class="easyui-linkbutton" plain="false" onclick="clearFun();" href="javascript:void(0);">清空</a>
	    		<a class="easyui-linkbutton" plain="false" onclick="hideSearch();" href="javascript:void(0);">返回</a>
	    	</div>
	    </div>
<script src="static/js/platform/component/common/exportData.js" type="text/javascript"></script>
<script src="avicit/platform6/centralcontrol/sysapp/js/SysAppTree.js" type="text/javascript"></script>
<script type="text/javascript">
var APPLICATION ='${d}';
(function(func){
	$.ajax({
		url: 'platform/sysApps/sysApplicationMap.json',
		type :'get',
		dataType :'json',
		success :func
	});
})(function(r){r.json&&(APPLCATION=r.json);});

//var queryParams;
var sysAppTree;
var m=${m};
$(document).ready(function(){ 
	$('#searchDialog').dialog('close');
	$('#searchForm').find('input').on('keyup',function(e){
		if(e.keyCode == 13){
			searchFun();
		}
	});
	if(${m}){
		sysAppTree = new SysAppTree('apps','searchApp',APP_.PRIVATE,null,120);
		
		sysAppTree.setOnLoadSuccess(function(){
		});
		sysAppTree.setOnSelect(function(_sysAppTree,node){
			APPLICATION=node.id;
			loadRoleInfo(APPLICATION);
		});
		sysAppTree.init();
	}else{
		loadRoleInfo(APPLICATION);
	}
	
});
/**
 * 加载群组信息
 */
function loadRoleInfo(appId){
	$('#sysLoglist').datagrid("options").url ="platform/syslog/getSysLogDataByPage/"+appId+".json";
	var opts = $("#sysLoglist").datagrid('options');
   	var pager = $("#sysLoglist").datagrid('getPager');
   	opts.pageNumber = 1;
   	pager.pagination('refresh',{
   	    	pageNumber:1
   	});
	$('#sysLoglist').datagrid("reload",{});
};
var _a={};
//查询
function searchFun(){
    //var _a={};
    _a.syslogOp =$('#syslogOp').combobox('getValue').trim();
    _a.syslogType =$('#syslogType').combobox('getValue').trim();
    _a.syslogUsernameZh = $('#syslogUsernameZh').attr('value').trim();
    _a.syslogModule = $('#syslogModule').attr('value').trim();	
    _a.syslogTitle = $('#syslogTitle').attr('value').trim();	
    _a.syslogTimeBegin = $('#startDateBegin').datetimebox('getValue').trim();	
    _a.syslogTimeEnd = $('#startDateEnd').datetimebox('getValue').trim();	
    _a.syslogIp = $('#syslogIp').attr('value').trim();	
    $("#sysLoglist").datagrid('reload',{ param : JSON.stringify(_a)});
}
//查询选项重置
function clearFun(){
	$('#searchForm input').val('');
	$('#searchForm select').val('');
	_a={};
}

function formatDate(value)
{
	var newDate=new Date(value);
	return newDate.Format("yyyy-MM-dd hh:mm:ss");   
};
function formatApp(value){
	var _t=APPLCATION;
	var l=_t.length;
	for(;l--;){
		if(_t[l].id == value){
			return _t[l].name;
		}
	}
};

function cellTip(data){
	$('#sysLoglist').datagrid('doCellTip',   
	{   
		onlyShowInterrupt:false,   
		position:'bottom',
		tipStyler:{'backgroundColor':'#FFFFFF',boxShadow:'1px 1px 3px #292929'}
	}); 
};

function showSearch()
{
	$('#searchDialog').dialog('open');
};

function hideSearch()
{
	$('#searchDialog').dialog('close');
};
/**
 * 导出日志(客户端数据)
 */
function exportClientData(){
	$.messager.confirm('确认','是否确认导出Excel文件?',function(r) {
        if (r) {
            //封装参数
            var columnFieldsOptions = getGridColumnFieldsOptions('sysLoglist');
            var dataGridFields = JSON.stringify(columnFieldsOptions[0]);
            var rows = $('#sysLoglist').datagrid('getRows');
            var datas = JSON.stringify(rows);
            var myParams = {
                dataGridFields: dataGridFields,//表头信息集合
                datas: datas,//数据集
                unContainFields:'id',
                hasRowNum : true,//默认为Y:代表第一列为序号
                sheetName: 'sheet1',//如果该参数为空，默认为导出的Excel文件名
                fileName: '平台日志导出数据'+ new Date().toString()//导出的Excel文件名
            };
            var url = "platform/syslog/exportClient";
            var ep = new exportData("xlsExport","xlsExport",myParams,url);
            ep.excuteExport();
        }
       });
}
/**
 * 导出日志(服务端数据)
 */
function exportServerData(){
	$.messager.confirm('确认','是否确认导出Excel文件?',function(r) {
        if (r) {   
            //封装参数
            var columnFieldsOptions = getGridColumnFieldsOptions('sysLoglist');
            var dataGridFields = JSON.stringify(columnFieldsOptions[0]);
            
            var expSearchParams ={};
            
            expSearchParams.dataGridFields=dataGridFields;
            expSearchParams.hasRowNum=true;
            expSearchParams.sheetName='sheet1';
            expSearchParams.unContainFields='id';//由于id没有chechbox，所以需要显示的过滤掉
            expSearchParams.fileName='平台日志导出数据'+ new Date().toString();
            expSearchParams.param = JSON.stringify(_a);
            expSearchParams.appid=APPLICATION;
            var url = "platform/syslog/exportServer";
            var ep = new exportData("xlsExport","xlsExport",expSearchParams,url);
            ep.excuteExport();
        }
       });
}

</script>
</body>
</html>