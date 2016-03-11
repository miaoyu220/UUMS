<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "uums/synch/toappsys/orgdept/uumsorgsynchrecord/UumsOrgSynchRecordController/operation/Edit/id" -->
<title>修改</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js" type="text/javascript"></script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false" style="overflow:auto;padding-bottom:35px;">
		<form id='form'>
															<input type="hidden" name="id" value='${uumsOrgSynchRecordDTO.id}'/>
																																																																																																																											<table width="100%" style="padding-top: 10px;">
					<tr>
																																																														<th align="right">
																	<span style="color:red;">*</span>
																组织编码:</th>
								<td>
																											<input title="组织编码" class="easyui-validatebox" data-options="required:true,validType:'maxLength[50]'" style="width: 180px;" type="text" name="orgCode" id="orgCode" value='${uumsOrgSynchRecordDTO.orgCode}'/>
																									</td>
																																															<th align="right">
																								组织OR部门:</th>
								<td>
								                                     <pt6:syslookup name="orgOrDept" lookupCode="UUMS_ORG_OR_DEPT" defaultValue='${uumsOrgSynchRecordDTO.orgOrDept}' dataOptions="width:180,editable:false,panelHeight:'auto'">
                                     </pt6:syslookup> 
																</td>
																	</tr>
									<tr>
																																															<th align="right">
																	<span style="color:red;">*</span>
																操作状态:</th>
								<td>
								                                     <pt6:syslookup name="operFlag" lookupCode="UUMS_OPER_FLAG" defaultValue='${uumsOrgSynchRecordDTO.operFlag}' dataOptions="width:180,editable:false,panelHeight:'auto'">
                                     </pt6:syslookup> 
																</td>
																																															<th align="right">
																	<span style="color:red;">*</span>
																同步状态:</th>
								<td>
								                                     <pt6:syslookup name="synchFlag" lookupCode="UUMS_SYNCH_FLAG" defaultValue='${uumsOrgSynchRecordDTO.synchFlag}' dataOptions="width:180,editable:false,panelHeight:'auto'">
                                     </pt6:syslookup> 
																</td>
																	</tr>
									<tr>
																																															<th align="right">
																								更新时间:</th>
								<td>
																									  		<input title="更新时间" class="easyui-datebox"  style="width: 182px;" type="text" name="updateTime" id="updateTime" value='${uumsOrgSynchRecordDTO.updateTime}'/>
																									</td>
																																															<th align="right">
																								同步时间:</th>
								<td>
																									  		<input title="同步时间" class="easyui-datebox"  style="width: 182px;" type="text" name="synchTime" id="synchTime" value='${uumsOrgSynchRecordDTO.synchTime}'/>
																									</td>
																	</tr>
									<tr>
																																															<th align="right">
																								同步方式:</th>
								<td>
								                                     <pt6:syslookup name="synchType" lookupCode="UUMS_SYNCH_OPER_TYPE" defaultValue='${uumsOrgSynchRecordDTO.synchType}' dataOptions="width:180,editable:false,panelHeight:'auto'">
                                     </pt6:syslookup> 
																</td>
																																																																																																																	<th align="right">
																								父组织编码:</th>
								<td>
																											<input title="父组织编码" class="inputbox easyui-validatebox" data-options="validType:'maxLength[50]'" style="width: 180px;" type="text" name="parentOrgCode" id="parentOrgCode" value='${uumsOrgSynchRecordDTO.parentOrgCode}'/>
																									</td>
																	</tr>
									<tr>
																																															<th align="right">
																	<span style="color:red;">*</span>
																组织ID:</th>
								<td>
																											<input title="组织ID" class="easyui-validatebox" data-options="required:true,validType:'maxLength[50]'" style="width: 180px;" type="text" name="sysOrgId" id="sysOrgId" value='${uumsOrgSynchRecordDTO.sysOrgId}'/>
																									</td>
																																															<th align="right">
																	<span style="color:red;">*</span>
																应用系统ID:</th>
								<td>
																											<input title="应用系统ID" class="easyui-validatebox" data-options="required:true,validType:'maxLength[50]'" style="width: 180px;" type="text" name="appId" id="appId" value='${uumsOrgSynchRecordDTO.appId}'/>
																									</td>
																	</tr>
									<tr>
																															</tr>
					</table>
					</form>
		<div id="toolbar" class="datagrid-toolbar datagrid-toolbar-extend">
			<table class="tableForm" border="0" cellspacing="1" width='100%'>
				<tr>	
					<td width="50%" align="right">
						<a title="保存" id="saveButton" class="easyui-linkbutton" onclick="saveForm();" href="javascript:void(0);">保存</a>
						<a title="返回" id="returnButton" class="easyui-linkbutton" onclick="closeForm();" href="javascript:void(0);">返回</a>
					</td>
				</tr>
			</table>
		</div>
	</div>  
	<script type="text/javascript">
		$.extend($.fn.validatebox.defaults.rules, {    
        maxLength: {    
            validator: function(value, param){    
                return param[0] >= value.length;
                
            },    
            message: '请输入最多 {0} 字符.'   
        }    
    });  
	$(function(){
																																				if(!"${uumsOrgSynchRecordDTO.updateTime}"==""){
					$('#updateTime').datebox('setValue', parserColumnTime("${uumsOrgSynchRecordDTO.updateTime}").format("yyyy-MM-dd"));
				}
												if(!"${uumsOrgSynchRecordDTO.synchTime}"==""){
					$('#synchTime').datebox('setValue', parserColumnTime("${uumsOrgSynchRecordDTO.synchTime}").format("yyyy-MM-dd"));
				}
																																																																																																																																																																																																																																																																								})
	function closeForm(){
		parent.uumsOrgSynchRecord.closeDialog("#edit");
	}
	function saveForm(){
	    if ($('#form').form('validate') == false) {
            return;
        }
		parent.uumsOrgSynchRecord.save(serializeObject($('#form')),"#edit");
	}
	</script>
</body>
</html>