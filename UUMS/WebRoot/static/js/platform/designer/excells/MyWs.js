/**
 * ws extends MyBase
 */
function MyWs(obj) {
	MyBase.call(this, obj, "ws");
	this.style = "image;image=static/js/platform/designer/images/48/task_webservice.png;";
};
MyWs.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyWs.prototype.init = function() {
	this.initBase();
	this.name = this.tagName + _countUtils.getWs();
	this.labelChanged(this.name);
	this.initJBXX();// 初始化基本信息
};
/**
 * 加载时初始化元素信息
 * 
 * @param xmlValue
 * @param rootXml
 */
MyWs.prototype.initLoad = function(xmlValue, rootXml) {
	this.initBase();
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	_countUtils.setWs(this.resolve());// 设置自增长数字
	this.initJBXX();// 初始化基本信息
	/*****以上是公共的*******/
	this.setDomValByAttr("fu_wu_di_zhi", xmlValue, "url");
	this.setDomValByAttr("zhi_xing_fang_fa", xmlValue, "method");
	this.setDomValByAttr("fan_hui_bian_liang", xmlValue, "var");
	this.setDomValByMeta("yong_hu_ming", xmlValue, "accessUser");
	this.setDomValByMeta("mi_ma", xmlValue, "accessPwd");
	this.setDomValByMeta("ding_zhi_shi_xian", xmlValue, "wsClient");
	this.setDomCheckByMeta("sftb_no", xmlValue, "sync", "false");
	this.createFfcsCyblDom(xmlValue, "fang_fa_can_shu", "arg");//方法参数
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
MyWs.prototype.getOtherAttr = function(node) {
	this.setXmlAttrByVal("fu_wu_di_zhi", node, "url");
	this.setXmlAttrByVal("zhi_xing_fang_fa", node, "method");
	this.setXmlAttrByVal("fan_hui_bian_liang", node, "var");
	this.setXmlMetaByVal("yong_hu_ming", node, "accessUser");
	this.setXmlMetaByVal("mi_ma", node, "accessPwd");
	this.setXmlMetaByVal("ding_zhi_shi_xian", node, "wsClient");
	this.addMeta("error", "break", node);
	this.setXmlMetaByCheck("shi_fou_tong_bu", node, "sync");
	this.createFfcsCyblXml(node, "fang_fa_can_shu", "arg");//方法参数
	this.createEventXml(node, "qian_zhi_shi_jian", "start");
	this.createEventXml(node, "hou_zhi_shi_jian", "end");
};