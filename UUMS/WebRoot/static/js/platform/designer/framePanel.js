var _myLayout;// 布局
var _editor;// _editor
var _myAction;// 函数
var _myPropLayout;// 属性区域
var _mySidebar;// 属性导航
var _myCurCellId;// 当前对象ID
var _myCellMap;// 对象Map
var _processKey;// 流程key
var _countUtils;// 自增长数值管理
var _myLoadMap;// 加载时用到的变量，存放以name为key的元素对象
var _maxHeight;
var _userHeight;
$(function() {
	_maxHeight = $(document).height();
	_userHeight = $(document).height();
	if(_maxHeight > 400){
		_maxHeight = 400;
	}
	if(_userHeight > 460){
		_userHeight = 460;
	}
	// 重写mxClient弹出框样式
	mxUtils.alert = function(message) {
		dhtmlxUtils.message(message);
	};
	// 函数
	_myAction = new MyAction();
	// 对象Map
	_myCellMap = new Map();
	// map
	_myLoadMap = new Map();
	// 自增长数值管理
	_countUtils = new countUtils();
	// 布局
	_myLayout = new dhtmlXLayoutObject({
		parent : document.body,
		pattern : "3L"
	});
	_myLayout.cells("a").setText("组件");
	_myLayout.cells("a").setWidth(120);
	_myLayout.cells("a").attachObject("toolbar");
	_myLayout.cells("a").showInnerScroll();
	_myLayout.cells("b").hideHeader();
	_myLayout.cells("b").attachObject("graph");
	_myLayout.cells("b").showInnerScroll();
	_myLayout.cells("c").setText("属性");
	_myLayout.cells("c").setHeight(200);
	var propLayout = _myLayout.cells("c").attachLayout({
		pattern : "2U"
	});
	_mySidebar = propLayout.cells("a").attachSidebar({
		icons_path : _iconPath,
		width : 100
	});
	_mySidebar.attachEvent("onSelect", function(id, lastId) {
		_myCellMap.get(_myCurCellId).selectProp(id);
	});
	propLayout.cells("a").hideHeader();
	propLayout.cells("a").setWidth(100);
	propLayout.cells("a").fixSize(true, false);
	propLayout.cells("b").hideHeader();
	_myLayout.cells("c").showHeader();
	_myPropLayout = propLayout.cells("b");
	// _editor
	_editor = new mxApplication(_designerPath + "config/myEditor.xml");
	mxEvent.disableContextMenu(document.body);// 禁用右键菜单
	_editor.graph.allowDanglingEdges = false;// 禁止连线没有目标
	_editor.graph.setCellsResizable(false);// 禁止改变元素大小
	_editor.graph.setAllowLoops(false);// 禁止连线的目标和源是同一元素
	_editor.graph.setMultigraph(false);// 禁止重复连接
	_editor.graph.htmlLabels = true;// isHtmlLabel
	mxGraphHandler.prototype.guidesEnabled = true;// 允许对齐线
	_editor.graph.setCellsDisconnectable(false);// 允许新的连接，但不允许现有的连接被改变成简化的
	_editor.graph.resizeContainer = true;//允许改变容器大小
	
	// 为面板添加单击事件，包括点击空白和点击元素的处理
	_editor.graph.addListener(mxEvent.CLICK, function(sender, evt) {
		//获取焦点，监听键盘事件
		window.focus();
		// 因为添加事件后会执行点击事件，或者取消点击后等问题，所以延迟处理选中节点
		setTimeout(function() {
			_myAction.showSelectedCell();
		}, 100);
	});
	// 添加cell后监听
	_editor.graph.addListener(mxEvent.CELLS_ADDED, function(sender, evt) {
		var cells = evt.getProperty('cells');
		_myAction.addCells(cells);
	});
	// 删除cell监听
	_editor.graph.addListener(mxEvent.REMOVE_CELLS, function(sender, evt) {
		var cells = evt.getProperty('cells');
		_myAction.removeCells(cells);
	});
	// 移动cells
	/**
	_editor.graph.addListener(mxEvent.MOVE_CELLS, function(sender, evt) {
		var cells = evt.getProperty('cells');
		if($.notNull(cells)){
			var arr = new Array();
			for(var i = 0; i < cells.length; i++){
				if(cells[i].vertex){
					var x = Number(cells[i].geometry.x);
					var y = Number(cells[i].geometry.y);
					if(x < 0 || y < 0){
						x = x < 0 ? 0 : x;
						y = y < 0 ? 0 : y;
						var o = {};
						o.x = x;
						o.y = y;
						o.cell = cells[i];
						arr.push(o);
					}
				}
			}
			if(arr.length > 0){
				dhtmlxUtils.message("元素超出边缘！");
				for(var i = 0; i < arr.length; i ++){
					_editor.graph.moveCells([arr[i].cell], arr[i].x, arr[i].y)
				}
			}
		}
	});
	**/
	//键盘事件
	var keyHandler = new mxKeyHandler(_editor.graph);
	//删除
	keyHandler.bindKey(46, function() {
		_editor.graph.removeCells();
	});
	//全选
	keyHandler.bindControlKey(65, function() {
		_editor.graph.selectAll();
		_myAction.showSelectedCell();
	});
	// 上下左右移动
	keyHandler.bindKey(38, function() {
		var cells = _editor.graph.getSelectionCells();
		if($.notNull(cells)){
			_editor.graph.moveCells(cells, 0, -1)
		}
	});
	keyHandler.bindKey(40, function() {
		var cells = _editor.graph.getSelectionCells();
		if($.notNull(cells)){
			_editor.graph.moveCells(cells, 0, 1)
		}
	});
	keyHandler.bindKey(37, function() {
		var cells = _editor.graph.getSelectionCells();
		if($.notNull(cells)){
			_editor.graph.moveCells(cells, -1, 0)
		}
	});
	keyHandler.bindKey(39, function() {
		var cells = _editor.graph.getSelectionCells();
		if($.notNull(cells)){
			_editor.graph.moveCells(cells, 1, 0)
		}
	});
	//上下左右对齐
	keyHandler.bindShiftKey(38, function() {
		_editor.graph.alignCells("top");
	});
	keyHandler.bindShiftKey(40, function() {
		_editor.graph.alignCells("bottom");
	});
	keyHandler.bindShiftKey(37, function() {
		_editor.graph.alignCells("left");
	});
	keyHandler.bindShiftKey(39, function() {
		_editor.graph.alignCells("right");
	});
	//等宽
	keyHandler.bindShiftKey(87, function() {
		_myAction.comWidth();
	});
	//等高
	keyHandler.bindShiftKey(72, function() {
		_myAction.comHeight();
	});
	
	$(".mxToolbarModeDiv span").on("click", function(){
		$(this).prev().trigger("click");
	});
	
	// 执行初始化，没有流程xml文件就认为是新增流程，初始化时当前对象就是流程对象
	_myLayout.progressOn();
	$.ajax({
		type : "POST",
		data : {
			id : _id,
			type : _type
		},
		url : _controlPath + "getProcessXml",
		dataType : "json",
		success : function(result) {
			if($.notNull(result.processXml)){
				var xml = mxUtils.parseXml(result.processXml);
				var xmlvalue = _myAction.converToGraphXml(xml);
				var doc = mxUtils.parseXml(xmlvalue);
				var codec = new mxCodec(doc);
				_editor.graph.getModel().beginUpdate();
				codec.decode(doc.documentElement, _editor.graph.getModel());
				_editor.graph.getModel().endUpdate();
				// 当前对象
				var myProcess = _myCellMap.get(_processKey);
				myProcess.showProp();
				_myCurCellId = _processKey;
			}else{
				_processKey = _id;// key值和id值一样
				var myProcess = new MyProcess(_processKey);
				myProcess.init();
				_myCellMap.put(_processKey, myProcess);
				myProcess.showProp();
				_myCurCellId = _processKey;
			}
			
			//graph大小设置
			_editor.graph.minimumContainerSize = {width : _myLayout.cells("b").getWidth() - 50, height : _myLayout.cells("b").getHeight() - 50};
			_editor.graph.sizeDidChange();
			
			_myLayout.progressOff();
		}
	});
	
});