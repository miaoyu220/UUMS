/**
 * 函数
 */
function MyAction() {
};
/**
 * 添加元件事件
 * 
 * @param cells
 */
MyAction.prototype.addCells = function(cells) {
	var removeCells = [];
	if ($.notNull(cells)) {
		for (var i = 0; i < cells.length; i++) {
			var cell = cells[i];
			if (cell.edge) {
				if (cell.source.tagName == "end") {
					removeCells.push(cell);
					dhtmlxUtils.message("结束节点不能作为起点");
					continue;
				} else if (cell.target.tagName == "start") {
					removeCells.push(cell);
					dhtmlxUtils.message("开始节点不能作为终点");
					continue;
				}
			} else if (cell.vertex && cell.tagName == "start") {
				var values = _myCellMap.values();
				var flg = false;
				for (var i = 0; i < values.length; i++) {
					if (values[i].tagName == "start") {
						removeCells.push(cell);
						dhtmlxUtils.message("不能添加多个开始节点");
						flg = true;
						break;
					}
				}
				if (flg) {
					continue;
				}
			}
			var nodeBase = _myAction.createBaseByTagName(cell.tagName, cell.id,
					cell.vertex, cell.edge);
			nodeBase.init();
			_myCellMap.put(cell.id, nodeBase);
		}
	}
	_editor.graph.removeCells(removeCells);
};
/**
 * 删除元件事件
 * 
 * @param cells
 */
MyAction.prototype.removeCells = function(cells) {
	if ($.notNull(cells) && cells.length > 0) {
		for (var i = 0; i < cells.length; i++) {
			var cell = cells[i];
			if (_myCellMap.containsKey(cell.id)) {
				_myCellMap.get(cell.id).remove();
				_myCellMap.remove(cell.id);
			}
		}
		if (_processKey != _myCurCellId) {
			_myCellMap.get(_processKey).showProp();
			_myCurCellId = _processKey;
		}
	}
};
/**
 * 执行选中节点显示
 * 
 * @param cell
 */
MyAction.prototype.showSelectedCell = function(cells) {
	var cells = _editor.graph.getSelectionCells();
	var id;
	if ($.notNull(cells) && $.notNull(cells[0])
			&& _myCellMap.containsKey(cells[0].id)) {
		id = cells[0].id;
	} else {
		id = _processKey;
	}
	if (id != _myCurCellId) {
		_myCellMap.get(id).showProp();
		_myCurCellId = id;
	}

};
/**
 * 构建graph文件
 * 
 * @returns
 */
MyAction.prototype.showGraph = function() {
	var enc = new mxCodec(mxUtils.createXmlDocument());
	var node = enc.encode(_editor.graph.getModel());
	return mxUtils.getPrettyXml(node);
};
/**
 * 构建process文件
 * 
 * @returns
 */
MyAction.prototype.showProcess = function() {
	var process = _myCellMap.get(_processKey).getXmlDoc();
	var transitionMap = new Map();
	var values = _myCellMap.values();
	for (var i = 0; i < values.length; i++) {
		var baseNode = values[i];
		if (baseNode.tagName == "transition") {
			var sourceId = baseNode.getCell().source.id;
			if (transitionMap.containsKey(sourceId)) {
				transitionMap.get(sourceId).push(baseNode.getXmlDoc());
			} else {
				var transitionArr = new Array();
				transitionArr.push(baseNode.getXmlDoc());
				transitionMap.put(sourceId, transitionArr);
			}
		}
	}
	for (var i = 0; i < values.length; i++) {
		var baseNode = values[i];
		if (baseNode.tagName != "process" && baseNode.tagName != "transition") {
			var node = baseNode.getXmlDoc();
			if (transitionMap.containsKey(baseNode.id)) {
				var transitionArr = transitionMap.get(baseNode.id);
				for (j = 0; j < transitionArr.length; j++) {
					node.appendChild(transitionArr[j]);
				}
			}
			process.appendChild(node);
		}
	}
	return ComUtils.getPrettyXml(process)
};
/**
 * 构建processPng并显示
 * 
 * @returns
 */
MyAction.prototype.showPng = function() {
	mxUtils.show(_editor.graph, null, 10, 10);
};
/**
 * 对齐
 * @param align
 */
MyAction.prototype.alignCells = function(align) {
	_editor.graph.alignCells(align);
};
/**
 * 等宽
 */
MyAction.prototype.comWidth = function() {
	var cells = _editor.graph.getSelectionCells();
	if($.notNull(cells)){
		var o = {};
		var vCells = new Map();
		for(var i = 0; i < cells.length; i++){
			if(cells[i].vertex){
				var x = Number(cells[i].getGeometry().x);
				vCells.put(x, cells[i]);
				if(!$.notNull(o.minx) || o.minx > x){
					o.minx = x;
				}
				if(!$.notNull(o.maxx) || o.maxx < x){
					o.maxx = x;
				}
			}
		}
		if(vCells.size() > 1){
			var w = (o.maxx - o.minx) / (vCells.size() - 1);
			var keys = vCells.keys();
			keys = keys.sort(function(a,b){return a-b;})
			for(var i = 0; i < keys.length; i++){
				_editor.graph.moveCells([vCells.get(keys[i])], (o.minx + w*i) - Number(keys[i]), 0);
				vCells.remove(keys[i]);
			}
		}
	}
};
/**
 * 等高
 */
MyAction.prototype.comHeight = function() {
	var cells = _editor.graph.getSelectionCells();
	if($.notNull(cells)){
		var o = {};
		var vCells = new Map();
		for(var i = 0; i < cells.length; i++){
			if(cells[i].vertex){
				var y = Number(cells[i].getGeometry().y);
				vCells.put(y, cells[i]);
				if(!$.notNull(o.miny) || o.miny > y){
					o.miny = y;
				}
				if(!$.notNull(o.maxy) || o.maxy < y){
					o.maxy = y;
				}
			}
		}
		if(vCells.size() > 1){
			var h = (o.maxy - o.miny) / (vCells.size() - 1);
			var keys = vCells.keys();
			keys = keys.sort(function(a,b){return a-b;})
			for(var i = 0; i < keys.length; i++){
				_editor.graph.moveCells([vCells.get(keys[i])], 0, (o.miny + h*i) - Number(keys[i]));
				vCells.remove(keys[i]);
			}
		}
	}
};
/**
 * 获取流程名称
 * 
 * @returns
 */
MyAction.prototype.getFlowName = function() {
	return _myCellMap.get(_processKey).alias;
};
/**
 * 获取保存数据
 * 
 * @returns
 */
MyAction.prototype.getSaveData = function() {
	var flow_xml = _myAction.showProcess();
	var png_xml = _myAction.getImageXml();

	var bounds = _editor.graph.getGraphBounds();
	var w = Math.round(bounds.x + bounds.width + 4);
	var h = Math.round(bounds.y + bounds.height + 4);

	var flowName = _myAction.getFlowName();
	var flowKey = _processKey;
	var flowDesc = "";

	var postData = {};
	postData.flowName = flowName;
	postData.flowKey = flowKey;
	postData.flowDesc = flowDesc;
	postData.flow_xml = flow_xml;
	postData.png_xml = png_xml;
	postData.id = _id;
	postData.w = w;
	postData.h = h;
	return postData;
};
/**
 * 创建ImageXml
 * 
 * @returns
 */
MyAction.prototype.getImageXml = function() {
	var root = ComUtils.createElement("output");
	var xmlCanvas = new mxXmlCanvas2D(root);
	xmlCanvas.getConverter().setBaseUrl(_basePath);
	var imgExport = new mxImageExport();
	imgExport.drawState(_editor.graph.getView().getState(
			_editor.graph.model.root), xmlCanvas);
	return mxUtils.getPrettyXml(root);
};
/**
 * 创建元素对象
 * 
 * @returns
 */
MyAction.prototype.createBaseByTagName = function(tagName, id, vertex, edge) {
	var baseNode = null;
	if (vertex) {
		if (tagName == "start") {
			baseNode = new MyStart(id);
		} else if (tagName == "end") {
			baseNode = new MyEnd(id);
		} else if (tagName == "task") {
			baseNode = new MyTask(id);
		} else if (tagName == "java") {
			baseNode = new MyJava(id);
		} else if (tagName == "sql") {
			baseNode = new MySql(id);
		} else if (tagName == "ws") {
			baseNode = new MyWs(id);
		} else if (tagName == "state") {
			baseNode = new MyState(id);
		} else if (tagName == "fork") {
			baseNode = new MyFork(id);
		} else if (tagName == "join") {
			baseNode = new MyJoin(id);
		} else if (tagName == "decision") {
			baseNode = new MyExclusive(id);
		} else if (tagName == "sub-process") {
			baseNode = new MySubprocess(id);
		} else if (tagName == "foreach") {
			baseNode = new MyForeach(id);
		} else if (tagName == "jms") {
			baseNode = new MyJms(id);
		} else if (tagName == "custom") {
			baseNode = new MyCustom(id);
		} 
	} else if (edge) {
		baseNode = new MyTransition(id);
	}
	return baseNode;
};
/**
 * 循环各个元素进行转换
 */
MyAction.prototype.cycleTags = function(tagName, process, rootXml,
		transitionArr) {
	var tags = process.getElementsByTagName(tagName);
	for (var i = 0; i < tags.length; i++) {
		var tagId = _countUtils.getSelfId();
		var tagNode = _myAction.createBaseByTagName(tagName, tagId, 1, 0);
		tagNode.initLoad(tags[i], rootXml);
		_myCellMap.put(tagId, tagNode);
		var transitions = tags[i].getElementsByTagName("transition");
		for (var j = 0; j < transitions.length; j++) {
			var transitionObject = {};
			transitionObject.xml = transitions[j];
			transitionObject.sourceId = tagId;
			transitionArr.push(transitionObject);
		}
	}
};
/**
 * 循环各个元素进行转换
 */
MyAction.prototype.converToGraphXml = function(data) {
	// process
	var process = data.getElementsByTagName("process")[0];
	_processKey = process.getAttribute("key");
	var myProcess = new MyProcess(_processKey);
	myProcess.initLoad(process);
	_myCellMap.put(_processKey, myProcess);

	var graphXml = ComUtils.createElement("mxGraphModel");
	var rootXml = ComUtils.createElement("root");
	var mxCell0 = ComUtils.createElement("mxCell");
	mxCell0.setAttribute("id", "0");
	rootXml.appendChild(mxCell0);
	var mxCell1 = ComUtils.createElement("mxCell");
	mxCell1.setAttribute("id", "1");
	mxCell1.setAttribute("parent", "0");
	rootXml.appendChild(mxCell1);

	var transitionArr = new Array();// 先循环节点，连线只是存储，最后再执行连线初始化，因为连线需要寻找target，即目标节点
	_myAction.cycleTags("start", process, rootXml, transitionArr);
	_myAction.cycleTags("end", process, rootXml, transitionArr);
	_myAction.cycleTags("task", process, rootXml, transitionArr);
	_myAction.cycleTags("java", process, rootXml, transitionArr);
	_myAction.cycleTags("sql", process, rootXml, transitionArr);
	_myAction.cycleTags("ws", process, rootXml, transitionArr);
	_myAction.cycleTags("state", process, rootXml, transitionArr);
	_myAction.cycleTags("fork", process, rootXml, transitionArr);
	_myAction.cycleTags("join", process, rootXml, transitionArr);
	_myAction.cycleTags("decision", process, rootXml, transitionArr);
	_myAction.cycleTags("sub-process", process, rootXml, transitionArr);
	_myAction.cycleTags("foreach", process, rootXml, transitionArr);
	_myAction.cycleTags("jms", process, rootXml, transitionArr);
	_myAction.cycleTags("custom", process, rootXml, transitionArr);
	for (var i = 0; i < transitionArr.length; i++) {
		var transitionId = _countUtils.getSelfId();
		var transitionNode = new MyTransition(transitionId);
		transitionNode.initLoad(transitionArr[i].xml, rootXml,
				transitionArr[i].sourceId);
		_myCellMap.put(transitionId, transitionNode);
	}

	graphXml.appendChild(rootXml);
	return mxUtils.getPrettyXml(graphXml);
};