/**
 * java extends MyBase
 */
function MyJava(id) {
	MyBase.call(this, id, "java");
	this.style = "image;image=static/js/platform/designer/images/48/task_java.png;";
};
MyJava.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyJava.prototype.init = function() {
	this.initBase();
	this.name = this.tagName + _countUtils.getJava();
	this.labelChanged(this.name);
	this.initJBXX();// 初始化基本信息
};
/**
 * 加载时初始化元素信息
 * 
 * @param xmlValue
 * @param rootXml
 */
MyJava.prototype.initLoad = function(xmlValue, rootXml) {
	this.initBase();
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	_countUtils.setJava(this.resolve());// 设置自增长数字
	this.initJBXX();// 初始化基本信息
	/*****以上是公共的*******/
	this.setDomValByAttr("zu_jian", xmlValue, "class");
	this.setDomValByAttr("zhi_xing_fang_fa", xmlValue, "method");
	this.setDomValByAttr("fan_hui_bian_liang", xmlValue, "var");
	this.createEventDom(xmlValue, "qian_zhi_shi_jian", "start");//event
	this.createEventDom(xmlValue, "hou_zhi_shi_jian", "end");//event
	this.createFfcsCyblDom(xmlValue, "cheng_yuan_bian_liang", "field");//成员变量
	this.createFfcsCyblDom(xmlValue, "fang_fa_can_shu", "arg");//方法参数
	/*****以下是公共的*******/
	rootXml.appendChild(this.createMxCell());// 创建mxCell
	_myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
};
/**
 * 组装processXML的自定义信息
 * 
 * @param node
 */
MyJava.prototype.getOtherAttr = function(node) {
	this.setXmlAttrByVal("zu_jian", node, "class");
	this.setXmlAttrByVal("zhi_xing_fang_fa", node, "method");
	this.setXmlAttrByVal("fan_hui_bian_liang", node, "var");
	this.createEventXml(node, "qian_zhi_shi_jian", "start");//event
	this.createEventXml(node, "hou_zhi_shi_jian", "end");//event
	this.createFfcsCyblXml(node, "cheng_yuan_bian_liang", "field");//成员变量
	this.createFfcsCyblXml(node, "fang_fa_can_shu", "arg");//方法参数
};
