<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ page import="avicit.platform6.commons.utils.ViewUtil"%>
<div id="toolbarTree" class="datagrid-toolbar">
	 	<table width="100%">
	 		<tr>
	 			<td width="100%"><input type="text"  name="searchTempletTree" id="searchTempletTree"></input></td>
	 		</tr>
	 	</table>
 	 </div>
	 <ul id="templetTree">正在加载模版列表...</ul>
	 <div id="contextMenu" class="easyui-menu" style="width:120px;">
		<div onclick="tree.openinsert()" data-options="">添加</div>
		<div onclick="tree.openedit()" data-options="">编辑</div>
		<div onclick="tree.del()" data-options="">删除</div>
	 </div>
	 