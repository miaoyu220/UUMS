<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ request.getContextPath() + "/";
	String skin = "skyblue";
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<base href="<%=basePath%>">
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<title>流程设计</title>
<link rel="stylesheet" href="<%=basePath%>static/js/platform/designer/dhtmlx/codebase/dhtmlx.css" />
<link rel="stylesheet" href="<%=basePath%>static/js/platform/designer/css/style.css" />
<script>
	//全局变量
	var _basePath = "<%=basePath%>";
	var _controlPath = _basePath + "platform/bpm/bpmdesigner/bpmWebDesigner/";
	var _skin = "<%=skin%>";
	var mxBasePath = _basePath + "static/js/platform/designer/";
	var _designerPath = _basePath + "static/js/platform/designer/";
	var _iconPath = _designerPath + "images/";
	var _imgPath = _designerPath + "dhtmlx/codebase/imgs/";
	var _id = "${id}";
	var _type = "${type}";
</script>
<script src="<%=basePath%>static/js/platform/designer/dhtmlx/codebase/dhtmlx.js"></script>
<script src="<%=basePath%>static/js/platform/designer/jquery-1.11.3.min.js"></script>
<script src="<%=basePath%>static/js/platform/designer/mxClient.js"></script>
<script src="<%=basePath%>static/js/platform/designer/myExtend.js"></script>
<script src="<%=basePath%>static/js/platform/designer/mxApplication.js"></script>
<script src="<%=basePath%>static/js/platform/designer/ComUtils.js"></script>
<script src="<%=basePath%>static/js/platform/designer/MyAction.js"></script>
<script src="<%=basePath%>static/js/platform/designer/propUtils.js"></script>
<script src="<%=basePath%>static/js/platform/designer/prop.js"></script>
<script src="<%=basePath%>static/js/platform/designer/framePanel.js"></script>
<!-- 元素 -->
<script src="<%=basePath%>static/js/platform/designer/excells/MyBase.js"></script>
<script src="<%=basePath%>static/js/platform/designer/excells/MyProcess.js"></script>
<script src="<%=basePath%>static/js/platform/designer/excells/MyTransition.js"></script>
<script src="<%=basePath%>static/js/platform/designer/excells/MyStart.js"></script>
<script src="<%=basePath%>static/js/platform/designer/excells/MyEnd.js"></script>
<script src="<%=basePath%>static/js/platform/designer/excells/MyTask.js"></script>
<script src="<%=basePath%>static/js/platform/designer/excells/MyJava.js"></script>
<script src="<%=basePath%>static/js/platform/designer/excells/MySql.js"></script>
<script src="<%=basePath%>static/js/platform/designer/excells/MyWs.js"></script>
<script src="<%=basePath%>static/js/platform/designer/excells/MyState.js"></script>
<script src="<%=basePath%>static/js/platform/designer/excells/MyFork.js"></script>
<script src="<%=basePath%>static/js/platform/designer/excells/MyJoin.js"></script>
<script src="<%=basePath%>static/js/platform/designer/excells/MyExclusive.js"></script>
<script src="<%=basePath%>static/js/platform/designer/excells/MySubprocess.js"></script>
<script src="<%=basePath%>static/js/platform/designer/excells/MyForeach.js"></script>
<script src="<%=basePath%>static/js/platform/designer/excells/MyJms.js"></script>
<script src="<%=basePath%>static/js/platform/designer/excells/MyCustom.js"></script>
<style> /* it's important to set width/height to 100% for full-screen init */
html,body {
	width: 100%;
	height: 100%;
	margin: 0px;
	overflow: hidden;
}
</style>
</head>
<body>
	<div id="toolbar" style="width:100%;height:100%"></div>
	<div id="graph"></div>
	<div id="iconDiv" style="display:none;">
		<input type="radio" value="领导01.png" name="icon" checked /><label class="label_for">领导01<img alt="领导01" src="<%=basePath%>static/js/platform/designer/images/node/leader01.png" /></label>
		<input type="radio" value="领导02.png" name="icon" /><label class="label_for">领导02<img alt="领导02" src="<%=basePath%>static/js/platform/designer/images/node/leader02.png" /></label>
		<input type="radio" value="员工01.png" name="icon" /><label class="label_for">员工01<img alt="员工01" src="<%=basePath%>static/js/platform/designer/images/node/employee01.png" /></label>
		<input type="radio" value="员工02.png" name="icon" /><label class="label_for">员工02<img alt="员工02" src="<%=basePath%>static/js/platform/designer/images/node/employee02.png" /></label>
	</div>
	<!-- process start -->
	<div id="process" class="prop_wrap" style="display:none">
		<!-- 基本信息 -->
		<form id="jbxx" class="prop_cont" style="display:none" action="">
			<table>
				<tbody>
					<tr>
						<td class="prop_fc10">显示名称</td>
						<td class="prop_fc40">
							<input id="liu_cheng_ming_cheng" name="liu_cheng_ming_cheng" class="wp73 prop_txt" type="text" value="" />
						</td>
						<td class="prop_fc10">逻辑标识</td>
						<td class="prop_fc40">
							<input id="liu_cheng_biao_shi" name="liu_cheng_biao_shi" class="wp73 prop_ro prop_txt" type="text" value="" readonly />
						</td>
					</tr>
				</tbody>
			</table>
			<table>
				<tbody>
					<tr>
						<td class="prop_fc10">实例标题</td>
						<td class="prop_fc90">
							<input id="shi_li_biao_ti" name="shi_li_biao_ti" class="wp88 prop_txt" type="text" value="" />
							<!-- <input class="wp_10 js_variable" type="button" value="选择" /> 改为下面的,弹出框支持表达式-->
							<input class="wp_10 js_dbbt" type="button" value="选择" />
						</td>
					</tr>
					<tr>
						<td class="prop_fc10">流程删除</td>
						<td class="prop_fc90">
							<input id="liu_cheng_shan_chu" name="liu_cheng_shan_chu" class="wp88 prop_txt" type="text" value="" />
						</td>
					</tr>
					<tr>
						<td class="prop_fc10">流程描述</td>
						<td class="prop_fc90">
							<textarea maxlength="255" id="liu_cheng_miao_shu" name="liu_cheng_miao_shu" class="wp88 prop_txt java_ta"></textarea>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<!-- 启动条件 -->
		<form id="qdtj" class="prop_cont" style="display:none" action="">
			<table>
				<tbody>
					<tr>
						<td class="prop_fc10">执行方式</td>
						<td class="prop_fc90">
							<select id="zhi_xing_fang_shi">
								<option value="AND" selected>AND</option>
								<option value="OR">OR</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="prop_fc10"></td>
						<td class="prop_fc90">
							<div class="pc5">
								<table>
									<thead>
										<tr>
											<th class="pc5_th3">条件类型</th>
											<th class="pc5_th4">条件</th>
										</tr>
									</thead>
									<tbody id="qi_dong_tiao_jian">
										<tr>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
										</tr>
									</tbody>
								</table>
								<i class="e_add e_add_top js_add_c"></i> <i class="e_edit e_edit_top js_edit_c"></i> <i
									class="e_del e_del_top js_del"></i>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<!-- 全局权限 -->
		<form id="qjqx" class="prop_cont" style="display:none" action="">
			<table class="tab_1 need_check">
				<tbody>
					<tr>
						<td class="prop_fc10 prop_lbl">
							<input id="yi_jian_xiu_gai" name="yi_jian_xiu_gai" type="checkbox" />
                            <label class="label_for">意见修改</label>
						</td>
						<td class="prop_fc45">
							<input class="wp84 prop_txt flg_possess" type="text" value="" readonly disabled />
                            <input class="wp_10 js_who" type="button" value="操作人" disabled />
						</td>
						<td class="prop_fc45">
							<input class="wp84 prop_txt flg_pre-processing" type="text" value="" readonly disabled />
                            <input class="wp_10 js_cl" type="button" value="预处理" disabled />
						</td>
					</tr>
					<tr>
						<td class="prop_fc10 prop_lbl">
							<input id="liu_cheng_tiao_zhuan" name="liu_cheng_tiao_zhuan" type="checkbox" />
                            <label class="label_for">流程跳转</label>
						</td>
						<td class="prop_fc45">
							<input class="wp84 prop_txt flg_possess" type="text" value="" readonly disabled />
                            <input class="wp_10 js_who" type="button" value="操作人" disabled />
						</td>
						<td class="prop_fc45">
							<input class="wp84 prop_txt flg_pre-processing" type="text" value="" readonly disabled />
                            <input class="wp_10 js_cl" type="button" value="预处理" disabled />
						</td>
					</tr>
					<tr>
						<td class="prop_fc10 prop_lbl">
							<input id="liu_cheng_zan_ting" name="liu_cheng_zan_ting" type="checkbox" />
                            <label class="label_for">流程暂停</label>
						</td>
						<td class="prop_fc45">
							<input class="wp84 prop_txt flg_possess" type="text" value="" readonly disabled />
                            <input class="wp_10 js_who" type="button" value="操作人" disabled />
						</td>
						<td class="prop_fc45">
							<input class="wp84 prop_txt flg_pre-processing" type="text" value="" readonly disabled />
                            <input class="wp_10 js_cl" type="button" value="预处理" disabled />
						</td>
					</tr>
					<tr>
						<td class="prop_fc10 prop_lbl">
							<input id="liu_cheng_hui_fu" name="liu_cheng_hui_fu" type="checkbox" />
                            <label class="label_for">流程恢复</label>
						</td>
						<td class="prop_fc45">
							<input class="wp84 prop_txt flg_possess" type="text" value="" readonly disabled />
                            <input class="wp_10 js_who" type="button" value="操作人" disabled />
						</td>
						<td class="prop_fc45">
							<input class="wp84 prop_txt flg_pre-processing" type="text" value="" readonly disabled />
                            <input class="wp_10 js_cl" type="button" value="预处理" disabled />
						</td>
					</tr>
					<tr>
						<td class="prop_fc10 prop_lbl">
							<input id="liu_cheng_jie_shu" name="liu_cheng_jie_shu" type="checkbox" />
                            <label class="label_for">流程结束</label>
						</td>
						<td class="prop_fc45">
							<input class="wp84 prop_txt flg_possess" type="text" value="" readonly disabled />
                            <input class="wp_10 js_who" type="button" value="操作人" disabled />
						</td>
						<td class="prop_fc45">
							<input class="wp84 prop_txt flg_pre-processing" type="text" value="" readonly disabled />
                            <input class="wp_10 js_cl" type="button" value="预处理" disabled />
						</td>
					</tr>
					<tr>
						<td class="prop_fc10 prop_lbl">
							<input id="quan_ju_zhuan_fa" name="quan_ju_zhuan_fa" type="checkbox" />
                            <label class="label_for">全局转发</label>
						</td>
						<td class="prop_fc45">
							<input class="wp84 prop_txt flg_possess" type="text" value="" readonly disabled />
                            <input class="wp_10 js_who" type="button" value="操作人" disabled />
						</td>
						<td class="prop_fc45">
							<input class="wp84 prop_txt flg_scope" type="text" value="" readonly disabled />
                            <input class="wp_10 js_who" type="button" value="候选人" disabled />
						</td>
					</tr>
					<tr>
						<td class="prop_fc10 prop_lbl"></td>
						<td class="prop_fc45">
							<input class="wp84 prop_txt flg_pre-processing" type="text" value="" readonly disabled />
                            <input class="wp_10 js_cl" type="button" value="预处理" disabled />
						</td>
						<td class="prop_fc45">
							<input class="wp84 prop_txt flg_post-processing" type="text" value="" readonly disabled />
                            <input class="wp_10 js_cl" type="button" value="后处理" disabled />
						</td>
					</tr>
					<tr>
						<td class="prop_fc10 prop_lbl">
							<input id="quan_ju_du_zhe" name="quan_ju_du_zhe" type="checkbox" />
                            <label class="label_for">全局读者</label>
						</td>
						<td class="prop_fc45">
							<input class="wp84 prop_txt flg_possess" type="text" value="" readonly disabled />
                            <input class="wp_10 js_who" type="button" value="操作人" disabled />
						</td>
						<td class="prop_fc45">
							<input class="wp84 prop_txt flg_scope" type="text" value="" readonly disabled />
                            <input class="wp_10 js_who" type="button" value="候选人" disabled />
						</td>
					</tr>
					<tr>
						<td class="prop_fc10 prop_lbl"></td>
						<td class="prop_fc45">
							<input class="wp84 prop_txt flg_pre-processing" type="text" value="" readonly disabled />
                            <input class="wp_10 js_cl" type="button" value="预处理" disabled />
						</td>
						<td class="prop_fc45">
							<input class="wp84 prop_txt flg_post-processing" type="text" value="" readonly disabled />
                            <input class="wp_10 js_cl" type="button" value="后处理" disabled />
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<!-- 前置事件 -->
		<form id="qzsj" class="prop_cont" style="display:none" action="">
			<div class="pc5">
				<table>
					<thead>
						<tr>
							<th class="pc5_th1">事件名称</th>
							<th class="pc5_th2">事件</th>
							<th class="pc5_th3">事件常量</th>
						</tr>
					</thead>
					<tbody id="qian_zhi_shi_jian">
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
				<i class="e_add e_add_top js_add_e"></i> <i class="e_edit e_edit_top js_edit_e"></i> <i
					class="e_del e_del_top js_del"></i>
			</div>
		</form>
		<!-- 超时事件 -->
		<form id="cssj" class="prop_cont" style="display:none" action="">
			<table>
				<tbody>
					<tr>
						<td class="prop_fc10">触发规则</td>
						<td class="prop_fc90">
							<input id="chu_fa_gui_ze" name="chu_fa_gui_ze" class="wp88 prop_txt" type="text" value="" readonly />
							<input class="wp_10 js_cfgz" type="button" value="选择" />
						</td>
					</tr>
					<tr>
						<td class="prop_fc10">持续时间</td>
						<td class="prop_fc90">
							<input id="chi_xu_shi_jian" name="chi_xu_shi_jian" class="wp88 prop_txt" type="text" value="" readonly />
							<input class="wp_10 js_cxsj" type="button" value="选择" />
						</td>
					</tr>
					<tr>
						<td class="prop_fc10"></td>
						<td class="prop_fc90">
							<div class="pc5 js_show">
								<table>
									<thead>
										<tr>
											<th class="pc5_th1">事件名称</th>
											<th class="pc5_th2">事件</th>
											<th class="pc5_th3">事件常量</th>
										</tr>
									</thead>
									<tbody id="chao_shi_shi_jian">
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
									</tbody>
								</table>
								<i class="e_add e_add_top js_add_e"></i> <i class="e_edit e_edit_top js_edit_e"></i> <i
									class="e_del e_del_top js_del"></i>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<!-- 流程变量 -->
		<form id="lcbl" class="prop_cont" style="display:none" action="">
			<div class="pc5">
				<table>
					<thead>
						<tr>
							<th class="pc5_th1">变量名称</th>
							<th class="pc5_th1">变量</th>
							<th class="pc5_th1">初始值</th>
							<th class="pc5_th1">变量类型</th>
							<th class="pc5_th1">描述</th>
						</tr>
					</thead>
					<tbody id="liu_cheng_bian_liang">
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
				<i class="e_add e_add_top js_add_v"></i> <i class="e_edit e_edit_top js_edit_v"></i> <i
					class="e_del e_del_top js_del"></i>
			</div>
		</form>
	</div>
	<!-- process end -->
	<!-- start start -->
	<div id="start" class="prop_wrap" style="display:none">
		<!-- 基本信息 -->
		<form id="jbxx" class="prop_cont" style="display:none" action="">
			<table>
				<tbody>
					<tr>
						<td class="prop_fc10">显示名称</td>
						<td class="prop_fc40">
							<input id="xian_shi_ming_cheng" name="xian_shi_ming_cheng" class="wp73 prop_txt" type="text" value="" />
						</td>
						<td class="prop_fc10">逻辑标识</td>
						<td class="prop_fc40">
							<input id="luo_ji_biao_shi" name="luo_ji_biao_shi" class="wp73 prop_ro prop_txt" type="text" value="" readonly />
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<!-- 前置事件 -->
		<form id="qzsj" class="prop_cont" style="display:none" action="">
			<div class="pc5">
				<table>
					<thead>
						<tr>
							<th class="pc5_th1">事件名称</th>
							<th class="pc5_th2">事件</th>
							<th class="pc5_th3">事件常量</th>
						</tr>
					</thead>
					<tbody id="qian_zhi_shi_jian">
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
				<i class="e_add e_add_top js_add_e"></i> <i class="e_edit e_edit_top js_edit_e"></i> <i
					class="e_del e_del_top js_del"></i>
			</div>
		</form>
		<!-- 后置事件 -->
		<form id="hzsj" class="prop_cont" style="display:none" action="">
			<div class="pc5">
				<table>
					<thead>
						<tr>
							<th class="pc5_th1">事件名称</th>
							<th class="pc5_th2">事件</th>
							<th class="pc5_th3">事件常量</th>
						</tr>
					</thead>
					<tbody id="hou_zhi_shi_jian">
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
				<i class="e_add e_add_top js_add_e"></i> <i class="e_edit e_edit_top js_edit_e"></i> <i
					class="e_del e_del_top js_del"></i>
			</div>
		</form>
	</div>
	<!-- start end -->
	<!-- end start -->
	<div id="end" class="prop_wrap" style="display:none">
		<!-- 基本信息 -->
		<form id="jbxx" class="prop_cont" style="display:none" action="">
			<table>
				<tbody>
					<tr>
						<td class="prop_fc10">显示名称</td>
						<td class="prop_fc40">
							<input id="xian_shi_ming_cheng" name="xian_shi_ming_cheng" class="wp73 prop_txt" type="text" value="" />
						</td>
						<td class="prop_fc10">逻辑标识</td>
						<td class="prop_fc40">
							<input id="luo_ji_biao_shi" name="luo_ji_biao_shi" class="wp73 prop_ro prop_txt" type="text" value="" readonly />
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<!-- 前置事件 -->
		<form id="qzsj" class="prop_cont" style="display:none" action="">
			<div class="pc5">
				<table>
					<thead>
						<tr>
							<th class="pc5_th1">事件名称</th>
							<th class="pc5_th2">事件</th>
							<th class="pc5_th3">事件常量</th>
						</tr>
					</thead>
					<tbody id="qian_zhi_shi_jian">
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
				<i class="e_add e_add_top js_add_e"></i> <i class="e_edit e_edit_top js_edit_e"></i> <i
					class="e_del e_del_top js_del"></i>
			</div>
		</form>
		<!-- 后置事件 -->
		<form id="hzsj" class="prop_cont" style="display:none" action="">
			<div class="pc5">
				<table>
					<thead>
						<tr>
							<th class="pc5_th1">事件名称</th>
							<th class="pc5_th2">事件</th>
							<th class="pc5_th3">事件常量</th>
						</tr>
					</thead>
					<tbody id="hou_zhi_shi_jian">
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
				<i class="e_add e_add_top js_add_e"></i> <i class="e_edit e_edit_top js_edit_e"></i> <i
					class="e_del e_del_top js_del"></i>
			</div>
		</form>
	</div>
	<!-- end end -->
	<!-- task start -->
	<div id="task" class="prop_wrap" style="display:none">
		<!-- 基本信息 -->
		<form id="jbxx" class="prop_cont" style="display:none" action="">
			<table>
				<tbody>
					<tr>
						<td class="prop_fc10">显示名称</td>
						<td class="prop_fc40">
							<input id="xian_shi_ming_cheng" name="xian_shi_ming_cheng" class="wp73 prop_txt" type="text" value="" />
						</td>
						<td class="prop_fc10">逻辑标识</td>
						<td class="prop_fc40">
							<input id="luo_ji_biao_shi" name="luo_ji_biao_shi" class="wp73 prop_ro prop_txt" type="text" value="" readonly />
						</td>
					</tr>
				</tbody>
			</table>
			<table>
				<tbody>
					<tr>
						<td class="prop_fc10">显示图标</td>
						<td class="prop_fc90">
							<input id="xian_shi_tu_biao" name="xian_shi_tu_biao" class="wp88 prop_txt" type="text" value="" readonly />
							<input class="wp_10 js_xstb" type="button" value="选择" />
						</td>
					</tr>
					<tr>
						<td class="prop_fc10">待办标题</td>
						<td class="prop_fc90">
							<input id="dai_ban_biao_ti" name="dai_ban_biao_ti" class="wp88 prop_txt" type="text" value="" />
							<input class="wp_10 js_dbbt" type="button" value="选择" />
						</td>
					</tr>
					<tr>
						<td class="prop_fc10">提交别名</td>
						<td class="prop_fc90">
							<input id="ti_jiao_bie_ming" name="ti_jiao_bie_ming" class="wp88 prop_txt" type="text" value="" />
						</td>
					</tr>
				</tbody>
			</table>
			<table>
				<tbody>
					<tr>
						<td class="prop_fc10">审批方式</td>
						<td class="prop_fc40 js_open">
							<input id="sddk" type="radio" name="shen_pi_fang_shi" value="no" checked />
							<label class="label_for">手动打开</label>
							<input class="js_onoff" id="zddk" type="radio" name="shen_pi_fang_shi" value="yes"/>
							<label class="label_for">自动打开</label>
						</td>
						<td class="prop_fc10">
							<span class="js_show">路径</span>
						</td>
						<td class="prop_fc40">
							<input class="wp73 prop_txt js_show" type="text" id="autoOpenTransitionName" name="autoOpenTransitionName" value="" readonly />
							<input class="wp_10 js_auto js_show" type="button" value="选择" />
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<!-- 人员信息 -->
		<form id="ryxx" class="prop_cont" style="display:none" action="">
			<table>
				<tbody>
					<tr>
						<td class="prop_fc10">候选处理人</td>
						<td class="prop_fc90">
							<input id="hou_xuan_chu_li_ren" name="hou_xuan_chu_li_ren" class="wp88 prop_txt" type="text" value="" readonly />
							<input class="wp_10 js_who" type="button" value="候选人" />
						</td>
					</tr>
				</tbody>
			</table>
			<table>
				<tbody>
					<tr>
						<td class="prop_fc10">处理方式</td>
						<td class="prop_fc40">
							<select class="js_handler" id="dealtype">
								<option value="1">单人处理</option>
								<option value="2">多人顺序</option>
								<option value="3">多人任意</option>
								<option value="4" selected >多人并行</option>
							</select>
							<select class="js_status">
								<option value="allfinish" selected >全部完成</option>
								<option value="number">完成个数</option>
								<option value="percent">完成率</option>
							</select>
							<input class="prop_short js_show num_only" id="num" name="num" type="text" value="" />
							<em class="js_show">个</em>
						</td>
						<td class="prop_fc10">选人方式</td>
						<td class="prop_fc40">
							<input id="sdxr" type="radio" name="userSelectType" value="manual" checked />
							<label class="label_for">手动</label>
							<input id="zdxr" type="radio" name="userSelectType" value="auto" />
							<label class="label_for">自动</label>
						</td>
					</tr>
					<tr>
						<td class="prop_fc10">显示选人框</td>
						<td class="prop_fc40">
							<input id="xs" type="radio" name="isSelectUser" value="yes" checked />
							<label class="label_for">显示</label>
							<input id="bxs" type="radio" name="isSelectUser" value="no" />
							<label class="label_for">不显示</label>
						</td>
						<td class="prop_fc10">必须选人</td>
						<td class="prop_fc40">
							<input id="xr_yes" type="radio" name="isMustUser" value="yes" checked />
							<label class="label_for">是</label>
							<input id="xr_no" type="radio" name="isMustUser" value="no" />
							<label class="label_for">否</label>
						</td>
					</tr>
					<tr>
						<td class="prop_fc10">自动获取用户</td>
						<td class="prop_fc40">
							<input id="hq_yes" type="radio" name="isAutoGetUser" value="yes" />
							<label class="label_for">是</label>
							<input id="hq_no" type="radio" name="isAutoGetUser" value="no" checked />
							<label class="label_for">否</label>
						</td>
						<td class="prop_fc10">工作移交</td>
						<td class="prop_fc40">
							<input id="yj_yes" type="radio" name="isWorkHandUser" value="yes" checked />
							<label class="label_for">启用</label>
							<input id="yj_no" type="radio" name="isWorkHandUser" value="no" />
							<label class="label_for">不启用</label>
						</td>
					</tr>
					<tr>
						<td class="prop_fc10">密级控制</td>
						<td class="prop_fc40 js_open">
							<input class="js_onoff" id="secret_yes" type="radio" name="isSecret" value="yes" />
							<label class="label_for">启用</label>
							<input id="secret_no" type="radio" name="isSecret" value="no" checked />
							<label class="label_for">不启用</label>
						</td>
						<td class="prop_fc10">密级变量</td>
						<td class="prop_fc40">
							<input class="wp73 prop_txt js_enabled" type="text" id="secret" name="secret" value="" disabled/>
							<input class="wp_10 js_variable_n js_enabled" type="button" value="选择" disabled/>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<!-- 意见设置 -->
		<form id="yjsz" class="prop_cont" style="display:none" action="">
			<table>
				<tbody>
					<tr>
						<td class="prop_fc10">意见填写方式</td>
						<td class="prop_fc90">
							<select class="js_ideaType" id="ideaType">
								<option value="must">必须填写</option>
								<option value="can" selected>可以不填</option>
								<option value="cannot">不能填写</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="prop_fc10">是否强制表态</td>
						<td class="prop_fc90">
							<input id="icm_yes" type="radio" name="ideaCompelManner" value="yes" />
							<label class="label_for">是</label>
							<input id="icm_no" type="radio" name="ideaCompelManner" value="no" checked />
							<label class="label_for">否</label>
						</td>
					</tr>
					<tr>
						<td class="prop_fc10">意见显示方式</td>
						<td class="prop_fc90">
							<input id="ids_add" type="radio" name="ideaDisplayStyle" value="add" checked />
							<label class="label_for">追加</label>
							<input id="ids_cover" type="radio" name="ideaDisplayStyle" value="cover" />
							<label class="label_for">覆盖</label>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<!-- 节点权限 -->
		<form id="jdqx" class="prop_cont" style="display:none" action="">
			<div class="tab_wrap">
				<span class="abs_span">退回操作</span>
				<table class="tab_1 need_check">
					<tbody>
						<tr>
							<td class="wp_10 prop_lbl">
								<input id="tui_hui_ni_gao_ren" name="tui_hui_ni_gao_ren" type="checkbox" />
	                            <label class="label_for">退回拟稿人</label>
							</td>
							<td class="prop_fc45">
								<input class="wp84 prop_txt flg_pre-processing" type="text" value="" readonly disabled />
	                            <input class="wp_10 js_cl" type="button" value="预处理" disabled />
							</td>
							<td class="prop_fc45">
								<input class="wp84 prop_txt flg_post-processing" type="text" value="" readonly disabled />
	                            <input class="wp_10 js_cl" type="button" value="后处理" disabled />
							</td>
						</tr>
						<tr>
							<td class="wp_10 prop_lbl">
								<input id="tui_hui_shang_yi_bu" name="tui_hui_shang_yi_bu" type="checkbox" />
	                            <label class="label_for">退回上一步</label>
							</td>
							<td class="prop_fc45">
								<input class="wp84 prop_txt flg_pre-processing" type="text" value="" readonly disabled />
	                            <input class="wp_10 js_cl" type="button" value="预处理" disabled />
							</td>
							<td class="prop_fc45">
								<input class="wp84 prop_txt flg_post-processing" type="text" value="" readonly disabled />
	                            <input class="wp_10 js_cl" type="button" value="后处理" disabled />
							</td>
						</tr>
						<!-- 任意退回功能没有实现，先屏蔽掉该功能，MyTask.js中也屏蔽了解析和组装该部分的代码，包括候选点的代码。
						<tr>
							<td class="wp_10 prop_lbl">
								<input id=ren_yi_tui_hui name="ren_yi_tui_hui" type="checkbox" />
	                            <label class="label_for">任意退回</label>
							</td>
							<td class="prop_fc45">
								<input class="wp84 prop_txt flg_possess" type="text" value="" readonly disabled />
	                            <input class="wp_10 js_who" type="button" value="操作人" disabled />
							</td>
							<td class="prop_fc45">
								<input id="reTreatToArbitraryScope" class="wp84 prop_txt" type="text" value="" readonly disabled />
	                            <input class="wp_14 js_task" type="button" value="候选节点" disabled />
							</td>
						</tr>
						<tr>
							<td class="wp_10 prop_lbl"></td>
							<td class="prop_fc45">
								<input class="wp84 prop_txt flg_pre-processing" type="text" value="" readonly disabled />
	                            <input class="wp_10 js_cl" type="button" value="预处理" disabled />
							</td>
							<td class="prop_fc45">
								<input class="wp84 prop_txt flg_post-processing" type="text" value="" readonly disabled />
	                            <input class="wp_10 js_cl" type="button" value="后处理" disabled />
							</td>
						</tr>
						 -->
					</tbody>
				</table>
			</div>
			<div class="tab_wrap">
				<span class="abs_span">对下一节点操作</span>
				<table class="tab_1 need_check">
					<tbody>
						<tr>
							<td class="wp_10 prop_lbl">
								<input id="liu_cheng_na_hui" name="liu_cheng_na_hui" type="checkbox" />
	                            <label class="label_for">流程拿回</label>
							</td>
							<td class="prop_fc45">
								<input class="wp84 prop_txt flg_pre-processing" type="text" value="" readonly disabled />
	                            <input class="wp_10 js_cl" type="button" value="预处理" disabled />
							</td>
							<td class="prop_fc45">
								<input class="wp84 prop_txt flg_post-processing" type="text" value="" readonly disabled />
	                            <input class="wp_10 js_cl" type="button" value="后处理" disabled />
							</td>
						</tr>
						<tr>
							<td class="wp_10 prop_lbl">
								<input id="liu_cheng_bu_fa" name="liu_cheng_bu_fa" type="checkbox" />
	                            <label class="label_for">流程补发</label>
							</td>
							<td class="prop_fc45">
								<input class="wp84 prop_txt flg_pre-processing" type="text" value="" readonly disabled />
	                            <input class="wp_10 js_cl" type="button" value="预处理" disabled />
							</td>
							<td class="prop_fc45">
								<input class="wp84 prop_txt flg_post-processing" type="text" value="" readonly disabled />
	                            <input class="wp_10 js_cl" type="button" value="后处理" disabled />
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="tab_wrap">
				<span class="abs_span">对当前节点操作</span>
				<table class="tab_1 need_check">
					<tbody>
						<tr>
							<td class="wp_10 prop_lbl">
								<input id="liu_cheng_zhuan_fa" name="liu_cheng_zhuan_fa" type="checkbox" />
	                            <label class="label_for">流程转发</label>
							</td>
							<td class="prop_fc45">
								<input class="wp84 prop_txt flg_possess" type="text" value="" readonly disabled />
	                            <input class="wp_10 js_who" type="button" value="操作人" disabled />
							</td>
							<td class="prop_fc45">
								<input class="wp84 prop_txt flg_scope" type="text" value="" readonly disabled />
	                            <input class="wp_10 js_who" type="button" value="候选人" disabled />
							</td>
						</tr>
						<tr>
							<td class="wp_10 prop_lbl"></td>
							<td class="prop_fc45">
								<input class="wp84 prop_txt flg_pre-processing" type="text" value="" readonly disabled />
	                            <input class="wp_10 js_cl" type="button" value="预处理" disabled />
							</td>
							<td class="prop_fc45">
								<input class="wp84 prop_txt flg_post-processing" type="text" value="" readonly disabled />
	                            <input class="wp_10 js_cl" type="button" value="后处理" disabled />
							</td>
						</tr>
						<tr>
							<td class="wp_10 prop_lbl">
								<input id="liu_cheng_zhuan_ban" name="liu_cheng_zhuan_ban" type="checkbox" />
	                            <label class="label_for">流程转办</label>
							</td>
							<td class="prop_fc45">
								<input class="wp84 prop_txt flg_possess" type="text" value="" readonly disabled />
	                            <input class="wp_10 js_who" type="button" value="操作人" disabled />
							</td>
							<td class="prop_fc45">
								<input class="wp84 prop_txt flg_scope" type="text" value="" readonly disabled />
	                            <input class="wp_10 js_who" type="button" value="候选人" disabled />
							</td>
						</tr>
						<tr>
							<td class="wp_10 prop_lbl"></td>
							<td class="prop_fc45">
								<input class="wp84 prop_txt flg_pre-processing" type="text" value="" readonly disabled />
	                            <input class="wp_10 js_cl" type="button" value="预处理" disabled />
							</td>
							<td class="prop_fc45">
								<input class="wp84 prop_txt flg_post-processing" type="text" value="" readonly disabled />
	                            <input class="wp_10 js_cl" type="button" value="后处理" disabled />
							</td>
						</tr>
						<tr>
							<td class="wp_10 prop_lbl">
								<input id="liu_cheng_zeng_fa" name="liu_cheng_zeng_fa" type="checkbox" />
	                            <label class="label_for">流程增发</label>
							</td>
							<td class="prop_fc45">
								<input class="wp84 prop_txt flg_possess" type="text" value="" readonly disabled />
	                            <input class="wp_10 js_who" type="button" value="操作人" disabled />
							</td>
							<td class="prop_fc45">
								<input class="wp84 prop_txt flg_scope" type="text" value="" readonly disabled />
	                            <input class="wp_10 js_who" type="button" value="候选人" disabled />
							</td>
						</tr>
						<tr>
							<td class="wp_10 prop_lbl"></td>
							<td class="prop_fc45">
								<input class="wp84 prop_txt flg_pre-processing" type="text" value="" readonly disabled />
	                            <input class="wp_10 js_cl" type="button" value="预处理" disabled />
							</td>
							<td class="prop_fc45">
								<input class="wp84 prop_txt flg_post-processing" type="text" value="" readonly disabled />
	                            <input class="wp_10 js_cl" type="button" value="后处理" disabled />
							</td>
						</tr>
						<tr>
							<td class="wp_10 prop_lbl">
								<input id="bu_fen_na_hui" name="bu_fen_na_hui" type="checkbox" />
	                            <label class="label_for">部分拿回</label>
							</td>
							<td class="prop_fc45">
								<input class="wp84 prop_txt flg_pre-processing" type="text" value="" readonly disabled />
	                            <input class="wp_10 js_cl" type="button" value="预处理" disabled />
							</td>
							<td class="prop_fc45">
								<input class="wp84 prop_txt flg_post-processing" type="text" value="" readonly disabled />
	                            <input class="wp_10 js_cl" type="button" value="后处理" disabled />
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="tab_wrap">
				<span class="abs_span">对所有节点操作</span>
				<table class="tab_1 need_check">
					<tbody>
						<tr>
							<td class="wp_10 prop_lbl">
								<input id="pei_zhi_xuan_ren" name="pei_zhi_xuan_ren" type="checkbox" />
	                            <label class="label_for">配置选人</label>
							</td>
							<td class="prop_fc45">
								<input class="wp84 prop_txt flg_possess" type="text" value="" readonly disabled />
	                            <input class="wp_10 js_who" type="button" value="操作人" disabled />
							</td>
							<td class="prop_fc45">
								<input class="wp84 prop_txt flg_scope" type="text" value="" readonly disabled />
	                            <input class="wp_10 js_who" type="button" value="候选人" disabled />
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</form>
		<!-- 文档权限 -->
		<form id="wdqx" class="prop_cont" style="display:none" action="">
			<div class="pc4_wrap">
				<ul class="pc4_tab cf">
					<li class="fl on">正文权限</li>
					<li class="fl">附件权限</li>
					<li class="fl">表单权限</li>
				</ul>
				<div class="active js_hl wp90">
					<div class="tab_wrap">
						<span class="abs_span">正文操作</span>
						<table class="tab_1">
							<tr>
								<td class="prop_lbl wp_10">
									<input id="wordCreate" class="js_wdqx" type="checkbox" name="" />
									<label class="label_for">创建正文</label>
								</td>
								<td class="prop_lbl wp_10">
									<input id="wordEdit" class="js_wdqx" type="checkbox" name="" />
									<label class="label_for">编辑正文</label>
								</td>
								<td class="prop_lbl wp_10">
									<input id="wordRead" class="js_wdqx" type="checkbox" name="" />
									<label class="label_for">查看正文</label>
								</td>
								<td class="prop_lbl wp_10">
									<input id="wordPrint" class="js_wdqx" type="checkbox" name="" />
									<label class="label_for">打印正文</label>
								</td>
								<td class="prop_lbl wp_10">
									<input id="wordValue" class="js_wdqx" type="checkbox" name="" />
									<label class="label_for">域值同步</label>
								</td>
								<td class="prop_lbl wp_10">
									<input id="wordRedTemplet" class="js_wdqx" type="checkbox" name="" />
									<label class="label_for">套红功能</label>
								</td>
								<td class="prop_lbl wp_10">
									<input id="wordSeal" class="js_wdqx" type="checkbox" name="" />
									<label class="label_for">加盖公章</label>
								</td>
							</tr>
						</table>
					</div>
					<div class="wordEdit tab_wrap js_vis">
						<span class="abs_span">编辑正文</span>
						<table class="tab_1">
							<tr>
								<td class="prop_lbl prop_fc50">
									<input id="wordRevisions" type="checkbox" name="" />
									<label class="label_for">编辑时留痕</label>
								</td>
								<td class="prop_lbl prop_fc50">
									<input id="wordShowRevisions" type="checkbox" name="" />
									<label class="label_for">显示留痕</label>
								</td>
							</tr>
						</table>
					</div>
					<div class="wordRead tab_wrap js_vis">
						<span class="abs_span">查看操作</span>
						<table class="tab_1">
							<tr>
								<td class="prop_lbl prop_fc50">
									<input id="read1" type="checkbox" name="" />
									<label class="label_for">显示清稿</label>
								</td>
								<td class="prop_lbl prop_fc50">
									<input id="read2" type="checkbox" name="" />
									<label class="label_for">显示留痕</label>
								</td>
							</tr>
						</table>
					</div>
					<div class="wordValue tab_wrap js_vis">
						<table class="tab_1">
							<tr>
								<td class="prop_lbl prop_fc10">域值同步</td>
								<td class="prop_lbl prop_fc90">
   									<input id="wordFieldName" class="wp84 prop_txt wd_text" type="text" value="" readonly />
									<input class="wp_10 yztb_xg" type="button" value="修改" />
								</td>
							</tr>
						</table>
					</div>
					<div class="wordCreate tab_wrap js_vis">
						<table class="tab_1">
							<tr>
								<td class="prop_lbl prop_fc10">正文模板</td>
								<td class="prop_lbl prop_fc90">
   									<input id="wordTemplates" class="wp84 prop_txt wd_text" type="text" value="" />
									<input class="wp_10 zwmb_xg" type="button" value="修改" />
								</td>
							</tr>
						</table>
					</div>
					<div class="wordRedTemplet tab_wrap js_vis">
						<table class="tab_1">
							<tr>
								<td class="prop_lbl prop_fc10">套红模板</td>
								<td class="prop_lbl prop_fc90">
   									<input id="wordRedTemplates" class="wp84 prop_txt wd_text" type="text" value="" />
									<input class="wp_10 thmb_xg" type="button" value="修改" />
								</td>
							</tr>
						</table>
					</div>
					<div id="dayinzhengwen" class="wordPrint tab_wrap js_vis">
						<span class="abs_span">打印正文</span>
						<table class="tab_1">
							<c:forEach var="secretLevel" items="${secretLevelList }">
								<tr>
									<td class="prop_lbl prop_fc10">${secretLevel.lookupName }打印人</td>
									<td class="prop_lbl prop_fc90">
										<input class="wp84 prop_txt wd_actor" id="wordSecret${secretLevel.lookupCode }PrintUser" type="text" value="" readonly />
										<input class="wp_10 js_who" type="button" value="修改" />
									</td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</div>
				<div class="js_hl wp90">
					<div class="tab_wrap">
						<span class="abs_span">附件操作</span>
						<table class="tab_1">
							<tr>
								<td class="prop_lbl wp_10">
									<input id="attachCreate" class="js_wdqx" type="checkbox" name="" />
									<label class="label_for">增删附件</label>
								</td>
								<td class="prop_lbl wp_10">
									<input id="attachEdit" class="js_wdqx" type="checkbox" name="" />
									<label class="label_for">编辑附件</label>
								</td>
								<td class="prop_lbl wp_10">
									<input id="attachPrint" class="js_wdqx" type="checkbox" name="" />
									<label class="label_for">打印附件</label>
								</td>
							</tr>
						</table>
					</div>
					<div class="attachEdit tab_wrap js_vis">
						<span class="abs_span">编辑附件</span>
						<table class="tab_1">
							<tr>
								<td class="prop_lbl prop_fc50">
									<input id="attachRevisions" type="checkbox" name="" />
									<label class="label_for">编辑时留痕</label>
								</td>
								<td class="prop_lbl prop_fc50">
									<input id="attachShowRevisions" type="checkbox" name="" />
									<label class="label_for">显示留痕</label>
								</td>
							</tr>
						</table>
					</div>
					<div id="dayinfujian" class="attachPrint tab_wrap js_vis">
						<span class="abs_span">打印附件</span>
						<table class="tab_1">
							<c:forEach var="secretLevel" items="${secretLevelList }">
								<tr>
									<td class="prop_lbl prop_fc10">${secretLevel.lookupName }打印人</td>
									<td class="prop_lbl prop_fc90">
										<input class="wp84 prop_txt wd_actor" id="attachSecret${secretLevel.lookupCode }PrintUser" type="text" value="" readonly />
										<input class="wp_10 js_who" type="button" value="修改" />
									</td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</div>
				<div class="js_hl wp90">
					<div class="tab_wrap">
						<span class="abs_span">表单操作</span>
						<table class="tab_1">
							<tr>
								<td class="prop_lbl wp_10">
									<input id="formSave" type="checkbox" name="" />
									<label class="label_for">保存表单</label>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</form>
		<!-- 前置事件 -->
		<form id="qzsj" class="prop_cont" style="display:none" action="">
			<div class="pc5">
				<table>
					<thead>
						<tr>
							<th class="pc5_th1">事件名称</th>
							<th class="pc5_th2">事件</th>
							<th class="pc5_th3">事件常量</th>
						</tr>
					</thead>
					<tbody id="qian_zhi_shi_jian">
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
				<i class="e_add e_add_top js_add_e"></i> <i class="e_edit e_edit_top js_edit_e"></i> <i
					class="e_del e_del_top js_del"></i>
			</div>
		</form>
		<!-- 后置事件 -->
		<form id="hzsj" class="prop_cont" style="display:none" action="">
			<div class="pc5">
				<table>
					<thead>
						<tr>
							<th class="pc5_th1">事件名称</th>
							<th class="pc5_th2">事件</th>
							<th class="pc5_th3">事件常量</th>
						</tr>
					</thead>
					<tbody id="hou_zhi_shi_jian">
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
				<i class="e_add e_add_top js_add_e"></i> <i class="e_edit e_edit_top js_edit_e"></i> <i
					class="e_del e_del_top js_del"></i>
			</div>
		</form>
		<!-- 超时事件 -->
		<form id="cssj" class="prop_cont" style="display:none" action="">
			<table>
				<tbody>
					<tr>
						<td class="prop_fc10">触发规则</td>
						<td class="prop_fc90">
							<input id="chu_fa_gui_ze" name="chu_fa_gui_ze" class="wp88 prop_txt" type="text" value="" readonly />
							<input class="wp_10 js_cfgz" type="button" value="选择" />
						</td>
					</tr>
					<tr>
						<td class="prop_fc10">持续时间</td>
						<td class="prop_fc90">
							<input id="chi_xu_shi_jian" name="chi_xu_shi_jian" class="wp88 prop_txt" type="text" value="" readonly />
							<input class="wp_10 js_cxsj" type="button" value="选择" />
						</td>
					</tr>
					<tr>
						<td class="prop_fc10"></td>
						<td class="prop_fc90">
							<div class="pc5 js_show">
								<table>
									<thead>
										<tr>
											<th class="pc5_th1">事件名称</th>
											<th class="pc5_th2">事件</th>
											<th class="pc5_th3">事件常量</th>
										</tr>
									</thead>
									<tbody id="chao_shi_shi_jian">
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
									</tbody>
								</table>
								<i class="e_add e_add_top js_add_e"></i> <i class="e_edit e_edit_top js_edit_e"></i> <i
									class="e_del e_del_top js_del"></i>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	<!-- task end -->
	<!-- java start -->
	<div id="java" class="prop_wrap" style="display:none">
		<!-- 基本信息 -->
		<form id="jbxx" class="prop_cont" style="display:none" action="">
			<table>
				<tbody>
					<tr>
						<td class="prop_fc10">显示名称</td>
						<td class="prop_fc40">
							<input id="xian_shi_ming_cheng" name="xian_shi_ming_cheng" class="wp73 prop_txt" type="text" value="" />
						</td>
						<td class="prop_fc10">逻辑标识</td>
						<td class="prop_fc40">
							<input id="luo_ji_biao_shi" name="luo_ji_biao_shi" class="wp73 prop_ro prop_txt" type="text" value="" readonly />
						</td>
					</tr>
					<tr>
						<td class="prop_fc10">组件</td>
						<td class="prop_fc40">
							<input id="zu_jian" name="zu_jian" class="wp73 prop_txt" type="text" value="" />
						</td>
						<td class="prop_fc10">执行方法</td>
						<td class="prop_fc40">
							<input id="zhi_xing_fang_fa" name="zhi_xing_fang_fa" class="wp73 prop_txt" type="text" value="" />
						</td>
					</tr>
					<tr>
						<td class="prop_fc10">返回变量</td>
						<td class="prop_fc40">
							<input id="fan_hui_bian_liang" name="fan_hui_bian_liang" class="wp73 prop_txt" type="text" value="" />
							<input class="wp_10 js_variable" type="button" value="选择" />
						</td>
						<td class="prop_fc10"></td>
						<td class="prop_fc40">
						</td>
					</tr>
					<tr>
						<td class="prop_fc10">方法参数</td>
						<td class="prop_fc40">
							<div class="pc5">
								<table>
									<thead>
										<tr>
											<th class="pc5_th5">方法参数名</th>
											<th class="pc5_th3">方法参数类型</th>
											<th class="pc5_th3">方法参数初始值</th>
										</tr>
									</thead>
									<tbody id="fang_fa_can_shu">
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
									</tbody>
								</table>
								<i class="e_add e_add_top js_add_ffcs"></i> <i class="e_edit e_edit_top js_edit_ffcs"></i> <i
									class="e_del e_del_top js_del"></i>
							</div>
						</td>
						<td class="prop_fc10">成员变量</td>
						<td class="prop_fc40">
							<div class="pc5">
								<table>
									<thead>
										<tr>
											<th class="pc5_th5">成员变量名</th>
											<th class="pc5_th3">成员变量类型</th>
											<th class="pc5_th3">成员变量初始值</th>
										</tr>
									</thead>
									<tbody id="cheng_yuan_bian_liang">
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
									</tbody>
								</table>
								<i class="e_add e_add_top js_add_cybl"></i> <i class="e_edit e_edit_top js_edit_cybl"></i> <i
									class="e_del e_del_top js_del"></i>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<!-- 前置事件 -->
		<form id="qzsj" class="prop_cont" style="display:none" action="">
			<div class="pc5">
				<table>
					<thead>
						<tr>
							<th class="pc5_th1">事件名称</th>
							<th class="pc5_th2">事件</th>
							<th class="pc5_th3">事件常量</th>
						</tr>
					</thead>
					<tbody id="qian_zhi_shi_jian">
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
				<i class="e_add e_add_top js_add_e"></i> <i class="e_edit e_edit_top js_edit_e"></i> <i
					class="e_del e_del_top js_del"></i>
			</div>
		</form>
		<!-- 后置事件 -->
		<form id="hzsj" class="prop_cont" style="display:none" action="">
			<div class="pc5">
				<table>
					<thead>
						<tr>
							<th class="pc5_th1">事件名称</th>
							<th class="pc5_th2">事件</th>
							<th class="pc5_th3">事件常量</th>
						</tr>
					</thead>
					<tbody id="hou_zhi_shi_jian">
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
				<i class="e_add e_add_top js_add_e"></i> <i class="e_edit e_edit_top js_edit_e"></i> <i
					class="e_del e_del_top js_del"></i>
			</div>
		</form>
	</div>
	<!-- java end -->
	<!-- sql start -->
	<div id="sql" class="prop_wrap" style="display:none">
		<!-- 基本信息 -->
		<form id="jbxx" class="prop_cont" style="display:none" action="">
			<table>
				<tbody>
					<tr>
						<td class="prop_fc10">显示名称</td>
						<td class="prop_fc40">
							<input id="xian_shi_ming_cheng" name="xian_shi_ming_cheng" class="wp73 prop_txt" type="text" value="" />
						</td>
						<td class="prop_fc10">逻辑标识</td>
						<td class="prop_fc40">
							<input id="luo_ji_biao_shi" name="luo_ji_biao_shi" class="wp73 prop_ro prop_txt" type="text" value="" readonly />
						</td>
					</tr>
				</tbody>
			</table>
			<table>
				<tbody>
					<tr>
						<td class="prop_fc10">数据源</td>
						<td class="prop_fc90">
							<input id="shu_ju_yuan" name="shu_ju_yuan" class="wp88 prop_txt" type="text" value="" />
						</td>
					</tr>
					<tr>
						<td class="prop_fc10">返回变量</td>
						<td class="prop_fc90">
							<input id="fan_hui_bian_liang" name="fan_hui_bian_liang" class="wp88 prop_txt" type="text" value="" />
							<input class="wp_10 js_variable" type="button" value="选择" />
						</td>
					</tr>
					<tr>
						<td class="prop_fc10">返回唯一值</td>
						<td class="prop_fc90">
							<input id="fhwyz_yes" type="radio" name="fan_hui_wei_yi_zhi" value="true" checked/>
							<label class="label_for">是</label>
							<input id="fhwyz_no" type="radio" name="fan_hui_wei_yi_zhi" value="false" />
							<label class="label_for">否</label>
						</td>
					</tr>
				</tbody>
			</table>
			<table>
				<tbody>
					<tr>
						<td class="prop_fc10">查询条件</td>
						<td class="prop_fc40">
							<textarea maxlength="255" id="cha_xun_tiao_jian" name="cha_xun_tiao_jian" class="wp88 prop_txt hp100"></textarea>
						</td>
						<td class="prop_fc10">查询参数</td>
						<td class="prop_fc40">
							<div class="pc5">
								<table>
									<thead>
										<tr>
											<th class="pc5_th1">参数名称</th>
											<th class="pc5_th3">参数</th>
											<th class="pc5_th1">参数类型</th>
											<th class="pc5_th3">参数值</th>
										</tr>
									</thead>
									<tbody id="cha_xun_can_shu">
										<tr>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
										</tr>
									</tbody>
								</table>
								<i class="e_add e_add_top js_add_cxcs"></i> <i class="e_edit e_edit_top js_edit_cxcs"></i> <i
									class="e_del e_del_top js_del"></i>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<!-- 前置事件 -->
		<form id="qzsj" class="prop_cont" style="display:none" action="">
			<div class="pc5">
				<table>
					<thead>
						<tr>
							<th class="pc5_th1">事件名称</th>
							<th class="pc5_th2">事件</th>
							<th class="pc5_th3">事件常量</th>
						</tr>
					</thead>
					<tbody id="qian_zhi_shi_jian">
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
				<i class="e_add e_add_top js_add_e"></i> <i class="e_edit e_edit_top js_edit_e"></i> <i
					class="e_del e_del_top js_del"></i>
			</div>
		</form>
		<!-- 后置事件 -->
		<form id="hzsj" class="prop_cont" style="display:none" action="">
			<div class="pc5">
				<table>
					<thead>
						<tr>
							<th class="pc5_th1">事件名称</th>
							<th class="pc5_th2">事件</th>
							<th class="pc5_th3">事件常量</th>
						</tr>
					</thead>
					<tbody id="hou_zhi_shi_jian">
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
				<i class="e_add e_add_top js_add_e"></i> <i class="e_edit e_edit_top js_edit_e"></i> <i
					class="e_del e_del_top js_del"></i>
			</div>
		</form>
	</div>
	<!-- sql end -->
	<!-- ws start -->
	<div id="ws" class="prop_wrap" style="display:none">
		<!-- 基本信息 -->
		<form id="jbxx" class="prop_cont" style="display:none" action="">
			<table>
				<tbody>
					<tr>
						<td class="prop_fc10">显示名称</td>
						<td class="prop_fc40">
							<input id="xian_shi_ming_cheng" name="xian_shi_ming_cheng" class="wp73 prop_txt" type="text" value="" />
						</td>
						<td class="prop_fc10">逻辑标识</td>
						<td class="prop_fc40">
							<input id="luo_ji_biao_shi" name="luo_ji_biao_shi" class="wp73 prop_ro prop_txt" type="text" value="" readonly />
						</td>
					</tr>
				</tbody>
			</table>
			<table>
				<tbody>
					<tr>
						<td class="prop_fc10">服务地址</td>
						<td class="prop_fc90">
							<input id="fu_wu_di_zhi" name="fu_wu_di_zhi" class="wp88 prop_txt" type="text" value="" />
						</td>
					</tr>
				</tbody>
			</table>
			<table>
				<tbody>
					<tr>
						<td class="prop_fc10">执行方法</td>
						<td class="prop_fc40">
							<input id="zhi_xing_fang_fa" name="zhi_xing_fang_fa" class="wp73 prop_txt" type="text" value="" />
						</td>
						<td class="prop_fc10">返回变量</td>
						<td class="prop_fc40">
							<input id="fan_hui_bian_liang" name="fan_hui_bian_liang" class="wp73 prop_txt" type="text" value="" />
							<input class="wp_10 js_variable" type="button" value="选择"/>
						</td>
					</tr>
					<tr>
						<td class="prop_fc10">用户名</td>
						<td class="prop_fc40">
							<input id="yong_hu_ming" name="yong_hu_ming" class="wp73 prop_txt" type="text" value="" />
						</td>
						<td class="prop_fc10">密码</td>
						<td class="prop_fc40">
							<input id="mi_ma" name="mi_ma" class="wp73 prop_txt" type="text" value="" />
						</td>
					</tr>
				</tbody>
			</table>
			<table>
				<tbody>
					<tr>
						<td class="prop_fc10">定制实现</td>
						<td class="prop_fc90">
							<input id="ding_zhi_shi_xian" name="ding_zhi_shi_xian" class="wp88 prop_txt" type="text" value="" />
						</td>
					</tr>
					<tr>
						<td class="prop_fc10">是否同步</td>
						<td class="prop_fc90">
							<input id="sftb_yes" type="radio" name="shi_fou_tong_bu" value="true" checked/>
							<label class="label_for">是</label>
							<input id="sftb_no" type="radio" name="shi_fou_tong_bu" value="false" />
							<label class="label_for">否</label>
						</td>
					</tr>
					<tr>
						<td class="prop_fc10">方法参数</td>
						<td class="prop_fc90">
							<div class="pc5">
								<table>
									<thead>
										<tr>
											<th class="pc5_th5">参数名</th>
											<th class="pc5_th3">参数类型</th>
											<th class="pc5_th3">参数初始值</th>
										</tr>
									</thead>
									<tbody id="fang_fa_can_shu">
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
									</tbody>
								</table>
								<i class="e_add e_add_top js_add_ffcs"></i> <i class="e_edit e_edit_top js_edit_ffcs"></i> <i
									class="e_del e_del_top js_del"></i>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<!-- 前置事件 -->
		<form id="qzsj" class="prop_cont" style="display:none" action="">
			<div class="pc5">
				<table>
					<thead>
						<tr>
							<th class="pc5_th1">事件名称</th>
							<th class="pc5_th2">事件</th>
							<th class="pc5_th3">事件常量</th>
						</tr>
					</thead>
					<tbody id="qian_zhi_shi_jian">
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
				<i class="e_add e_add_top js_add_e"></i> <i class="e_edit e_edit_top js_edit_e"></i> <i
					class="e_del e_del_top js_del"></i>
			</div>
		</form>
		<!-- 后置事件 -->
		<form id="hzsj" class="prop_cont" style="display:none" action="">
			<div class="pc5">
				<table>
					<thead>
						<tr>
							<th class="pc5_th1">事件名称</th>
							<th class="pc5_th2">事件</th>
							<th class="pc5_th3">事件常量</th>
						</tr>
					</thead>
					<tbody id="hou_zhi_shi_jian">
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
				<i class="e_add e_add_top js_add_e"></i> <i class="e_edit e_edit_top js_edit_e"></i> <i
					class="e_del e_del_top js_del"></i>
			</div>
		</form>
	</div>
	<!-- ws end -->
	<!-- state start -->
	<div id="state" class="prop_wrap" style="display:none">
		<!-- 基本信息 -->
		<form id="jbxx" class="prop_cont" style="display:none" action="">
			<table>
				<tbody>
					<tr>
						<td class="prop_fc10">显示名称</td>
						<td class="prop_fc40">
							<input id="xian_shi_ming_cheng" name="xian_shi_ming_cheng" class="wp73 prop_txt" type="text" value="" />
						</td>
						<td class="prop_fc10">逻辑标识</td>
						<td class="prop_fc40">
							<input id="luo_ji_biao_shi" name="luo_ji_biao_shi" class="wp73 prop_ro prop_txt" type="text" value="" readonly />
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<!-- 前置事件 -->
		<form id="qzsj" class="prop_cont" style="display:none" action="">
			<div class="pc5">
				<table>
					<thead>
						<tr>
							<th class="pc5_th1">事件名称</th>
							<th class="pc5_th2">事件</th>
							<th class="pc5_th3">事件常量</th>
						</tr>
					</thead>
					<tbody id="qian_zhi_shi_jian">
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
				<i class="e_add e_add_top js_add_e"></i> <i class="e_edit e_edit_top js_edit_e"></i> <i
					class="e_del e_del_top js_del"></i>
			</div>
		</form>
		<!-- 后置事件 -->
		<form id="hzsj" class="prop_cont" style="display:none" action="">
			<div class="pc5">
				<table>
					<thead>
						<tr>
							<th class="pc5_th1">事件名称</th>
							<th class="pc5_th2">事件</th>
							<th class="pc5_th3">事件常量</th>
						</tr>
					</thead>
					<tbody id="hou_zhi_shi_jian">
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
				<i class="e_add e_add_top js_add_e"></i> <i class="e_edit e_edit_top js_edit_e"></i> <i
					class="e_del e_del_top js_del"></i>
			</div>
		</form>
		<!-- 超时事件 -->
		<form id="cssj" class="prop_cont" style="display:none" action="">
			<table>
				<tbody>
					<tr>
						<td class="prop_fc10">触发规则</td>
						<td class="prop_fc90">
							<input id="chu_fa_gui_ze" name="chu_fa_gui_ze" class="wp88 prop_txt" type="text" value="" readonly />
							<input class="wp_10 js_cfgz" type="button" value="选择" />
						</td>
					</tr>
					<tr>
						<td class="prop_fc10">持续时间</td>
						<td class="prop_fc90">
							<input id="chi_xu_shi_jian" name="chi_xu_shi_jian" class="wp88 prop_txt" type="text" value="" readonly />
							<input class="wp_10 js_cxsj" type="button" value="选择" />
						</td>
					</tr>
					<tr>
						<td class="prop_fc10"></td>
						<td class="prop_fc90">
							<div class="pc5 js_show">
								<table>
									<thead>
										<tr>
											<th class="pc5_th1">事件名称</th>
											<th class="pc5_th2">事件</th>
											<th class="pc5_th3">事件常量</th>
										</tr>
									</thead>
									<tbody id="chao_shi_shi_jian">
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
									</tbody>
								</table>
								<i class="e_add e_add_top js_add_e"></i> <i class="e_edit e_edit_top js_edit_e"></i> <i
									class="e_del e_del_top js_del"></i>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	<!-- state end -->
	<!-- fork start -->
	<div id="fork" class="prop_wrap" style="display:none">
		<!-- 基本信息 -->
		<form id="jbxx" class="prop_cont" style="display:none" action="">
			<table>
				<tbody>
					<tr>
						<td class="prop_fc10">显示名称</td>
						<td class="prop_fc40">
							<input id="xian_shi_ming_cheng" name="xian_shi_ming_cheng" class="wp73 prop_txt" type="text" value="" />
						</td>
						<td class="prop_fc10">逻辑标识</td>
						<td class="prop_fc40">
							<input id="luo_ji_biao_shi" name="luo_ji_biao_shi" class="wp73 prop_ro prop_txt" type="text" value="" readonly />
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<!-- 前置事件 -->
		<form id="qzsj" class="prop_cont" style="display:none" action="">
			<div class="pc5">
				<table>
					<thead>
						<tr>
							<th class="pc5_th1">事件名称</th>
							<th class="pc5_th2">事件</th>
							<th class="pc5_th3">事件常量</th>
						</tr>
					</thead>
					<tbody id="qian_zhi_shi_jian">
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
				<i class="e_add e_add_top js_add_e"></i> <i class="e_edit e_edit_top js_edit_e"></i> <i
					class="e_del e_del_top js_del"></i>
			</div>
		</form>
		<!-- 后置事件 -->
		<form id="hzsj" class="prop_cont" style="display:none" action="">
			<div class="pc5">
				<table>
					<thead>
						<tr>
							<th class="pc5_th1">事件名称</th>
							<th class="pc5_th2">事件</th>
							<th class="pc5_th3">事件常量</th>
						</tr>
					</thead>
					<tbody id="hou_zhi_shi_jian">
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
				<i class="e_add e_add_top js_add_e"></i> <i class="e_edit e_edit_top js_edit_e"></i> <i
					class="e_del e_del_top js_del"></i>
			</div>
		</form>
	</div>
	<!-- fork end -->
	<!-- join start -->
	<div id="join" class="prop_wrap" style="display:none">
		<!-- 基本信息 -->
		<form id="jbxx" class="prop_cont" style="display:none" action="">
			<table>
				<tbody>
					<tr>
						<td class="prop_fc10">显示名称</td>
						<td class="prop_fc40">
							<input id="xian_shi_ming_cheng" name="xian_shi_ming_cheng" class="wp73 prop_txt" type="text" value="" />
						</td>
						<td class="prop_fc10">逻辑标识</td>
						<td class="prop_fc40">
							<input id="luo_ji_biao_shi" name="luo_ji_biao_shi" class="wp73 prop_ro prop_txt" type="text" value="" readonly />
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<!-- 合并条件 -->
		<form id="hbtj" class="prop_cont" style="display:none" action="">
			<table>
				<tbody>
					<tr>
						<td class="prop_fc10">合并方式</td>
						<td class="prop_fc40">
							<input id="qbhb" type="radio" name="he_bing_fang_shi" value="all" checked />
							<label class="label_for">全部合并</label>
							<input id="tjhb" type="radio" name="he_bing_fang_shi" value="condition" />
							<label class="label_for">条件合并</label>
							<input id="ryhb" type="radio" name="he_bing_fang_shi" value="arbitrary" />
							<label class="label_for">任意合并</label>
							<input class="prop_short num_only" id="num" name="num" type="text" value="" disabled />
							<em>个</em>
						</td>
					</tr>
					<tr>
						<td class="prop_fc10">
							<span class="js_show">逻辑类型</span>
						</td>
						<td class="prop_fc40">
							<select id="luo_ji_lei_xing" class="js_show">
								<option value="AND" selected>AND</option>
								<option value="OR">OR</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="prop_fc10"></td>
						<td class="prop_fc90">
							<div class="pc5 js_show">
								<table>
									<thead>
										<tr>
											<th class="pc5_th3">条件类型</th>
											<th class="pc5_th4">条件</th>
										</tr>
									</thead>
									<tbody id="he_bing_tiao_jian">
										<tr>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
										</tr>
									</tbody>
								</table>
								<i class="e_add e_add_top js_add_c"></i> <i class="e_edit e_edit_top js_edit_c"></i> <i
									class="e_del e_del_top js_del"></i>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<!-- 前置事件 -->
		<form id="qzsj" class="prop_cont" style="display:none" action="">
			<div class="pc5">
				<table>
					<thead>
						<tr>
							<th class="pc5_th1">事件名称</th>
							<th class="pc5_th2">事件</th>
							<th class="pc5_th3">事件常量</th>
						</tr>
					</thead>
					<tbody id="qian_zhi_shi_jian">
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
				<i class="e_add e_add_top js_add_e"></i> <i class="e_edit e_edit_top js_edit_e"></i> <i
					class="e_del e_del_top js_del"></i>
			</div>
		</form>
		<!-- 后置事件 -->
		<form id="hzsj" class="prop_cont" style="display:none" action="">
			<div class="pc5">
				<table>
					<thead>
						<tr>
							<th class="pc5_th1">事件名称</th>
							<th class="pc5_th2">事件</th>
							<th class="pc5_th3">事件常量</th>
						</tr>
					</thead>
					<tbody id="hou_zhi_shi_jian">
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
				<i class="e_add e_add_top js_add_e"></i> <i class="e_edit e_edit_top js_edit_e"></i> <i
					class="e_del e_del_top js_del"></i>
			</div>
		</form>
	</div>
	<!-- join end -->
	<!-- exclusive start -->
	<div id="decision" class="prop_wrap" style="display:none">
		<!-- 基本信息 -->
		<form id="jbxx" class="prop_cont" style="display:none" action="">
			<table>
				<tbody>
					<tr>
						<td class="prop_fc10">显示名称</td>
						<td class="prop_fc40">
							<input id="xian_shi_ming_cheng" name="xian_shi_ming_cheng" class="wp73 prop_txt" type="text" value="" />
						</td>
						<td class="prop_fc10">逻辑标识</td>
						<td class="prop_fc40">
							<input id="luo_ji_biao_shi" name="luo_ji_biao_shi" class="wp73 prop_ro prop_txt" type="text" value="" readonly />
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<!-- 前置事件 -->
		<form id="qzsj" class="prop_cont" style="display:none" action="">
			<div class="pc5">
				<table>
					<thead>
						<tr>
							<th class="pc5_th1">事件名称</th>
							<th class="pc5_th2">事件</th>
							<th class="pc5_th3">事件常量</th>
						</tr>
					</thead>
					<tbody id="qian_zhi_shi_jian">
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
				<i class="e_add e_add_top js_add_e"></i> <i class="e_edit e_edit_top js_edit_e"></i> <i
					class="e_del e_del_top js_del"></i>
			</div>
		</form>
		<!-- 后置事件 -->
		<form id="hzsj" class="prop_cont" style="display:none" action="">
			<div class="pc5">
				<table>
					<thead>
						<tr>
							<th class="pc5_th1">事件名称</th>
							<th class="pc5_th2">事件</th>
							<th class="pc5_th3">事件常量</th>
						</tr>
					</thead>
					<tbody id="hou_zhi_shi_jian">
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
				<i class="e_add e_add_top js_add_e"></i> <i class="e_edit e_edit_top js_edit_e"></i> <i
					class="e_del e_del_top js_del"></i>
			</div>
		</form>
	</div>
	<!-- exclusive end -->
	<!-- sub-process start -->
	<div id="sub-process" class="prop_wrap" style="display:none">
		<!-- 基本信息 -->
		<form id="jbxx" class="prop_cont" style="display:none" action="">
			<table>
				<tbody>
					<tr>
						<td class="prop_fc10">显示名称</td>
						<td class="prop_fc40">
							<input id="xian_shi_ming_cheng" name="xian_shi_ming_cheng" class="wp73 prop_txt" type="text" value="" />
						</td>
						<td class="prop_fc10">逻辑标识</td>
						<td class="prop_fc40">
							<input id="luo_ji_biao_shi" name="luo_ji_biao_shi" class="wp73 prop_ro prop_txt" type="text" value="" readonly />
						</td>
					</tr>
					<tr>
						<td class="prop_fc10">子流程名</td>
						<td class="prop_fc40">
							<input id="zi_liu_cheng_ming" name="zi_liu_cheng_ming" class="wp73 prop_txt" type="text" value="" readonly/>
							<input class="wp_10 js_childProcess" type="button" value="选择" />
						</td>
						<td class="prop_fc10">是否同步</td>
						<td class="prop_fc40">
							<input id="sftb_yes" type="radio" name="shi_fou_tong_bu" value="false" checked/>
							<label class="label_for">同步</label>
							<input id="sftb_no" type="radio" name="shi_fou_tong_bu" value="true" />
							<label class="label_for">异步</label>
						</td>
					</tr>
					<tr>
						<td class="prop_fc10">子流程选人</td>
						<td class="prop_fc40 js_open">
							<input id="zlcxr_yes" class="js_onoff" type="radio" name="zi_liu_cheng_xuan_ren" value="yes" />
							<label class="label_for">是</label>
							<input id="zlcxr_no" type="radio" name="zi_liu_cheng_xuan_ren" value="no" checked />
							<label class="label_for">否</label>
						</td>
						<td class="prop_fc10">选人方式</td>
						<td class="prop_fc40">
							<input id="xrfs_yes" class="js_enabled" type="radio" name="xuan_ren_fang_shi" value="manual" checked disabled/>
							<label class="label_for">手动</label>
							<input id="xrfs_no" class="js_enabled" type="radio" name="xuan_ren_fang_shi" value="auto" disabled/>
							<label class="label_for">自动</label>
						</td>
					</tr>
					<tr>
						<td class="prop_fc10">候选人员</td>
						<td class="prop_fc40">
							<input id="hou_xuan_ren_yuan" name="hou_xuan_ren_yuan" class="wp73 prop_txt js_enabled" type="text" value="" readonly disabled/>
							<input class="wp_10 js_who js_enabled" type="button" value="选择" disabled/>
						</td>
						<td class="prop_fc10">流转目标</td>
						<td class="prop_fc40">
							<input id="liu_zhuan_mu_biao" name="liu_zhuan_mu_biao" class="wp73 prop_txt" type="text" value="" readonly/>
							<input class="wp_10 js_variable_n" type="button" value="选择" />
						</td>
					</tr>
					<tr>
						<td class="prop_fc10">主传子参数</td>
						<td class="prop_fc40">
							<div class="pc5">
								<table>
									<thead>
										<tr>
											<th class="pc5_th2">主流程输出参数</th>
											<th class="pc5_th2">子流程接收参数</th>
										</tr>
									</thead>
									<tbody id="zhu_chuan_zi_can_shu">
										<tr>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
										</tr>
									</tbody>
								</table>
								<i class="e_add e_add_top js_add_zhuzi"></i> <i class="e_edit e_edit_top js_edit_zhuzi"></i> <i
									class="e_del e_del_top js_del"></i>
							</div>
						</td>
						<td class="prop_fc10">子传主参数</td>
						<td class="prop_fc40">
							<div class="pc5">
								<table>
									<thead>
										<tr>
											<th class="pc5_th2">子流程输出参数</th>
											<th class="pc5_th2">主流程接收参数</th>
										</tr>
									</thead>
									<tbody id="zi_chuan_zhu_can_shu">
										<tr>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
										</tr>
									</tbody>
								</table>
								<i class="e_add e_add_top js_add_zhuzi"></i> <i class="e_edit e_edit_top js_edit_zhuzi"></i> <i
									class="e_del e_del_top js_del"></i>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<!-- 前置事件 -->
		<form id="qzsj" class="prop_cont" style="display:none" action="">
			<div class="pc5">
				<table>
					<thead>
						<tr>
							<th class="pc5_th1">事件名称</th>
							<th class="pc5_th2">事件</th>
							<th class="pc5_th3">事件常量</th>
						</tr>
					</thead>
					<tbody id="qian_zhi_shi_jian">
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
				<i class="e_add e_add_top js_add_e"></i> <i class="e_edit e_edit_top js_edit_e"></i> <i
					class="e_del e_del_top js_del"></i>
			</div>
		</form>
		<!-- 后置事件 -->
		<form id="hzsj" class="prop_cont" style="display:none" action="">
			<div class="pc5">
				<table>
					<thead>
						<tr>
							<th class="pc5_th1">事件名称</th>
							<th class="pc5_th2">事件</th>
							<th class="pc5_th3">事件常量</th>
						</tr>
					</thead>
					<tbody id="hou_zhi_shi_jian">
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
				<i class="e_add e_add_top js_add_e"></i> <i class="e_edit e_edit_top js_edit_e"></i> <i
					class="e_del e_del_top js_del"></i>
			</div>
		</form>
	</div>
	<!-- sub-process end -->
	<!-- foreach start -->
	<div id="foreach" class="prop_wrap" style="display:none">
		<!-- 基本信息 -->
		<form id="jbxx" class="prop_cont" style="display:none" action="">
			<table>
				<tbody>
					<tr>
						<td class="prop_fc10">显示名称</td>
						<td class="prop_fc40">
							<input id="xian_shi_ming_cheng" name="xian_shi_ming_cheng" class="wp73 prop_txt" type="text" value="" />
						</td>
						<td class="prop_fc10">逻辑标识</td>
						<td class="prop_fc40">
							<input id="luo_ji_biao_shi" name="luo_ji_biao_shi" class="wp73 prop_ro prop_txt" type="text" value="" readonly />
						</td>
					</tr>
					<tr>
						<td class="prop_fc10">变量</td>
						<td class="prop_fc40">
							<input id="bian_liang" name="bian_liang" class="wp73 prop_txt" type="text" value="" />
							<input class="wp_10 js_variable" type="button" value="选择" />
						</td>
						<td class="prop_fc10">必须选人</td>
						<td class="prop_fc40 js_open">
							<input id="bxxr_yes" class="js_onoff" type="radio" name="isMustUser" value="yes" />
							<label class="label_for">是</label>
							<input id="bxxr_no" type="radio" name="isMustUser" value="no" checked/>
							<label class="label_for">否</label>
						</td>
					</tr>
					<tr>
						<td class="prop_fc10">集合</td>
						<td class="prop_fc40">
							<input id="ji_he" name="ji_he" class="wp73 prop_txt js_disabled" type="text" value="" />
							<input class="wp_10 js_variable_n js_disabled" type="button" value="选择" />
						</td>
						<td class="prop_fc10">选人方式</td>
						<td class="prop_fc40">
							<input id="xrfs_sd" class="js_enabled" type="radio" name="userSelectType" value="manual" checked disabled/>
							<label class="label_for">手动</label>
							<input id="xrfs_zd" class="js_enabled" type="radio" name="userSelectType" value="auto" disabled/>
							<label class="label_for">自动</label>
						</td>
					</tr>
					<tr>
						<td class="prop_fc10">分组类型</td>
						<td class="prop_fc90" colSpan=3>
							<select id="userGroupBy" class="js_enabled" disabled>
								<option value="dept" selected>部门</option>
								<option value="user">用户</option>
								<option value="group">群组</option>
								<option value="relation">自定义</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="prop_fc10"></td>
						<td class="prop_fc90" colSpan=3>
							<input id="candidateUsers" name="candidateUsers" class="wp88 prop_txt js_enabled" type="text" value="" readonly disabled/>
							<input class="wp_10 js_who js_enabled" type="button" value="选择" disabled/>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<!-- 前置事件 -->
		<form id="qzsj" class="prop_cont" style="display:none" action="">
			<div class="pc5">
				<table>
					<thead>
						<tr>
							<th class="pc5_th1">事件名称</th>
							<th class="pc5_th2">事件</th>
							<th class="pc5_th3">事件常量</th>
						</tr>
					</thead>
					<tbody id="qian_zhi_shi_jian">
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
				<i class="e_add e_add_top js_add_e"></i> <i class="e_edit e_edit_top js_edit_e"></i> <i
					class="e_del e_del_top js_del"></i>
			</div>
		</form>
		<!-- 后置事件 -->
		<form id="hzsj" class="prop_cont" style="display:none" action="">
			<div class="pc5">
				<table>
					<thead>
						<tr>
							<th class="pc5_th1">事件名称</th>
							<th class="pc5_th2">事件</th>
							<th class="pc5_th3">事件常量</th>
						</tr>
					</thead>
					<tbody id="hou_zhi_shi_jian">
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
				<i class="e_add e_add_top js_add_e"></i> <i class="e_edit e_edit_top js_edit_e"></i> <i
					class="e_del e_del_top js_del"></i>
			</div>
		</form>
	</div>
	<!-- foreach end -->
	<!-- jms start -->
	<div id="jms" class="prop_wrap" style="display:none">
		<!-- 基本信息 -->
		<form id="jbxx" class="prop_cont" style="display:none" action="">
			<table>
				<tbody>
					<tr>
						<td class="prop_fc10">显示名称</td>
						<td class="prop_fc40">
							<input id="xian_shi_ming_cheng" name="xian_shi_ming_cheng" class="wp73 prop_txt" type="text" value="" />
						</td>
						<td class="prop_fc10">逻辑标识</td>
						<td class="prop_fc40">
							<input id="luo_ji_biao_shi" name="luo_ji_biao_shi" class="wp73 prop_ro prop_txt" type="text" value="" readonly />
						</td>
					</tr>
					<tr>
						<td class="prop_fc10">连接工厂类</td>
						<td class="prop_fc40">
							<input id="lian_jie_gong_chang_lei" name="lian_jie_gong_chang_lei" class="wp73 prop_txt" type="text" value="org.apache.activemq.jndi.ActiveMQInitialContextFactory" />
						</td>
						<td class="prop_fc10">连接地址</td>
						<td class="prop_fc40">
							<input id="lian_jie_di_zhi" name=""lian_jie_di_zhi"" class="wp73 prop_txt" type="text" value="tcp://127.0.0.1:61616" />
						</td>
					</tr>
					<tr>
						<td class="prop_fc10">连接工厂</td>
						<td class="prop_fc40">
							<input id="lian_jie_gong_chang" name="lian_jie_gong_chang" class="wp73 prop_txt" type="text" value="ConnectionFactory" />
						</td>
						<td class="prop_fc10">队列主题</td>
						<td class="prop_fc40">
							<input id="lie_dui_zhu_ti" name="lie_dui_zhu_ti" class="wp73 prop_txt" type="text" value="BpmQueue" />
						</td>
					</tr>
					<tr>
						<td class="prop_fc10">事务控制</td>
						<td class="prop_fc40">
							<input id="swkz_yes" type="radio" name="shi_wu_kong_zhi" value="true" />
							<label class="label_for">是</label>
							<input id="swkz_no" type="radio" name="shi_wu_kong_zhi" value="false" checked/>
							<label class="label_for">否</label>
						</td>
						<td class="prop_fc10">应答类型</td>
						<td class="prop_fc40">
							<input id="ydlx_auto" type="radio" name="ying_da_lei_xing" value="auto" checked/>
							<label class="label_for">auto</label>
							<input id="ydlx_client" type="radio" name="ying_da_lei_xing" value="client" />
							<label class="label_for">client</label>
							<input id="ydlx_dups_ok" type="radio" name="ying_da_lei_xing" value="dups_ok" />
							<label class="label_for">dups_ok</label>
						</td>
					</tr>
					<tr>
						<td class="prop_fc10">返回类型</td>
						<td class="prop_fc40">
							<input id="fhlx_text" type="radio" name="fan_hui_lei_xing" value="text" checked/>
							<label class="label_for">文本</label>
							<input id="fhlx_object" type="radio" name="fan_hui_lei_xing" value="object" />
							<label class="label_for">对象</label>
							<input id="fhlx_map" type="radio" name="fan_hui_lei_xing" value="map" />
							<label class="label_for">集合</label>
						</td>
						<td class="prop_fc10">
							<span class="js_hide">文本值</span>
						</td>
						<td class="prop_fc40">
							<input id="fan_hui_lei_xing_zhi" name="fan_hui_lei_xing_zhi" class="wp73 prop_txt js_hide" type="text" value="" />
						</td>
					</tr>
					<tr>
						<td class="prop_fc10">
							<span class="js_show">集合值</span>
						</td>
						<td class="prop_fc40">
							<div class="pc5 js_show">
								<table>
									<thead>
										<tr>
											<th class="pc5_th1">参数名</th>
											<th class="pc5_th2">参数类型</th>
											<th class="pc5_th3">参数初始值</th>
										</tr>
									</thead>
									<tbody id="ji_he_zhi">
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
										</tr>
									</tbody>
								</table>
								<i class="e_add e_add_top js_add_jh"></i> <i class="e_edit e_edit_top js_edit_jh"></i> <i
									class="e_del e_del_top js_del"></i>
							</div>
						</td>
						<td class="prop_fc10">
						</td>
						<td class="prop_fc40">
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<!-- 前置事件 -->
		<form id="qzsj" class="prop_cont" style="display:none" action="">
			<div class="pc5">
				<table>
					<thead>
						<tr>
							<th class="pc5_th1">事件名称</th>
							<th class="pc5_th2">事件</th>
							<th class="pc5_th3">事件常量</th>
						</tr>
					</thead>
					<tbody id="qian_zhi_shi_jian">
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
				<i class="e_add e_add_top js_add_e"></i> <i class="e_edit e_edit_top js_edit_e"></i> <i
					class="e_del e_del_top js_del"></i>
			</div>
		</form>
		<!-- 后置事件 -->
		<form id="hzsj" class="prop_cont" style="display:none" action="">
			<div class="pc5">
				<table>
					<thead>
						<tr>
							<th class="pc5_th1">事件名称</th>
							<th class="pc5_th2">事件</th>
							<th class="pc5_th3">事件常量</th>
						</tr>
					</thead>
					<tbody id="hou_zhi_shi_jian">
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
				<i class="e_add e_add_top js_add_e"></i> <i class="e_edit e_edit_top js_edit_e"></i> <i
					class="e_del e_del_top js_del"></i>
			</div>
		</form>
	</div>
	<!-- jms end -->
	<!-- custom start -->
	<div id="custom" class="prop_wrap" style="display:none">
		<!-- 基本信息 -->
		<form id="jbxx" class="prop_cont" style="display:none" action="">
			<table>
				<tbody>
					<tr>
						<td class="prop_fc10">显示名称</td>
						<td class="prop_fc40">
							<input id="xian_shi_ming_cheng" name="xian_shi_ming_cheng" class="wp73 prop_txt" type="text" value="" />
						</td>
						<td class="prop_fc10">逻辑标识</td>
						<td class="prop_fc40">
							<input id="luo_ji_biao_shi" name="luo_ji_biao_shi" class="wp73 prop_ro prop_txt" type="text" value="" readonly />
						</td>
					</tr>
				</tbody>
			</table>
			<table>
				<tbody>
					<tr>
						<td class="prop_fc10">Class路径</td>
						<td class="prop_fc90">
							<input id="class_lu_jing" name="class_lu_jing" class="wp88 prop_txt" type="text" value="" />
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<!-- 前置事件 -->
		<form id="qzsj" class="prop_cont" style="display:none" action="">
			<div class="pc5">
				<table>
					<thead>
						<tr>
							<th class="pc5_th1">事件名称</th>
							<th class="pc5_th2">事件</th>
							<th class="pc5_th3">事件常量</th>
						</tr>
					</thead>
					<tbody id="qian_zhi_shi_jian">
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
				<i class="e_add e_add_top js_add_e"></i> <i class="e_edit e_edit_top js_edit_e"></i> <i
					class="e_del e_del_top js_del"></i>
			</div>
		</form>
		<!-- 后置事件 -->
		<form id="hzsj" class="prop_cont" style="display:none" action="">
			<div class="pc5">
				<table>
					<thead>
						<tr>
							<th class="pc5_th1">事件名称</th>
							<th class="pc5_th2">事件</th>
							<th class="pc5_th3">事件常量</th>
						</tr>
					</thead>
					<tbody id="hou_zhi_shi_jian">
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
				<i class="e_add e_add_top js_add_e"></i> <i class="e_edit e_edit_top js_edit_e"></i> <i
					class="e_del e_del_top js_del"></i>
			</div>
		</form>
	</div>
	<!-- custom end -->
	<!-- transition start -->
	<div id="transition" class="prop_wrap" style="display:none">
		<!-- 基本信息 -->
		<form id="jbxx" class="prop_cont" style="display:none" action="">
			<table>
				<tbody>
					<tr>
						<td class="prop_fc10">显示名称</td>
						<td class="prop_fc40">
							<input id="xian_shi_ming_cheng" name="xian_shi_ming_cheng" class="wp73 prop_txt" type="text" value="" />
						</td>
						<td class="prop_fc10">逻辑标识</td>
						<td class="prop_fc40">
							<input id="luo_ji_biao_shi" name="luo_ji_biao_shi" class="wp73 prop_ro prop_txt" type="text" value="" readonly />
						</td>
					</tr>
				</tbody>
			</table>
			<table>
				<tbody>
					<tr>
						<td class="prop_fc10">显示顺序</td>
						<td class="prop_fc90">
							<input id="xian_shi_shun_xu" name="xian_shi_shun_xu" class="wp88 prop_txt num_only" type="text" value="" />
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<!-- 路由条件 -->
		<form id="lytj" class="prop_cont" style="display:none" action="">
			<table>
				<tbody>
					<tr>
						<td class="prop_fc10">执行方式</td>
						<td class="prop_fc90">
							<select id="zhi_xing_fang_shi">
								<option value="AND" selected>AND</option>
								<option value="OR">OR</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="prop_fc10"></td>
						<td class="prop_fc90">
							<div class="pc5">
								<table>
									<thead>
										<tr>
											<th class="pc5_th3">条件类型</th>
											<th class="pc5_th4">条件</th>
										</tr>
									</thead>
									<tbody id="lu_you_tiao_jian">
										<tr>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
										</tr>
										<tr>
											<td></td>
											<td></td>
										</tr>
									</tbody>
								</table>
								<i class="e_add e_add_top js_add_c"></i> <i class="e_edit e_edit_top js_edit_c"></i> <i
									class="e_del e_del_top js_del"></i>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<!-- 流转事件 -->
		<form id="lzsj" class="prop_cont" style="display:none" action="">
			<div class="pc5">
				<table>
					<thead>
						<tr>
							<th class="pc5_th1">事件名称</th>
							<th class="pc5_th2">事件</th>
							<th class="pc5_th3">事件常量</th>
						</tr>
					</thead>
					<tbody id="liu_zhuan_shi_jian">
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
				<i class="e_add e_add_top js_add_e"></i> <i class="e_edit e_edit_top js_edit_e"></i> <i
					class="e_del e_del_top js_del"></i>
			</div>
		</form>
		<!-- 超时流转 -->
		<form id="cslz" class="prop_cont" style="display:none" action="">
			<table>
				<tbody>
					<tr>
						<td class="prop_fc10">触发规则</td>
						<td class="prop_fc90">
							<input id="chu_fa_gui_ze" name="chu_fa_gui_ze" class="wp88 prop_txt" type="text" value="" readonly />
							<input class="wp_10 js_cfgz" type="button" value="选择" />
						</td>
					</tr>
					<tr>
						<td class="prop_fc10">持续时间</td>
						<td class="prop_fc90">
							<input id="chi_xu_shi_jian" name="chi_xu_shi_jian" class="wp88 prop_txt" type="text" value="" readonly />
							<input class="wp_10 js_cxsj" type="button" value="选择" />
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	<!-- transition end -->
</body>
</html>
