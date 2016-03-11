<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<html>
<head>
	<base href="<%=ViewUtil.getRequestPath(request)%>">
	<script src="static/js/platform/component/jQuery/jQuery-1.8.2/jquery-1.8.2.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="static/js/platform/component/commonword/Ntkoocx.js"></script>
	<title>查看正文</title>
</head>
<%
	String path = request.getContextPath();
	if (path.equals("/")) { path = "";}
	String strAuthType = (String) request.getHeader("Auth_Type");
	String processInstanceId = (String) request.getParameter("processInstanceId");
	String executionId = (String) request.getParameter("executionId");
%>
<body onload="doOpen();">
	<form id="" method="post" enctype ="multipart/form-data">
		<script type="text/javascript">
		   var baseurl = '<%=request.getContextPath()%>';
			//打开正文
			function doOpen(){
		        TANGER_OCX_OpenDoc("<%=processInstanceId%>");//打开正文
				var url = "<%=path%>/platform/bpm/clientbpmwordction/getWordRight";
				jQuery.ajax({
			        type:"POST",
					data:"processInstanceId=<%=processInstanceId%>&executionId=<%=executionId%>",
			        url: url,  
			        dataType:"json",
					context: document.body, 
			        success: function(msg){
			        	if(msg!=null){
			        		if(msg.error!=null){ //失败
			        			window.alert("Ajax操作时发生异常，地址为：" + url + "，异常信息为：" + msg.error);
			        			return;
			        		}else{
			        			getWordRight(msg.docRight);//得到正文权限
			        		}
			        	}
					},
					error: function(msg){
						window.alert("Ajax操作时发生异常，地址为：" + url + "，异常信息为：" + msg.responseText);
					}
		    	}); 
			}
			
			//打开模板
			function TANGER_OCX_OpenDoc(processInstanceId){
				TANGER_OCX_OBJ = document.all.item("TANGER_OCX");
				if(processInstanceId != ""){	
					TANGER_OCX_OBJ.BeginOpenFromURL("<%=path%>/platform/bpm/clientbpmwordction/getword.doc?processInstanceId=<%=processInstanceId%>&openType=wordRead");
				}else{
					alert("没有正文模板，请添加正文模板！");
				}
			}
			
			//关闭
			function doClose(){
				window.close();
			}
			
			//得到正文拥有的权限
			var userName = "";//文档处理人
			var read1 = false;//显示清稿
			var read2 = false;//显示留痕
			var wordSecretPrintUser = false;//是否有打印权限
			function getWordRight(docRight) {
				if (docRight.userName) userName = docRight.userName;
				if (docRight.read1) read1 = true;
				if (docRight.read2) read2 = true;
				if (docRight.wordSecretPrintUser) wordSecretPrintUser = true;
				initCustomMenus();
			}
			
			//控制
			function ShowTitleBar() {
				TANGER_OCX_OBJ.Menubar = true;
				TANGER_OCX_EnableFileNewMenu(false);
				TANGER_OCX_EnableFileOpenMenu(false);
				TANGER_OCX_EnableFilePropertiesMenu(false);
				TANGER_OCX_EnableFileCloseMenu(false);
				TANGER_OCX_EnableFilePageSetupMenu(false);
				TANGER_OCX_EnableFileSaveMenu(false);
				TANGER_OCX_EnableFileSaveAsMenu(false);
				TANGER_OCX_EnableFilePrintPreviewMenu(false);
				TANGER_OCX_EnableFilePrintMenu(false);
				
				//显示留痕
				TANGER_OCX_ShowRevisions(false);
			}
			
			//初始化自定义按钮
			function initCustomMenus() {
				if (read2) {
					TANGER_OCX_OBJ.AddCustomButtonOnMenu(0,"显示留痕",true);
				}
				if (read1) {
					TANGER_OCX_OBJ.AddCustomButtonOnMenu(1,"显示清稿",true);
				}
				
				if(wordSecretPrintUser){//打印
					TANGER_OCX_EnableFilePrintPreviewMenu(true);
					TANGER_OCX_EnableFilePrintMenu(true);
				}
			}
		</script>
	
		<!-- 引用正文控件 -->
		<script src="static/js/platform/component/commonword/NtkoObjRead.js"></script>
		<!-- 以下函数相应控件的两个事件:OnDocumentClosed,和OnDocumentOpened -->
	    <script language="JScript" for=TANGER_OCX event="OnDocumentClosed()">
		   	TANGER_OCX_OnDocumentClosed();
	 	</script>
		<script  language="JScript" for=TANGER_OCX event="OnDocumentOpened(TANGER_OCX_str,TANGER_OCX_obj)">
			TANGER_OCX_OnDocumentOpened(TANGER_OCX_str,TANGER_OCX_obj);
			ShowTitleBar();
		</script>
		<script language="JScript" for="TANGER_OCX" event="OnFileCommand(cmd,canceled)"></script> 
		<script language="JScript" for="TANGER_OCX" event="OnCustomButtonOnMenuCmd(btnPos,btnCaption,btnCmdid)">
			//事件处理代码中可以直接引用控件属性或者方法，可以省略控件对象前缀
			if(btnCmdid == 0) {//"显示留痕"
				TANGER_OCX_ShowRevisions(true);
			} else if(btnCmdid == 1) {//"显示清稿"
				TANGER_OCX_ShowRevisions(false);
			}
		</script>
	</form>
</body>
</html>

