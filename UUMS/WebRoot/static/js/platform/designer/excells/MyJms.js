/**
 * jms extends MyBase
 */
function MyJms(id) {
	MyBase.call(this, id, "jms");
	this.style = "image;image=static/js/platform/designer/images/48/task_jms.png;";
};
MyJms.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyJms.prototype.init = function() {
	this.initBase();
	this.name = this.tagName + _countUtils.getJms();
	this.labelChanged(this.name);
	this.initJBXX();// 初始化基本信息
};
/**
 * 加载时初始化元素信息
 * 
 * @param xmlValue
 * @param rootXml
 */
MyJms.prototype.initLoad = function(xmlValue, rootXml) {
	this.initBase();
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	_countUtils.setJms(this.resolve());// 设置自增长数字
	this.initJBXX();// 初始化基本信息
	/*****以上是公共的*******/
	this.setDomValByAttr("lian_jie_gong_chang_lei", xmlValue, "initial-context-factory");
	this.setDomValByAttr("lian_jie_di_zhi", xmlValue, "provider-url");
	this.setDomValByAttr("lian_jie_gong_chang", xmlValue, "connection-factory");
	this.setDomValByAttr("lie_dui_zhu_ti", xmlValue, "destination");
	this.setDomCheckByAttr("swkz_yes", xmlValue, "transacted", "true");
	this.setDomCheckByAttr("ydlx_client", xmlValue, "acknowledge", "client");
	this.setDomCheckByAttr("ydlx_dups_ok", xmlValue, "acknowledge", "dups_ok");
	var message = this.getAttr(xmlValue, "message");
	if($.notNull(message)){
		if(message == "text"){
			var self = this;
			$("#" + this.id).find("#fhlx_text").attr("checked", true);
			$(xmlValue).children("text").each(function(i, n){
				$("#" + self.id).find("#fan_hui_lei_xing_zhi").val($.trim($(this).text()));
			});
		}else if(message == "object"){
			var self = this;
			$("#" + this.id).find("#fhlx_object").attr("checked", true);
			$(xmlValue).children("object").each(function(){
				$("#" + self.id).find("#fan_hui_lei_xing_zhi").val($.trim($(this).attr("expr")));
			});
		}else if(message == "map"){
			this.createMapDom(xmlValue);
		}
		$("#" + this.id).find("input[name='fan_hui_lei_xing']:checked").trigger('change');
	}
	this.createEventDom(xmlValue, "qian_zhi_shi_jian", "start");//event
	this.createEventDom(xmlValue, "hou_zhi_shi_jian", "end");//event
	/*****以下是公共的*******/
	rootXml.appendChild(this.createMxCell());// 创建mxCell
	_myLoadMap.put(this.name, this);//加载时的赋值，用于连线加载时按照name来寻找target节点
};
/**
 * 组装processXML时的自定义信息
 * 
 * @param node
 */
MyJms.prototype.getOtherAttr = function(node) {
	this.setXmlAttrByVal("lian_jie_gong_chang_lei", node, "initial-context-factory");
	this.setXmlAttrByVal("lian_jie_di_zhi", node, "provider-url");
	this.setXmlAttrByVal("lian_jie_gong_chang", node, "connection-factory");
	this.setXmlAttrByVal("lie_dui_zhu_ti", node, "destination");
	this.setXmlAttrByCheck("shi_wu_kong_zhi", node, "transacted");
	this.setXmlAttrByCheck("ying_da_lei_xing", node, "acknowledge");
	var message = $("#" + this.id).find("input[name='fan_hui_lei_xing']:checked").val();
	this.putAttr("message", message, node);
	if(message == "text"){
		var text = $("#" + this.id).find("#fan_hui_lei_xing_zhi").val();
		if($.notNull(text)){
			var textNode = ComUtils.createElement("text");
			textNode.appendChild(ComUtils.createTextNode(text));
			node.appendChild(textNode);
		}
	}else if(message == "object"){
		var text = $("#" + this.id).find("#fan_hui_lei_xing_zhi").val();
		if($.notNull(text)){
			var objNode = ComUtils.createElement("object");
			objNode.setAttribute("expr", text);
			node.appendChild(objNode);
		}
	}else{
		this.createMapXml(node);
	}
	this.createEventXml(node, "qian_zhi_shi_jian", "start");//event
	this.createEventXml(node, "hou_zhi_shi_jian", "end");//event
};
/**
 * 集合
 */
MyJms.prototype.createMapXml = function(tagNodeXml){
	var $obj = $('#' + this.id).find('#ji_he_zhi tr');
	var array = propUtils.getHtmlListByDom($obj);
	if(array.length > 0){
		var node = ComUtils.createElement('map');
		$.each(array, function(i, n){
			var entry = ComUtils.createElement("entry");
			var key = ComUtils.createElement("key");
			var value = ComUtils.createElement("value");
			var stringNode = ComUtils.createElement("string");
			stringNode.setAttribute('value', n.a);
			key.appendChild(stringNode);
			var valueNode = ComUtils.createElement(n.b);
			valueNode.setAttribute('value', n.c);
			value.appendChild(valueNode);
			entry.appendChild(key);
			entry.appendChild(value);
			node.appendChild(entry);
		});
		tagNodeXml.appendChild(node);
	}
};
/**
 * 加载集合
 */
MyJms.prototype.createMapDom = function(tagNodeXml){
	var self = this;
	$("#" + this.id).find("#fhlx_map").attr("checked", true);
	$(tagNodeXml).children("map").children("entry").each(function(i){
		var name = $(this).find("key").find("string").attr("value");
		var type = $(this).find("value").children().get(0).tagName;
		var init = $(this).find("value").children().attr("value");
		$("#" + self.id).find("#ji_he_zhi").find("tr").eq(i).find("td").eq(0).html($.trim(name));
		$("#" + self.id).find("#ji_he_zhi").find("tr").eq(i).find("td").eq(1).html($.trim(type));
		$("#" + self.id).find("#ji_he_zhi").find("tr").eq(i).find("td").eq(2).html($.trim(init));
	});
};