<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "uums/synch/toappsys/orgdept/uumsorgsynchrecord/UumsOrgSynchRecordController/operation/Detail/id" -->
<title>详情</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js" type="text/javascript"></script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false" style="overflow:hidden;padding-bottom:35px;">
		<form id='form'>
									<input type="hidden" name="id" value='${uumsOrgSynchRecordDTO.id}'/>
												<input type="hidden" name="id" value='${uumsOrgSynchRecordDTO.id}'/>
																																																																																							<table width="100%" style="padding-top: 10px;">
		<tr>
																																<th align="right">
											<span style="color:red;">*</span>
										组织编码:</th>
					<td>
																		<input title="组织编码" class="easyui-validatebox" data-options="required:true" style="width: 180px;" type="text" name="orgCode" id="orgCode" readonly="readonly" value='${uumsOrgSynchRecordDTO.orgCode}'/>
																</td>
																										<th align="right">
															组织OR部门:</th>
					<td>
																		<input title="组织OR部门" class="inputbox" style="width: 180px;" type="text" name="orgOrDept" id="orgOrDept" readonly="readonly" value='${uumsOrgSynchRecordDTO.orgOrDept}'/>
																</td>
											</tr>
						<tr>
																										<th align="right">
											<span style="color:red;">*</span>
										操作状态:</th>
					<td>
																		<input title="操作状态" class="easyui-validatebox" data-options="required:true" style="width: 180px;" type="text" name="operFlag" id="operFlag" readonly="readonly" value='${uumsOrgSynchRecordDTO.operFlag}'/>
																</td>
																										<th align="right">
											<span style="color:red;">*</span>
										同步状态:</th>
					<td>
																		<input title="同步状态" class="easyui-validatebox" data-options="required:true" style="width: 180px;" type="text" name="synchFlag" id="synchFlag" readonly="readonly" value='${uumsOrgSynchRecordDTO.synchFlag}'/>
																</td>
											</tr>
						<tr>
																										<th align="right">
															更新时间:</th>
					<td>
																  		<input title="更新时间" class="easyui-datebox" style="width: 180px;" type="text" name="updateTime" id="updateTime" readonly="readonly" value='${uumsOrgSynchRecordDTO.updateTime}'/>
																</td>
																										<th align="right">
															同步时间:</th>
					<td>
																  		<input title="同步时间" class="easyui-datebox" style="width: 180px;" type="text" name="synchTime" id="synchTime" readonly="readonly" value='${uumsOrgSynchRecordDTO.synchTime}'/>
																</td>
											</tr>
						<tr>
																										<th align="right">
															同步方式:</th>
					<td>
																		<input title="同步方式" class="inputbox" style="width: 180px;" type="text" name="synchType" id="synchType" readonly="readonly" value='${uumsOrgSynchRecordDTO.synchType}'/>
																</td>
																																																								<th align="right">
															父组织编码:</th>
					<td>
																		<input title="父组织编码" class="inputbox" style="width: 180px;" type="text" name="parentOrgCode" id="parentOrgCode" readonly="readonly" value='${uumsOrgSynchRecordDTO.parentOrgCode}'/>
																</td>
											</tr>
						<tr>
																										<th align="right">
											<span style="color:red;">*</span>
										组织ID:</th>
					<td>
																		<input title="组织ID" class="easyui-validatebox" data-options="required:true" style="width: 180px;" type="text" name="sysOrgId" id="sysOrgId" readonly="readonly" value='${uumsOrgSynchRecordDTO.sysOrgId}'/>
																</td>
																										<th align="right">
											<span style="color:red;">*</span>
										应用系统ID:</th>
					<td>
																		<input title="应用系统ID" class="easyui-validatebox" data-options="required:true" style="width: 180px;" type="text" name="appId" id="appId" readonly="readonly" value='${uumsOrgSynchRecordDTO.appId}'/>
																</td>
											</tr>
						<tr>
																</tr>
		</table>
		</form>
	</div>
	<script type="text/javascript">
	$(function(){
																																				if(!"${uumsOrgSynchRecordDTO.updateTime}"==""){
					$('#updateTime').datebox('setValue', parserColumnTime("${uumsOrgSynchRecordDTO.updateTime}").format("yyyy-MM-dd"));
				}
												if(!"${uumsOrgSynchRecordDTO.synchTime}"==""){
					$('#synchTime').datebox('setValue', parserColumnTime("${uumsOrgSynchRecordDTO.synchTime}").format("yyyy-MM-dd"));
				}
																																																																																																																																																																																																																																																																								});
	</script>
</body>
</html>