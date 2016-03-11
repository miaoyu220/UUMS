<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "uums/synch/log/userlog/uumslogsynchuser/UumsLogSynchUserController/operation/Edit/id" -->
<title>修改</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js" type="text/javascript"></script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false" style="overflow:auto;padding-bottom:35px;">
		<form id='form'>
															<input type="hidden" name="id" value='${uumsLogSynchUserDTO.id}'/>
																																																																																																																				<table width="100%" style="padding-top: 10px;">
					<tr>
																																																														<th align="right">
																	<span style="color:red;">*</span>
																应用系统:</th>
								<td>
																											<input title="应用系统" class="easyui-validatebox" data-options="required:true,validType:'maxLength[32]'" style="width: 180px;" type="text" name="appId" id="appId" value='${uumsLogSynchUserDTO.appId}'/>
																									</td>
																																															<th align="right">
																	<span style="color:red;">*</span>
																组织名称:</th>
								<td>
																											<input title="组织名称" class="easyui-validatebox" data-options="required:true,validType:'maxLength[200]'" style="width: 180px;" type="text" name="userName" id="userName" value='${uumsLogSynchUserDTO.userName}'/>
																									</td>
																	</tr>
									<tr>
																																															<th align="right">
																	<span style="color:red;">*</span>
																组织编码:</th>
								<td>
																											<input title="组织编码" class="easyui-validatebox" data-options="required:true,validType:'maxLength[100]'" style="width: 180px;" type="text" name="userId" id="userId" value='${uumsLogSynchUserDTO.userId}'/>
																									</td>
																																															<th align="right">
																	<span style="color:red;">*</span>
																同步时间:</th>
								<td>
																									  		<input title="同步时间" class="easyui-datebox" data-options="required:true" style="width: 182px;" type="text" name="synchTime" id="synchTime" value='${uumsLogSynchUserDTO.synchTime}'/>
																									</td>
																	</tr>
									<tr>
																																															<th align="right">
																	<span style="color:red;">*</span>
																同步结果:</th>
								<td>
								                                     <pt6:syslookup name="synchFlag" lookupCode="UUMS_SYNCH_RESULT" defaultValue='${uumsLogSynchUserDTO.synchFlag}' dataOptions="width:180,editable:false,panelHeight:'auto'">
                                     </pt6:syslookup> 
																</td>
																																															<th align="right">
																	<span style="color:red;">*</span>
																操作类型:</th>
								<td>
								                                     <pt6:syslookup name="operFlag" lookupCode="UUMS_OPER_FLAG" defaultValue='${uumsLogSynchUserDTO.operFlag}' dataOptions="width:180,editable:false,panelHeight:'auto'">
                                     </pt6:syslookup> 
																</td>
																	</tr>
									<tr>
																																															<th align="right">
																	<span style="color:red;">*</span>
																同步方式:</th>
								<td>
								                                     <pt6:syslookup name="synchType" lookupCode="UUMS_SYNCH_OPER_TYPE" defaultValue='${uumsLogSynchUserDTO.synchType}' dataOptions="width:180,editable:false,panelHeight:'auto'">
                                     </pt6:syslookup> 
																</td>
																																															<th align="right">
																								失败原因:</th>
								<td>
																											<input title="失败原因" class="inputbox easyui-validatebox" data-options="validType:'maxLength[4000]'" style="width: 180px;" type="text" name="faildCause" id="faildCause" value='${uumsLogSynchUserDTO.faildCause}'/>
																									</td>
																	</tr>
									<tr>
																																															<th align="right">
																								操作人:</th>
								<td>
																											<input title="操作人" class="inputbox easyui-validatebox" data-options="validType:'maxLength[200]'" style="width: 180px;" type="text" name="operator" id="operator" value='${uumsLogSynchUserDTO.operator}'/>
																									</td>
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
																															if(!"${uumsLogSynchUserDTO.synchTime}"==""){
					$('#synchTime').datebox('setValue', parserColumnTime("${uumsLogSynchUserDTO.synchTime}").format("yyyy-MM-dd"));
				}
																																																																																																																																																																																																																																																													})
	function closeForm(){
		parent.uumsLogSynchUser.closeDialog("#edit");
	}
	function saveForm(){
	    if ($('#form').form('validate') == false) {
            return;
        }
		parent.uumsLogSynchUser.save(serializeObject($('#form')),"#edit");
	}
	</script>
</body>
</html>