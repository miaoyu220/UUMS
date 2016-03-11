<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<html>
<head>
	<%
		String id = request.getParameter("id");
	%>
	
	<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/bpmclient/bpm/ProcessCommonJsInclude.jsp"></jsp:include>
	<title>印章</title>
	<style>
		body td{
			font-family: Microsoft Yahei,sans-serif,Arial,Helvetica;
			font-size: 12px;
			padding-left: 0.5em;
		}
	</style>
	<script type="text/javascript">
		var baseurl = '<%=request.getContextPath()%>';
		$(function(){
			ajaxRequest("POST","id=<%=id%>","platform/bpm/bpmconsole/wordSealAction/getWordSeal","json","getWordSealBack");
	    });
	   
	   	function getWordSealBack(retValue){
	    	var wordSeal=retValue.obj;
	    	$("#id").attr("value",wordSeal.id); 
	    	$("#sealName").attr("value",wordSeal.sealName);
	    	$("#orderBy").attr("value",wordSeal.orderBy); 
	    	$("#sealAdmins").attr("value",wordSeal.sealAdmins); 
	    	$("#remark").attr("value",wordSeal.remark); 
	    	$("#version").attr("value",wordSeal.version);
	    	$("#createdBy").attr("value",wordSeal.createdBy);
	    	$("#creationDate").attr("value",wordSeal.creationDate);
	    }
	</script>
</head>

<body class="easyui-layout" fit="true">
	<div region="center" border="false" style="overflow: hidden;">
		<form id="form1" method="post">
        	<table class="tableForm" width="100%" border=0>
				<tr>
					<td >印章名称</td>
					<td ><input id="sealName"  name="sealName" required="true" class="easyui-validatebox"/></td>
					<td>印章排序</td>
					<td ><input id="orderBy"  name="orderBy" class="easyui-validatebox"/></td>
				</tr>
				<tr>
					<td>可访问的角色</td>
					<td colspan="3"><input id="sealAdmins" title="多个角色以逗号分隔" name="sealAdmins" class="easyui-validatebox"/></td>
				</tr>
				<tr>
					<td>印章描述</td>
					<td colspan="3"> 
						<textarea name="remark" id="remark" class="easyui-validatebox" style="height:60px;width:480px;"></textarea>
					</td>
				</tr>
			</table>
			
			<input type="hidden" id="id"  name="id"/>
			<input type="hidden" id="version"  name="version"/>
			<input type="hidden" id="createdBy"  name="createdBy"/>
			<input type="hidden" id="creationDate"  name="creationDate"/>
		</form>
	</div>
</body>
</html>

