<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>编辑代码规则</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<style type="text/css">
.icon-system {
    background: url("static/images/platform/bpm/images/org-1.gif") no-repeat scroll 0 0 transparent;
}
.icon-criterion {
    background: url("static/images/platform/common/icons/page.png") no-repeat scroll 0 0 transparent;
}
</style>
<script type="text/javascript">
/**
 * 初始化数据
 */
$(function(){
	$('#${ruleBase.signImage}').css('border', '1px solid red');
});

/**
 * 当前码段tab页签的切换时触发
 */
function fushTabByTabIndex(){
	var tab = $('#tabRuleSegment').tabs('getSelected');
	var title = tab.panel('options').title;
	if(title != null && title.indexOf('码段')>=0){
		var segmentIndex = title.substring(2);
		var _segmentType = $('#segmentType_' + segmentIndex).combobox('getValue');
		for(var i = 1; i < parseInt(segmentIndex); i++){
			var segmentType = $('#segmentType_' + i).combobox('getValue');
			var comSegmentId = $('#comSegmentId_' + i).combobox('getValue');
			var relation = $('#segmentRelation'+ i + '_' + segmentIndex);
			//本码段类型是流水码，放开所有依赖项
			if(_segmentType == '3'){
				relation.attr('disabled', false);
			}else{
				//如果不是流水码，根据之前码段类型判断哪些可以依赖
				if(segmentType == '3' || segmentType == '4'){
					if(relation.attr('checked') == 'checked'){
						relation.attr('checked', false);
					}
					relation.attr('disabled', true);
				}else{
					if(comSegmentId != null && comSegmentId != ''){
						relation.attr('disabled', true);
					}else{
						relation.attr('disabled', false);
					}
				}
			}
		}
		setSegmentRelation(segmentIndex);
	}
}

/**
 * 选择规则标志图片
 */
function selectSignImage(obj, image){
	var id = $(obj).attr('id');
	$('#signImage').val(id);
	$("img[name='selectImage']").css('border', '');
	$(obj).css('border', '1px solid red');
}

/**
 * 选择依赖标准号前判断
 */
function doBeforeSelectCriterion(node){
	//1:编码体系；2：编码体系下的标准
	var type = node.attributes.type;
	if(type == '2'){
		return true;
	}else{
		return false;
	}
}

/**
 * 修改码段个数
 */
function doChangeSegmentNumber(newValue,oldValue){
	var tabs = $('#tabRuleSegment').tabs('tabs');
	var tabsLength = tabs.length;
	var segmentNumber = parseInt(newValue);
	if(segmentNumber > tabsLength){
		for(var i = tabsLength + 1; i <= segmentNumber; i++){
			$.ajax({
		        cache: true,
		        type: "POST",
		        url:'avicit/platform6/modules/system/syscodingrule/sysCodingRuleAddContent.jsp?index=' + i,
		        dataType:"text",
		        async: false,
		        timeout:10000,
		        error: function(request) {
		        	alert("操作失败，服务请求状态："+request.status+" "+request.statusText+" 请检查服务是否可用！");
		        },
		        success: function(data) {
		        	if(data){
		        		$('#tabRuleSegment').tabs('add',{    
		    			    title:'码段' + i,
		    			    content: data,
		    			    selected: true,
		    			    closable:false
		    			});
					}
		        }
		    });
			$('#tabRuleSegment').tabs('select', tabsLength);
		}  
	}else if(segmentNumber < tabsLength){
		for(var i = tabsLength - 1; i >=  segmentNumber; i--){
			$('#tabRuleSegment').tabs('close', i);
		}
	}
}

/**
 * 修改码段类型
 */
function doChangeSegmentType(index, newValue, oldValue){
	fushTabByTabIndex();
	if(newValue == '1'){
		//控制显隐
		$('#tdComSegment_' + index).css('display','');
		$('#tdSerialNumber_' + index).css('display','none');
		$('#tdCount_' + index).css('display','none');
		$('#tdCount2_' + index).css('display','none');
		//设置字段是否必填
		setSerialRequired(index, false);
		setClassifyRequired(index, false);
		setFormatRequired(index, false);
		$('#segmentLength_'+ index).validatebox({ required: false});
		//根据通用代码判断
		var comSegmentId = $('#comSegmentId_' + index).combobox('getValue');
		doChangeComSegment(index, comSegmentId, '');
	}else if(newValue == '2'){
		//控制显隐
		$('#tdComSegment_' + index).css('display','');
		$('#tdSerialNumber_' + index).css('display','none');
		$('#tdCount_' + index).css('display','none');
		$('#tdCount2_' + index).css('display','none');
		//设置字段是否必填
		setSerialRequired(index, false);
		setClassifyRequired(index, false);
		setFormatRequired(index, false);
		$('#segmentLength_'+ index).validatebox({ required: false});
		//根据通用代码判断
		var comSegmentId = $('#comSegmentId_' + index).combobox('getValue');
		doChangeComSegment(index, comSegmentId, '');
	}else if(newValue == '3'){
		//控制显隐
		$('#tdSegmentRelation_' + index).css('display','');
		$('#tdComSegment_' + index).css('display','none');
		$('#tdSerialNumber_' + index).css('display','');
		$('#tdCount_' + index).css('display','none');
		$('#tdCount2_' + index).css('display','none');
		//设置字段是否必填
		setSerialRequired(index, true);
		setClassifyRequired(index, false);
		setFormatRequired(index, false);
		$('#segmentLength_'+ index).validatebox({ required: true});
		//码段长度可以修改
		$('#segmentLength_' + index).attr("readonly", false);
		//设置分类码值关联是否可选
		setRelationDisabled(index, true);
	}else if(newValue == '4'){
		//控制显隐
		$('#tdSegmentRelation_' + index).css('display','none');
		$('#tdComSegment_' + index).css('display','none');
		$('#tdSerialNumber_' + index).css('display','none');
		$('#tdCount_' + index).css('display','');
		//设置字段是否必填
		setSerialRequired(index, false);
		setClassifyRequired(index, true);
		$('#segmentLength_'+ index).validatebox({ required: true});
		//根据计算分类
		var classify = $('#classify_' + index).combobox('getValue');
		doChangeClassify(index, classify, '');
		//设置分类码值关联是否可选
		setRelationDisabled(index, true);
	}
}

/**
 * 设置流水字段是否必填
 */
function setSerialRequired(index, isRequired){
	var maxValue = 1000000;
	var segmentLength = $('#segmentLength_' + index).numberbox('getValue');
	if(segmentLength != null && segmentLength != '' && segmentLength > 0){
		maxValue = Math.pow(10, segmentLength)-1;
	}
	$('#serialNumberStart_' + index).numberbox({    
		required: isRequired,
		min:0,
		max:maxValue
	});
	$('#serialNumberEnd_' + index).numberbox({    
		required: isRequired,
		min:0,
		max:maxValue
	});
	$('#serialStep_' + index).numberbox({    
		required: isRequired,
		min:1,
		max:1000000
	});
}

/**
 * 设置计算码字段是否必填
 */
function setClassifyRequired(index, isRequired){
	$('#classify_' + index).combobox({    
		required: isRequired,
		value: ''
	});
}

/**
 * 设置计算码格式化字段是否必填
 */
function setFormatRequired(index, isRequired){
	$('#format_' + index).combobox({    
 		required: isRequired,
 		value: ''
 	});
}

/**
 * 重新设置本码段之后的码段是否可选依赖本码段
 * @param index
 * @param isDisabled 是否不可用
 */
function setRelationDisabled(index, isDisabled){
	index = parseInt(index);
	var tabs = $('#tabRuleSegment').tabs('tabs');
	var tabsLength = tabs.length;
	if(isDisabled == true){
		for(var i = index + 1; i <= tabsLength; i++){
			var relation = $('#segmentRelation'+ index + '_' + i);
			if(relation.attr('checked') == 'checked'){
				relation.attr('checked', false);
				setSegmentRelation(i);
			}
			relation.attr('disabled', true);
		}
	}else{
		for(var i = index + 1; i <= tabsLength; i++){
			var relation = $('#segmentRelation'+ index + '_' + i);
			if(relation.length > 0){
				relation.attr('disabled', false);
			} 
		}
	}
}

/**
 * 修改分类码值关联
 */
function setSegmentRelation(index){
	var segmentRelation = '';
	for(var i = 1; i < index; i++){
		var relation = $('#segmentRelation'+ i + '_' + index);
		if(relation.attr('checked') == 'checked'){
			if(segmentRelation == ''){
				segmentRelation += relation.val();
			}else{
				segmentRelation += '@@' + relation.val();
			}
		}
	}
	$('#segmentRelation_' + index).val(segmentRelation);
}

/**
 * 码段长度变化时修改
 */
function doChangeSegmentLength(index, newValue, oldValue){
	if(newValue != null && newValue != ''){
		$('#serialNumberStart_' + index).numberbox({max:(Math.pow(10,newValue)-1)});
		$('#serialNumberEnd_' + index).numberbox({max:(Math.pow(10,newValue)-1)});
		$('#serialNumberStart_' + index).numberbox('clear');
		$('#serialNumberEnd_' + index).numberbox('clear');
	} 
}

/**
 * 格式化流水码值
 */
function doFarmatterSerialNumber(index, value){
	var returnValue = '';
	if(value != null && value != ''){
		returnValue = value + '';
		var segmentLength = $('#segmentLength_' + index).numberbox('getValue');
		if(segmentLength != null && segmentLength != '' && segmentLength > 0){
			if (value.length < segmentLength){
				for(var i = value.length; i < segmentLength; i++){
					returnValue = '0' + returnValue;
				}
			}
		}
	}
	
	return returnValue;
 }
 
/**
 * 修改计算类型
 */
function doChangeClassify(index, newValue, oldValue){
	if(newValue == '1'){
		$('#tdFormatName_' + index).css('display','none');
		$('#tdFormatValue_' + index).css('display','none');
		$('#tdCount2_' + index).css('display','none');
		setFormatRequired(index, false);
		$('#segmentLength_'+ index).validatebox({ required: true});
		$('#segmentLength_' + index).attr("readonly", false);
	}else if(newValue == '2'){
		$('#tdFormatName_' + index).css('display','');
		$('#tdFormatValue_' + index).css('display','');
		$('#tdCount2_' + index).css('display','');
		setFormatRequired(index, true);
		$('#segmentLength_'+ index).validatebox({ required: false});
		$('#segmentLength_'+ index).numberbox('clear');
		$('#segmentLength_' + index).attr("readonly", true);
	}else{
		$('#tdFormatName_' + index).css('display','none');
		$('#tdFormatValue_' + index).css('display','none');
		$('#tdCount2_' + index).css('display','none');
		setFormatRequired(index, false);
		$('#segmentLength_'+ index).validatebox({ required: true});
		$('#segmentLength_' + index).attr("readonly", false);
	}
}

/**
 * 修改通用码段
 */
function doChangeComSegment(index, newValue, oldValue){
	 if(newValue != null && newValue != ''){
		 //不显示分类码值关联
		 $('#tdSegmentRelation_' + index).css('display','none');
		 //编码长度只读
		 $('#segmentLength_' + index).attr("readonly", true);
		 //设置分类码值关联可选
		 setRelationDisabled(index, true);
		 //获取选择的数据
		 var data = $('#comSegmentId_' + index).combobox('getData');
		 var row = null;
		 for(var i = 0; i < data.length; i++){
			 if(data[i].code == newValue){
				 row = data[i];
				 break;
			 }
		 }
		
		 if(row != null && row.length != null){
			 $('#segmentLength_' + index).numberbox('setValue', row.length);
		 }else{
			 $('#segmentLength_' + index).numberbox('clear');
		 }
	 }else{
		 //显示分类码值关联
		 $('#tdSegmentRelation_' + index).css('display','');
		 //去除编码长度只读
		 $('#segmentLength_' + index).attr("readonly", false);
		 //设置分类码值关联可选
		 setRelationDisabled(index, false);
	 }
}
</script>
</head>
<body class="easyui-layout">
<div region="center" border="false">
	<div id="tabControlList" class="easyui-tabs" tabPosition="top" fit="true" border="false" style="padding:0px;" >
		<!-- 基本设置显示区域 -->
		<div title="基本设置" style="padding:10px 0 0 0;overflow: hidden;">
		   <form id="formRuleBase" method="post">
		   		<input id="id" name="id" type="hidden" value="${ruleBase.id}"/>
		   		<input id="version" name="version" type="hidden" value="${ruleBase.version}"/>
				<table width="660px" border="0" align="center">
					<tr height="30px">
						<td width="100px" align="right">规则名称</td>
						<td width="230px"><input id="codingName" name="codingName" class="easyui-validatebox" required="true" data-options="validType:'length[0,100]'" style="width: 220px" value="${ruleBase.codingName}" /></td>
						<td width="100px" align="right">码段个数</td>
						<td width="230px"><input id="segmentNumber" name="segmentNumber" class="easyui-numberbox" required="true" data-options="min:1,max:20,onChange: doChangeSegmentNumber" style="width: 170px"/ value="${ruleBase.segmentNumber}"></td>
					</tr>
					<tr height="30px">
						<td align="right">依赖标准号</td>
						<td>
							<input id="criterionId" name="criterionId" style="width:222px;" class="easyui-combotree" 
								data-options="
									url:'platform/sysCodingSystemController/getCodingSystemTreeAllValidData.json',
									required:true,
									lines:true,
									loadFilter: function(data){if (data.data){return data.data;}else{return data;}},
									onBeforeSelect: doBeforeSelectCriterion" value="${ruleBase.criterionId}" />
						</td>
						<td align="right"></td>
						<td></td>
					</tr>
					<tr height="45px">
						<td align="right">说明</td>
						<td colspan="4">
							<textarea class="easyui-validatebox" id="ruleRemark" name="ruleRemark" style="height:45px;width:90%;">${ruleBase.ruleRemark }</textarea>
						</td>
					</tr>
					<tr height="20px">
						<td colspan="4" align="center" valign="bottom">
						请选择规则标志图片
						<input type="hidden" id="signImage" name="signImage" value="${ruleBase.signImage}" />
						</td>
					</tr>
					<tr height="150px">
						<td colspan="4">
							<table width="660px" border="0" align="center">
								<tr height="50px">
									<td width="66px" align="center"><img id="rulebase_01" name="selectImage" alt="" style="cursor: pointer;" src="avicit/platform6/modules/system/syscodingrule/images/rulebase_01.gif" onclick="selectSignImage(this)"></td>
									<td width="66px" align="center"><img id="rulebase_02" name="selectImage" alt="" style="cursor: pointer;" src="avicit/platform6/modules/system/syscodingrule/images/rulebase_02.gif" onclick="selectSignImage(this)"></td>
									<td width="66px" align="center"><img id="rulebase_03" name="selectImage" alt="" style="cursor: pointer;" src="avicit/platform6/modules/system/syscodingrule/images/rulebase_03.gif" onclick="selectSignImage(this)"></td>
									<td width="66px" align="center"><img id="rulebase_04" name="selectImage" alt="" style="cursor: pointer;" src="avicit/platform6/modules/system/syscodingrule/images/rulebase_04.gif" onclick="selectSignImage(this)"></td>
									<td width="66px" align="center"><img id="rulebase_05" name="selectImage" alt="" style="cursor: pointer;" src="avicit/platform6/modules/system/syscodingrule/images/rulebase_05.gif" onclick="selectSignImage(this)"></td>
									<td width="66px" align="center"><img id="rulebase_06" name="selectImage" alt="" style="cursor: pointer;" src="avicit/platform6/modules/system/syscodingrule/images/rulebase_06.gif" onclick="selectSignImage(this)"></td>
									<td width="66px" align="center"><img id="rulebase_07" name="selectImage" alt="" style="cursor: pointer;" src="avicit/platform6/modules/system/syscodingrule/images/rulebase_07.gif" onclick="selectSignImage(this)"></td>
									<td width="66px" align="center"><img id="rulebase_08" name="selectImage" alt="" style="cursor: pointer;" src="avicit/platform6/modules/system/syscodingrule/images/rulebase_08.gif" onclick="selectSignImage(this)"></td>
									<td width="66px" align="center"><img id="rulebase_09" name="selectImage" alt="" style="cursor: pointer;" src="avicit/platform6/modules/system/syscodingrule/images/rulebase_09.gif" onclick="selectSignImage(this)"></td>
									<td width="66px" align="center"><img id="rulebase_10" name="selectImage" alt="" style="cursor: pointer;" src="avicit/platform6/modules/system/syscodingrule/images/rulebase_10.gif" onclick="selectSignImage(this)"></td>
								</tr>
								<tr height="50px">
									<td width="66px" align="center"><img id="rulebase_11" name="selectImage" alt="" style="cursor: pointer;" src="avicit/platform6/modules/system/syscodingrule/images/rulebase_11.gif" onclick="selectSignImage(this)"></td>
									<td width="66px" align="center"><img id="rulebase_12" name="selectImage" alt="" style="cursor: pointer;" src="avicit/platform6/modules/system/syscodingrule/images/rulebase_12.gif" onclick="selectSignImage(this)"></td>
									<td width="66px" align="center"><img id="rulebase_13" name="selectImage" alt="" style="cursor: pointer;" src="avicit/platform6/modules/system/syscodingrule/images/rulebase_13.gif" onclick="selectSignImage(this)"></td>
									<td width="66px" align="center"><img id="rulebase_14" name="selectImage" alt="" style="cursor: pointer;" src="avicit/platform6/modules/system/syscodingrule/images/rulebase_14.gif" onclick="selectSignImage(this)"></td>
									<td width="66px" align="center"><img id="rulebase_15" name="selectImage" alt="" style="cursor: pointer;" src="avicit/platform6/modules/system/syscodingrule/images/rulebase_15.gif" onclick="selectSignImage(this)"></td>
									<td width="66px" align="center"><img id="rulebase_16" name="selectImage" alt="" style="cursor: pointer;" src="avicit/platform6/modules/system/syscodingrule/images/rulebase_16.gif" onclick="selectSignImage(this)"></td>
									<td width="66px" align="center"><img id="rulebase_17" name="selectImage" alt="" style="cursor: pointer;" src="avicit/platform6/modules/system/syscodingrule/images/rulebase_17.gif" onclick="selectSignImage(this)"></td>
									<td width="66px" align="center"><img id="rulebase_18" name="selectImage" alt="" style="cursor: pointer;" src="avicit/platform6/modules/system/syscodingrule/images/rulebase_18.gif" onclick="selectSignImage(this)"></td>
									<td width="66px" align="center"><img id="rulebase_19" name="selectImage" alt="" style="cursor: pointer;" src="avicit/platform6/modules/system/syscodingrule/images/rulebase_19.gif" onclick="selectSignImage(this)"></td>
									<td width="66px" align="center"><img id="rulebase_20" name="selectImage" alt="" style="cursor: pointer;" src="avicit/platform6/modules/system/syscodingrule/images/rulebase_20.gif" onclick="selectSignImage(this)"></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<!-- 编码规则设置显示区域 -->
		<div title="编码规则设置" style="padding:0px;">
			<div id="tabRuleSegment" data-options="onSelect: fushTabByTabIndex" class="easyui-tabs" tabPosition="top" fit="true" border="false" style="padding:0px;" >
				<c:forEach items="${segmentList}"  var="segment" varStatus="segmentStatus">
					<div title="码段${segment.segmentIndex}">
					<form id="formRuleSegment_${segment.segmentIndex}" method="post" enctype="multipart/form-data">
							<input id="id" name="id" type="hidden" value="${segment.id}"/>
							<input id="version" name="version" type="hidden" value="${segment.version}"/>
							<table id="tableRuleSegment_${segment.segmentIndex}" width="700px" border="0">
								<tr height="30px">
									<td width="120px" align="right">码段名称</td>
									<td width="240px"><input id="segmentName_${segment.segmentIndex}" name="segmentName" class="easyui-validatebox" required="true" data-options="validType:'length[0,100]'" style="width: 200px" value="${segment.segmentName}"/></td>
									<td width="120px" align="right">码段类型</td>
									<td width="240px"><input id="segmentType_${segment.segmentIndex}" name="segmentType" class="easyui-combobox" required="true" data-options="editable:false,panelHeight:'auto',onChange: function(newValue,oldValue){doChangeSegmentType(${segment.segmentIndex},newValue,oldValue)},valueField:'code',textField:'name',url:'platform/sysCodingRuleController/getSegmentType.json'" style="width: 202px" value="${segment.segmentType}"/></td>
								</tr>
								<tr height="30px">
									<td align="right">码段长度</td>
									<td><input id="segmentLength_${segment.segmentIndex}" name="segmentLength" class="easyui-numberbox" <c:if test="${(segment.segmentType == '4' && segment.classify != '1') || (segment.segmentType == '1' && segment.comSegmentId != null) || (segment.segmentType == '2' && segment.comSegmentId != null)}">readonly="true"</c:if> data-options="required:<c:choose><c:when test="${segment.segmentType == '1' || segment.segmentType == '2' || (segment.segmentType == '4' && segment.classify != '1')}">false</c:when><c:otherwise>true</c:otherwise></c:choose>,min:1,max:99,onChange:function(newValue,oldValue){doChangeSegmentLength(${segment.segmentIndex},newValue,oldValue)}" style="width: 200px" value="${segment.segmentLength}"/></td>
									<td align="right">前缀</td>
									<td><input id="segmentPrefixion_${segment.segmentIndex}" name="segmentPrefixion" class="easyui-validatebox" data-options="required:false,validType:'length[0,100]'" style="width: 200px" value="${segment.segmentPrefixion}"/></td>
								</tr>
								<tr height="30px">	
									<td align="right">后缀</td>
									<td><input id="segmentSuffix_${segment.segmentIndex}" name="segmentSuffix" class="easyui-validatebox" data-options="required:false,validType:'length[0,100]'" style="width: 200px" value="${segment.segmentSuffix}"/></td>
									<td align="right"></td>
									<td></td>
								</tr>
								<c:if test="${segment.segmentIndex != '1'}">
								<tr height="30px" id="tdSegmentRelation_${segment.segmentIndex}" <c:if test="${segment.segmentType == '4' || (segment.segmentType == '1' && segment.comSegmentId != null) || (segment.segmentType == '2' && segment.comSegmentId != null)}">style="display: none"</c:if>>
									<td align="right">分类码值关联<input type="hidden" id="segmentRelation_${segment.segmentIndex}" name="segmentRelation" value="${segment.segmentRelation}"/></td>
									<td colspan="3">
										<c:forEach var="theIndex" begin="1" end="${segment.segmentIndex - 1}" step="1"> 
											<input type="checkbox" <c:forTokens var="num" items="${segment.segmentRelation}" delims="@@"><c:if test="${theIndex == num}">checked="checked"</c:if></c:forTokens> id="segmentRelation${theIndex }_${segment.segmentIndex}" onclick="setSegmentRelation(${segment.segmentIndex})" value="${theIndex }" style="width: 15px"/>码段${theIndex }
										</c:forEach>
									</td>										
								</tr>
								</c:if>
								<tr height="30px" id="tdComSegment_${segment.segmentIndex}" <c:if test="${segment.segmentType != '1' && segment.segmentType != '2'}">style="display: none"</c:if>>
									<td align="right">通用编码</td>
									<td><input id="comSegmentId_${segment.segmentIndex}" name="comSegmentId" class="easyui-combobox" value="${segment.comSegmentId}" required="false" data-options="editable:false,panelHeight:100,onChange: function(newValue,oldValue){doChangeComSegment(${segment.segmentIndex},newValue,oldValue)},valueField:'code',textField:'name',url:'platform/sysCodingComSegmentController/getComSegmentData.json?isDisplaySelect=true'" style="width: 202px"/></td>
									<td align="right"></td>
									<td></td>
								</tr>
								<tr height="30px" id="tdSerialNumber_${segment.segmentIndex}" <c:if test="${segment.segmentType != '3'}">style="display: none"</c:if>>
									<td align="right">流水范围(数字)</td>
									<td>
										<input id="serialNumberStart_${segment.segmentIndex}" name="serialNumberStart" class="easyui-numberbox" data-options="<c:if test="${segment.segmentType != '3'}">required:false</c:if><c:if test="${segment.segmentType == '3'}">required:true</c:if>,min:0<c:if test="${segment.segmentLength != null}">,max:<c:forEach begin="1" end="${segment.segmentLength}">9</c:forEach></c:if>,formatter: function(value){return doFarmatterSerialNumber(${segment.segmentIndex}, value)}" style="width: 65px" value="${segment.serialNumberStart}"/>(开始)
										<input id="serialNumberEnd_${segment.segmentIndex}" name="serialNumberEnd" class="easyui-numberbox" data-options="<c:if test="${segment.segmentType != '3'}">required:false</c:if><c:if test="${segment.segmentType == '3'}">required:true</c:if>,min:0<c:if test="${segment.segmentLength != null}">,max:<c:forEach begin="1" end="${segment.segmentLength}">9</c:forEach></c:if>,formatter: function(value){return doFarmatterSerialNumber(${segment.segmentIndex}, value)}" style="width: 65px" value="${segment.serialNumberEnd}"/>(结束)
									</td>
									<td align="right">流水步长</td>
									<td><input id="serialStep_${segment.segmentIndex}" name="serialStep" class="easyui-numberbox" data-options="<c:if test="${segment.segmentType != '3'}">required:false</c:if><c:if test="${segment.segmentType == '3'}">required:true</c:if>,min:1,max:1000000" style="width: 200px" value="${segment.serialStep}"/></td>
								</tr>
								<tr height="30px" id="tdCount_${segment.segmentIndex}" <c:if test="${segment.segmentType != '4'}">style="display: none"</c:if>>
									<td align="right">计算分类</td>
									<td>
										<input id="classify_${segment.segmentIndex}" name="classify" class="easyui-combobox" data-options="editable:false,panelHeight:'auto',onChange: function(newValue,oldValue){doChangeClassify(${segment.segmentIndex},newValue,oldValue)},valueField:'code',textField:'name',url:'platform/sysCodingRuleController/getCountType.json'" style="width: 202px" value="${segment.classify}"/>
									</td>
									<td align="right" id="tdFormatName_${segment.segmentIndex}" <c:if test="${segment.segmentType == '4' && segment.classify == '1'}">style="display: none"</c:if>>格式化</td>
									<td id="tdFormatValue_${segment.segmentIndex}" <c:if test="${segment.segmentType == '4' && segment.classify == '1'}">style="display: none"</c:if>>
										<input id="format_${segment.segmentIndex}" name="format" class="easyui-combobox" data-options="editable:false,panelHeight: 100,valueField:'code',textField:'name',url:'platform/sysCodingRuleController/getCountFormatDate.json'" style="width: 202px" value="${segment.format}"/>
									</td>
								</tr>
								<tr height="30px" id="tdCount2_${segment.segmentIndex}" <c:if test="${segment.segmentType != '4' || (segment.segmentType == '4' && segment.classify == '1')}">style="display: none"</c:if>>
									<td align="right"></td>
									<td><input type="checkbox" id="isCurrentTime_${segment.segmentIndex}" name="isCurrentTime" value="Y" style="width: 15px" <c:if test="${segment.segmentType == '4' && segment.isCurrentTime == 'Y'}">checked="checked"</c:if>/>
										<span title="选中获取服务器默认时间，否则自己选择时间">是否默认当前时间</span>
									</td>
									<td align="right"></td>
									<td></td>
								</tr>
							</table>
						</form>
						
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</div>
<iframe name="loadFileIframe" style="display: none"></iframe>
</body>
</html>
