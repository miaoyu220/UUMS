<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "uums/appsys/register/uumsappsys/UumsAppSysController/operation/Detail/id" -->
<title>详情</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js" type="text/javascript"></script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false" style="overflow:hidden;padding-bottom:35px;">
		<form id='form'>
									<input type="hidden" name="id" value='${uumsAppSysDTO.id}'/>
												<input type="hidden" name="id" value='${uumsAppSysDTO.id}'/>
																																																																																																	<table width="100%" style="padding-top: 10px;">
		<tr>
																																<th align="right">
											<span style="color:red;">*</span>
										应用系统编码:</th>
					<td>
																		<input title="应用系统编码" class="easyui-validatebox" data-options="required:true" style="width: 180px;" type="text" name="appCode" id="appCode" readonly="readonly" value='${uumsAppSysDTO.appCode}'/>
																</td>
																										<th align="right">
											<span style="color:red;">*</span>
										应用系统名称:</th>
					<td>
																		<input title="应用系统名称" class="easyui-validatebox" data-options="required:true" style="width: 180px;" type="text" name="appName" id="appName" readonly="readonly" value='${uumsAppSysDTO.appName}'/>
																</td>
											</tr>
						<tr>
																										<th align="right">
															应用系统简介:</th>
					<td>
																		<input title="应用系统简介" class="inputbox" style="width: 180px;" type="text" name="appDescribe" id="appDescribe" readonly="readonly" value='${uumsAppSysDTO.appDescribe}'/>
																</td>
																										<th align="right">
											<span style="color:red;">*</span>
										系统安全管理员:</th>
					<td>
											<input title="{param.field.comment}" class="inputbox"  style="width: 180px;" type="hidden" name="securitAdmin" id="securitAdmin"/>
						<div class=""><input class="easyui-validatebox"  name="securitAdminAlias"   id="securitAdminAlias"  readOnly="readOnly" style="width:179px;" ></input></div>
										</td>
											</tr>
						<tr>
																										<th align="right">
											<span style="color:red;">*</span>
										是否权威数据源:</th>
					<td>
																		<input title="是否权威数据源" class="easyui-validatebox" data-options="required:true" style="width: 180px;" type="text" name="isDataSource" id="isDataSource" readonly="readonly" value='${uumsAppSysDTO.isDataSource}'/>
																</td>
																										<th align="right">
											<span style="color:red;">*</span>
										新增是否审批:</th>
					<td>
																		<input title="新增是否审批" class="easyui-validatebox" data-options="required:true" style="width: 180px;" type="text" name="addAuditFlag" id="addAuditFlag" readonly="readonly" value='${uumsAppSysDTO.addAuditFlag}'/>
																</td>
											</tr>
						<tr>
																										<th align="right">
											<span style="color:red;">*</span>
										修改是否审批:</th>
					<td>
																		<input title="修改是否审批" class="easyui-validatebox" data-options="required:true" style="width: 180px;" type="text" name="editAuditFlag" id="editAuditFlag" readonly="readonly" value='${uumsAppSysDTO.editAuditFlag}'/>
																</td>
																										<th align="right">
											<span style="color:red;">*</span>
										删除是否审批:</th>
					<td>
																		<input title="删除是否审批" class="easyui-validatebox" data-options="required:true" style="width: 180px;" type="text" name="delAuditFlag" id="delAuditFlag" readonly="readonly" value='${uumsAppSysDTO.delAuditFlag}'/>
																</td>
											</tr>
						<tr>
																										<th align="right">
															同步方式:</th>
					<td>
																		<input title="同步方式" class="inputbox" style="width: 180px;" type="text" name="synchType" id="synchType" readonly="readonly" value='${uumsAppSysDTO.synchType}'/>
																</td>
																										<th align="right">
															创建时间:</th>
					<td>
																  		<input title="创建时间" class="easyui-datebox" style="width: 180px;" type="text" name="createTime" id="createTime" readonly="readonly" value='${uumsAppSysDTO.createTime}'/>
																</td>
											</tr>
						<tr>
																										<th align="right">
															修改时间:</th>
					<td>
																  		<input title="修改时间" class="easyui-datebox" style="width: 180px;" type="text" name="updateTime" id="updateTime" readonly="readonly" value='${uumsAppSysDTO.updateTime}'/>
																</td>
																										<th align="right">
															排序:</th>
					<td>
																  		<input title="排序" class="easyui-numberbox" style="width: 180px;" type="text" name="orderBy" id="orderBy" readonly="readonly" value='${uumsAppSysDTO.orderBy}'/>	
																</td>
											</tr>
						<tr>
																																														</tr>
		</table>
		</form>
	</div>
	<script type="text/javascript">
	$(function(){
																																																													if(!"${uumsAppSysDTO.createTime}"==""){
					$('#createTime').datebox('setValue', parserColumnTime("${uumsAppSysDTO.createTime}").format("yyyy-MM-dd"));
				}
												if(!"${uumsAppSysDTO.updateTime}"==""){
					$('#updateTime').datebox('setValue', parserColumnTime("${uumsAppSysDTO.updateTime}").format("yyyy-MM-dd"));
				}
																																																																																																																						var securitAdminUserCommonSelector = new CommonSelector("user","userSelectCommonDialog","securitAdmin","securitAdminAlias");
					securitAdminUserCommonSelector.init(); 
																																																																																																																																																																								});
	</script>
</body>
</html>