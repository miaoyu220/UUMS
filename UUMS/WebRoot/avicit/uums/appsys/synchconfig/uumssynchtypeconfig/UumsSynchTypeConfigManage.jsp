<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "uums/appsys/synchconfig/uumssynchtypeconfig/UumsSynchTypeConfigController/UumsSynchTypeConfigInfo" -->
<title></title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include
	page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include
	page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js"
	type="text/javascript"></script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center', title:'同步方式配置'" style="background: #ffffff;">
		<div id="toolbarUumsSynchTypeConfig" class="datagrid-toolbar">
			<table>
				<tr>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_uumsSynchTypeConfig_button_add"
						permissionDes="添加">
						<td><a class="easyui-linkbutton" iconCls="icon-add"
							plain="true" onclick="uumsSynchTypeConfig.insert();"
							href="javascript:void(0);">添加</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_uumsSynchTypeConfig_button_edit"
						permissionDes="编辑">
						<td><a class="easyui-linkbutton" iconCls="icon-edit"
							plain="true" onclick="uumsSynchTypeConfig.modify();"
							href="javascript:void(0);">编辑</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_uumsSynchTypeConfig_button_delete"
						permissionDes="删除">
						<td><a class="easyui-linkbutton" iconCls="icon-remove"
							plain="true" onclick="uumsSynchTypeConfig.del();"
							href="javascript:void(0);">删除</a></td>
					</sec:accesscontrollist>
					<sec:accesscontrollist hasPermission="3"
						domainObject="formdialog_uumsSynchTypeConfig_button_query"
						permissionDes="查询">
						<td><a class="easyui-linkbutton" iconCls="icon-search"
							plain="true" onclick="uumsSynchTypeConfig.openSearchForm();"
							href="javascript:void(0);">查询</a></td>
					</sec:accesscontrollist>
				</tr>
			</table>
		</div>
		<table id="dgUumsSynchTypeConfig"
			data-options="
				fit: true,
				border: false,
				rownumbers: true,
				animate: true,
				collapsible: false,
				fitColumns: true,
				autoRowHeight: false,
				toolbar:'#toolbarUumsSynchTypeConfig',
				idField :'id',
				singleSelect: true,
				checkOnSelect: true,
				selectOnCheck: false,
				pagination:true,
				pageSize:dataOptions.pageSize,
				pageList:dataOptions.pageList,
				striped:true">
			<thead>
				<tr>
					<th data-options="field:'id', halign:'center',checkbox:true"
						width="220">主键ID</th>
					<!-- <th data-options="field:'appId', halign:'center'" width="220">应用系统</th> -->
					<th data-options="field:'appIdAlias', halign:'center'" width="220">应用系统</th>
					<th
						data-options="field:'synchType', halign:'center',formatter:formatesynchType"
						width="220">同步方式</th>
					<!-- <th
						data-options="field:'dbType', halign:'center',formatter:formatedbType"
						width="220">数据库类型</th>
					<th data-options="field:'driverClass', halign:'center'" width="220">JDBC驱动类</th>
					<th data-options="field:'connectStr', halign:'center'" width="220">JDBC连接串</th>
					<th data-options="field:'userName', halign:'center'" width="220">用户名</th>
					<th data-options="field:'password', halign:'center'" width="220">密码</th>
					<th data-options="field:'orgTable', halign:'center'" width="220">组织机构表CODE</th>
					<th data-options="field:'userTable', halign:'center'" width="220">用户表CODE</th>
					<th data-options="field:'hostIp', halign:'center'" width="220">主机地址</th>
					<th data-options="field:'hostPort', halign:'center'" width="220">端口</th>
					<th data-options="field:'orgObject', halign:'center'" width="220">组织扩展对象类</th>
					<th data-options="field:'orgOu', halign:'center'" width="220">组织根路径</th>
					<th data-options="field:'userObject', halign:'center'" width="220">用户扩展对象类</th>
					<th data-options="field:'userOu', halign:'center'" width="220">用户根路径</th>
					<th data-options="field:'wsUrl', halign:'center'" width="220">WS服务地址</th> -->
				</tr>
			</thead>
		</table>
	</div>
	<div data-options="region:'east', title:'同步映射配置'"
		style="width: 850px; background: #f5fafe;">
		<div id="uumsSynchOrgUserMapperTab" class="easyui-tabs" data-options="fit:true">
			<div title="组织映射" id = "orgTab" data-options="iconCls:'icon-dept',fit:true">
				<div id="toolbaruumsSynchOrgUserMapper" class="datagrid-toolbar">
					<table>
						<tr>
							<sec:accesscontrollist hasPermission="3"
								domainObject="formdialog_uumsSynchOrgUserMapper_button_add"
								permissionDes="添加">
								<td><a class="easyui-linkbutton" iconCls="icon-add"
									plain="true"
									onclick="insertRow('dguumsSynchOrgUserMapper');"
									href="javascript:void(0);">添加</a></td>
							</sec:accesscontrollist>
							<sec:accesscontrollist hasPermission="3"
								domainObject="formdialog_uumsSynchOrgUserMapper_button_edit"
								permissionDes="保存">
								<td><a class="easyui-linkbutton" iconCls="icon-edit"
									plain="true" onclick="saveMapperData(currentRowId, 'dguumsSynchOrgUserMapper');"
									href="javascript:void(0);">保存</a></td>
							</sec:accesscontrollist>
							<sec:accesscontrollist hasPermission="3"
								domainObject="formdialog_uumsSynchOrgUserMapper_button_delete"
								permissionDes="删除">
								<td><a class="easyui-linkbutton" iconCls="icon-remove"
									plain="true" onclick="uumsSynchOrgUserMapper.del('dguumsSynchOrgUserMapper');"
									href="javascript:void(0);">删除</a></td>
							</sec:accesscontrollist>
						</tr>
					</table>
				</div>
				<table id='dguumsSynchOrgUserMapper' class="easyui-datagrid"
					data-options="
		    		fit: true,
					border: false,
					rownumbers: true,
					animate: true,
					collapsible: false,
					fitColumns: true,
					autoRowHeight: false,
					idField :'id',
					toolbar:'#toolbaruumsSynchOrgUserMapper',
					singleSelect: true,
					checkOnSelect: true,
					selectOnCheck: false,
					pagination:false,
		            pageSize:dataOptions.pageSize,
		            pageList:dataOptions.pageList,
					striped:true">
					<thead>
						<tr>
							<th data-options="field:'id', halign:'center',checkbox:true"
								width="220">主键ID</th>
							<th data-options="field:'mainType', halign:'center',hidden:true" editor="{type:'text'}" width="220">主体类型</th>
							<th data-options="field:'columnName', halign:'center'" editor="{type:'text'}" width="220">字段名称</th>
							<th data-options="field:'columnCode', halign:'center'" editor="{type:'text'}" width="220">字段CODE</th>
							<th data-options="field:'dataType', halign:'center'" editor="{type:'combobox',
								options:{panelHeight:'auto',editable:false,valueField:'value',textField:'label',
								data:[{label: 'STRING',value: 'STRING'},{label: 'NUMBER',value: 'NUMBER'},
								{label: 'DATE',value: 'DATE'},{label: 'BLOB',value: 'BLOB'}]}}" width="220">数据类型</th>
							<th data-options="field:'orderBy', halign:'center'" editor="{type:'numberbox'}" width="120">排序</th>
							<th data-options="field:'comments', halign:'center'" editor="{type:'text'}" width="220">注释</th>
							<th data-options="field:'uumsAttribute', halign:'center'" 
								width="220">UUMS字段</th>
							<th data-options="field:'dataFormat', halign:'center'" editor="{type:'text'}" width="300">字段数据格式化 
								<a href="javascript:void(0);" title="格式：类名全路径#方法名，例：com.demo.HelloWorld#sayHello">
									<img src='static/images/platform/bpm/client/images/help.png' style="margin-bottom:-3px" border='0' width='15px' height='15px'></a></th>
							<th data-options="field:'typeId', halign:'center', hidden:true" editor="{type:'text'}" width="220">同步方式ID</th>
						</tr>
					</thead>
				</table>
			</div>
			<div title="用户映射" id = "userTab" data-options="iconCls:'icon-role',fit:true">
				<div id="toolbaruumsSynchUserMapper" class="datagrid-toolbar">
					<table>
						<tr>
							<sec:accesscontrollist hasPermission="3"
								domainObject="formdialog_uumsSynchOrgUserMapper_button_add"
								permissionDes="添加">
								<td><a class="easyui-linkbutton" iconCls="icon-add"
									plain="true"
									onclick="insertRow('dguumsSynchOrgUserMapper_user');"
									href="javascript:void(0);">添加</a></td>
							</sec:accesscontrollist>
							<sec:accesscontrollist hasPermission="3"
								domainObject="formdialog_uumsSynchOrgUserMapper_button_edit"
								permissionDes="保存">
								<td><a class="easyui-linkbutton" iconCls="icon-edit"
									plain="true" onclick="saveMapperData(currentRowId, 'dguumsSynchOrgUserMapper_user');"
									href="javascript:void(0);">保存</a></td>
							</sec:accesscontrollist>
							<sec:accesscontrollist hasPermission="3"
								domainObject="formdialog_uumsSynchOrgUserMapper_button_delete"
								permissionDes="删除">
								<td><a class="easyui-linkbutton" iconCls="icon-remove"
									plain="true" onclick="uumsSynchOrgUserMapper.del('dguumsSynchOrgUserMapper_user');"
									href="javascript:void(0);">删除</a></td>
							</sec:accesscontrollist>
						</tr>
					</table>
				</div>
				<table id='dguumsSynchOrgUserMapper_user' class="easyui-datagrid"
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
					pagination:true,
		            pageSize:dataOptions.pageSize,
		            pageList:dataOptions.pageList,
					striped:true">
					<thead>
						<tr>
							<th data-options="field:'id', halign:'center',checkbox:true"
								width="220">主键ID</th>
							<th data-options="field:'mainType', halign:'center', hidden:true" editor="{type:'text'}" width="220">主体类型</th>
							<th data-options="field:'columnName', halign:'center'" editor="{type:'text'}" width="220">字段名称</th>
							<th data-options="field:'columnCode', halign:'center'" editor="{type:'text'}" width="220">字段CODE</th>
							<th data-options="field:'dataType', halign:'center'" editor="{type:'combobox',
								options:{panelHeight:'auto',editable:false,valueField:'value',textField:'label',
								data:[{label: 'STRING',value: 'STRING'},{label: 'NUMBER',value: 'NUMBER'},
								{label: 'DATE',value: 'DATE'},{label: 'BLOB',value: 'BLOB'}]}}" width="220">数据类型</th>
							<th data-options="field:'orderBy', halign:'center'" editor="{type:'numberbox'}" width="120">排序</th>
							<th data-options="field:'comments', halign:'center'" editor="{type:'text'}" width="220">注释</th>
							<th data-options="field:'uumsAttribute', halign:'center'" 
								width="220">UUMS字段</th>
							<th data-options="field:'dataFormat', halign:'center'" editor="{type:'text'}" width="300">字段数据格式化
								<a href="javascript:void(0);" title="格式：类名全路径#方法名，例：com.demo.HelloWorld#sayHello">
									<img src='static/images/platform/bpm/client/images/help.png' style="margin-bottom:-3px" border='0' width='15px' height='15px'></a></th>
							<th data-options="field:'typeId', halign:'center', hidden:true" editor="{type:'text'}" width="220">同步方式ID</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
	
	<script
		src=" avicit/uums/appsys/synchconfig/uumssynchtypeconfig/js/UumsSynchTypeConfig.js"
		type="text/javascript"></script>
	<script
		src=" avicit/uums/appsys/synchconfig/uumssynchtypeconfig/js/UumsSynchOrgUserMapper.js"
		type="text/javascript"></script>
	<script type="text/javascript">
		var uumsSynchTypeConfig;
		var uumsSynchOrgUserMapper;
		var currentRowId="root";
		var curComId="none";
		var curDatagrid = $('#dguumsSynchOrgUserMapper');
		var currTabIndex="UUMS_ORG";
		var currDatagridInit = "false";
		$(function() {
			uumsSynchTypeConfig = new UumsSynchTypeConfig(
					'dgUumsSynchTypeConfig', '${url}', 'searchDialog',
					'uumsSynchTypeConfig');

			uumsSynchTypeConfig.setOnLoadSuccess(function() {
				uumsSynchOrgUserMapper = new UumsSynchOrgUserMapper(
						'dguumsSynchOrgUserMapper', '${surl}');
			});
			uumsSynchTypeConfig.setOnSelectRow(function(rowIndex, rowData, id) {
				currentRowId = id;
				loadMapperTable(id, currTabIndex);
			});

			uumsSynchTypeConfig.init();
			
			initTabContainer();
			
			initDataGrid(currentRowId);
		});
		
		//扩展easyui单元格编辑
		$.extend($.fn.datagrid.methods, {
		    editCell: function(jq,param){
		        return jq.each(function(){
		            var opts = $(this).datagrid('options');
		            var fields = $(this).datagrid('getColumnFields',true).concat($(this).datagrid('getColumnFields'));
		            for(var i=0; i<fields.length; i++){
		                var col = $(this).datagrid('getColumnOption', fields[i]);
		                col.editor1 = col.editor;
		                if (fields[i] != param.field){
		                    col.editor = null;
		                }
		            }
		            $(this).datagrid('beginEdit', param.index);
		            for(var i=0; i<fields.length; i++){
		                var col = $(this).datagrid('getColumnOption', fields[i]);
		                col.editor = col.editor1;
		            }
		        });
		    }
		});
		
		// 初始化TAB标签页，并添加选择事件处理
		function initTabContainer() {
			$('#uumsSynchOrgUserMapperTab').tabs({
				onSelect : function(title, index) {
					if (index == 0) {
						currTabIndex = "UUMS_ORG";
						curDatagrid = $('#dguumsSynchOrgUserMapper');
						loadMapperTable(currentRowId, currTabIndex);
					}
					if (index == 1) {
						currTabIndex = "UUMS_USER";
						curDatagrid = $('#dguumsSynchOrgUserMapper_user');
						loadMapperTable(currentRowId, currTabIndex);
					}
					if(index == 2){
						addTab('定时任务管理','avicit/platform6/modules/system/quartz/jobMaintainManager.jsp','static/images/platform/sysmenu/icons.gif','sysjob','-100px -40px');
						//return false;
					}
				}});
		}
		
		// 加载数据
		function loadMapperTable(pid, uumsType){
			return curDatagrid.datagrid({url : "${surl}getUumsSynchOrgUserMapper/"+ pid+"/"+uumsType});
		}
		
		//以下为动态编辑行
		var editIndex = undefined;//当前正在编辑的行
		function insertRow(datagridId){
			endEditing(datagridId);
			$('#'+datagridId).datagrid('insertRow',{
				index: 0,
				//row:{id:""}
				row:{id:"",mainType:currTabIndex,typeId:currentRowId}
			});
		}
		// 结束行编辑
		function endEditing(datagridId){
		    if (editIndex == undefined){return true;}
		    	$('#'+datagridId).datagrid('endEdit', this.editIndex).datagrid('unselectRow',this.editIndex);
		        editIndex = undefined;
		        return true;
		};
		
		// 初始化DataGrid
		function initDataGrid(pid){
			var _datagrid_org;
			var _datagrid_user;
			_datagrid_org =$('#dguumsSynchOrgUserMapper').datagrid({
				onLoadSuccess: function(data){
					currDatagridInit = data.init;
					endEditing('dguumsSynchOrgUserMapper');
					_datagrid_org.datagrid('clearChecked').datagrid('clearSelections');
				},
				onClickRow: function(index, field, value){
					if (endEditing('dguumsSynchOrgUserMapper')){
						_datagrid_org.datagrid('beginEdit', index);
						editIndex = index;
						return true;
					}
					return false;
				}
			});
			_datagrid_user =$('#dguumsSynchOrgUserMapper_user').datagrid({
				onLoadSuccess: function(data){
					currDatagridInit = data.init;
					endEditing('dguumsSynchOrgUserMapper_user');
					_datagrid_user.datagrid('clearChecked').datagrid('clearSelections');
				},
				onClickRow: function(index, field, value){
					if (endEditing('dguumsSynchOrgUserMapper_user')){
						_datagrid_user.datagrid('beginEdit', index);
						editIndex = index;
						return true;
					}
					return false;
				}
			});
		}
		
		// 验证必填项
		function validate(_datagrid){
			if(!endEditing(_datagrid)){
				$.messager.alert('提示','不能保存，请确保上一条数据填写完整','warning');
				return false;
			}
			
			var accessRows = $('#'+_datagrid).datagrid('getChanges');
			
			var l = accessRows.length;
			var length=l;
			var row;
			for(;l--;){
				row =accessRows[l];
				if(!row.columnName){
					$.messager.show({
						 title : '提示',
						 msg : '第'+(length-l)+'条数据中,字段名称不能为空!'
					 });
					return false;
				}
				if(!row.columnCode){
					$.messager.show({
						 title : '提示',
						 msg : '第'+(length-l)+'条数据中,字段CODE不能为空!'
					 });
					return false;
				}
				if(!row.dataType){
					$.messager.show({
						 title : '提示',
						 msg : '第'+(length-l)+'条数据中,数据类型不能为空!'
					 });
					return false;
				}
				if(row.dataFormat){
					var str = row.dataFormat;
					if(str.indexOf('#') == -1){
						$.messager.show({
							 title : '提示',
							 msg : '第'+(length-l)+'条数据中,字段数据格式化填写格式不正确!正确格式为：类全路径#方法名，如：com.avicit.HelloWorld#sayHello'
						 });
						return false;
					}
				}
			}
			return true;
		}
		
		//保存功能
		function saveMapperData(pid, datagridId){
			endEditing(datagridId);
			/* if(!validate(datagridId)){
				return false;
			} */
			
			var accessRows;
			if(currDatagridInit == 'true'){
				accessRows = curDatagrid.datagrid('getRows');
			}else{
				accessRows = curDatagrid.datagrid('getChanges');
				if(accessRows.length == 0 ){
					$.messager.show({
						title: '提示',
						msg: '没有修改数据！'
					})
					return;
				}
			}
			/*if(accessRows.length > 0){
				var reg =/\s/;
				for (var i=0;i<accessRows.length;i++){
					if(reg.test(accessRows[i].lookupName)){
						$.messager.alert('提示',"系统代码名称不能为空或含有空格字符，请检查！",'warning');
						return;
					}
					if(reg.test(accessRows[i].lookupCode)){
						$.messager.alert('提示',"系统代码值不能为空或含有空格字符，请检查！",'warning');
						return;
					}
				}
			}*/
			$.ajax({
				 url: '${surl}save',
				 data : {datas:JSON.stringify(accessRows)},
				 type : 'post',
				 dataType : 'json',
				 success : function(r){
					 if (r.flag == "success"){
						 reLoad();
						$.messager.show({
							 title : '提示',
							 msg : '保存成功！'
						 });
					 }else{
						 $.messager.show({
							 title : '提示',
							 msg : r.error
						});
					 }
				 }
			 });
		};
		// 重载数据
		function reLoad(){
			curDatagrid.datagrid('load',{}).datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
		};
		
		function formateDate(value, row, index) {
			return uumsSynchTypeConfig.formate(value);
		}
		function formateDateTime(value, row, index) {
			return uumsSynchTypeConfig.formateTime(value);
		}
		//uumsSynchTypeConfig.detail(\''+row.id+'\')
		function formateHref(value, row, inde) {
			return '<a href="javascript:void(0);" onclick="uumsSynchTypeConfig.detail(\''
					+ row.id + '\');">' + value + '</a>';
		}
		function formatedbType(value) {
			return Platform6.fn.lookup.formatLookupType(value,
					uumsSynchTypeConfig.dbType);
		}
		function formatesynchType(value) {
			return Platform6.fn.lookup.formatLookupType(value,
					uumsSynchTypeConfig.synchType);
		}

		function formatedataType(value) {
			return Platform6.fn.lookup.formatLookupType(value,
					uumsSynchOrgUserMapper.dataType);
		}
		
		function formatTip(value,rowData,rowIndex){
			var val = "<a href='#' title='This is the tooltip message.' class='easyui-tooltip'>Hover me</a>";
			return val;
		}
	</script>
</body>
</html>