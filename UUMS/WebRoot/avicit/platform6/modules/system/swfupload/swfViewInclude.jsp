<%@page import="avicit.platform6.modules.system.sysfileupload.service.SwfUploadService"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="avicit.platform6.core.spring.SpringFactory"%>
<%@page import="avicit.platform6.commons.utils.ComUtil"%>
<%@page import="java.util.*"%>
<%
	String form_id = ComUtil.replaceNull2Space(request.getParameter("form_id"));
	String save_type = ComUtil.replaceNull2Space(request.getParameter("save_type"));
	String secret_level = ComUtil.replaceNull2Space(request.getParameter("secret_level"));
	String file_category = ComUtil.replaceNull2Space(request.getParameter("file_category"));
	String form_field = ComUtil.replaceNull2Space(request.getParameter("form_field"));
	SwfUploadService swfUploadService = (SwfUploadService) SpringFactory.getBean(SwfUploadService.class);
	
	Map<String,String> para = new HashMap<String,String>();
	para.put("formId", form_id);
	para.put("saveType", save_type);
	para.put("secretLevel", secret_level);
	para.put("fileCategory", file_category);
	
	Map<String,String> result = swfUploadService.getAttachViewHtml(para);
	String attachHtml = result.get("html");
	if (form_field != null && !"".equals(form_field)){
		String[] fields = form_field.split(",");
		for (String field : fields){
			para.put("formId", field);
			Map<String,String> res = swfUploadService.getAttachViewHtml(para);
			attachHtml += res.get("html");
		}
	}
%>
<script type="text/javascript">
	var baseurl = "<%=request.getContextPath()%>";
	var form_id = "<%=form_id%>";
	var save_type = "<%=save_type%>";

	function downloadFile(fileId,formId,formTable,saveType){
		window.open("<%=request.getContextPath()%>/platform/swfUploadController/doDownload?fileuploadBusinessId="+formId+"&fileuploadBusinessTableName="+formTable+"&fileuploadIsSaveToDatabase=<%=save_type%>&fileId="+fileId,"_blank");
	}
</script>
<link href="avicit/platform6/modules/system/swfupload/swf/css/default.css"
	rel="stylesheet" type="text/css" />
	<table width="95%" cellspacing="1" cellpadding="1" border="0">
		<tr>
			<td colspan="2">
				<TABLE id="idFileList" width="100%" border="0" cellpadding="1"
					cellspacing="1">
					<tr class="newUploadTitle">
							<th align="center" nowrap>
								附件名称
							</th>
							<% if(file_category!=null && !file_category.equals("")) {%>
							<th align="center" nowrap>
								附件类型
							</th>
							<%} %>
							<% if(secret_level!=null && !secret_level.equals("")) {%>
							<th align="center" nowrap>
								附件密级
							</th>
							<%} %>
							<th align="center" nowrap>
								附件大小
							</th>
							<th  align="center" nowrap>
								操作
							</th>
						</tr>
					<%=attachHtml%>
				</table>
			</td>
		</tr>

	</table>
