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
<div data-options="region:'center',split:true,border:false" style="overflow:hidden;padding-bottom:35px;">	
	<!-- ADD表单 start-->
		<form id="fm" method="post" novalidate>
		<input  id="tableId"  value="${tableId}"   type="hidden"  />
			<table>
				<c:forEach items="${formColumns}"   var="item"  >
					<tr>
						<c:choose>
						   <c:when test="${item.colType== 'DATE'}">  
						   		<th>${item.colLabel}:</th> 
						   		<td width="80" align="right"><input id="${item.colName}"   name="${item.colName}" class="easyui-datetimebox" required="true" ></input></td>
						   </c:when>
						   <c:otherwise> 
						   				<c:if test="${item.attribute01== null  and item.colRuleName!=null}">
						   						<th>${item.colLabel}:</th> 
						   						<td width="80" align="right">
						   								<input id="${item.colName}"   name="${item.colName}" class="easyui-textbox" required="true" type="hidden" ></input>
						   								<div class=""><input class="easyui-validatebox"  name="${item.colName}Name"   id="${item.colName}Name"  readOnly="readOnly" style="width:170px;" ></input></div>
						   						</td>
						   				</c:if>
						   				
						   				<c:if test="${item.attribute01== null  and item.colRuleName== null and item.colName eq ptable.subColumnName}">
						   						<td width="80" align="right"><input id="${item.colName}"   name="${item.colName}" class="easyui-textbox" required="true"  value="${fkvalue}"  type="hidden"></input></td>
						   				</c:if>
						   				
						   				<c:if test="${item.attribute01== null  and item.colRuleName== null and item.colName ne ptable.subColumnName}">
						   						<th>${item.colLabel}:</th> 
						   						<td width="80" align="right"><input id="${item.colName}"   name="${item.colName}" class="easyui-textbox" required="true"></input></td>
						   				</c:if>
						   				
						   				<c:if test="${item.attribute01!= null}">
						   						<th>${item.colLabel}:</th> 
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
		
		<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>	
					<td width="50%" align="right">
						<a href="javascript:void(0)" class="easyui-linkbutton"  onclick="saveObj()" >保存</a>
						<a href="javascript:void(0)" class="easyui-linkbutton"  onclick="javascript:parent.dlg_close('insert')" >返回</a>
					</td>
				</tr>
			</table>
		</div>
	<!-- ADD表单 end-->
	</div>
	
	<!-- button js event -->
	<script type="text/javascript">
		var baseurl = '<%=request.getContextPath()%>';
		var url;
		
		function saveObj() {
			var tableId=$('#tableId').val();
			url = 'platform/eform/formlayout/add?tableId='+tableId;
			$('#fm').form('submit', {
				url : url,
				onSubmit : function() {
					return $(this).form('validate');
				},
				success : function(result) {
					var result = eval('(' + result + ')');
					if (result.errorMsg) {
						$.messager.show({
							title : 'Error',
							msg : result.errorMsg
						});
					} else {
						parent.dgsub_reload();
						parent.dlg_close('insert');
					}
				}
			});
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
		
	</script>
</body>
</html>