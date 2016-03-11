/**
 * process extends MyBase
 */
function MyProcess(id) {
	MyBase.call(this, id, "process");
};
MyProcess.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyProcess.prototype.init = function() {
	this.initBase();
	this.name = _processKey;
	this.alias = "";
	$("#" + this.id).find("#liu_cheng_ming_cheng").val(this.alias);
	$("#" + this.id).find("#liu_cheng_biao_shi").val(this.name);
};
/**
 * 加载时初始化元素信息
 * 
 * @param xmlValue
 * @param rootXml
 */
MyProcess.prototype.initLoad = function(xmlValue, rootXml) {
	this.initBase();
	this.alias = $.trim(xmlValue.getAttribute("name"));
	this.name = _processKey;
	$("#" + this.id).find("#liu_cheng_ming_cheng").val($.trim(this.alias));
	$("#" + this.id).find("#liu_cheng_biao_shi").val(this.name);
	
	this.setDomValByAttr("shi_li_biao_ti", xmlValue, "title");
	this.setDomValByAttr("liu_cheng_miao_shu", xmlValue, "description");
	this.setDomValByMeta("liu_cheng_shan_chu", xmlValue, "deleteEvent");
	
	this.createEventDom(xmlValue, "qian_zhi_shi_jian", "start");//event
	this.createTimeEventDom(xmlValue);//超时事件
	this.createVariableDom(xmlValue);//流程变量
	this.createConditionDom(xmlValue, "qi_dong_tiao_jian", "zhi_xing_fang_shi");//启动条件
	
	//权限
	this.createActorsDom(xmlValue);
	this.createQXDom(xmlValue, "yi_jian_xiu_gai", "globalIdea");
	this.createQXDom(xmlValue, "liu_cheng_tiao_zhuan", "globalJump");
	this.createQXDom(xmlValue, "liu_cheng_zan_ting", "globalSuspend");
	this.createQXDom(xmlValue, "liu_cheng_hui_fu", "globalResume");
	this.createQXDom(xmlValue, "liu_cheng_jie_shu", "globalEnd");
	this.createQXDom(xmlValue, "quan_ju_zhuan_fa", "globalTransmit");
	this.createQXDom(xmlValue, "quan_ju_du_zhe", "globalReader");
};
/**
 * 重写了组装processXML的方法，自定义所有信息
 * 
 * @returns
 */
MyProcess.prototype.getXmlDoc = function() {
	var node = ComUtils.createElement(this.tagName);
	this.putAttr("name", this.alias, node);
	this.putAttr("key", this.name, node);
	
	this.setXmlAttrByVal("shi_li_biao_ti", node, "title");
	this.setXmlAttrByVal("liu_cheng_miao_shu", node, "description");
	this.setXmlMetaByVal("liu_cheng_shan_chu", node, "deleteEvent");
	this.createEventXml(node, "qian_zhi_shi_jian", "start");//event
	this.createTimeEventXml(node);//超时事件
	this.createVariableXml(node);//流程变量
	this.createConditionXml(node, "qi_dong_tiao_jian", "zhi_xing_fang_shi");//启动条件
	
	//权限
	var magicsNode = ComUtils.createElement("magics");
	this.createQXXml(magicsNode, "yi_jian_xiu_gai", "globalIdea", "意见修改", node);
	this.createQXXml(magicsNode, "liu_cheng_tiao_zhuan", "globalJump", "流程跳转", node);
	this.createQXXml(magicsNode, "liu_cheng_zan_ting", "globalSuspend", "流程暂停", node);
	this.createQXXml(magicsNode, "liu_cheng_hui_fu", "globalResume", "流程恢复", node);
	this.createQXXml(magicsNode, "liu_cheng_jie_shu", "globalEnd", "流程结束", node);
	this.createQXXml(magicsNode, "quan_ju_zhuan_fa", "globalTransmit", "全局转发", node);
	this.createQXXml(magicsNode, "quan_ju_du_zhe", "globalReader", "全局读者", node);
	if(magicsNode.childNodes.length > 0){
		node.appendChild(magicsNode);
	}
	return node;
};
/**
 * 重写了name监听事件，不需要其他处理
 * 
 * @param value
 */
MyProcess.prototype.labelChanged = function(value) {
	this.alias = value;
};
/**
 * 获取属性分项列表
 * 
 * @returns {Array}
 */
MyProcess.prototype.getItem = function() {
	return [ {
		id : "jbxx_" + this.id,
		text : "基本信息",
		selected : true,
		icon : "grid.gif"
	}, {
		id : "qdtj_" + this.id,
		text : "启动条件",
		icon : "grid.gif"
	}, {
		id : "qjqx_" + this.id,
		text : "全局权限",
		icon : "grid.gif"
	}, {
		id : "qzsj_" + this.id,
		text : "前置事件",
		icon : "grid.gif"
	}, {
		id : "cssj_" + this.id,
		text : "超时事件",
		icon : "grid.gif"
	}, {
		id : "lcbl_" + this.id,
		text : "流程变量",
		icon : "grid.gif"
	} ];
};
/**
 * 流程变量组装
 */
MyProcess.prototype.createVariableXml = function(tagNodeXml) {
	var array = propUtils.getVariables();
	if (array.length > 0) {
		var node = ComUtils.createElement('variables');
		$.each(array, function(i, n){
			var vNode = ComUtils.createElement('variable');
			vNode.setAttribute('alias', n.alias);
			vNode.setAttribute('name', n.name);
			vNode.setAttribute('required', "N");
			vNode.setAttribute('init-expr', n.init);
			vNode.setAttribute('type', n.type);
			vNode.setAttribute('desc', n.desc);
			node.appendChild(vNode);
		});
		tagNodeXml.appendChild(node);
	}
};
/**
 * 加载流程变量区域
 * @param tagNodeXml
 * @param eventDomId
 * @param eventName
 */
MyProcess.prototype.createVariableDom = function(tagNodeXml) {
	var self = this;
	$(tagNodeXml).children("variables").each(function(){
		$(this).find("variable").each(function(i){
			var alias = $(this).attr("alias");
			var name = $(this).attr("name");
			var init = $(this).attr("init-expr");
			var type = $(this).attr("type");
			var desc = $(this).attr("desc");
			var $table = $("#" + self.id).find("#liu_cheng_bian_liang").find("tr");
			$table.eq(i).find("td").eq(0).html(alias);
			$table.eq(i).find("td").eq(1).html(name);
			$table.eq(i).find("td").eq(2).html(init);
			$table.eq(i).find("td").eq(3).html(type);
			$table.eq(i).find("td").eq(4).html(desc);
		});
	});
};
