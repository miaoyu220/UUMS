<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.lang.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<form id="formRuleSegment_${param.index}" method="post" enctype="multipart/form-data">
	<table id="tableRuleSegment_${param.index}" width="700px" border="0">
		<tr height="30px">
			<td width="120px" align="right">码段名称</td>
			<td width="240px"><input id="segmentName_${param.index}" name="segmentName" class="easyui-validatebox" required="true" data-options="validType:'length[0,100]'" style="width: 200px" /></td>
			<td width="120px" align="right">码段类型</td>
			<td width="240px"><input id="segmentType_${param.index}" name="segmentType" class="easyui-combobox" required="true" data-options="editable:false,panelHeight:'auto',onChange: function(newValue,oldValue){doChangeSegmentType(${param.index},newValue,oldValue)},valueField:'code',textField:'name',url:'platform/cc/sysCodingRule/getSegmentType.json'" style="width: 202px"/></td>
		</tr>
		<tr height="30px">
			<td align="right">码段长度</td>
			<td><input id="segmentLength_${param.index}" name="segmentLength" class="easyui-numberbox"  data-options="min:1,max:99,onChange:function(newValue,oldValue){doChangeSegmentLength(${param.index},newValue,oldValue)}" style="width: 200px"/></td>
			<td align="right">前缀</td>
			<td><input id="segmentPrefixion_${param.index}" name="segmentPrefixion" class="easyui-validatebox" data-options="required:false,validType:'length[0,100]'" style="width: 200px" /></td>
		</tr>
		<tr height="30px">	
			<td align="right">后缀</td>
			<td><input id="segmentSuffix_${param.index}" name="segmentSuffix" class="easyui-validatebox" data-options="required:false,validType:'length[0,100]'" style="width: 200px" /></td>
			<td align="right"></td>
			<td></td>
		</tr>
		<c:if test="${param.index != '1'}">
		<tr height="30px" id="tdSegmentRelation_${param.index}" style="display: none">
			<td align="right">分类码值关联<input type="hidden" id="segmentRelation_${param.index}" name="segmentRelation" /></td>
			<td colspan="3">
				<c:forEach var="theIndex" begin="1" end="${param.index - 1}" step="1"> 
					<input type="checkbox" id="segmentRelation${theIndex }_${param.index}" onclick="setSegmentRelation(${param.index})" value="${theIndex }" style="width: 15px"/>码段${theIndex }
				</c:forEach>
			</td>
		</tr>
		</c:if>
		<tr height="30px" id="tdComSegment_${param.index}" style="display: none">
			<td align="right">通用编码</td>
			<td><input id="comSegmentId_${param.index}" name="comSegmentId" class="easyui-combobox" required="false" data-options="editable:false,panelHeight:100,onChange: function(newValue,oldValue){doChangeComSegment(${param.index},newValue,oldValue)},valueField:'code',textField:'name',url:'platform/cc/sysCodingComSegment/getComSegmentData.json?isDisplaySelect=true&appId=${param.appId}'" style="width: 202px"/></td>
			<td align="right"></td>
			<td></td>
		</tr>
		<tr height="30px" id="tdSerialNumber_${param.index}" style="display: none">
			<td align="right">流水范围(数字)</td>
			<td>
				<input id="serialNumberStart_${param.index}" name="serialNumberStart" class="easyui-numberbox" data-options="required:false,min:0,max:1000000,formatter: function(value){return doFarmatterSerialNumber(${param.index}, value)}" style="width: 65px"/>(开始)--
				<input id="serialNumberEnd_${param.index}" name="serialNumberEnd" class="easyui-numberbox" data-options="required:false,min:0,max:1000000,formatter: function(value){return doFarmatterSerialNumber(${param.index}, value)}" style="width: 65px"/>(结束)
			</td>
			<td align="right">流水步长</td>
			<td><input id="serialStep_${param.index}" name="serialStep" class="easyui-numberbox" data-options="required:false,min:1,max:1000000" style="width: 200px"/></td>
		</tr>
		<tr height="30px" id="tdCount_${param.index}" style="display: none">
			<td align="right">计算分类</td>
			<td>
				<input id="classify_${param.index}" name="classify" class="easyui-combobox" data-options="editable:false,panelHeight:'auto',onChange: function(newValue,oldValue){doChangeClassify(${param.index},newValue,oldValue)},valueField:'code',textField:'name',url:'platform/cc/sysCodingRule/getCountType.json'" style="width: 202px"/>
			</td>
			<td align="right" id="tdFormatName_${param.index}">格式化</td>
			<td id="tdFormatValue_${param.index}">
				<input id="format_${param.index}" name="format" class="easyui-combobox" data-options="editable:false,panelHeight: 100,valueField:'code',textField:'name',url:'platform/cc/sysCodingRule/getCountFormatDate.json'" style="width: 202px"/>
			</td>
		</tr>
		<tr height="30px" id="tdCount2_${param.index}" style="display: none">
			<td align="right"></td>
			<td><input type="checkbox" id="isCurrentTime_${param.index}" name="isCurrentTime" value="Y" style="width: 15px"/>
				<span title="选中获取服务器默认时间，否则自己选择时间">是否默认当前时间</span>
			</td>
			<td align="right"></td>
			<td></td>
		</tr>
	</table>
</form>