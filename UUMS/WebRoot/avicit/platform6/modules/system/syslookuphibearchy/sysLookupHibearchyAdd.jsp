<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加多维通用代码</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<script type="text/javascript">
$(function(){
	var lookupTypeReadOnly = '${param.lookupTypeReadOnly}';
	if(lookupTypeReadOnly == 'true'){
		getHibearchy('${param.parentId}');
	}
});

/**
 * 装载标准的值
 */
function getHibearchy(parentId){
	if(parent.getLookupType){
		var lookupType = parent.getLookupType(parentId);
		$("#formHibearchy").form('load', {lookupType: lookupType});
	}
}
</script>
</head>
<body class="easyui-layout">
<div region="center" border="false">
   <form id="formHibearchy" fit="true">
		<input id="parentId" name="parentId" type="hidden" value="${param.parentId}"/>
		<div class="formExtendBase">
			<sec:accesscontrollist hasPermission="3" domainObject="sysLookupHibearchyManager_form_lookupType">
			<div class="formUnit column1">
				<label class="labelbg">系统代码类型</label>
				<div class="inputContainer <c:if test="${param.lookupTypeReadOnly == 'true'}">input-readonly</c:if>">
					<input style="width:400px;" id="lookupType" name="lookupType" title="系统代码类型" class="easyui-validatebox" required="true" type="text" 
						data-options="validType:'length[0,50]'" <c:if test="${param.lookupTypeReadOnly == 'true'}">readonly="readonly"</c:if>/>
				</div>
			</div>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="sysLookupHibearchyManager_form_systemFlag">
			<div class="formUnit column1">
				<label class="labelbg">系统级别</label>
				<div class="inputContainer">
					<input style="width:400px;" id="systemFlag" name="systemFlag" title="系统级别" class="easyui-combobox"
					     data-options="editable:false,panelHeight:'auto',valueField:'code',textField:'name',
							  url:'platform/sysLookupHibearchy/getLookUpJsonData.json?lookUpCode=PLATFORM_SYS_USER_FLAG'" 
						 required="true" value="0"/> 
				</div>
			</div>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="sysLookupHibearchyManager_form_validFlag">
			<div class="formUnit column1">
				<label class="labelbg">有效标识</label>
				<div class="inputContainer">
					<input style="width:400px;" id="validFlag" name="validFlag" title="有效标识" class="easyui-combobox" 
					   data-options="editable:false,panelHeight:'auto',valueField:'code',textField:'name',
							url:'platform/sysLookupHibearchy/getLookUpJsonData.json?lookUpCode=PLATFORM_VALID_FLAG'" 
						required="true" value="1"/> 
				</div>
			</div>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="sysLookupHibearchyManager_form_sysLanguageCode">
			<div class="formUnit column1">
				<label class="labelbg">多语言</label>
				<div class="inputContainer input-readonly">
					<input style="width:400px;" id="sysLanguageCode" name="sysLanguageCode" title="有效标识" class="easyui-combobox" readonly="readonly"
					    data-options="editable:false,panelHeight:'auto',valueField:'code',textField:'name',
							url:'platform/sysLookupHibearchy/getSysLanguages.json'" 
						required="true" value="zh_CN"/> 
				</div>
			</div>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="sysLookupHibearchyManager_form_typeKey">
			<div class="formUnit column1">
				<label class="labelbg">数据编码</label>
				<div class="inputContainer">
					<input style="width:400px;" id="typeKey" name="typeKey" title="数据编码" class="easyui-validatebox" data-options="validType:'length[0,255]'" required="true" type="text" value=""/>
				</div>
			</div>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="sysLookupHibearchyManager_form_typeValue">
			<div class="formUnit column1">
				<label class="labelbg">系统代码值</label>
				<div class="inputContainer">
					<input style="width:400px;" id="typeValue" name="typeValue" title="系统代码值" class="easyui-validatebox" data-options="validType:'length[0,255]'" required="true" type="text" value=""/>
				</div>
			</div>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="sysLookupHibearchyManager_form_orderBy">
			<div class="formUnit column1">
				<label class="labelbg">排序</label>
				<div class="inputContainer">
					<input style="width:400px;" id="orderBy" name="orderBy" title="排序" class="easyui-numberbox" data-options="min:0,max:1000000" required="true" type="text" data-options="min:0" value=""/>  
				</div>
			</div>
			</sec:accesscontrollist>
			<sec:accesscontrollist hasPermission="3" domainObject="sysLookupHibearchyManager_form_remark">
			<div class="formUnit column1" style="height: 60px;">
				<label>备注</label>
				<div class="inputContainer">
					<textarea style="width:395px;height: 50px;" id="remark" name="remark"  title="备注"></textarea>
				</div>
			</div>
			</sec:accesscontrollist>
		</div>
	</form>
</div>
</body>
</html>
