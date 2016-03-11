<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>自编代码例子</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<script src="avicit/platform6/modules/system/syscodingselect/CodingSelect.js"></script>
<script type="text/javascript">
function setCodingId(newvalue, oldvalue){
	$('#coding1').coding('setValue', '');
	$('#coding1').coding('setCodingId', newvalue);
}

/**
 * 提交后台
 */
function saveCoding(){
	var codingId = $('#setCoding').combobox('getValue');
	var codingValue = $('#coding1').coding('getValue');
	
	//增加非空验证
	if(codingId == ''){
		$.messager.show({title:'提示',msg :'请选择编码规则！'});
		return;
	}
	if(codingValue == ''){
		$.messager.show({title:'提示',msg :'请选择生成码值！'});
		return;
	}
	
	var segmentValueLength = $('#coding1').coding('getLengths');//不同码段的长度
	$.ajax({
        cache: true,
        type: "POST",
        url:'platform/sysCodingSelectController/saveCoding',
        dataType:"json",
        data:{codingId: codingId, codingValue: codingValue,segmentValueLength:segmentValueLength},
        async: false,
        timeout:10000,
        error: function(request) {
        	alert("操作失败，服务请求状态："+request.status+" "+request.statusText+" 请检查服务是否可用！");
        },
        success: function(result) {
        	if (result.flag == 'success') {
				$.messager.show({title:'提示',msg :'保存成功！'});
        		$('#formSelectCoding').form('reset');
			}else{
				$.messager.show({title:'提示',msg :'保存失败！'});
				$('#formSelectCoding').form('reset');
			}
        }
    });
}
</script>
</head>
<body class="easyui-layout">
<div region="center" border="false">
<form id="formSelectCoding" method="post">
	<table border="0">
		<tr height="30px">
			<td width="300px" align="right">选择编码规则</td>
			<td width="300px">
				<input id="setCoding" class="easyui-combobox" data-options="editable:false,panelHeight:'auto',onChange: setCodingId,valueField:'code',textField:'name',url:'platform/sysCodingSelectController/getCodingRuleListJsonData.json?isDisplaySelect=true'" style="width: 205px"/>
			</td>
		</tr>
		<!-- 编码选择空间提供如下参数：
			codingId:编码规则ID。
			separator: 批量生产编码直接的分隔符，默认","。
			panelWidth: 下拉面板宽度，默认300。
			panelHeight：下拉面板高度，默认87。
			multiSerial: 是否批量流水号，默认 false。
			showDefaultValue:是否显示默认数据，默认 true。
		  -->
		<tr height="30px">
			<td align="right">生成码值</td>
			<td><input type="text" id="coding1" class="easyui-coding" style="width: 200px" data-options="codingId: '', panelWidth: 300, multiSerial: true" value=""></td>
		</tr>
		<tr height="30px">
			<td align="right"></td>
			<td><a class="easyui-linkbutton" iconCls="icon-add" plain="false" onclick="saveCoding()" href="javascript:void(0);">提交后台</a></td>
		</tr>
	</table>
</form>
</div>
</body>
</html>
