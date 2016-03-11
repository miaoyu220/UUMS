/**
 * state extends MyBase
 */
function MyState(id) {
	MyBase.call(this, id, "state");
	this.style = "image;image=static/js/platform/designer/images/48/task_wait.png;";
};
MyState.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyState.prototype.init = function() {
	this.initBase();
	this.name = this.tagName + _countUtils.getState();
	this.labelChanged(this.name);
	this.initJBXX();// 初始化基本信息
};
/**
 * 加载时初始化元素信息
 * 
 * @param xmlValue
 * @param rootXml
 */
MyState.prototype.initLoad = function(xmlValue, rootXml) {
	this.initBase();
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	_countUtils.setState(this.resolve());// 设置自增长数字
	this.initJBXX();// 初始化基本信息
	/*****以上是公共的*******/
	this.createEventDom(xmlValue, "qian_zhi_shi_jian", "start");//event
	this.createEventDom(xmlValue, "hou_zhi_shi_jian", "end");//event
	this.createTimeEventDom(xmlValue);//超时事件
	/*****以下是公共的*******/
	rootXml.appendChild(this.createMxCell());// 创建mxCell
	_myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
};
/**
 * 组装processXML的自定义信息
 * 
 * @param node
 */
MyState.prototype.getOtherAttr = function(node) {
	this.createEventXml(node, "qian_zhi_shi_jian", "start");
	this.createEventXml(node, "hou_zhi_shi_jian", "end");
	this.createTimeEventXml(node);//超时事件
};
/**
 * 获取属性分项列表
 * 
 * @returns {Array}
 */
MyState.prototype.getItem = function() {
	return [ {
		id : "jbxx_" + this.id,
		text : "基本信息",
		selected : true,
		icon : "grid.gif"
	}, {
		id : "qzsj_" + this.id,
		text : "前置事件",
		icon : "grid.gif"
	}, {
		id : "hzsj_" + this.id,
		text : "后置事件",
		icon : "grid.gif"
	}, {
		id : "cssj_" + this.id,
		text : "超时事件",
		icon : "grid.gif"
	} ];
};