<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>编辑码值</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<style type="text/css">
table{
     border-collapse: collapse;/* 边框合并属性  */
}
th{
     border: 1px solid #95B8E7;
}
td{
     border: 1px solid #95B8E7;
}
</style>
<script type="text/javascript">
/**
 * 修改依赖码值
 */
function doChangeSegmentValue(newValue, oldValue, index, segmentIndex){
	var _index = index + 1;
	if($('#segmentValue' + _index).length > 0){
		while($('#segmentValue' + _index).length > 0){
			$('#segmentValue' + _index).combobox('setValue','');
			$('#segmentValue' + _index).combobox('reload');
			_index++;
		}
	}else{
		setDependValues(index);
	}
}

/**
 * 加载码值数据前修改参数
 */
function doBeforeLoad(param, index, segmentIndex){
	var baseId = $('#baseId').val();
	param.baseId = baseId;
	param.segmentIndex = segmentIndex;

	for(var i = 0; i < index; i++){
		var value = $('#segmentValue' + i).combobox('getValue');
		if(value == null || value == ''){
			return false;
		}
		var _segmentIndex = $('#segmentValue' + i).attr("segmentIndex");
		param['segmentValue' + _segmentIndex] = value;
	}
	
	return true;
}

/**
 * 修改分类码值关联
 */
function setDependValues(index){
	var dependValues = '';
	for(var i = 0; i <= index; i++){
		if($('#segmentValue'+ i).length > 0){
			var segmentValue = $('#segmentValue'+ i).combobox('getValue');
			if(dependValues == ''){
				dependValues += segmentValue;
			}else{
				dependValues += '@@' + segmentValue;
			}
		}
	}
	$('#dependValues').val(dependValues);
}
</script>
</head>
<body class="easyui-layout">
<div region="center" border="false">
   <form id="formSegmentValue" fit="true" style="padding-top: 5px;">
  		<input id="id" name="id" type="hidden" value="${segmentValues.id}"/>
		<input id="baseId" name="baseId" type="hidden" value="${segmentValues.baseId}"/>
		<input id="segmentIndex" name="segmentIndex" type="hidden" value="${segmentValues.segmentIndex}"/>
		<input id="dependValues" name="dependValues" type="hidden" value="${segmentValues.dependValues}"/>
		<table class="tableForm" width="100%" border="0" align="center">
			<c:if test="${segment.segmentRelation != null && segment.segmentRelation != ''}">
				<c:forTokens var="num" items="${segment.segmentRelation}" delims="@@" varStatus="numStatus">
					<c:if test="${numStatus.last }"><c:set value="${numStatus.count }" var="segmentCount"></c:set></c:if>
				</c:forTokens>
				<c:forTokens var="num" items="${segment.segmentRelation}" delims="@@" varStatus="numStatus">
					<tr>
						<c:if test="${numStatus.first }">
							<td <c:if test="${segmentCount != 1 }">width="20px" rowspan="${segmentCount }" style="writing-mode:lr-tb"</c:if><c:if test="${segmentCount == 1 }">width="50px" rowspan="${segmentCount }"</c:if> align="center">依赖值</td>
						</c:if>
						<td width="60px" align="center">码段${num}</td>
						<td>
							<input id="segmentValue${numStatus.index}" segmentIndex="${num}" class="easyui-combobox" required="true" style="width: 165px"
								data-options="
									url:'platform/sysCodingRuleController/getSegmentValuesData.json',
									editable:false,
									panelHeight:100,
									onChange:function(newValue, oldValue){ doChangeSegmentValue(newValue, oldValue, ${numStatus.index}, ${num});},
									onBeforeLoad: function(param){ return doBeforeLoad(param, ${numStatus.index}, ${num});},
									valueField:'code',
									textField:'name'"
								<c:if test="${segmentValues.dependValues != null && segmentValues.dependValues != ''}">
									<c:forTokens var="dependValue" items="${segmentValues.dependValues}" delims="@@" varStatus="dependStatus">
										<c:if test="${dependStatus.index == numStatus.index}">value="${dependValue}"</c:if>
									</c:forTokens>
								</c:if>/>
						</td>	
					</tr>
				</c:forTokens>
			</c:if>
			<tr>
				<td width="60px" colspan="2" align="center">码名称</td>
				<td><input id="segmentName" name="segmentName" class="easyui-validatebox" required="true" data-options="validType:'length[1,100]'" style="width: 180px;" value="${segmentValues.segmentName }"/></td>
			</tr>
			<tr>
				<td width="60px" colspan="2" align="center">码值</td>
				<td>
					<c:choose>
						<c:when test="${segment.segmentLength gt 0}">
							<input id="segmentValue" name="segmentValue" class="easyui-validatebox" required="true" data-options="invalidMessage:'码段长度必须为${segment.segmentLength }',validType:'length[${segment.segmentLength },${segment.segmentLength }]'" style="width: 180px;" value="${segmentValues.segmentValue }"/>
						</c:when>
						<c:otherwise>
							<input id="segmentValue" name="segmentValue" class="easyui-validatebox" required="true" style="width: 180px;" value="${segmentValues.segmentValue }" data-options="invalidMessage:'码段长度不能大于50',validType:'length[1,50]'"/>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>
