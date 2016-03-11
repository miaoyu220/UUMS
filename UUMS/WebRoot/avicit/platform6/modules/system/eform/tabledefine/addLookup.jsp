<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@page import="avicit.platform6.api.session.SessionHelper"%>
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
<%
	long timestamp = System.currentTimeMillis();
	String language =SessionHelper.getCurrentLanguageCode(request);
	String appId = SessionHelper.getApplicationId();
%>
<body>
<body class="easyui-layout"  fit="true">
<div data-options="region:'center',split:true,border:false" style="overflow:hidden;padding-bottom:35px;">	
		<input  id="columnId"  value="${columnId}"   type="hidden"  />
		
		<table id="tablelookup" class="easyui-datagrid"  fit="true"  pagination="true" rownumbers="true" fitColumns="true" singleSelect="true" autoRowHeight="false" striped="true" url="platform/eform/tabledefine/<%=timestamp%>/<%=appId%>/<%=language%>/allSysLookupType.json"   > 
								<thead>
										<tr> 
								        	<th data-options="field:'id', halign:'center',checkbox:true" width="220">id</th>
								        	<th data-options="field:'sid', halign:'center',hidden:true" width="220">sid</th>
								        	<th data-options="field:'lookupTypeName',align:'center'"  width="320">系统代码名称</th>
								        	<th data-options="field:'lookupType',align:'center'"  >系统代码值</th>
											<th data-options="field:'validFlag',align:'center'" 	 width="220">有效标识</th>
											<th data-options="field:'description',align:'center'"  width="220">描述</th>
								        </tr>
									</thead>
		</table>
		<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>	
					<td width="50%" align="right">
						<a href="javascript:void(0)" class="easyui-linkbutton"  onclick="savelookup()" >保存</a>
						<a href="javascript:void(0)" class="easyui-linkbutton"  onclick="javascript:parent.dlg_close('insert')" >返回</a>
					</td>
				</tr>
			</table>
		</div>
		
</div>


<!-- button js event -->
	<script type="text/javascript">
		var baseurl = '<%=request.getContextPath()%>';
		var url;
		
		function savelookup() {
			var columnId=$('#columnId').val();
			url = 'platform/eform/tabledefine/savelookup';
			
			var row=$('#tablelookup').datagrid('getSelected');
			if(row){
				var lookupType=row.lookupType;
				$.post(url, {
					lookupType:lookupType,
					columnId:columnId
				}, function(result) {
					parent.dlg_close('newlookup');
				}, 'json');
			}
		}
		
	</script>
</body>
</html>