<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "uums/synch/log/orglog/uumslogsynchorg/UumsLogSynchOrgController/operation/Detail/id" -->
<title>详情</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js" type="text/javascript"></script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false" style="overflow:hidden;padding-bottom:35px;">
		<form id='form'>
									<input type="hidden" name="id" value='${uumsLogSynchOrgDTO.id}'/>
												<input type="hidden" name="id" value='${uumsLogSynchOrgDTO.id}'/>
																																																				<table width="100%" style="padding-top: 10px;">
		<tr>
																																<th align="right">
											<span style="color:red;">*</span>
										应用系统:</th>
					<td>
																		<input title="应用系统" class="easyui-validatebox" data-options="required:true" style="width: 180px;" type="text" name="appId" id="appId" readonly="readonly" value='${uumsLogSynchOrgDTO.appId}'/>
																</td>
																										<th align="right">
											<span style="color:red;">*</span>
										组织名称:</th>
					<td>
																		<input title="组织名称" class="easyui-validatebox" data-options="required:true" style="width: 180px;" type="text" name="orgName" id="orgName" readonly="readonly" value='${uumsLogSynchOrgDTO.orgName}'/>
																</td>
											</tr>
						<tr>
																										<th align="right">
											<span style="color:red;">*</span>
										组织编码:</th>
					<td>
																		<input title="组织编码" class="easyui-validatebox" data-options="required:true" style="width: 180px;" type="text" name="orgCode" id="orgCode" readonly="readonly" value='${uumsLogSynchOrgDTO.orgCode}'/>
																</td>
																										<th align="right">
											<span style="color:red;">*</span>
										同步时间:</th>
					<td>
																  		<input title="同步时间" class="easyui-datebox easyui-validatebox" data-options="required:true" style="width: 180px;" type="text" readonly="readonly" name="synchTime" id="synchTime" value='${uumsLogSynchOrgDTO.synchTime}'/>
																</td>
											</tr>
						<tr>
																										<th align="right">
											<span style="color:red;">*</span>
										同步结果:</th>
					<td>
																		<input title="同步结果" class="easyui-validatebox" data-options="required:true" style="width: 180px;" type="text" name="synchFlag" id="synchFlag" readonly="readonly" value='${uumsLogSynchOrgDTO.synchFlag}'/>
																</td>
																										<th align="right">
											<span style="color:red;">*</span>
										操作类型:</th>
					<td>
																		<input title="操作类型" class="easyui-validatebox" data-options="required:true" style="width: 180px;" type="text" name="operFlag" id="operFlag" readonly="readonly" value='${uumsLogSynchOrgDTO.operFlag}'/>
																</td>
											</tr>
						<tr>
																										<th align="right">
											<span style="color:red;">*</span>
										同步方式:</th>
					<td>
																		<input title="同步方式" class="easyui-validatebox" data-options="required:true" style="width: 180px;" type="text" name="synchType" id="synchType" readonly="readonly" value='${uumsLogSynchOrgDTO.synchType}'/>
																</td>
																										<th align="right">
															失败原因:</th>
					<td>
																		<input title="失败原因" class="inputbox" style="width: 180px;" type="text" name="faildCause" id="faildCause" readonly="readonly" value='${uumsLogSynchOrgDTO.faildCause}'/>
																</td>
											</tr>
						<tr>
																										<th align="right">
															操作人:</th>
					<td>
																		<input title="操作人" class="inputbox" style="width: 180px;" type="text" name="operator" id="operator" readonly="readonly" value='${uumsLogSynchOrgDTO.operator}'/>
																</td>
																</tr>
		</table>
		</form>
	</div>
	<script type="text/javascript">
	$(function(){
																															if(!"${uumsLogSynchOrgDTO.synchTime}"==""){
					$('#synchTime').datebox('setValue', parserColumnTime("${uumsLogSynchOrgDTO.synchTime}").format("yyyy-MM-dd"));
				}
																																																																																																																																																																																																	});
	</script>
</body>
</html>