<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<%@ page import="java.util.*"%>
<%@ page import="avicit.platform6.api.syslookup.SysLookupAPI"%>
<%@ page import="avicit.platform6.api.syslookup.impl.SysLookupAPImpl"%>
<%@ page import="avicit.platform6.api.syslookup.dto.SysLookupSimpleVo"%>
<%@ page import="avicit.platform6.core.spring.SpringFactory"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%
	SysLookupAPI upLoader = SpringFactory.getBean(SysLookupAPI.class);
	Collection<SysLookupSimpleVo> lookUpdeptType = upLoader.getLookUpListByType("PLATFORM_DEPT_TYPE");//修改平台，转换为通用代码，部门类型
	Collection<SysLookupSimpleVo> lookUpValidFlag = upLoader.getLookUpListByType("PLATFORM_VALID_FLAG");//修改平台，转换为通用代码，是否有效
	
	
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>部门用户管理</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/CommonDialog.js" type="text/javascript"></script>
<link href="static/css/platform/sysdept/icon.css" type="text/css" rel="stylesheet">
<script type="text/javascript">
var path="<%=ViewUtil.getRequestPath(request)%>";
var currTreeNode;

$.extend($.fn.validatebox.defaults.rules,{
    //国内邮编验证
    zipcode: {
        validator: function (value) {
            var reg = /^[1-9]\d{5}$/;
            return reg.test(value);
        },
        message: "请输入正确的邮编格式"
    },
  //电话验证
    tel: {
        validator: function (value) {
        	var mobilereg = /^((13[0-9])|(15[^4,\D])|(18[0,5-9])|145|147)\d{8}$/;
            var phonereg = /^((0[0-9]{2,3})-)([0-9]{7,8})(-([0-9]{3,}))?$/;
            return mobilereg.test(value) || phonereg.test(value);
        },
        message: "请输入有效的电话号码"
    },
    fax :{
    	validator: function (value) {
        	var reg = /^[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[ ]){1,12})+$/;
            return reg.test(value);
        },
        message: "请输入有效的传真号码"
    }
});

$(document).ready(function(){ 
	
	var deptId='<%=request.getParameter("id")%>';
	loadDeptInfo(deptId);
	setFormReadOnly(false);
	//addDept();
});

function setFormReadOnly(isReadOnly){
	
	if(!isReadOnly){
				
		$("form input[name!='PARENT_DEPT_NAME']").attr("disabled",false);
		$('form textarea').attr("disabled",false);
		//$("#btSaveDept").linkbutton('enable');
	}else{
		$("form input[name!='PARENT_DEPT_NAME']").attr("disabled",true);
		$('form textarea').attr("disabled",true);
	}
	
	//设置部门CODE为只读
	$("#DEPT_CODE").attr("readonly", true);
};

function loadDeptInfo(deptId){
	$.ajax({
        cache: true,
        type: "POST",
        url:'platform/cc/sysdept/getDeptById.json?id='+deptId,
        dataType:"json",
        data:{id:deptId},
        error: function(request) {
        	$.messager.alert('提示','操作失败，服务请求状态：'+request.status+' '+request.statusText+' 请检查服务是否可用！','warning');
        },
        success: function(data) {
			if(data.result==0&&data.sysDept){
				$('#deptEditForm').form('load',data.sysDept);
				
			}else{
				$.messager.alert('提示',data.msg,'warning');
			}
        }
    }); 
};

function clearDeptForm(){
	$('#deptEditForm').form('load',{
		ID:'',
		ORG_ID:'',
		PARENT_DEPT_ID:'',
		DEPT_CODE:'',
		DEPT_NAME:'',
		DEPT_ALIAS:'',
		PARENT_DEPT_NAME:'',
		POST:'',
		TEL:'',
		FAX:'',
		EMAIL:'',
		WORK_CALENDAR_ID:'',
		ORDER_BY:'',
		//ATTRIBUTE_08:'',
		DEPT_PLACE:'',
		DEPT_TYPE:'',
		//ATTRIBUTE_09:'',
		VALID_FLAG:'',
		DEPT_DESC:''
		});
};



</script>
</head>
<body>

<div region="center" border="false" style="overflow: hidden;">
			<form id="deptEditForm" name="deptEditForm" method="post">
				<input type="hidden"  name="ORG_ID" id="ORG_ID"></input>
				<input type="hidden"  name="ID" id="ID"></input>
				<input type="hidden"  name="PARENT_DEPT_ID" id="PARENT_DEPT_ID"></input>
				<input type="hidden"  name="PARENT_TYPE" id="PARENT_TYPE"></input>
				<div class="formExtendBase">
						<div class="formUnit column2">
							<label class="labelbg">部门代码：</label>
							<div class="inputContainer">
								<input class="easyui-validatebox" disabled="disabled"  data-options="required:true,validType:length[0,100]" type="text" name="DEPT_CODE" id="DEPT_CODE" ></input>
							</div>
						</div>
					
						<div class="formUnit column2">
							<label class="labelbg">部门名称：</label>
							<div class="inputContainer">
								<input class="easyui-validatebox" disabled="disabled"  data-options="required:true" type="text" name="DEPT_NAME" id="DEPT_NAME" ></input>
							</div>
						</div>
					
						<div class="formUnit column2">
							<label>部门别名：</label>
							<div class="inputContainer">
								<input class="easyui-validatebox" disabled="disabled" type="text" name="DEPT_ALIAS" id="DEPT_ALIAS" ></input>
							</div>
						</div>
					
						<div class="formUnit column2">
							<label>上级部门：</label>
							<div class="inputContainer">
								<input class="easyui-validatebox" disabled="disabled" type="text" name="PARENT_DEPT_NAME" id="PARENT_DEPT_NAME" ></input>
							</div>
						</div>
					
						<div class="formUnit column2">
							<label>邮编：</label>
							<div class="inputContainer">
								<input class="easyui-validatebox" disabled="disabled" data-options="validType:'zipcode'" type="text" name="POST" id="POST" ></input>
							</div>
						</div>
					
						<div class="formUnit column2">
							<label >电话：</label>
							<div class="inputContainer">
								<input class="easyui-validatebox" disabled="disabled" data-options="validType:'tel'" type="text" name="TEL" id="TEL" ></input>
							</div>
						</div>
					
						<div class="formUnit column2">
							<label >传真：</label>
							<div class="inputContainer">
								<input class="easyui-validatebox" disabled="disabled" data-options="validType:'fax'" type="text" name="FAX" id="FAX" ></input>
							</div>
						</div>
					
						<div class="formUnit column2">
							<label >邮箱：</label>
							<div class="inputContainer">
								<input class="easyui-validatebox" disabled="disabled" data-options="validType:'email'" type="text" name="EMAIL" id="EMAIL" ></input>
							</div>
						</div>
					
						<div class="formUnit column2">
							<label>工作日历：</label>
							<div class="inputContainer">
								<input class="easyui-datebox" type="text" name="WORK_CALENDAR_ID" id="WORK_CALENDAR_ID" ></input>
							</div>
						</div>
					
						<div class="formUnit column2">
							<label>排序编号：</label>
							<div class="inputContainer">
								<input class="easyui-numberbox" disabled="disabled" data-options="max:9999999999" type="text" name="ORDER_BY" id="ORDER_BY" ></input>
							</div>
						</div>
						<div class="formUnit column2">
							<label>工作地点：</label>
							<div class="inputContainer">
								<input class="easyui-validatebox" disabled="disabled"  type="text"  name="DEPT_PLACE" id="DEPT_PLACE" ></input>
							</div>
						</div>
						<div class="formUnit column2">
							<label class="labelbg">部门类型：</label>
							<div class="inputContainer">
								<c:forEach items="<%=lookUpdeptType%>" var="data">
									<input type="radio" name="DEPT_TYPE" disabled="disabled" id="DEPT_TYPE" value="${data.lookupCode}" style="width: 20px"/>${data.lookupName}
								</c:forEach>
							</div>
						</div>
						<div class="formUnit column2">
							<label class="labelbg">状态：</label>
							<div class="inputContainer">
								<c:forEach items="<%=lookUpValidFlag%>" var="data">
									<input type="radio" name="VALID_FLAG" disabled="disabled" id="VALID_FLAG" value="${data.lookupCode}" style="width: 20px"/>${data.lookupName}
								</c:forEach>
							</div>
						</div>
						<div class="formUnit column1" style="height:80px">
							<label>描述 ：</label>
							<div class="inputContainer">
								<textarea  style="height:60px;width: 90%" disabled="disabled"  name="DEPT_DESC" id="DEPT_DESC"></textarea>
							</div>
						</div>
					
					<div class="formUnit column1" style="height:40px">
							<label><div class="icon-tip"></div></label>
							<div class="inputContainer">
								<div><span class="icon-org"></span>代表组织 &nbsp;<span class="icon-dept"></span>代表部门</div>
							</div>
					</div>
				</div>
			</form> 
</div>
</body>
</html>