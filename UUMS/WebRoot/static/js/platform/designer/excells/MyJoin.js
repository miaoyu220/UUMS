/**
 * join extends MyBase
 */
function MyJoin(id) {
	MyBase.call(this, id, "join");
	this.style = "image;image=static/js/platform/designer/images/48/gateway_join.png;";
};
MyJoin.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyJoin.prototype.init = function() {
	this.initBase();
	this.name = this.tagName + _countUtils.getJoin();
	this.labelChanged(this.name);
	this.initJBXX();// 初始化基本信息
};
/**
 * 加载时初始化元素信息
 * 
 * @param xmlValue
 * @param rootXml
 */
MyJoin.prototype.initLoad = function(xmlValue, rootXml) {
	this.initBase();
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	_countUtils.setJoin(this.resolve());// 设置自增长数字
	this.initJBXX();// 初始化基本信息
	/*****以上是公共的*******/
	//合并方式
	var joinType = this.getMeta(xmlValue, "joinType");
	if($.notNull(joinType)){
		if(joinType == "condition"){
			$("#" + this.id).find("#tjhb").attr("checked", true);
			this.createConditionDom(xmlValue, "he_bing_tiao_jian", "luo_ji_lei_xing");
		}else if(joinType == "arbitrary"){
			$("#" + this.id).find("#ryhb").attr("checked", true);
			this.setDomValByAttr("num", xmlValue, "multiplicity");
		}
		$("#" + this.id).find("input[name='he_bing_fang_shi']:checked").trigger('change');
	}
	this.createEventDom(xmlValue, "qian_zhi_shi_jian", "start");//event
	this.createEventDom(xmlValue, "hou_zhi_shi_jian", "end");//event
	/*****以下是公共的*******/
	rootXml.appendChild(this.createMxCell());// 创建mxCell
	_myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
};
/**
 * 组装processXML的自定义信息
 * 
 * @param node
 */
MyJoin.prototype.getOtherAttr = function(node) {
	//合并方式
	var joinType = $("#" + this.id).find("input[name='he_bing_fang_shi']:checked").val();
	this.addMeta("joinType", joinType, node);
	if(joinType == "condition"){
		this.createConditionXml(node, "he_bing_tiao_jian", "luo_ji_lei_xing");
	}else if(joinType == "arbitrary"){
		this.setXmlAttrByVal("num", node, "multiplicity");
	}
	this.createEventXml(node, "qian_zhi_shi_jian", "start");//前置事件
	this.createEventXml(node, "hou_zhi_shi_jian", "end");//后置事件
};
/**
 * 获取属性分项列表
 * 
 * @returns {Array}
 */
MyJoin.prototype.getItem = function() {
	return [ {
		id : "jbxx_" + this.id,
		text : "基本信息",
		selected : true,
		icon : "grid.gif"
	}, {
		id : "hbtj_" + this.id,
		text : "合并条件",
		icon : "grid.gif"
	}, {
		id : "qzsj_" + this.id,
		text : "前置事件",
		icon : "grid.gif"
	}, {
		id : "hzsj_" + this.id,
		text : "后置事件",
		icon : "grid.gif"
	} ];
};