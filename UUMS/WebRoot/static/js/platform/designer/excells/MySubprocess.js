/**
 * sub-process extends MyBase
 */
function MySubprocess(id) {
	MyBase.call(this, id, "sub-process");
	this.style = "image;image=static/js/platform/designer/images/48/task_subprocess.png;";
};
MySubprocess.prototype = new MyBase();
/**
 * 初始化属性信息
 */
MySubprocess.prototype.init = function() {
	this.initBase();
	this.name = "Subprocess" + _countUtils.getSubprocess();
	this.labelChanged(this.name);
	this.initJBXX();// 初始化基本信息
};
/**
 * 加载时初始化元素信息
 * 
 * @param xmlValue
 * @param rootXml
 */
MySubprocess.prototype.initLoad = function(xmlValue, rootXml) {
	this.initBase();
	this.name = xmlValue.getAttribute("name");
	this.alias = $.trim(xmlValue.getAttribute("alias"));
	this.g = xmlValue.getAttribute("g");
	_countUtils.setSubprocess(this.resolve());// 设置自增长数字
	this.initJBXX();// 初始化基本信息
	/*****以上是公共的*******/
	//首先解析人员信息
	this.createActorsDom(xmlValue);
	this.setDomPropByAttr("zi_liu_cheng_ming", xmlValue, "sub-process-key", "userData");
	this.setDomValByAttr("zi_liu_cheng_ming", xmlValue, "sub-process-name");
	this.setDomValByAttr("liu_zhuan_mu_biao", xmlValue, "outcome");
	this.setDomCheckByMeta("sftb_no", xmlValue, "asynchronous", "true");
	var isMustUser = this.getMeta(xmlValue, "isMustUser");
	if(isMustUser == "yes"){
		$("#" + this.id).find("#zlcxr_yes").attr("checked", true);
		$("#" + this.id).find("#zlcxr_yes").trigger('click');
		this.setDomCheckByMeta("xrfs_no", xmlValue, "userSelectType", "auto");
		var candidateUsers = this.getAttr(xmlValue, "candidate-users");
		if($.notNull(candidateUsers)){
			$("#" + this.id).find("#hou_xuan_ren_yuan").attr("actorsId", candidateUsers);
			$("#" + this.id).find("#hou_xuan_ren_yuan").val(actorFactory.getActorsTextById(candidateUsers));
		}
	}
	var self = this;
	$(xmlValue).children("parameter-in").each(function(i){
		$("#" + self.id).find("#zhu_chuan_zi_can_shu").find("tr").eq(i).find("td").eq(0).html($.trim($(this).attr("var")));
		$("#" + self.id).find("#zhu_chuan_zi_can_shu").find("tr").eq(i).find("td").eq(1).html($.trim($(this).attr("subvar")));
	});
	$(xmlValue).children("parameter-out").each(function(i){
		$("#" + self.id).find("#zi_chuan_zhu_can_shu").find("tr").eq(i).find("td").eq(0).html($.trim($(this).attr("subvar")));
		$("#" + self.id).find("#zi_chuan_zhu_can_shu").find("tr").eq(i).find("td").eq(1).html($.trim($(this).attr("var")));
	});
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
MySubprocess.prototype.getOtherAttr = function(node) {
	//基本信息
	this.setXmlAttrByProp("zi_liu_cheng_ming", node, "sub-process-key", "userData");
	this.setXmlAttrByVal("zi_liu_cheng_ming", node, "sub-process-name");
	this.setXmlAttrByVal("liu_zhuan_mu_biao", node, "outcome");
	this.setXmlMetaByCheck("shi_fou_tong_bu", node, "asynchronous");
	var isMustUser = $("#" + this.id).find("input[name='zi_liu_cheng_xuan_ren']:checked").val();
	this.addMeta("isMustUser", isMustUser, node);
	if(isMustUser == "yes"){
		this.setXmlMetaByCheck("xuan_ren_fang_shi", node, "userSelectType");
		var candidateUsers = $("#" + this.id).find("#hou_xuan_ren_yuan").attr("actorsId");
		if($.notNull(candidateUsers)){
			this.putAttr("candidate-users", candidateUsers, node);
			this.createActorsXml(node, candidateUsers);
		}
	}
	var $obj = $('#' + this.id).find('#zhu_chuan_zi_can_shu tr');
	var array = propUtils.getHtmlListByDom($obj);
	$.each(array, function(i, n){
		var tag = ComUtils.createElement("parameter-in");
		tag.setAttribute('subvar', n.b);
		tag.setAttribute('var', n.a);
		node.appendChild(tag);
	});
	$obj = $('#' + this.id).find('#zi_chuan_zhu_can_shu tr');
	array = propUtils.getHtmlListByDom($obj);
	$.each(array, function(i, n){
		var tag = ComUtils.createElement("parameter-out");
		tag.setAttribute('subvar', n.a);
		tag.setAttribute('var', n.b);
		node.appendChild(tag);
	});
	this.createEventXml(node, "qian_zhi_shi_jian", "start");
	this.createEventXml(node, "hou_zhi_shi_jian", "end");
};
/**
 * 通过name解析数字，例如end1解析出数字:1
 */
MySubprocess.prototype.resolve = function() {
	return Number(this.name.replace("Subprocess", ""));
};