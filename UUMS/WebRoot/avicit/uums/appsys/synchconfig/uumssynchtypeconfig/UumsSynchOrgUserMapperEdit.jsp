<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sec" uri="/WEB-INF/tags/shiro.tld"%>
<%@taglib prefix="pt6" uri="/WEB-INF/tags/platform6.tld"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- ControllerPath = "uums/appsys/synchconfig/uumssynchtypeconfig/UumsSynchTypeConfigController/operation/sub/Edit/id" -->
<title>修改</title>
<base href="<%=ViewUtil.getRequestPath(request)%>">
<jsp:include page="/avicit/platform6/component/common/EasyUIJsInclude.jsp"></jsp:include>
<jsp:include page="/avicit/platform6/modules/system/commonpopup/commonSelectionHead.jsp"></jsp:include>
<script src="static/js/platform/component/common/exteasyui.js" type="text/javascript"></script>
</head>
<body class="easyui-layout" fit="true">
	<div data-options="region:'center',split:true,border:false" style="overflow:auto;padding-bottom:35px;">
		<form id='form'>
			<input type="hidden" name="id" value='${uumsSynchOrgUserMapperDTO.id}'/>
			<input type="hidden" name="typeId" value='${uumsSynchOrgUserMapperDTO.typeId}'/>
				<table width="100%" style="padding-top: 10px;">
					<tr>
	    	    		    		    			    	    		    			<th align="right">
    			    				<span style="color:red;">*</span>
    			    			主体类型:</th>
    			<td>
    			    				    					<input title="主体类型" class="easyui-validatebox" data-options="required:true,validType:'maxLength[20]'" style="width: 180px;" type="text" name="mainType" id="mainType" value='${uumsSynchOrgUserMapperDTO.mainType}'/>
    				    			    			</td>
    			    		    			    	    		    			<th align="right">
    			    				<span style="color:red;">*</span>
    			    			字段名称:</th>
    			<td>
    			    				    					<input title="字段名称" class="easyui-validatebox" data-options="required:true,validType:'maxLength[1000]'" style="width: 180px;" type="text" name="columnName" id="columnName" value='${uumsSynchOrgUserMapperDTO.columnName}'/>
    				    			    			</td>
    			    				</tr>
    				<tr>
    			    		    			    	    		    			<th align="right">
    			    				<span style="color:red;">*</span>
    			    			字段CODE:</th>
    			<td>
    			    				    					<input title="字段CODE" class="easyui-validatebox" data-options="required:true,validType:'maxLength[100]'" style="width: 180px;" type="text" name="columnCode" id="columnCode" value='${uumsSynchOrgUserMapperDTO.columnCode}'/>
    				    			    			</td>
    			    		    			    	    		    			<th align="right">
    			    				<span style="color:red;">*</span>
    			    			数据类型:</th>
    			<td>
    			                       <pt6:syslookup name="dataType" lookupCode="UUMS_DB_DATA_TYPE" defaultValue='${uumsSynchOrgUserMapperDTO.dataType}' dataOptions="width:180,editable:false,panelHeight:'auto'">
                       </pt6:syslookup> 
    			
    			    			</td>
    			    				</tr>
    				<tr>
    			    		    			    	    		    			<th align="right">
    			    			    			排序:</th>
    			<td>
    			    				    			  		<input title="排序" class="easyui-numberbox easyui-validatebox" data-options="validType:'maxLength[22]'" style="width: 180px;" type="text" name="orderBy" id="orderBy" value='${uumsSynchOrgUserMapperDTO.orderBy}'/>	
    				    			    			</td>
    			    		    			    	    		    			<th align="right">
    			    			    			注释:</th>
    			<td>
    			    				    					<input title="注释" class="inputbox easyui-validatebox" data-options="validType:'maxLength[3000]'" style="width: 180px;" type="text" name="comments" id="comments" value='${uumsSynchOrgUserMapperDTO.comments}'/>
    				    			    			</td>
    			    				</tr>
    				<tr>
    			    		    				    	    		    			<th align="right">
    			    			    			字段数据格式化:</th>
    			<td>
    			    				    					<input title="字段数据格式化" class="inputbox easyui-validatebox" data-options="validType:'maxLength[200]'" style="width: 180px;" type="text" name="dataFormat" id="dataFormat" value='${uumsSynchOrgUserMapperDTO.dataFormat}'/>
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
																																																																														})
	function closeForm(){
		parent.uumsSynchOrgUserMapper.closeDialog("#edit");
	};
	function saveForm(){
	  if ($('#form').form('validate') == false) {
                return;
            }
		parent.uumsSynchOrgUserMapper.save(serializeObject($('#form')),"#edit");
	};
	</script>
</body>
</html>