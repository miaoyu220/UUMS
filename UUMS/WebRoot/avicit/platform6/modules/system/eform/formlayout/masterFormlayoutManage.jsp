<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>单位列表</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js" type="text/javascript"></script>
</head>
<body class="easyui-layout"  fit="true">
<input  id="tableId"  value="${tableId}"   type="hidden"  />
<input  id="subtableId"  value="${subtableId}"   type="hidden"  />
<input  id="subfk"  value="${subfk}"   type="hidden"  />
<div data-options="region:'center',split:true,border:false" style="padding:0px;overflow:hidden;">
	<!-- LIST表单 start-->
	<table id="dg"  class="easyui-datagrid"  url="platform/eform/formlayout/list.json?tableId=${tableId}" fit="true" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true" autoRowHeight="false" striped="true">
		<thead>
			<tr>
				<th data-options="field:'ID', halign:'center',checkbox:true" width="50">id</th>
				<c:forEach items="${tabColumns}"   var="item"  >
						<c:choose>
						   <c:when test="${item.colType== 'DATE'}">  
						   		<th data-options="field:'${item.colName}',required:true,align:'center'"  width="100"  formatter="Common.DateFormatter">${item.colLabel}</th>
						   </c:when>
						   <c:otherwise> 
						   				<c:if test="${item.attribute01== null}">
						   						<th data-options="field:'${item.colName}',required:true,align:'center'"  width="100">${item.colLabel}</th>
						   				</c:if>
						   				<c:if test="${item.attribute01!= null}">
						   						<th data-options="field:'${item.colName}Value',required:true,align:'center'"  width="100"   >${item.colLabel}</th>
						   				</c:if>
						   </c:otherwise>
						</c:choose>
				</c:forEach>
			</tr>
		</thead>
	</table>
	<!-- CRUD工具栏 -->
	<div id="toolbar">
		<table>
		<tr>
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newObj()">添加</a></td>
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editObj()">编辑</a></td>
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="deleteObj()">删除</a></td>
		<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="queryObj()">查询</a></td>
		</tr>
		</table>
	</div>
	<!-- LIST表单 end-->
	
	<!-- SEARCH表单 start-->
     <div id="searchdlg" class="easyui-dialog" data-options="iconCls:'icon-search',resizable:true,modal:false,buttons:'#searchBtns'"  style="width: 600px;height:250px; visible: hidden" title="搜索" closed="true" >
			<form id="searchfm" method="post">
	    		<table>
	    		<c:forEach items="${searchColumns}"   var="item"  >
	    			<tr>
	    			<c:choose>
						   <c:when test="${item.colType== 'DATE'}">  
						   		<td>${item.colLabel}:</td> 
						   		<td><input name="${item.colName}" type='text'  class="easyui-datetimebox" ></input></td>
						   </c:when>
						   <c:otherwise> 
						   				
						   				<c:if test="${item.attribute01== null  and item.colRuleName!=null}">
						   						<td>${item.colLabel}:</td> 
						   						<td>
						   								<input id="${item.colName}"  name="${item.colName}"  class="easyui-textbox"   type="hidden"></input>
						   								<div class=""><input class="easyui-validatebox"  name="${item.colName}Name"   id="${item.colName}Name"  readOnly="readOnly" style="width:170px;" ></input></div>
						   						</td>
						   				</c:if>
						   				
						   				<c:if test="${item.attribute01== null  and item.colRuleName== null }">
						   						<td>${item.colLabel}:</td> 
						   						<td><input name="${item.colName}" type='text'></input></td>
						   				</c:if>
						   				
						   				<c:if test="${item.attribute01!= null}">
						   						<td>${item.colLabel}:</td> 
						   						<td width="80" align="right">
								   						<select name="${item.colName}" class="easyui-combobox" data-options="width:172,editable:false,panelHeight:'auto'">
																		<c:forEach items="${item.sysLookupList}"   var="itemlookup"  >
																				<option value="${itemlookup.lookupCode}">${itemlookup.lookupName}</option>
																		</c:forEach>
														</select>
						   						</td>
						   				</c:if>
						   </c:otherwise>
						</c:choose>
						</tr>
	    		</c:forEach>
	    		</table>
	    	</form>
	    	<div id="searchBtns">
	    		<a class="easyui-linkbutton" plain="false" onclick="searchObj();" >查询</a>
	    		<a class="easyui-linkbutton" plain="false" onclick="javascript:$('#searchdlg').dialog('close')" >返回</a>
	    	</div>
	    </div>
	 <!-- SEARCH表单 end-->
	    
	</div>
	
	
	<div data-options="region:'east'" style="width:550px;background:#f5fafe;">
				<table id="dgsub"  class="easyui-datagrid"   fit="true" toolbar="#toolbarsub" pagination="false" rownumbers="true" fitColumns="true" singleSelect="true" autoRowHeight="false" striped="true">
					<thead>
						<tr>
							<th data-options="field:'ID', halign:'center',checkbox:true" width="50">id</th>
							<c:forEach items="${subtabColumns}"   var="item"  >
									<c:choose>
									   <c:when test="${item.colType== 'DATE'}">  
									   		<th data-options="field:'${item.colName}',required:true,align:'center'"  width="100"  formatter="Common.DateFormatter">${item.colLabel}</th>
									   </c:when>
									   <c:otherwise> 
									   				<c:if test="${item.attribute01== null}">
									   						<th data-options="field:'${item.colName}',required:true,align:'center'"  width="100">${item.colLabel}</th>
									   				</c:if>
									   				<c:if test="${item.attribute01!= null}">
									   						<th data-options="field:'${item.colName}Value',required:true,align:'center'"  width="100"   >${item.colLabel}</th>
									   				</c:if>
									   </c:otherwise>
									</c:choose>
							</c:forEach>
						</tr>
					</thead>
				</table>
				<!-- CRUD工具栏 -->
				<div id="toolbarsub">
					<table>
					<tr>
					<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="subnewObj()">添加</a></td>
					<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="subeditObj()">编辑</a></td>
					<td><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="subdeleteObj()">删除</a></td>
					</tr>
					</table>
				</div>
	
	</div>
	
	
	<!-- button js event -->
	<script type="text/javascript">
		var baseurl = '<%=request.getContextPath()%>';
		var url;
		
		function queryObj() {
			var tableId=$('#tableId').val();
			$('#searchdlg').dialog('open');
			$('#searchfm').form('clear');
			url = 'platform/eform/formlayout/list.json?tableId='+tableId;
		}
		
		function searchObj(){
			$('#searchfm').form('submit', {
				url : url,
				onSubmit : function() {
					return $(this).form('validate');
				},
				success : function(result) {
						var results=$.parseJSON(result);
						$('#dg').datagrid('loadData',results); 
						$('#searchdlg').dialog('close'); 
				}
			});
		}
		
		function newObj() {
			var tableId=$('#tableId').val();
			url = 'platform/eform/formlayout/add?tableId='+tableId;
			var  dlg = new CommonDialog("insert","600","400",url,"添加",false,true,false);
			dlg.show();
		}
		
		function editObj() {
			var tableId=$('#tableId').val();
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				url = 'platform/eform/formlayout/get?id=' + row.ID+'&tableId='+tableId;
				var  dlg = new CommonDialog("update","600","400",url,"编辑",false,true,false);
				dlg.show();
			}
		}
		
		
		function deleteObj() {
			url='platform/eform/formlayout/delete.json';
			var row = $('#dg').datagrid('getSelected');
			var tableId=$('#tableId').val();
			if (row) {
				$.messager.confirm('',
						'确认删除吗?',
						function(r) {
							if (r) {
								$.post(url, {
									id : row.ID,
									tableId : tableId
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
		
		
		
		function subnewObj() {
			var subtableId=$('#subtableId').val();
			var tableId=$('#tableId').val();
			var row = $('#dg').datagrid('getSelected');
			if (row) {
				url = 'platform/eform/formlayout/add?tableId='+subtableId+'&ptableId='+tableId+'&fkvalue='+row.ID;
				var  dlg = new CommonDialog("insert","600","400",url,"添加",false,true,false);
				dlg.show();
			}
			
		}
		
		function subeditObj() {
			var subtableId=$('#subtableId').val();
			var tableId=$('#tableId').val();
			var row = $('#dgsub').datagrid('getSelected');
			if (row) {
				url = 'platform/eform/formlayout/get?id=' + row.ID+'&tableId='+subtableId+'&ptableId='+tableId;
				var  dlg = new CommonDialog("update","600","400",url,"编辑",false,true,false);
				dlg.show();
			}
		}
		
		
		
		function subdeleteObj() {
			url='platform/eform/formlayout/delete.json';
			var row = $('#dgsub').datagrid('getSelected');
			var subtableId=$('#subtableId').val();
			if (row) {
				$.messager.confirm('',
						'确认删除吗?',
						function(r) {
							if (r) {
								$.post(url, {
									id : row.ID,
									tableId : subtableId
								}, function(result) {
									if (result.success) {
										
										var row=$('#dg').datagrid('getSelected');
						        		if(row){
						        			var id=row.ID;
						        			var subtableId=$('#subtableId').val();
						        			url = 'platform/eform/formlayout/list.html?'+'${subfk}'+'='+id;
						    				$.post(url, {
						    					tableId : subtableId
						    				}, function(result) {
						    					$('#dgsub').datagrid('loadData',result);
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
		
		
		
		
		
		function dlg_close(id){
				$('#'+id).dialog('close');
		}
		
		function dg_reload(id){
			$('#'+id).datagrid('reload'); 
		}
		
		function dgsub_reload(){
			var row=$('#dg').datagrid('getSelected');
    		if(row){
    			var id=row.ID;
    			var subtableId=$('#subtableId').val();
    			url = 'platform/eform/formlayout/list.html?'+'${subfk}'+'='+id;
				$.post(url, {
					tableId : subtableId
				}, function(result) {
					$('#dgsub').datagrid('loadData',result);
				}, 'json');
    		}
		}
		
		
		var Common = {
			    DateFormatter: function (value, rec, index) {
			        if (value == undefined) {
			            return "";
			        }
			        return new Date(value).format("yyyy-MM-dd hh:mm:ss");
			    },
		
				LookUpFormatter: function (value, rec, index){
					//return Platform6.fn.lookup.formatLookupType(value, demoBusinessTrip.traffic);
				}
			};
		
		$(function(){
			
			<c:forEach items="${selectColumns}"   var="item"  >
					var ${item.colName}CommonSelector = new CommonSelector("${item.colRuleName}","${item.colRuleName}SelectCommonDialog","${item.colName}","${item.colName}Name");
					${item.colName}CommonSelector.init();  
			</c:forEach>
			
		});
		
		
		$('#dg').datagrid({
        	onClickRow:function(index,data)
        	{
        		var row=$('#dg').datagrid('getSelected');
        		if(row){
        			var id=row.ID;
        			var subtableId=$('#subtableId').val();
        			url = 'platform/eform/formlayout/list.html?'+'${subfk}'+'='+id;
    				$.post(url, {
    					tableId : subtableId
    				}, function(result) {
    					$('#dgsub').datagrid('loadData',result);
    				}, 'json');
        		}
        	}
        })
		
		
	</script>
</body>
</html>