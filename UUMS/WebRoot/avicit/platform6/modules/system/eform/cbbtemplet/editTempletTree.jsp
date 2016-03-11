<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	String parentTempType = request.getAttribute("parentTempType").toString();
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>编辑</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
</style>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false" style="overflow:hidden;padding-bottom:35px;">
		<form id='form'>
			<!-- <input type="hidden" name="sid" value=""/> -->
				<input type="hidden" id="parentId" name="parentId" value="${cbbTempletInfo.parentId}">
				<input type="hidden" id="id" name="id" value="${cbbTempletInfo.id}">
				<input type="hidden" id="sysApplicationId" name="sysApplicationId" value="${appId}">
				<input type="hidden" id="sysId" name="sysId" value="${appId}">
				<input type="hidden" id="secretLevel" name="secretLevel" value="${secretLevel}">
				<table width="100%" style="padding-top: 10px;">
					<tr>
						<th align="right">模版编号:</th>
						<td><span style="padding:0px;margin: 0px;">
								<span style="padding:0px;margin: 0px;width: 5px;display: inline-block;">
									<span class="required-icon"></span>
								</span>
							  	<input title="模版编号" class="inputbox" style="width: 180px;" type="text" name="tempCode" id="tempCode" value="${cbbTempletInfo.tempCode}"/>
							</span></td>
						<th align="right">节点类型 :</th>
						<td><select name="tempType" id="tempType" class="easyui-combobox" data-options="width:173,editable:false,panelHeight:'auto'">
							</select>
						</td>
					</tr>
					<tr>
						<th align="right">模版名称 :</th>
						<td>
							<span style="padding:0px;margin: 0px;">
								<span style="padding:0px;margin: 0px;width: 5px;display: inline-block;">
									<span class="required-icon"></span>
								</span>
								<input title="系统代码类型名称" class="inputbox" style="width: 180px;" type="text" name="tempName" id="tempName" value="${cbbTempletInfo.tempName}"/></span>
						</td>
					</tr>
					<tr>
						<th align="right">描述:</th>
						<td colspan="3"><div style="padding-left: 10px;"><input title="描述" class="inputbox" style="width: 92%;" type="text" name="remark" id="remark" value="${cbbTempletInfo.remark}"/></div></td>
					</tr>
				</table>
		</form>
		<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>	
					<td align="right" width="60%">
					  	<a title="保存" id="saveButton"  class="easyui-linkbutton" plain="false" onclick="saveForm();" href="javascript:void(0);">保存</a>
						<a title="返回" id="returnButton"  class="easyui-linkbutton"  plain="false" onclick="closeForm();" href="javascript:void(0);">返回</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<script type="text/javascript">
	var parentTempType = "<%=parentTempType%>";
	$(function(){
		initSelect();
		$('#tempType').combobox('setValue', "${cbbTempletInfo.tempType}");
	});
	
	function initSelect(){
		if (parentTempType == "R"){
			$('#tempType').combobox({   
				valueField:'value',  
				textField:'text', 
				disabled:true,
				data: [{
					text: '系统标识',
					value: 'S'
				}]
			});
		}else{
			$('#tempType').combobox({   
				valueField:'value',  
				textField:'text', 
				editable:false,
				data: [{
					text: '模板夹',
					value: 'F'
				},
				{
					text: '模板',
					value: 'C'
				}]
			});
		}
	}
	
	function closeForm(){
		parent.tree.closeDialog("#edit");
	}
	function saveForm(){
		var reg =/\s/;
		var tempCode =$('#tempCode').val();
		if(tempCode.length ===  0||reg.test(tempCode)){
			$.messager.alert('提示','系统代码类型不能为空，或含有空格字符！','warning');
			return;
		}
		if(tempCode.length >100){
			$.messager.alert('提示',"系统代码类型不能太长！",'warning');
			return;
		}
		var tempName =$('#tempName').val();
		if(tempName.length ===  0||reg.test(tempName)){
			$.messager.alert('提示','系统代码类型名称不能为空，或含有空格字符！','warning');
			return;
		}
		if(tempName.length >100){
			$.messager.alert('提示','系统代码类型名称不能太长！','warning');
			return;
		}
		parent.tree.save(serializeObject($('#form')),"#edit");
	}
	</script>
</body>
</html>