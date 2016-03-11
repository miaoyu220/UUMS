/**
 * MyBase
 */
function MyBase(id, tagName) {
	this.id = id;// ID,流程的ID为流程的KEY
	this.tagName = tagName;
	this.cell;// 对应mxCell,通过getCell()获取
	this.itemId;// 当前属性内容的ID,当点击属性分项标签时初始化
};
/****************初始化、组装xml入口***************************/
/**
 * 初始化属性信息，新增mxCell时触发，子类重写
 */
MyBase.prototype.init = function() {
};
/**
 * 加载时初始化元素，子类需要重写
 * 
 * @param xmlValue
 * @param rootXml
 */
MyBase.prototype.initLoad = function(xmlValue, rootXml) {
};
/**
 * 基础初始化功能，复制对应dom到相应区域内
 */
MyBase.prototype.initBase = function() {
	var temp = $("#" + this.tagName).clone(true, true);
	temp.attr("id", this.id);
	temp.appendTo(document.body);
	_myPropLayout.appendObject(this.id);
	$("#" + this.id).hide();
	$("#" + this.id).find(".prop_cont").hide();
};
/**
 * 组装processXML,流程子类改写了该方法
 * 
 * @returns
 */
MyBase.prototype.getXmlDoc = function() {
	this.cell = this.getCell();// 重写获取cell,后续操作直接拿this.cell
	var node = ComUtils.createElement(this.tagName);
	this.putAttr("alias", this.alias, node);
	this.putAttr("g", this.getG(), node);
	this.putAttr("name", this.name, node);
	this.getOtherAttr(node);
	return node;
};
/**
 * 自定义扩展,子类需要重写，用于组装processXML时组织非公共部分
 * 
 * @param node
 */
MyBase.prototype.getOtherAttr = function(node) {
};
/************页签相关*****************/
/**
 * 点击mxCell时，显示对应的属性
 */
MyBase.prototype.showProp = function() {
	$(".prop_wrap").hide();
	$("#" + this.id).show();
	_mySidebar.clearAll();
	var item = this.getItem();
	if (item.length == 0) {
		item = [ {
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
		} ];
	}
	_mySidebar.addItem(item);
	if($.notNull(this.itemId)){
		_mySidebar.cells(this.itemId).setActive();
		this.selectProp(this.itemId);
	}else{
		_mySidebar.cells(item[0].id).setActive();
		this.selectProp(item[0].id);
	}
};
/**
 * 自定义属性内容条目，子类可以重写
 * 
 * @returns {Array}
 */
MyBase.prototype.getItem = function() {
	return [];
};
/**
 * 属性分项点击事件后显示对应区域
 * 
 * @param itemId
 */
MyBase.prototype.selectProp = function(itemId) {
	this.itemId = itemId;// 记录当前点击的属性条目
	var arr = itemId.split("_");
	var propId = arr[0];
	$("#" + this.id).find(".prop_cont").hide();
	$("#" + this.id).find("#" + propId).show();
};
/********************方法*****************************/
/**
 * 销毁dom对象
 */
MyBase.prototype.remove = function() {
	$("#" + this.id).remove();
};

/**
 * 获取当前对应的mxCell
 * 
 * @returns
 */
MyBase.prototype.getCell = function() {
	return _editor.graph.getModel().getCell(this.id);
};
/**
 * 解析位置G,连线子类改写了该方法
 * 
 * @returns {String}
 */
MyBase.prototype.getG = function() {
	var mxGeometry = this.cell.getGeometry();
	var g = Math.round(mxGeometry.x) + ",";
	g += Math.round(mxGeometry.y) + ",";
	g += mxGeometry.width + ",";
	g += mxGeometry.height;
	return g;
};
/**
 * 解析字符串G，连线不需要该方法
 * 
 * @returns {object}
 */
MyBase.prototype.getmxCellG = function() {
	var arr = this.g.split(",");
	var result = {};
	result.x = arr[0];
	result.y = arr[1];
	result.width = arr[2];
	result.height = arr[3];
	return result;
};
/**
 * 监听name改变事件，流程子类和连线子类改写了该方法
 * 
 * @param value
 */
MyBase.prototype.labelChanged = function(value) {
	this.alias = value;
	_editor.graph.labelChanged(this.getCell(), value);
};
/**
 * 通过name解析数字，例如end1解析出数字:1
 */
MyBase.prototype.resolve = function() {
	return Number(this.name.replace(this.tagName, ""));
};
/**
 * 初始化基本信息，流程不需要该方法
 */
MyBase.prototype.initJBXX = function() {
	$("#" + this.id).find("#xian_shi_ming_cheng").val($.trim(this.alias));
	$("#" + this.id).find("#luo_ji_biao_shi").val(this.name);
};
/**
 * 构建mxCell,连线子类改写了该方法，流程不需要该方法
 */
MyBase.prototype.createMxCell = function() {
	var mxCellG = this.getmxCellG();
	var mxCell = ComUtils.createElement("mxCell");
	var mxGeometry = ComUtils.createElement("mxGeometry");
	mxCell.setAttribute("id", this.id);
	mxCell.setAttribute("value", $.trim(this.alias));
	mxCell.setAttribute("style", this.style);
	mxCell.setAttribute("tagName", this.tagName);
	mxCell.setAttribute("vertex", "1");
	mxCell.setAttribute("parent", "1");

	mxGeometry.setAttribute("x", mxCellG.x);
	mxGeometry.setAttribute("y", mxCellG.y);
	mxGeometry.setAttribute("width", mxCellG.width);
	mxGeometry.setAttribute("height", mxCellG.height);
	mxGeometry.setAttribute("as", "geometry");

	mxCell.appendChild(mxGeometry);
	return mxCell;
};
/*******************组装xml、解析xml*******************************************/
/**
 * 构建processXml中的event部分，子类直接调用
 */
MyBase.prototype.createEventXml = function(tagNodeXml, eventDomId, eventName) {
	var array = new Array();
	$("#" + this.id).find('#' + eventDomId + ' tr').each(function() {
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
	if (array.length > 0) {
		var node = ComUtils.createElement('on');
		node.setAttribute('event', eventName);
		$.each(array, function(i, n){
			var eventNode = ComUtils.createElement('event-listener');
			eventNode.setAttribute('name', n.name);
			eventNode.setAttribute('class', n.classValue);
			$.each(n.array, function(j, m){
				var fieldNode = ComUtils.createElement('field');
				fieldNode.setAttribute('name', m.field);
				eventNode.appendChild(fieldNode);
				var stringNode = ComUtils.createElement('string');
				stringNode.setAttribute('value', m.value);
				fieldNode.appendChild(stringNode);
			});
			node.appendChild(eventNode);
		});
		tagNodeXml.appendChild(node);
	}
};
/**
 * 加载初始化事件区域
 * @param tagNodeXml
 * @param eventDomId
 * @param eventName
 */
MyBase.prototype.createEventDom = function(tagNodeXml, eventDomId, eventName) {
	var self = this;
	$(tagNodeXml).children("on[event='"+eventName+"']").each(function(){
		$(this).children("event-listener").each(function(i){
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
			
			$("#" + self.id).find("#"+eventDomId).find("tr").eq(i).find("td").eq(0).html($.trim(name));
			$("#" + self.id).find("#"+eventDomId).find("tr").eq(i).find("td").eq(1).html($.trim(classValue));
			$("#" + self.id).find("#"+eventDomId).find("tr").eq(i).find("td").eq(2).html($.trim(text));
		});
	});
};
/**
 * 构建processXml中的超时事件部分，子类直接调用
 */
MyBase.prototype.createTimeEventXml = function(tagNodeXml) {
	var array = new Array();
	$("#" + this.id).find("#chao_shi_shi_jian tr").each(function() {
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
	if (array.length > 0 || this.tagName == "transition") {
		var duedate = $("#" + this.id).find('#chu_fa_gui_ze').val();
		if(!$.notNull(duedate)){
			return;
		}
		var node = ComUtils.createElement('on');
		node.setAttribute('event', "timeout");
		var timerNode = ComUtils.createElement("timer");
		timerNode.setAttribute('duedate', duedate);
		this.putAttr("repeat", $("#" + this.id).find('#chi_xu_shi_jian').val(), timerNode);
		node.appendChild(timerNode);
		$.each(array, function(i, n){
			var eventNode = ComUtils.createElement('event-listener');
			eventNode.setAttribute('name', n.name);
			eventNode.setAttribute('class', n.classValue);
			$.each(n.array, function(j, m){
				var fieldNode = ComUtils.createElement('field');
				fieldNode.setAttribute('name', m.field);
				eventNode.appendChild(fieldNode);
				var stringNode = ComUtils.createElement('string');
				stringNode.setAttribute('value', m.value);
				fieldNode.appendChild(stringNode);
			});
			node.appendChild(eventNode);
		});
		tagNodeXml.appendChild(node);
	}
};
/**
 * 加载初始化超时事件区域
 * @param tagNodeXml
 * @param eventDomId
 * @param eventName
 */
MyBase.prototype.createTimeEventDom = function(tagNodeXml) {
	var self = this;
	$(tagNodeXml).children("on[event='timeout']").each(function(){
		$(this).children("event-listener").each(function(i){
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
			$("#" + self.id).find("#chao_shi_shi_jian").find("tr").eq(i).find("td").eq(0).html($.trim(name));
			$("#" + self.id).find("#chao_shi_shi_jian").find("tr").eq(i).find("td").eq(1).html($.trim(classValue));
			$("#" + self.id).find("#chao_shi_shi_jian").find("tr").eq(i).find("td").eq(2).html($.trim(text));
		});
		$(this).children("timer").each(function(i){
			var duedate = $(this).attr("duedate");
			var repeat = $(this).attr("repeat");
			$("#" + self.id).find('#chu_fa_gui_ze').val($.trim(duedate));
			$("#" + self.id).find('#chi_xu_shi_jian').val($.trim(repeat));
			$("#" + self.id).find("#chao_shi_shi_jian").parents("div").show();
		});
	});
};
/**
 * 构建processXml中的条件部分，子类直接调用
 */
MyBase.prototype.createConditionXml = function(tagNodeXml, eventDomId, typeDomId) {
	var $obj = $('#' + this.id).find('#' + eventDomId + ' tr');
	var array = propUtils.getHtmlListByDom($obj, ["type", "value"]);
	if (array.length > 0) {
		var node = ComUtils.createElement('conditions');
		node.setAttribute('type', $('#' + this.id).find('#' + typeDomId).val());
		$.each(array, function(i, n){
			var conditionNode = ComUtils.createElement('condition');
			conditionNode.setAttribute('type', n.type);
			conditionNode.appendChild(ComUtils.createTextNode("<![CDATA[" + n.value + "]]>"));
			node.appendChild(conditionNode);
		});
		tagNodeXml.appendChild(node);
	}
};
/**
 * 加载初始化条件区域
 * @param tagNodeXml
 * @param eventDomId
 * @param eventName
 */
MyBase.prototype.createConditionDom = function(tagNodeXml, eventDomId, typeDomId) {
	var self = this;
	$(tagNodeXml).children("conditions").each(function(){
		var type = $(this).attr("type");
		$('#' + self.id).find('#' + typeDomId).val(type)
		$(this).children("condition").each(function(i){
			var c_type = $(this).attr("type");
			var value = $(this).text();
			$("#" + self.id).find("#" + eventDomId).find("tr").eq(i).find("td").eq(0).html($.trim(c_type));
			$("#" + self.id).find("#" + eventDomId).find("tr").eq(i).find("td").eq(1).html($.trim(value));
		});
	});
};
/**
 * 方法参数、成员变量组织
 * @param tagNodeXml xml
 * @param domId tbodyDomId
 * @param tagName xmlTagName
 */
MyBase.prototype.createFfcsCyblXml = function(tagNodeXml, domId, tagName) {
	var $obj = $('#' + this.id).find('#' + domId + ' tr');
	var array = propUtils.getHtmlListByDom($obj);
	$.each(array, function(i, n){
		var tag = ComUtils.createElement(tagName);
		tag.setAttribute('name', n.a);
		var type = ComUtils.createElement(n.b);
		type.setAttribute('value', n.c);
		tag.appendChild(type);
		tagNodeXml.appendChild(tag);
	});
};
/**
 * 方法参数、成员变量加载
 * @param tagNodeXml xml
 * @param domId tbodyDomId
 * @param tagName xmlTagName
 */
MyBase.prototype.createFfcsCyblDom = function(tagNodeXml, domId, tagName){
	var self = this;
	$(tagNodeXml).children(tagName).each(function(i){
		var name = $(this).attr("name");
		var type = $(this).children().get(0).tagName;
		var value = $(this).children().attr("value");
		
		$("#" + self.id).find("#" + domId).find("tr").eq(i).find("td").eq(0).html($.trim(name));
		$("#" + self.id).find("#" + domId).find("tr").eq(i).find("td").eq(1).html($.trim(type));
		$("#" + self.id).find("#" + domId).find("tr").eq(i).find("td").eq(2).html($.trim(value));
	});
};
/**
 * 构建权限XML
 * @param tagNodeXml xml
 * @param domId tbodyDomId
 * @param tagName xmlTagName
 */
MyBase.prototype.createQXXml = function(tagNodeXml, checkId, type, name, rootNodeXml) {
	var $checkDom = $('#' + this.id).find('#' + checkId);
	var key=$checkDom.prop('checked');
	if(key){
		var flg_possess = $checkDom.parent().siblings().find('.flg_possess');
		var flg_scope = $checkDom.parent().siblings().find('.flg_scope');
		var flg_preProcessing = $checkDom.parent().siblings().find('.flg_pre-processing');
		var flg_postProcessing = $checkDom.parent().siblings().find('.flg_post-processing');
		if(!$checkDom.parents('tr').next().find('td').eq(0).text()){
			if(flg_possess.length == 0){
				flg_possess = $checkDom.parents('tr').next().find('.flg_possess');
			}
			if(flg_scope.length == 0){
				flg_scope = $checkDom.parents('tr').next().find('.flg_scope');
			}
			if(flg_preProcessing.length == 0){
				flg_preProcessing = $checkDom.parents('tr').next().find('.flg_pre-processing');
			}
			if(flg_postProcessing.length == 0){
				flg_postProcessing = $checkDom.parents('tr').next().find('.flg_post-processing');
			}
		}
		var magic = ComUtils.createElement("magic");
		magic.setAttribute('type', type);
		magic.setAttribute('name', name);
		var possess = ComUtils.createElement("possess");
		var scope = ComUtils.createElement("scope");
		var preProcessing = ComUtils.createElement("pre-processing");
		var postProcessing = ComUtils.createElement("post-processing");
		
		var ownerId = flg_possess.attr("actorsId");
		if($.notNull(ownerId)){
			possess.setAttribute('owner', ownerId);
			this.createActorsXml(rootNodeXml, ownerId);
		}else{
			possess.setAttribute('owner', "");
		}
		var selectId = flg_scope.attr("actorsId");
		if($.notNull(selectId)){
			scope.setAttribute('select', selectId);
			this.createActorsXml(rootNodeXml, selectId);
		}else{
			scope.setAttribute('select', "");
		}
		
		var preAlias = "";
		var preName = "";
		if($.notNull(flg_preProcessing.val())){
			preAlias = $.trim(flg_preProcessing.val().split("【")[0]);
			preName = $.trim(flg_preProcessing.val().split("【")[1]).replace("】", "");
		}
		preProcessing.setAttribute('class', preName);
		preProcessing.appendChild(ComUtils.createTextNode(preAlias));
		
		var postAlias = "";
		var postName = "";
		if($.notNull(flg_postProcessing.val())){
			postAlias = $.trim(flg_postProcessing.val().split("【")[0]);
			postName = $.trim(flg_postProcessing.val().split("【")[1]).replace("】", "");
		}
		postProcessing.setAttribute('class', postName);
		postProcessing.appendChild(ComUtils.createTextNode(postAlias));
		
		magic.appendChild(possess);
		magic.appendChild(scope);
		magic.appendChild(preProcessing);
		magic.appendChild(postProcessing);
		tagNodeXml.appendChild(magic);
	}
};
/**
 * 权限加载
 * @param tagNodeXml xml
 * @param domId tbodyDomId
 * @param tagName xmlTagName
 */
MyBase.prototype.createQXDom = function(tagNodeXml, checkId, type){
	var self = this;
	$(tagNodeXml).children("magics").children("magic[type='" + type + "']").each(function(){
		var $checkDom = $('#' + self.id).find('#' + checkId);
		var ownerId = $(this).find("possess").attr("owner");
		var selectId = $(this).find("scope").attr("select");
		
		if($.notNull(ownerId)){
			$checkDom.parent().siblings().find('.flg_possess').attr("actorsId", ownerId);
			$checkDom.parent().siblings().find('.flg_possess').val(actorFactory.getActorsTextById(ownerId));
			if(!$checkDom.parents('tr').next().find('td').eq(0).text()){
				$checkDom.parents('tr').next().find('.flg_possess').attr("actorsId", ownerId);
				$checkDom.parents('tr').next().find('.flg_possess').val(actorFactory.getActorsTextById(ownerId));
			}
		}
		if($.notNull(selectId)){
			$checkDom.parent().siblings().find('.flg_scope').attr("actorsId", selectId);
			$checkDom.parent().siblings().find('.flg_scope').val(actorFactory.getActorsTextById(selectId));
			if(!$checkDom.parents('tr').next().find('td').eq(0).text()){
				$checkDom.parents('tr').next().find('.flg_scope').attr("actorsId", selectId);
				$checkDom.parents('tr').next().find('.flg_scope').val(actorFactory.getActorsTextById(selectId));
			}
		}
		
		var preProcessing  = $(this).find("pre-processing").attr("class");
		var postProcessing  = $(this).find("post-processing").attr("class");
		var preProcessingText  = $(this).find("pre-processing").text();
		var postProcessingText  = $(this).find("post-processing").text();
		
		if($.notNull(preProcessing)){
			$checkDom.parent().siblings().find('.flg_pre-processing').val(preProcessingText + "【" + preProcessing + "】");
			if(!$checkDom.parents('tr').next().find('td').eq(0).text()){
				$checkDom.parents('tr').next().find('.flg_pre-processing').val(preProcessingText + "【" + preProcessing + "】");
			}
		}
		
		if($.notNull(postProcessing)){
			$checkDom.parent().siblings().find('.flg_post-processing').val(postProcessing + "【" + postProcessingText + "】");
			if(!$checkDom.parents('tr').next().find('td').eq(0).text()){
				$checkDom.parents('tr').next().find('.flg_post-processing').val(postProcessing + "【" + postProcessingText + "】");
			}
		}
		
		$checkDom.trigger('click');
	});
};
/**
 * 创建actors
 * @param tagNodeXml
 * @param id
 */
MyBase.prototype.createActorsXml = function(tagNodeXml, id){
	var self = this;
	var actors = ComUtils.createElement("actors");
	actors.setAttribute("id", id);
	$.each(actorFactory.getActorsById(id), function(i, n){
		var actor = ComUtils.createElement("actor");
		actor.setAttribute("type", n.type);
		var idNode = ComUtils.createElement("id");
		idNode.appendChild(ComUtils.createTextNode(n.id));
		var nameNode = ComUtils.createElement("name");
		nameNode.appendChild(ComUtils.createTextNode(n.name));
		actor.appendChild(idNode);
		actor.appendChild(nameNode);
		if($.notNull(n.position)){
			self.createActorsXmlCircle(actor, "position", n.position.id, n.position.name);
		}
		if($.notNull(n.deptlevel)){
			self.createActorsXmlCircle(actor, "deptlevel", n.deptlevel.id, n.deptlevel.name);
		}
		if($.notNull(n.customfunction)){
			self.createActorsXmlCircle(actor, "customfunction", n.customfunction.id, n.customfunction.name);
		}
		if($.notNull(n.variable)){
			self.createActorsXmlCircle(actor, "variable", n.variable.id, n.variable.name);
		}
		if($.notNull(n.variableType)){
			self.createActorsXmlCircle(actor, "type", n.variableType.id, n.variableType.name);
		}
		if($.notNull(n.step)){
			self.createActorsXmlCircle(actor, "step", n.step.id, n.step.name);
		}
		// TO DO 未完待续脚本选人
		actors.appendChild(actor);
	});
	tagNodeXml.appendChild(actors);
};
/**
 * 生成actorxml
 * @param actor
 * @param eleName
 * @param id
 * @param name
 */
MyBase.prototype.createActorsXmlCircle = function(actor, eleName, id, name){
	var eleNode = ComUtils.createElement(eleName);
	var idNode = ComUtils.createElement("id");
	idNode.appendChild(ComUtils.createTextNode(id));
	var nameNode = ComUtils.createElement("name");
	nameNode.appendChild(ComUtils.createTextNode("<![CDATA[" + name + "]]>"));
	eleNode.appendChild(idNode);
	eleNode.appendChild(nameNode);
	actor.appendChild(eleNode);
};
/**
 * 创建actors
 * @param tagNodeXml
 * @param id
 */
MyBase.prototype.createActorsDom = function(tagNodeXml){
	$(tagNodeXml).children("actors").each(function(){
		var id = $(this).attr("id");
		$(this).children("actor").each(function(){
			var type = $(this).attr("type");
			var actorId = $(this).find("id").eq(0).text();
			var actorName = $(this).find("name").eq(0).text();
			var actor = actorFactory.createActor(type, actorId, actorName);
			actorFactory.addActor(id, actor);
			$(this).children("position").each(function(){
				var positionId = $(this).find("id").eq(0).text();
				var positionName = $(this).find("name").eq(0).text();
				actorFactory.addPosition(actor, positionId, positionName);
			});
			
			$(this).children("deptlevel").each(function(){
				var deptlevelId = $(this).find("id").eq(0).text();
				var deptlevelName = $(this).find("name").eq(0).text();
				actorFactory.addDeptlevel(actor, deptlevelId, deptlevelName);
			});
			
			$(this).children("customfunction").each(function(){
				var customfunctionId = $(this).find("id").eq(0).text();
				var customfunctionName = $(this).find("name").eq(0).text();
				actorFactory.addCustomfunction(actor, customfunctionId, customfunctionName);
			});
			
			$(this).children("variable").each(function(){
				var variableId = $(this).find("id").eq(0).text();
				var variableName = $(this).find("name").eq(0).text();
				actorFactory.addVariable(actor, variableId, variableName);
			});
			
			$(this).children("type").each(function(){
				var variableTypeId = $(this).find("id").eq(0).text();
				var variableTypeName = $(this).find("name").eq(0).text();
				actorFactory.addVariableType(actor, variableTypeId, variableTypeName);
			});
			
			$(this).children("step").each(function(){
				var stepId = $(this).find("id").eq(0).text();
				var stepName = $(this).find("name").eq(0).text();
				actorFactory.addStep(actor, stepId, stepName);
			});
			// TO DO 未完待续脚本选人
		});
	});
};
/**********整理一下其他基本方法****************************/
/**
 * 往tagNodeXml中添加对应key-value,value进行空值判断
 * 
 * @param attrName
 * @param attrValue
 * @param tagNodeXml
 */
MyBase.prototype.putAttr = function(attrName, attrValue, tagNodeXml) {
	if($.notNull(attrValue)){
		tagNodeXml.setAttribute(attrName, attrValue);
	}
};
/**
 * 从tagNodeXml中取出指定attrName的值
 * 
 * @param tagNodeXml
 * @param attrName
 */
MyBase.prototype.getAttr = function(tagNodeXml, attrName) {
	return $.trim(tagNodeXml.getAttribute(attrName));
};
/**
 * 创建节点meta添加到知道tagNodeXml中
 * @param metaName
 * @param metaValue
 * @param tagNodeXml
 */
MyBase.prototype.addMeta = function(metaName, metaValue, tagNodeXml) {
	if($.notNull(metaValue)){
		var meta = ComUtils.createElement("meta");
		meta.setAttribute("name", metaName);
		meta.appendChild(ComUtils.createTextNode(metaValue));
		tagNodeXml.appendChild(meta);
	}
};
/**
 * 解析得到制定meta的值
 * @param tagNodeXml
 * @param metaName
 */
MyBase.prototype.getMeta = function(tagNodeXml, metaName) {
	return $.trim($(tagNodeXml).children("meta[name='"+metaName+"']").text());
};
/*********************setxml********************************/
/**
 * 设置xml的attr,取值为dom的value
 * @param domId
 * @param tagNodeXml
 * @param attrName
 */
MyBase.prototype.setXmlAttrByVal = function(domId, tagNodeXml, attrName) {
	this.putAttr(attrName, $("#" + this.id).find("#" + domId).val(), tagNodeXml);
};
/**
 * 设置xml的meta,取值为dom的value
 * @param domId
 * @param tagNodeXml
 * @param metaName
 */
MyBase.prototype.setXmlMetaByVal = function(domId, tagNodeXml, metaName) {
	this.addMeta(metaName, $("#" + this.id).find("#" + domId).val(), tagNodeXml);
};
/**
 * 设置xml的attr,取值为dom对象(check radio)
 * @param domName
 * @param tagNodeXml
 * @param attrName
 */
MyBase.prototype.setXmlAttrByCheck = function(domName, tagNodeXml, attrName) {
	this.putAttr(attrName, $("#" + this.id).find("input[name='" + domName + "']:checked").val(), tagNodeXml);
};
/**
 * 设置xml的meta,取值为dom对象(check radio)
 * @param domName
 * @param tagNodeXml
 * @param metaName
 */
MyBase.prototype.setXmlMetaByCheck = function(domName, tagNodeXml, metaName) {
	this.addMeta(metaName, $("#" + this.id).find("input[name='" + domName + "']:checked").val(), tagNodeXml);
};
/**
 * 设置xml的attr,取值为dom对象(prop)
 * @param domId
 * @param tagNodeXml
 * @param attrName
 * @param domProp
 */
MyBase.prototype.setXmlAttrByProp = function(domId, tagNodeXml, attrName, domProp) {
	this.putAttr(attrName, $("#" + this.id).find("#" + domId).attr(domProp), tagNodeXml);
};
/**
 * 设置xml的meta,取值为dom对象(prop)
 * @param domId
 * @param tagNodeXml
 * @param metaName
 * @param domProp
 */
MyBase.prototype.setXmlMetaByProp = function(domId, tagNodeXml, metaName, domProp) {
	this.addMeta(metaName, $("#" + this.id).find("#" + domId).attr(domProp), tagNodeXml);
};
/************************setDom******************************/
/**
 * 设置dom对象的value,取值为xml的attr
 * @param domId
 * @param tagNodeXml
 * @param attrName
 */
MyBase.prototype.setDomValByAttr = function(domId, tagNodeXml, attrName) {
	$("#" + this.id).find("#" + domId).val(this.getAttr(tagNodeXml, attrName));
};
/**
 * 设置dom对象的value,取值为xml的meta
 * @param domId
 * @param tagNodeXml
 * @param metaName
 */
MyBase.prototype.setDomValByMeta = function(domId, tagNodeXml, metaName) {
	$("#" + this.id).find("#" + domId).val(this.getMeta(tagNodeXml, metaName));
};
/**
 * 设置dom对象(check radio),取值为xml的attr
 * @param domId
 * @param tagNodeXml
 * @param attrName
 * @param domValue
 */
MyBase.prototype.setDomCheckByAttr = function(domId, tagNodeXml, attrName, domValue) {
	var attrValue = this.getAttr(tagNodeXml, attrName);
	if(attrValue == domValue){
		$("#" + this.id).find("#" + domId).attr("checked", true);
		$("#" + this.id).find("#" + domId).trigger('click');
	}
};
/**
 * 设置dom对象(check radio),取值为xml的meta
 * @param domId
 * @param tagNodeXml
 * @param metaName
 * @param domValue
 */
MyBase.prototype.setDomCheckByMeta = function(domId, tagNodeXml, metaName, domValue) {
	var metaValue = this.getMeta(tagNodeXml, metaName);
	if(metaValue == domValue){
		$("#" + this.id).find("#" + domId).attr("checked", true);
		$("#" + this.id).find("#" + domId).trigger('click');
	}
};
/**
 * 设置dom对象(自定义属性),取值为xml的attr
 * @param domId
 * @param tagNodeXml
 * @param attrName
 * @param domProp
 */
MyBase.prototype.setDomPropByAttr = function(domId, tagNodeXml, attrName, domProp) {
	var attrValue = this.getAttr(tagNodeXml, attrName);
	if($.notNull(attrValue)){
		$("#" + this.id).find("#" + domId).attr(domProp, attrValue);
	}
};
/**
 * 设置dom对象(自定义属性),取值为xml的meta
 * @param domId
 * @param tagNodeXml
 * @param metaName
 * @param domProp
 */
MyBase.prototype.setDomPropByMeta = function(domId, tagNodeXml, metaName, domProp) {
	var metaValue = this.getMeta(tagNodeXml, metaName);
	if($.notNull(metaValue)){
		$("#" + this.id).find("#" + domId).attr(domProp, metaValue);
	}
};