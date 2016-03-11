/**
 * sql extends MyBase
 */
function MySql(id) {
	MyBase.call(this, id, "sql");
	this.style = "image;image=static/js/platform/designer/images/48/task_sql.png;";
};
MySql.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MySql.prototype.init = function() {
	this.initBase();
	this.name = this.tagName + _countUtils.getSql();
	this.labelChanged(this.name);
	this.initJBXX();// 初始化基本信息
};
/**
 * 加载时初始化元素信息
 * 
 * @param xmlValue
 * @param rootXml
 */
MySql.prototype.initLoad = function(xmlValue, rootXml) {
	this.initBase();
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	_countUtils.setSql(this.resolve());// 设置自增长数字
	this.initJBXX();// 初始化基本信息
	/*****以上是公共的*******/
	var self = this;
	$(xmlValue).children("dataSource").each(function(){
		$("#" + self.id).find("#shu_ju_yuan").val($.trim($(this).text()));
	});
	this.setDomValByAttr("fan_hui_bian_liang", xmlValue, "var");
	this.setDomCheckByAttr("fhwyz_no", xmlValue, "unique", "false");
	this.createQueryDom(xmlValue);//查询参数
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
MySql.prototype.getOtherAttr = function(node) {
	this.setXmlAttrByVal("fan_hui_bian_liang", node, "var");
	this.setXmlAttrByCheck("fan_hui_wei_yi_zhi", node, "unique");
	var dataSource = $("#" + this.id).find("#shu_ju_yuan").val();
	if($.notNull(dataSource)){
		var dataSourceNode = ComUtils.createElement("dataSource");
		dataSourceNode.appendChild(ComUtils.createTextNode(dataSource));
		node.appendChild(dataSourceNode);
	}
	this.addMeta("error", "break", node);
	this.createQueryXml(node);//查询参数
	this.createEventXml(node, "qian_zhi_shi_jian", "start");//event
	this.createEventXml(node, "hou_zhi_shi_jian", "end");//event
};
/**
 * 查询参数
 * @param tagNodeXml
 */
MySql.prototype.createQueryXml = function(tagNodeXml){
	var query = $("#" + this.id).find("#cha_xun_tiao_jian").val();
	if($.notNull(query)){
		var queryNode = ComUtils.createElement("query");
		queryNode.appendChild(ComUtils.createTextNode(query));
		tagNodeXml.appendChild(queryNode);
	}
	var $obj = $('#' + this.id).find('#cha_xun_can_shu tr');
	var array = propUtils.getHtmlListByDom($obj);
	if(array.length > 0){
		var node = ComUtils.createElement('parameters');
		$.each(array, function(i, n){
			var tag = ComUtils.createElement(n.c);
			tag.setAttribute('alias', n.a);
			tag.setAttribute('name', n.b);
			tag.setAttribute('value', n.d);
			node.appendChild(tag);
		});
		tagNodeXml.appendChild(node);
	}
};
/**
 * 加载查询参数
 * @param tagNodeXml
 */
MySql.prototype.createQueryDom = function(tagNodeXml){
	var self = this;
	$(tagNodeXml).children("query").each(function(i, n){
		$("#" + self.id).find("#cha_xun_tiao_jian").val($.trim($(this).text()));
	});
	$(tagNodeXml).children("parameters").each(function(){
		$(this).children().each(function(i, n){
			var alias = $(this).attr("alias");
			var name = $(this).attr("name");
			var type = $(this).get(0).tagName;
			var value = $(this).attr("value");
			$("#" + self.id).find("#cha_xun_can_shu").find("tr").eq(i).find("td").eq(0).html($.trim(alias));
			$("#" + self.id).find("#cha_xun_can_shu").find("tr").eq(i).find("td").eq(1).html($.trim(name));
			$("#" + self.id).find("#cha_xun_can_shu").find("tr").eq(i).find("td").eq(2).html($.trim(type));
			$("#" + self.id).find("#cha_xun_can_shu").find("tr").eq(i).find("td").eq(3).html($.trim(value));
		});
	});
};