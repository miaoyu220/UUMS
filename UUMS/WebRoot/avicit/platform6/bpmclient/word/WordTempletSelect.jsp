<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<html>
<head>
	<base href="<%=ViewUtil.getRequestPath(request) %>">
	<jsp:include page="/avicit/platform6/bpmclient/bpm/ProcessCommonJsInclude.jsp"></jsp:include>
	<title>正文模版</title>
</head>
<%
	String processInstanceId = request.getParameter("processInstanceId");
	String executionId = (String) request.getParameter("executionId");
	String taskId = (String) request.getParameter("taskId");
	String type = (String) request.getParameter("type");
%>
<script type="text/javascript">
var baseurl = '<%=request.getContextPath()%>';
var processInstanceId = '<%=processInstanceId%>';
var executionId = '<%=executionId%>';
var taskId = '<%=taskId%>';
var type = '<%=type%>';
$(function(){
	$('#wordTemplet').datagrid({
		url: 'platform/bpm/clientbpmwordction/getWordTempletList.json?processInstanceId='+processInstanceId+'&executionId='+executionId+'&type='+type,
		width: '100%',
	    nowrap: false,
	    striped: true,
	    autoRowHeight:false,
	    singleSelect:true,
	    checkOnSelect:false,
		height: 340,
		fitColumns: true,
		pagination:false,
		rownumbers:true,
		loadMsg:' 处理中，请稍候…',
		columns:[[
			{field:'id',title:'',width:40,align:'left',hidden:true},
			{field:'wordName',title:'模版名称',width:40,align:'center',
				formatter:function(value,rec){
  					return "<a href=\"javascript:window.doOpenTemplet('"+processInstanceId+"','"+executionId+"','"+rec.id+"','"+type+"');\">"+value+"</a>";
  				}
			}
		]]
	});
	loadProcessTree();
});

function doOpenTemplet(processInstanceId, executionId, templetId, type) {
	parent.openWordWindow(processInstanceId, executionId, templetId, type);
}

//初始化流程业务树 
function loadProcessTree(){
	$('#mytree').tree({   
		checkbox: false,   
		lines : true,
		method : 'post',
	    url:'platform/bpm/bpmPublishAction/getPrcessPublishTree.json?nodeType=word&id=root&processInstanceId='+processInstanceId+'&executionId='+executionId+'&type='+type, 
	    onBeforeExpand:function(node,param){ 
	    	 $('#mytree').tree('options').url = "platform/bpm/bpmPublishAction/getPrcessPublishTree.json?nodeType=word&id=" + node.id + "&processInstanceId="+processInstanceId+"&executionId="+executionId+"&type="+type;
	    },
	    onClick:function(node){
            clickTree(node);
      	}
	});  
}

//点击树事件 
function clickTree(node) {
	expand();
	$('#wordTemplet').datagrid({ url: 'platform/bpm/clientbpmwordction/getWordTempletList.json?processInstanceId='+processInstanceId+'&executionId='+executionId+'&type='+type + '&id=' + node.id } );
	$("#wordTemplet").datagrid('reload'); 
}

//展开树
function expand() {
	var node = $('#mytree').tree('getSelected');
	if(node){
		$('#mytree').tree('expand',node.target);
	}else{
		$('#mytree').tree('expandAll');
	}
}
</script>
<body class="easyui-layout" fit="true">
<div data-options="region:'west',title:'模板目录',split:true,collapsible:false"  style="width:200px;overflow: auto;">
	<ul id="mytree"> </ul>
</div>
<div region="center" border="false" style="overflow: hidden;">
	<table id="wordTemplet"></table>
</div>
</body>
</html>