/**
 * transition extends MyBase
 */
function MyTransition(id) {
	MyBase.call(this, id, "transition");
};
MyTransition.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyTransition.prototype.init = function() {
	this.initBase();
	var targetName = _myCellMap.get(this.getCell().target.id).name;
	this.name = "to " + targetName;
	this.alias = "to " + targetName;
	this.initJBXX();// 初始化基本信息
};
/**
 * 加载时初始化元素信息
 * 
 * @param xmlValue
 * @param rootXml
 */
MyTransition.prototype.initLoad = function(xmlValue, rootXml, tagId) {
	this.initBase();
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.initJBXX();// 初始化基本信息
	/*****以上是公共的*******/
	this.setDomValByAttr("xian_shi_shun_xu", xmlValue, "order");
	this.createTimeEventDom(xmlValue);//超时事件
	this.createTransitionEventDom(xmlValue);//流转事件
	this.createConditionDom(xmlValue, "lu_you_tiao_jian", "zhi_xing_fang_shi");//路由条件
	/*****以下是公共的*******/
	rootXml.appendChild(this.createMxCell(tagId));// 创建mxCell
};
/**
 * 重写解析位置G的方法
 * 
 * @returns {String}
 */
MyTransition.prototype.getG = function() {
	return "-5,-22";
};
/**
 * 组装processXML的自定义信息
 * 
 * @param node
 */
MyTransition.prototype.getOtherAttr = function(node) {
	this.putAttr("to", _myCellMap.get(this.cell.target.id).name, node);
	this.setXmlAttrByVal("xian_shi_shun_xu", node, "order");
	this.createTimeEventXml(node);//超时事件
	this.createTransitionEventXml(node);//流转事件
	this.createConditionXml(node, "lu_you_tiao_jian", "zhi_xing_fang_shi");//路由条件
};
/**
 * 重写name监听事件，不需要往连线上写值
 * 
 * @param value
 */
MyTransition.prototype.labelChanged = function(value) {
	this.alias = value;
};
/**
 * 获取属性分项列表
 * 
 * @returns {Array}
 */
MyTransition.prototype.getItem = function() {
	return [ {
		id : "jbxx_" + this.id,
		text : "基本信息",
		selected : true,
		icon : "grid.gif"
	}, {
		id : "lytj_" + this.id,
		text : "路由条件",
		icon : "grid.gif"
	}, {
		id : "lzsj_" + this.id,
		text : "流转事件",
		icon : "grid.gif"
	}, {
		id : "cslz_" + this.id,
		text : "超时流转",
		icon : "grid.gif"
	} ];
};
/**
 * 构建mxCell
 */
MyTransition.prototype.createMxCell = function(tagId) {
	var targetName = this.name.split(" ")[1];
	var mxCell = ComUtils.createElement("mxCell");
	var mxGeometry = ComUtils.createElement("mxGeometry");
	mxCell.setAttribute("id", this.id);
	mxCell.setAttribute("value", "");
	mxCell.setAttribute("edge", "1");
	mxCell.setAttribute("parent", "1");
	mxCell.setAttribute("source", tagId);
	mxCell.setAttribute("target", _myLoadMap.get(targetName).id);

	mxGeometry.setAttribute("relative", "1");
	mxGeometry.setAttribute("as", "geometry");

	mxCell.appendChild(mxGeometry);
	return mxCell;
};
/**
 * 构建processXml中的超时事件部分，子类直接调用
 */
MyTransition.prototype.createTransitionEventXml = function(tagNodeXml) {
	var array = new Array();
	$('#' + this.id).find('#liu_zhuan_shi_jian tr').each(function() {
		if (!$.notNull($(this).find('td').text())) {
			return;
		}
		var str = $(this).find('td')[2].innerHTML;
		var ss = str.split(' ');
		var o = {
			name : $(this).find('td')[0].innerHTML,
			classValue : $(this).find('td')[1].innerHTML,
			array : []
		};
		$.each(ss, function(i, n){
			if($.notNull(n)){
				var field = n.split('=')[0].replace("【", "").replace("】", "");
				var value = n.split('=')[1].replace("【", "").replace("】", "");
				var a = {
						field : field,
						value : value
				};
				o.array.push(a);
			}
		});
		array.push(o);
	});
	
	$.each(array, function(i, n){
		var eventNode = ComUtils.createElement('event-listener');
		eventNode.setAttribute('name', n.name);
		eventNode.setAttribute('class', n.classValue);
		$.each(n.array, function(j, m){
			var o = ComUtils.createElement('field');
			o.setAttribute('name', m.field);
			eventNode.appendChild(o);
			var p = ComUtils.createElement('string');
			p.setAttribute('value', m.value);
			o.appendChild(p);
		});
		tagNodeXml.appendChild(eventNode);
	});
};
/**
 * 加载初始化超时事件区域
 * @param tagNodeXml
 * @param eventDomId
 * @param eventName
 */
MyTransition.prototype.createTransitionEventDom = function(tagNodeXml) {
	var self = this;
	$(tagNodeXml).children("event-listener").each(function(i){
		var name = $(this).attr("name");
		var classValue = $(this).attr("class");
		var text = "";
		$(this).children('field').each(function(){
			var obj = {
				name : $(this).attr("name"),
				value : $(this).children('string').attr("value")
			};
			text += "【" + obj.name + "=" + obj.value + "】 ";
		});
		$("#" + self.id).find("#liu_zhuan_shi_jian").find("tr").eq(i).find("td").eq(0).html($.trim(name));
		$("#" + self.id).find("#liu_zhuan_shi_jian").find("tr").eq(i).find("td").eq(1).html($.trim(classValue));
		$("#" + self.id).find("#liu_zhuan_shi_jian").find("tr").eq(i).find("td").eq(2).html($.trim(text));
	});
};