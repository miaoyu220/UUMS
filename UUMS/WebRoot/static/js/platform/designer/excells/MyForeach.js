/**
 * foreach extends MyBase
 */
function MyForeach(id) {
	MyBase.call(this, id, "foreach");
	this.style = "image;image=static/js/platform/designer/images/48/gateway_foreach.png;";
};
MyForeach.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MyForeach.prototype.init = function() {
	this.initBase();
	this.name = this.tagName + _countUtils.getForeach();
	this.labelChanged(this.name);
	this.initJBXX();// 初始化基本信息
};
/**
 * 加载时初始化元素信息
 * 
 * @param xmlValue
 * @param rootXml
 */
MyForeach.prototype.initLoad = function(xmlValue, rootXml) {
	this.initBase();
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	_countUtils.setForeach(this.resolve());// 设置自增长数字
	this.initJBXX();// 初始化基本信息
	/*****以上是公共的*******/
	//首先解析人员信息
	this.createActorsDom(xmlValue);
	this.setDomValByAttr("bian_liang", xmlValue, "var");
	var isMustUser = this.getMeta(xmlValue, "isMustUser");
	if(isMustUser == "yes"){
		this.setDomCheckByMeta("xrfs_zd", xmlValue, "userSelectType", "auto");
		this.setDomValByMeta("userGroupBy", xmlValue, "userGroupBy");
		var candidateUsers = this.getAttr(xmlValue, "candidate-users");
		if($.notNull(candidateUsers)){
			$("#" + this.id).find("#candidateUsers").val(actorFactory.getActorsTextById(candidateUsers));
			$("#" + this.id).find("#candidateUsers").attr("actorsId", candidateUsers);
		}
		$("#" + this.id).find("#bxxr_yes").attr("checked", true);
		$("#" + this.id).find("#bxxr_yes").trigger('click');
	}else{
		this.setDomValByAttr("ji_he", xmlValue, "in");
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
MyForeach.prototype.getOtherAttr = function(node) {
	//基本信息
	this.setXmlAttrByVal("bian_liang", node, "var");
	var isMustUser = $("#" + this.id).find("input[name='isMustUser']:checked").val();
	this.addMeta("isMustUser", isMustUser, node);
	if(isMustUser == "yes"){
		this.setXmlMetaByCheck("userSelectType", node, "userSelectType");
		this.setXmlMetaByVal("userGroupBy", node, "userGroupBy");
		var candidateUsers = $("#" + this.id).find("#candidateUsers").attr("actorsId");
		if($.notNull(candidateUsers)){
			this.putAttr("candidate-users", candidateUsers, node);
			this.createActorsXml(node, candidateUsers);
		}
	}else{
		this.setXmlAttrByVal("ji_he", node, "in");
	}
	this.createEventXml(node, "qian_zhi_shi_jian", "start");//event
	this.createEventXml(node, "hou_zhi_shi_jian", "end");//event
};