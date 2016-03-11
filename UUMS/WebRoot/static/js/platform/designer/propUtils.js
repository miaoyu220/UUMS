var propUtils = {
	//图标显示窗口
	createIconWin : function(self) {
		var myWin;
		if(mxClient.IS_IE8){
			myWin = parent.dhtmlxUtils.createModalWin("myWin", "图片设置", 600, _maxHeight);
		}else{
			myWin = dhtmlxUtils.createModalWin("myWin", "图片设置", 600, _maxHeight);
		}
		myWin.denyResize();
		var toolbar = myWin.attachToolbar({
			icons_path : _iconPath,
			items : [ {
				id : "ok",
				type : "button",
				text : "确定",
				img : "save.gif",
				img_disabled : "save_dis.gif"
			} ]
		});
		var iconId = guid();
		var temp = $("#iconDiv").clone(true, true);
		temp.attr("id", iconId);
		if(mxClient.IS_IE8){
			temp.appendTo(parent.document.body);
		}else{
			temp.appendTo(document.body);
		}
		myWin.attachObject(iconId);
		toolbar.attachEvent("onClick", function(id) {
			if (id == "ok") {
				if(mxClient.IS_IE8){
					var icon = parent.$("#" + iconId).find("input[name='icon']:checked").val();
					var url = parent.$("#" + iconId).find("input[name='icon']:checked").next().find("img").attr("src");
					_editor.graph.setCellStyles(mxConstants.STYLE_IMAGE, url);
					$(self).prev(".prop_txt").val(icon);
					myWin.close();
				}else{
					var icon = $("#" + iconId).find("input[name='icon']:checked").val();
					var url = $("#" + iconId).find("input[name='icon']:checked").next().find("img").attr("src");
					_editor.graph.setCellStyles(mxConstants.STYLE_IMAGE, url);
					$(self).prev(".prop_txt").val(icon);
					myWin.close();
				}
			}
		});
	},
	//事件窗口
	createEventWin : function() {
		var myWin;
		if(mxClient.IS_IE8){
			myWin = parent.dhtmlxUtils.createModalWin("myWin", "事件输入框", 700, _maxHeight);
		}else{
			myWin = dhtmlxUtils.createModalWin("myWin", "事件输入框", 700, _maxHeight);
		}
		myWin.denyResize();
		var myForm = myWin.attachForm();
		var toolbar = myWin.attachToolbar({
			icons_path : _iconPath,
			items : [ {
				id : "ok",
				type : "button",
				text : "确定",
				img : "save.gif",
				img_disabled : "save_dis.gif"
			} ]
		});
		myForm.attachEvent("onInputChange", function(name, value) {
			if (name == "fnName" || name == "fnEvt") {
				var value1 = myForm.getItemValue("fnName");
				var value2 = myForm.getItemValue("fnEvt");
				if ($.trim(value1) == "" || $.trim(value2) == "") {
					toolbar.disableItem("ok");
				} else {
					toolbar.enableItem("ok");
				}
			}
		});
		return {
			myWin : myWin,
			myForm : myForm,
			toolbar : toolbar
		};
	},
	//流程变量窗口
	createVariableWin : function() {
		var myWin;
		if(mxClient.IS_IE8){
			myWin = parent.dhtmlxUtils.createModalWin("myWin", "流程变量输入框", 700, 320);
		}else{
			myWin = dhtmlxUtils.createModalWin("myWin", "流程变量输入框", 700, 320);
		}
		myWin.denyResize();
		var myForm = myWin.attachForm();
		var toolbar = myWin.attachToolbar({
			icons_path : _iconPath,
			items : [ {
				id : "ok",
				type : "button",
				text : "确定",
				img : "save.gif",
				img_disabled : "save_dis.gif"
			} ]
		});
		myForm.attachEvent("onInputChange", function(name, value) {
			if (name == "alias" || name == "name") {
				var value1 = myForm.getItemValue("alias");
				var value2 = myForm.getItemValue("name");
				if ($.trim(value1) == "" || $.trim(value2) == "") {
					toolbar.disableItem("ok");
				} else {
					toolbar.enableItem("ok");
				}
			}
		});
		return {
			myWin : myWin,
			myForm : myForm,
			toolbar : toolbar
		};
	},
	//查询参数窗口
	createCxcsWin : function() {
		var myWin;
		if(mxClient.IS_IE8){
			myWin = parent.dhtmlxUtils.createModalWin("myWin", "查询参数输入框", 700, 320);
		}else{
			myWin = dhtmlxUtils.createModalWin("myWin", "查询参数输入框", 700, 320);
		}
		myWin.denyResize();
		var myForm = myWin.attachForm();
		var toolbar = myWin.attachToolbar({
			icons_path : _iconPath,
			items : [ {
				id : "ok",
				type : "button",
				text : "确定",
				img : "save.gif",
				img_disabled : "save_dis.gif"
			} ]
		});
		myForm.attachEvent("onInputChange", function(name, value) {
			if (name == "alias" || name == "name" || name == "init") {
				var value1 = myForm.getItemValue("alias");
				var value2 = myForm.getItemValue("name");
				var value3 = myForm.getItemValue("init");
				if ($.trim(value1) == "" || $.trim(value2) == "" || $.trim(value3) == "") {
					toolbar.disableItem("ok");
				} else {
					toolbar.enableItem("ok");
				}
			}
		});
		return {
			myWin : myWin,
			myForm : myForm,
			toolbar : toolbar
		};
	},
	//时间规则窗口
	createTimeWin : function(title) {
		var myWin;
		if(mxClient.IS_IE8){
			myWin = parent.dhtmlxUtils.createModalWin("myWin", title, 700, 220);
		}else{
			myWin = dhtmlxUtils.createModalWin("myWin", title, 700, 220);
		}
		myWin.denyResize();
		var myForm = myWin.attachForm();
		var toolbar = myWin.attachToolbar({
			icons_path : _iconPath,
			items : [ {
				id : "ok",
				type : "button",
				text : "确定",
				img : "save.gif",
				img_disabled : "save_dis.gif"
			} ]
		});
		return {
			myWin : myWin,
			myForm : myForm,
			toolbar : toolbar
		};
	},
	//添加方法参数、成员变量
	addFfcsCybl : function(title, xmlName, self){
        var obj = this.createFfcsCyblWin(title);
        var myForm = obj.myForm;
        var toolbar = obj.toolbar;
        var addWin = obj.myWin;
        myForm.load(_designerPath + "config/" + xmlName);
        toolbar.disableItem("ok");
		toolbar.attachEvent("onClick", function(id) {
			if (id == "ok") {
                var name=myForm.getItemValue("name");
                var type=myForm.getItemValue("type");
                var init=myForm.getItemValue("init");
                
                $(self).siblings('table').find('tbody').find('tr').each(function (){
                    if(!$(this).find('td').eq(0).html()){
                        $(this).find('td').eq(0).html(name);
                        $(this).find('td').eq(1).html(type);
                        $(this).find('td').eq(2).html(init);
                        return false;
                    }
                });
				addWin.close();
			}
		});
	},
	//编辑方法参数、成员变量
	editFfcsCybl : function(title, xmlName, self){
        if(!$(self).siblings('table').find('.tr_on').size())return;
        var obj = this.createFfcsCyblWin(title);
        var myForm = obj.myForm;
        var toolbar = obj.toolbar;
        var editWin = obj.myWin;
		toolbar.attachEvent("onClick", function(id) {
			if (id == "ok") {
                var name=myForm.getItemValue("name");
                var type=myForm.getItemValue("type");
                var init=myForm.getItemValue("init");
                
                var edit=$(self).siblings('table').find('.tr_on').find('td');
                edit.eq(0).html(name);
                edit.eq(1).html(type);
                edit.eq(2).html(init);
                editWin.close();
			}
		});
		var aTr=$(self).siblings('table').find('.tr_on').find('td');
        var name=aTr.eq(0).html();
        var type=aTr.eq(1).html();
        var init=aTr.eq(2).html();
        myForm.load(_designerPath + "config/" + xmlName, function(){
        	myForm.setItemValue("name", name);
        	myForm.setItemValue("type", type);
        	myForm.setItemValue("init", init);
        });
	},
	//创建方法参数、成员变量窗口
	createFfcsCyblWin : function(title) {
		var myWin;
		if(mxClient.IS_IE8){
			myWin = parent.dhtmlxUtils.createModalWin("myWin", title + "输入框", 700, 220);
		}else{
			myWin = dhtmlxUtils.createModalWin("myWin", title + "输入框", 700, 220);
		}
		myWin.denyResize();
		var myForm = myWin.attachForm();
		var toolbar = myWin.attachToolbar({
			icons_path : _iconPath,
			items : [ {
				id : "ok",
				type : "button",
				text : "确定",
				img : "save.gif",
				img_disabled : "save_dis.gif"
			} ]
		});
		myForm.attachEvent("onInputChange", function(name, value) {
			if (name == "name") {
				if ($.trim(value) == "") {
					toolbar.disableItem("ok");
				} else {
					toolbar.enableItem("ok");
				}
			}
		});
		return {
			myWin : myWin,
			myForm : myForm,
			toolbar : toolbar
		};
	},
	//创建主子参数窗口
	createZhuZiWin : function() {
		var myWin;
		if(mxClient.IS_IE8){
			myWin = parent.dhtmlxUtils.createModalWin("myWin", "输入输出参数", 700, 220);
		}else{
			myWin = dhtmlxUtils.createModalWin("myWin", "输入输出参数", 700, 220);
		}
		myWin.denyResize();
		var myForm = myWin.attachForm();
		var toolbar = myWin.attachToolbar({
			icons_path : _iconPath,
			items : [ {
				id : "ok",
				type : "button",
				text : "确定",
				img : "save.gif",
				img_disabled : "save_dis.gif"
			} ]
		});
		myForm.attachEvent("onInputChange", function(name, value) {
			var outStr = myForm.getItemValue("out");
			var inStr = myForm.getItemValue("in");
			if ($.trim(outStr) == "" || $.trim(inStr) == "") {
				toolbar.disableItem("ok");
			} else {
				toolbar.enableItem("ok");
			}
		});
		return {
			myWin : myWin,
			myForm : myForm,
			toolbar : toolbar
		};
	},
	//子流程选择窗口
	createChildProcessWin : function(self){
		var myWin;
		if(mxClient.IS_IE8){
			myWin = parent.dhtmlxUtils.createModalWin("myWin", "流程选择框", 700, _maxHeight);
		}else{
			myWin = dhtmlxUtils.createModalWin("myWin", "流程选择框", 700, _maxHeight);
		}
		myWin.denyResize();
		var myLayout = myWin.attachLayout({
			pattern : "2E"
		});
		myLayout.cells("a").hideHeader();
		myLayout.cells("b").hideHeader();
		myLayout.cells("a").setHeight(35);
		myLayout.cells("a").fixSize(true, true);
		var myForm = myLayout.cells("a").attachForm();
		myForm.load(_designerPath + "config/form_childprocess.xml");
		
		var myGrid = myLayout.cells("b").attachGrid();
		myGrid.setImagePath(_imgPath + "dhxgrid_" + _skin + "/");
		myGrid.enableEditEvents(false, false, false);
		myGrid.loadXML(_designerPath + "config/grid_childprocess.xml", function(){
			$.ajax({
				type : "POST",
				data : {
					flowKey : "",
					flowName : ""
				},
				url : _controlPath + "getAllProcessList",
				dataType : "json",
				success : function(node) {
					$.each(node, function(i, n) {
						myGrid.addRow(myGrid.uid(), [n.displayName, n.key, ""]);
					});
				}
			});
		});
		myForm.attachEvent("onInputChange", function(name, value){
			var flowKey = $.trim(myForm.getItemValue("flowKey"));
			var flowName = $.trim(myForm.getItemValue("flowName"));
			myGrid.clearAll();
			$.ajax({
				type : "POST",
				data : {
					flowKey : flowKey,
					flowName : flowName
				},
				url : _controlPath + "getAllProcessList",
				dataType : "json",
				success : function(node) {
					$.each(node, function(i, n) {
						myGrid.addRow(myGrid.uid(), [n.displayName, n.key, ""]);
					});
				}
			});
		});
		//定义toolbar
		var toolbar = myWin.attachToolbar({
			icons_path : _iconPath,
			items : [ {
				id : "ok",
				type : "button",
				text : "确定",
				img : "save.gif",
				img_disabled : "save_dis.gif"
			} ]
		});
		toolbar.attachEvent("onClick", function(id) {
			if (id == "ok") {
				var selectedId = myGrid.getSelectedRowId();
				if($.notNull(selectedId)){
					var nameCell = myGrid.cellById(selectedId, 0);
					var keyCell = myGrid.cellById(selectedId, 1);
					$(self).prev(".prop_txt").val(nameCell.getValue());
					$(self).prev(".prop_txt").attr("userData", keyCell.getValue());
				}else{
					$(self).prev(".prop_txt").val("");
					$(self).prev(".prop_txt").attr("userData", "");
				}
				myWin.close();
			}
		});
	},
	//解析时间规则字符串
	getRecords : function(recordValue) {
		var UNITS_COMBO = ["seconds", "minutes", "hours", "days", "weeks", "months", "years"];
		var str = ["", "", "days"];
		if ($.notNull(recordValue)) {
			for (var i = 0; i < UNITS_COMBO.length; i++) {
				var units = UNITS_COMBO[i];
				if (recordValue.lastIndexOf("business " + units) > -1) {
					str[0] = $.trim(recordValue.split("business " + units)[0]);
					str[1] = "business";
					str[2] = units;
					break;
				} else if (recordValue.lastIndexOf(units) > -1) {
					str[0] = $.trim(recordValue.split(units)[0]);
					str[1] = "";
					str[2] = units;
					break;
				}
			}
		}
		return str;
	},
	//条件窗口
	createConditionWin : function() {
		var myWin;
		if(mxClient.IS_IE8){
			myWin = parent.dhtmlxUtils.createModalWin("myWin", "条件构建向导", 700, _maxHeight);
		}else{
			myWin = dhtmlxUtils.createModalWin("myWin", "条件构建向导", 700, _maxHeight);
		}
		myWin.denyResize();
		var myForm = myWin.attachForm();
		var toolbar = myWin.attachToolbar({
			icons_path : _iconPath,
			items : [ {
				id : "ok",
				type : "button",
				text : "确定",
				img : "save.gif",
				img_disabled : "save_dis.gif"
			} , {
				id : "comm",
				type : "buttonSelect",
				text : "常用对象"
			} , {
				id : "overall",
				type : "buttonSelect",
				text : "全局变量"
			} ]
		});
		toolbar.addListOption("comm", "avicit_bpm_start_id", 1, "button", "表单ID(String avicit_bpm_start_id)");
		toolbar.addListOption("comm", "avicit_bpm_user", 2, "button", "流程当前人(List<MembershipImpl> avicit_bpm_user)");
		toolbar.addListOption("comm", "avicit_bpm_dept", 3, "button", "流程当前部门(DeptImpl avicit_bpm_dept)");
		toolbar.addListOption("comm", "avicit_bpm_starter", 4, "button", "流程启动者(DeptImpl avicit_bpm_starter)");
		toolbar.addListOption("comm", "avicit_bpm_starterdept", 5, "button", "流程启动部门(DeptImpl avicit_bpm_starterdept)");
		toolbar.addListOption("comm", "temp_avicit_bpm_transactor", 6, "button", "流程处理人(Map temp_avicit_bpm_transactor)");
		toolbar.addListOption("comm", "temp_avicit_bpm_message", 7, "button", "处理意见(String temp_avicit_bpm_message)");
		var vArr = this.getVariables();
		if(vArr.length == 0){
			toolbar.disableItem("overall");
		}else{
			for(var i = 0; i < vArr.length; i++){
				toolbar.addListOption("overall", vArr[i].name, i + 1, "button", vArr[i].alias + "(" + vArr[i].type + " " + vArr[i].name + ")");
			}
		}
		myForm.attachEvent("onInputChange", function(name, value) {
			if ($.trim(value) == "") {
				toolbar.disableItem("ok");
			} else {
				toolbar.enableItem("ok");
			}
		});
		myForm.attachEvent("onChange", function (name, value, state){
		     if($.notNull(state)){
		    	 var radio = myForm.getItemValue("type");
		    	 var value = myForm.getItemValue(radio);
		    	 if($.trim(value) == ""){
		    		 toolbar.disableItem("ok");
		    	 }else{
		    		 toolbar.enableItem("ok");
		    	 }
		     }
		});
		toolbar.attachEvent("onClick", function(id) {
			if (id != "ok" && id != "comm" && id != "overall") {
				var radio = myForm.getItemValue("type");
				var value = myForm.getItemValue(radio);
				if(radio == "expr"){
					myForm.setItemValue(radio, value + " #{" + id + "}");
					toolbar.enableItem("ok");
				}else if(radio == "beanshell"){
					myForm.setItemValue(radio, value + " " + id);
					toolbar.enableItem("ok");
				}
			}
			return true;
		});
		return {
			myWin : myWin,
			myForm : myForm,
			toolbar : toolbar
		};
	},
	createDbbtWin : function(title){
		var myWin;
		if(mxClient.IS_IE8){
			myWin = parent.dhtmlxUtils.createModalWin("myWin", title, 700, 320);
		}else{
			myWin = dhtmlxUtils.createModalWin("myWin", title, 700, 320);
		}
		myWin.denyResize();
		var myForm = myWin.attachForm();
		var toolbar = myWin.attachToolbar({
			icons_path : _iconPath,
			items : [ {
				id : "ok",
				type : "button",
				text : "确定",
				img : "save.gif",
				img_disabled : "save_dis.gif"
			} , {
				id : "comm",
				type : "buttonSelect",
				text : "常用对象"
			} , {
				id : "overall",
				type : "buttonSelect",
				text : "全局变量"
			} ]
		});
		toolbar.addListOption("comm", "avicit_bpm_start_id", 1, "button", "表单ID(String avicit_bpm_start_id)");
		toolbar.addListOption("comm", "avicit_bpm_user", 2, "button", "流程当前人(List<MembershipImpl> avicit_bpm_user)");
		toolbar.addListOption("comm", "avicit_bpm_dept", 3, "button", "流程当前部门(DeptImpl avicit_bpm_dept)");
		toolbar.addListOption("comm", "avicit_bpm_starter", 4, "button", "流程启动者(DeptImpl avicit_bpm_starter)");
		toolbar.addListOption("comm", "avicit_bpm_starterdept", 5, "button", "流程启动部门(DeptImpl avicit_bpm_starterdept)");
		toolbar.addListOption("comm", "temp_avicit_bpm_transactor", 6, "button", "流程处理人(Map temp_avicit_bpm_transactor)");
		toolbar.addListOption("comm", "temp_avicit_bpm_message", 7, "button", "处理意见(String temp_avicit_bpm_message)");
		var vArr = this.getVariables();
		if(vArr.length == 0){
			toolbar.disableItem("overall");
		}else{
			for(var i = 0; i < vArr.length; i++){
				toolbar.addListOption("overall", vArr[i].name, i + 1, "button", vArr[i].alias + "(" + vArr[i].type + " " + vArr[i].name + ")");
			}
		}
		toolbar.attachEvent("onClick", function(id) {
			if (id != "ok" && id != "comm" && id != "overall") {
				var value = myForm.getItemValue("value");
				myForm.setItemValue("value", value + " #{" + id + "}");
			}
			return true;
		});
		return {
			myWin : myWin,
			myForm : myForm,
			toolbar : toolbar
		};
	},
	//获取流程变量列表
	getVariables : function(){
		var $obj = $('#' + _processKey + ' #liu_cheng_bian_liang tr');
		return this.getHtmlListByDom($obj, ["alias","name","init","type","desc"]);
	},
	//读取html列表数据
	getHtmlListByDom : function(dom, fieldArr){
		var array = new Array();
		if(!$.notNull(fieldArr)){
			fieldArr = ["a","b","c","d","e","f","g","h","i"];
		}
		dom.each(function() {
			if ($.trim($(this).find('td').text()) == "") {
				return;
			}
			var o = {};
			$.each($(this).find('td'), function(i, n){
				eval("o." + fieldArr[i] + "='" + n.innerHTML + "';");
			});
			array.push(o);
		});
		return array;
	},
	//流程变量单选窗口
	createChooseVWin : function(){
		var obj = this.createMulChooseVWin("");
		if($.notNull(obj)){
			obj.toolbar.disableItem("ok");
			obj.myGrid.attachEvent("onRowSelect", function(id,ind){
				obj.toolbar.enableItem("ok");
			});
			obj.myGrid.setColumnHidden(0, true);
		}
        return obj;
	},
	//流程变量多选
	createMulChooseVWin : function(str){
		var vArr = this.getVariables();
		if(vArr.length == 0){
			if(mxClient.IS_IE8){
				parent.dhtmlxUtils.message("没有可供选择的流程变量！");
			}else{
				dhtmlxUtils.message("没有可供选择的流程变量！");
			}
			return;
		}
		var myWin;
		if(mxClient.IS_IE8){
			myWin = parent.dhtmlxUtils.createModalWin("myWin", "流程变量选择框", 700, _maxHeight);
		}else{
			myWin = dhtmlxUtils.createModalWin("myWin", "流程变量选择框", 700, _maxHeight);
		}
		myWin.denyResize();
		var myGrid = myWin.attachGrid();
		myGrid.setImagePath(_imgPath + "dhxgrid_" + _skin + "/");
		myGrid.enableEditEvents(false, false, false);
		myGrid.loadXML(_designerPath + "config/grid_variable.xml", function(){
			$.each(vArr, function(i, n) {
				myGrid.addRow(myGrid.uid(), [str.indexOf(n.name + ";") != -1 ? 1 : 0, n.alias,n.name,n.init,n.type,n.desc]);
			});
		});
		var toolbar = myWin.attachToolbar({
			icons_path : _iconPath,
			items : [ {
				id : "ok",
				type : "button",
				text : "确定",
				img : "save.gif",
				img_disabled : "save_dis.gif"
			} ]
		});
		return {
			myWin : myWin,
			toolbar : toolbar,
			myGrid : myGrid
		};
	},
	createQxClWin : function(){
		var myWin;
		if(mxClient.IS_IE8){
			myWin = parent.dhtmlxUtils.createModalWin("myWin", "函数输入框", 700, 220);
		}else{
			myWin = dhtmlxUtils.createModalWin("myWin", "函数输入框", 700, 220);
		}
		myWin.denyResize();
		var myForm = myWin.attachForm();
		var toolbar = myWin.attachToolbar({
			icons_path : _iconPath,
			items : [ {
				id : "ok",
				type : "button",
				text : "确定",
				img : "save.gif",
				img_disabled : "save_dis.gif"
			} ]
		});
		return {
			myWin : myWin,
			myForm : myForm,
			toolbar : toolbar
		};
	},
	//task单选框
	createQxTaskWin : function(){
		var obj = this.createMulQxTaskWin("");
		if($.notNull(obj)){
			obj.toolbar.disableItem("ok");
			obj.myGrid.attachEvent("onRowSelect", function(id,ind){
				obj.toolbar.enableItem("ok");
			});
			obj.myGrid.setColumnHidden(0, true);
		}
        return obj;
	},
	//task多选框
	createMulQxTaskWin : function(str){
		var vArr = new Array();
		var values = _myCellMap.values();
		$.each(values, function(i, n){
			if(n.tagName == "task"){
				var o = {};
				o.a = n.name;
				o.b = n.alias;
				vArr.push(o);
			}
		});
		var myWin;
		if(mxClient.IS_IE8){
			myWin = parent.dhtmlxUtils.createModalWin("myWin", "流程节点选择框", 700, _maxHeight);
		}else{
			myWin = dhtmlxUtils.createModalWin("myWin", "流程节点选择框", 700, _maxHeight);
		}
		myWin.denyResize();
		var myGrid = myWin.attachGrid();
		myGrid.setImagePath(_imgPath + "dhxgrid_" + _skin + "/");
		myGrid.enableEditEvents(false, false, false);
		myGrid.loadXML(_designerPath + "config/grid_task.xml", function(){
			$.each(vArr, function(i, n) {
				myGrid.addRow(myGrid.uid(), [str.indexOf(n.a + ";") != -1 ? 1 : 0, n.a, n.b]);
			});
		});
		var toolbar = myWin.attachToolbar({
			icons_path : _iconPath,
			items : [ {
				id : "ok",
				type : "button",
				text : "确定",
				img : "save.gif",
				img_disabled : "save_dis.gif"
			} ]
		});
		return {
			myWin : myWin,
			toolbar : toolbar,
			myGrid : myGrid
		};
	},
	//正文模板多选框
	createMulQxZWMBWin : function(str){
		var myWin;
		if(mxClient.IS_IE8){
			myWin = parent.dhtmlxUtils.createModalWin("myWin", "正文模板选择框", 700, _maxHeight);
		}else{
			myWin = dhtmlxUtils.createModalWin("myWin", "正文模板选择框", 700, _maxHeight);
		}
		myWin.denyResize();
		
		var myLayout = myWin.attachLayout({
			pattern : "2U"
		});
		myLayout.cells("a").hideHeader();
		myLayout.cells("b").hideHeader();
		myLayout.cells("a").setWidth(150);
		myLayout.cells("a").fixSize(true, true);
		
		var myGrid = myLayout.cells("b").attachGrid();
		myGrid.setImagePath(_imgPath + "dhxgrid_" + _skin + "/");
		myGrid.enableEditEvents(false, false, false);
		myGrid.loadXML(_designerPath + "config/grid_zwmb.xml", function(){
			$.ajax({
				type : "POST",
				data : {
					flowId : _processKey
				},
				url : _controlPath + "getZWMBList",
				dataType : "json",
				success : function(node) {
					$.each(node, function(i, n){
						myGrid.addRow(n.id, [str.indexOf(n.id + ";") != -1 ? 1 : 0, n.templetName, n.version]);
					});
				}
			});
		});
		
		var myTree = myLayout.cells("a").attachTree();
		myTree.setImagePath(_imgPath + "dhxtree_" + _skin + "/");
		$.ajax({
			type : "GET",
			url : _controlPath + "getAllWordTempletList",
			dataType : "json",
			success : function(node) {
				var treeXml = propUtils.createTree();
				propUtils.addWordTempletTree(treeXml, node);
				myTree.loadXMLString(ComUtils.getPrettyXml(treeXml));
				myTree.openItem("-2");
			}
		});
		myTree.attachEvent("onClick", function(id) {
			myGrid.clearAll();
			$.ajax({
				type : "POST",
				data : {
					flowId : _processKey,
					treeId : id
				},
				url : _controlPath + "getZWMBList",
				dataType : "json",
				success : function(node) {
					$.each(node, function(i, n){
						myGrid.addRow(n.id, [str.indexOf(n.id + ";") != -1 ? 1 : 0, n.templetName, n.version]);
					});
				}
			});
		});
		var toolbar = myWin.attachToolbar({
			icons_path : _iconPath,
			items : [ {
				id : "ok",
				type : "button",
				text : "确定",
				img : "save.gif",
				img_disabled : "save_dis.gif"
			} ]
		});
		return {
			myWin : myWin,
			toolbar : toolbar,
			myGrid : myGrid
		};
	},
	//套红模板多选框
	createMulQxTHMBWin : function(str){
		var myWin;
		if(mxClient.IS_IE8){
			myWin = parent.dhtmlxUtils.createModalWin("myWin", "套红模板选择框", 700, _maxHeight);
		}else{
			myWin = dhtmlxUtils.createModalWin("myWin", "套红模板选择框", 700, _maxHeight);
		}
		myWin.denyResize();
		
		var myLayout = myWin.attachLayout({
			pattern : "2U"
		});
		myLayout.cells("a").hideHeader();
		myLayout.cells("b").hideHeader();
		myLayout.cells("a").setWidth(150);
		myLayout.cells("a").fixSize(true, true);
		
		var myGrid = myLayout.cells("b").attachGrid();
		myGrid.setImagePath(_imgPath + "dhxgrid_" + _skin + "/");
		myGrid.enableEditEvents(false, false, false);
		myGrid.loadXML(_designerPath + "config/grid_thmb.xml", function(){
			$.ajax({
				type : "POST",
				data : {
					flowId : _processKey
				},
				url : _controlPath + "getTHMBList",
				dataType : "json",
				success : function(node) {
					$.each(node, function(i, n){
						myGrid.addRow(n.id, [str.indexOf(n.id + ";") != -1 ? 1 : 0, n.templetName, n.version]);
					});
				}
			});
		});
		
		var myTree = myLayout.cells("a").attachTree();
		myTree.setImagePath(_imgPath + "dhxtree_" + _skin + "/");
		$.ajax({
			type : "GET",
			url : _controlPath + "getAllWordTempletList",
			dataType : "json",
			success : function(node) {
				var treeXml = propUtils.createTree();
				propUtils.addWordTempletTree(treeXml, node);
				myTree.loadXMLString(ComUtils.getPrettyXml(treeXml));
				myTree.openItem("-2");
			}
		});
		myTree.attachEvent("onClick", function(id) {
			myGrid.clearAll();
			$.ajax({
				type : "POST",
				data : {
					flowId : _processKey,
					treeId : id
				},
				url : _controlPath + "getTHMBList",
				dataType : "json",
				success : function(node) {
					$.each(node, function(i, n){
						myGrid.addRow(n.id, [str.indexOf(n.id + ";") != -1 ? 1 : 0, n.templetName, n.version]);
					});
				}
			});
		});
		var toolbar = myWin.attachToolbar({
			icons_path : _iconPath,
			items : [ {
				id : "ok",
				type : "button",
				text : "确定",
				img : "save.gif",
				img_disabled : "save_dis.gif"
			} ]
		});
		return {
			myWin : myWin,
			toolbar : toolbar,
			myGrid : myGrid
		};
	},
	// 当前task的transition路径选择框，单选
	createTransitionWin : function(){
		var myWin;
		if(mxClient.IS_IE8){
			myWin = parent.dhtmlxUtils.createModalWin("transitionWin", "路径选择框", 300, _maxHeight);
		}else{
			myWin = dhtmlxUtils.createModalWin("transitionWin", "路径选择框", 300, _maxHeight);
		}
		myWin.denyResize();
		var myTree = myWin.attachTree();
		myTree.setImagePath(_imgPath + "dhxtree_" + _skin + "/");

		var treeXml = propUtils.createTree();
		var values = _myCellMap.values();
		for (var i = 0; i < values.length; i++) {
			var baseNode = values[i];
			if (baseNode.tagName == "transition") {
				var sourceId = baseNode.getCell().source.id;
				if(sourceId == _myCellMap.get(_myCurCellId).getCell().id){
					//需要排除task以外的节点
					var targetId = baseNode.getCell().target.id;
					if(_myCellMap.get(targetId).tagName == "task"){
						propUtils.addTreeNode(treeXml, baseNode.name, baseNode.alias, "task_human.png");
					}
				}
			}
		}
		myTree.loadXMLString(ComUtils.getPrettyXml(treeXml));

		myTree.attachEvent("onClick", function(id) {
			toolbar.enableItem("ok");
		});
		var toolbar = myWin.attachToolbar({
			icons_path : _iconPath,
			items : [ {
				id : "ok",
				type : "button",
				text : "确定",
				img : "save.gif",
				img_disabled : "save_dis.gif"
			} ]
		});
		toolbar.disableItem("ok");
		return {
			myWin : myWin,
			toolbar : toolbar,
			myTree : myTree
		};
	},
	/**
	 * 创建人员选择框,将选择事件在这里面绑定,而不是返回窗口后绑定,原因是无法拿到初始化后的grid
	 * @param self
	 */
	createPersonWin : function(self){
		var str=$(self).prev(".prop_txt").attr("actorsId");
		var myWin;
		if(mxClient.IS_IE8){
			myWin = parent.dhtmlxUtils.createModalWin("myWin", "人员选择框", 820, _userHeight);
		}else{
			myWin = dhtmlxUtils.createModalWin("myWin", "人员选择框", 820, _userHeight);
		}
		myWin.denyResize();
		var myLayout = myWin.attachLayout({
			pattern : "2U"
		});
		myLayout.cells("a").hideHeader();
		myLayout.cells("a").setWidth(350);
		myLayout.cells("b").hideHeader();
		myLayout.cells("b").fixSize(true, true);
		//定义左侧分页项
		var myTabbar = myLayout.cells("a").attachTabbar({
			tabs : [{
				id : "dept",
				text : "部门",
				active : true
			} , {
				id : "role",
				text : "角色"
			} , {
				id : "group",
				text : "群组"
			} , {
				id : "position",
				text : "岗位"
			} , {
				id : "relation",
				text : "关系"
			} ]
		});
		//部门
		var deptLayout = myTabbar.cells("dept").attachLayout({
			pattern : "2E"
		});
		deptLayout.cells("a").hideHeader();
		deptLayout.cells("b").hideHeader();
		deptLayout.cells("a").setHeight(35);
		deptLayout.cells("a").fixSize(true, true);
		var myForm = deptLayout.cells("a").attachForm();
		myForm.load(_designerPath + "config/form_searchUser.xml");
		myForm.attachEvent("onInputChange", function(name, value) {
			deptTree.deleteChildItems("ORG_ROOT");
			deptTree.deleteItem("ORG_ROOT");
			if ($.trim(value) == "") {
				$.ajax({
					type : "GET",
					url : _controlPath + "getAllOrgList",
					dataType : "json",
					success : function(node) {
						var treeXml = propUtils.createTree();
						propUtils.addOrgTree(treeXml, node);
						deptTree.loadXMLString(ComUtils.getPrettyXml(treeXml));
						deptTree.openItem("ORG_ROOT");
					}
				});
			} else {
				$.ajax({
					type : "POST",
					data : {
						userName : value
					},
					url : _controlPath + "getAllOrgListByUser",
					dataType : "json",
					success : function(node) {
						var treeXml = propUtils.createTree();
						propUtils.addOrgTree(treeXml, node);
						deptTree.loadXMLString(ComUtils.getPrettyXml(treeXml));
						deptTree.openAllItems("ORG_ROOT");
					}
				});
			}
		});
		var deptTree = deptLayout.cells("b").attachTree();
		deptTree.setImagePath(_imgPath + "dhxtree_" + _skin + "/");
		$.ajax({
			type : "GET",
			url : _controlPath + "getAllOrgList",
			dataType : "json",
			success : function(node) {
				var treeXml = propUtils.createTree();
				propUtils.addOrgTree(treeXml, node);
				deptTree.loadXMLString(ComUtils.getPrettyXml(treeXml));
				deptTree.openItem("ORG_ROOT");
			}
		});
		//角色
		var roleTree = myTabbar.cells("role").attachTree();
		roleTree.setImagePath(_imgPath + "dhxtree_" + _skin + "/");
		$.ajax({
			type : "GET",
			url : _controlPath + "getAllRoleList",
			dataType : "json",
			success : function(node) {
				var treeXml = propUtils.createTree();
				var root = propUtils.createTreeNode("root", "所有角色", "avicit/org.gif");
				propUtils.addRoleTree(root, node);
				treeXml.appendChild(root);
				roleTree.loadXMLString(ComUtils.getPrettyXml(treeXml));
				roleTree.openItem("root");
			}
		});
		//群组
		var groupTree = myTabbar.cells("group").attachTree();
		groupTree.setImagePath(_imgPath + "dhxtree_" + _skin + "/");
		$.ajax({
			type : "GET",
			url : _controlPath + "getAllGroupList",
			dataType : "json",
			success : function(node) {
				var treeXml = propUtils.createTree();
				var root = propUtils.createTreeNode("root", "所有群组", "avicit/org.gif");
				propUtils.addGroupTree(root, node);
				treeXml.appendChild(root);
				groupTree.loadXMLString(ComUtils.getPrettyXml(treeXml));
				groupTree.openItem("root");
			}
		});
		//岗位
		var positionTree = myTabbar.cells("position").attachTree();
		positionTree.setImagePath(_imgPath + "dhxtree_" + _skin + "/");
		$.ajax({
			type : "GET",
			url : _controlPath + "getAllPositionList",
			dataType : "json",
			success : function(node) {
				var treeXml = propUtils.createTree();
				var root = propUtils.createTreeNode("root", "所有岗位", "avicit/org.gif");
				propUtils.addPositionTree(root, node);
				treeXml.appendChild(root);
				positionTree.loadXMLString(ComUtils.getPrettyXml(treeXml));
				positionTree.openItem("root");
			}
		});
		//关系
		var relationTree = myTabbar.cells("relation").attachTree();
		relationTree.setImagePath(_imgPath + "dhxtree_" + _skin + "/");
		var relation_treeXml = propUtils.createTree();
		var relation_root = propUtils.createTreeNode("root", "所有关系", "avicit/org.gif");
		propUtils.addTreeNode(relation_root, "alluser", "所有人", "avicit/relation.gif");
		propUtils.addTreeNode(relation_root, "draftuser", "拟稿人", "avicit/relation.gif");
		propUtils.addTreeNode(relation_root, "draftdept", "拟稿人部门", "avicit/relation.gif");
		propUtils.addTreeNode(relation_root, "currentdept", "当前人部门", "avicit/relation.gif");
		propUtils.addTreeNode(relation_root, "currentusergroup", "当前人自定义群组", "avicit/relation.gif");
		propUtils.addTreeNode(relation_root, "stepuser", "某一节点处理人", "avicit/relation.gif");
		propUtils.addTreeNode(relation_root, "customfunction", "自定义函数", "avicit/relation.gif");
		propUtils.addTreeNode(relation_root, "variable", "流程变量", "avicit/relation.gif");
		//暂时不实现脚本选人功能，因为这个功能太绕了
		//propUtils.addTreeNode(relation_root, "expression", "脚本选人", "avicit/relation.gif");
		relation_treeXml.appendChild(relation_root);
		relationTree.loadXMLString(ComUtils.getPrettyXml(relation_treeXml));
		relationTree.openItem("root");
		//定义选择项存储区域并绑定事件
		var dept_myGrid;
		var user_myGrid;
		var role_myGrid;
		var group_myGrid;
		var position_myGrid;
		var relation_myGrid;
		var myForm = myLayout.cells("b").attachForm();
		myForm.load(_designerPath + "config/form_person.xml", function(){
			dept_myGrid = propUtils.createPersonGrid(myForm, "dept_myGrid", "部门");
			user_myGrid = propUtils.createPersonGrid(myForm, "user_myGrid", "用户");
			role_myGrid = propUtils.createPersonGrid(myForm, "role_myGrid", "角色");
			group_myGrid = propUtils.createPersonGrid(myForm, "group_myGrid", "群组");
			position_myGrid = propUtils.createPersonGrid(myForm, "position_myGrid", "岗位");
			relation_myGrid = propUtils.createPersonGrid(myForm, "relation_myGrid", "关系");
			//给选择树绑定事件
			propUtils.attachPersonTreeEvent(roleTree, role_myGrid, "角色");
			propUtils.attachPersonTreeEvent(groupTree, group_myGrid, "群组");
			propUtils.attachPersonTreeEvent(positionTree, position_myGrid, "岗位");
			//部门人员选择树
			deptTree.attachEvent("onDblClick", function(id){
				var type = deptTree.getUserData(id, "type");
				if($.notNull(type)){
					if(type == "dept"){
						propUtils.createPositionWin(myWin, deptTree, dept_myGrid, id);
					}else if(type == "user"){
						if(user_myGrid.doesRowExist(id)){
							if(mxClient.IS_IE8){
								parent.dhtmlxUtils.message("该用户已经存在");
							}else{
								dhtmlxUtils.message("该用户已经存在");
							}
						}else{
							var text = deptTree.getItemText(id);
							user_myGrid.addRow(id, [text]);
						}
						user_myGrid.selectRowById(id);
					}
				}
			});
			//关系选择树
			relationTree.attachEvent("onDblClick", function(id){
				if(id == "alluser" || id == "draftuser" || id == "currentusergroup"){
					if(relation_myGrid.doesRowExist(id)){
						if(mxClient.IS_IE8){
							parent.dhtmlxUtils.message("该关系已经存在");
						}else{
							dhtmlxUtils.message("该关系已经存在");
						}
					}else{
						var text = relationTree.getItemText(id);
						relation_myGrid.addRow(id, [text]);
					}
					relation_myGrid.selectRowById(id);
				}else if(id == "draftdept" || id == "currentdept"){
					propUtils.createDeptAndPositionWin(myWin, relationTree, relation_myGrid, id);
				}else if(id == "stepuser"){
					propUtils.createStepuserWin(myWin, relationTree, relation_myGrid, id);
				}else if(id == "customfunction"){
					propUtils.createClWin(myWin, relationTree, relation_myGrid, id);
				}else if(id == "variable"){
					propUtils.createRelationVariableWin(myWin, relationTree, relation_myGrid, id);
				}else if(id == "expression"){
					
				}
			});
			//初始化已经选择的数据
			if($.notNull(str)){
				$.each(actorFactory.getActorsById(str), function(i, n){
					if(n.type == "dept"){
						var deptId = n.id;
						var deptName = n.name;
						if($.notNull(n.position)){
							deptId += "@@@" + n.position.id;
							deptName += "#" + n.position.name;
						}
						dept_myGrid.addRow(deptId, [deptName]);
					} else if(n.type == "user"){
						user_myGrid.addRow(n.id, [n.name]);
					} else if(n.type == "role"){
						role_myGrid.addRow(n.id, [n.name]);
					} else if(n.type == "group"){
						group_myGrid.addRow(n.id, [n.name]);
					} else if(n.type == "position"){
						position_myGrid.addRow(n.id, [n.name]);
					} else if(n.type == "relation"){
						var relationId = n.id;
						var relationName = n.name;
						if($.notNull(n.deptlevel)){
							relationId += "@@@" + n.deptlevel.id;
							relationName += "#" + n.deptlevel.name;
						}
						if($.notNull(n.position)){
							relationId += "@@@" + n.position.id;
							relationName += "#" + n.position.name;
						}
						if($.notNull(n.customfunction)){
							relationId += "@@@" + n.customfunction.id;
							relationName += "#" + n.customfunction.name;
						}
						if($.notNull(n.variableType)){
							relationId += "@@@" + n.variableType.id;
							relationName += "#" + n.variableType.name;
						}
						if($.notNull(n.variable)){
							relationId += "@@@" + n.variable.id;
							relationName += "#" + n.variable.name;
						}
						if($.notNull(n.step)){
							relationId += "@@@" + n.step.id;
							relationName += "#" + n.step.name;
						}
						// TO DO
						//未完待续脚本选人
						relation_myGrid.addRow(relationId, [relationName]);
					}
				});
			}
        });
		//定义toolbar
		var toolbar = myWin.attachToolbar({
			icons_path : _iconPath,
			items : [ {
				id : "ok",
				type : "button",
				text : "确定",
				img : "save.gif",
				img_disabled : "save_dis.gif"
			} ]
		});
		toolbar.attachEvent("onClick", function(id) {
			if (id == "ok") {
				if(!$.notNull(str)){
					str = guid();
				}
				actorFactory.clearActorsById(str);
				dept_myGrid.forEachRow(function(id) {
					var idObj = $.arr2Obj(id.split("@@@"), ["id","positionId"]);
					var textObj = $.arr2Obj(dept_myGrid.cellById(id, 0).getValue().split("#"), ["text","positionText"]);
					var actor = actorFactory.createActor("dept", idObj.id, textObj.text);
					if($.notNull(idObj.positionId)){
						actorFactory.addPosition(actor, idObj.positionId, textObj.positionText);
					}
					actorFactory.addActor(str, actor);
				});
				user_myGrid.forEachRow(function(id) {
					var text = user_myGrid.cellById(id, 0).getValue();
					var actor = actorFactory.createActor("user", id, text);
					actorFactory.addActor(str, actor);
				});
				role_myGrid.forEachRow(function(id) {
					var text = role_myGrid.cellById(id, 0).getValue();
					var actor = actorFactory.createActor("role", id, text);
					actorFactory.addActor(str, actor);
				});
				group_myGrid.forEachRow(function(id) {
					var text = group_myGrid.cellById(id, 0).getValue();
					var actor = actorFactory.createActor("group", id, text);
					actorFactory.addActor(str, actor);
				});
				position_myGrid.forEachRow(function(id) {
					var text = position_myGrid.cellById(id, 0).getValue();
					var actor = actorFactory.createActor("position", id, text);
					actorFactory.addActor(str, actor);
				});
				relation_myGrid.forEachRow(function(id) {
					if(id == "alluser" || id == "draftuser" || id == "currentusergroup"){
						var text = relation_myGrid.cellById(id, 0).getValue();
						var actor = actorFactory.createActor("relation", id, text);
						actorFactory.addActor(str, actor);
					}else if(id.indexOf("draftdept") == 0 || id.indexOf("currentdept") == 0){
						var idObj = $.arr2Obj(id.split("@@@"), ["id", "deptlevelId", "positionId"]);
						var textObj = $.arr2Obj(relation_myGrid.cellById(id, 0).getValue().split("#"), ["text", "deptlevelText", "positionText"]);
						var actor = actorFactory.createActor("relation", idObj.id, textObj.text);
						if($.notNull(idObj.positionId)){
							actorFactory.addPosition(actor, idObj.positionId, textObj.positionText);
						}
						if($.notNull(idObj.deptlevelId)){
							actorFactory.addDeptlevel(actor, idObj.deptlevelId, textObj.deptlevelText);
						}
						actorFactory.addActor(str, actor);
					}else if(id.indexOf("stepuser") == 0){
						var idObj = $.arr2Obj(id.split("@@@"), ["id", "stepId"]);
						var textObj = $.arr2Obj(relation_myGrid.cellById(id, 0).getValue().split("#"), ["text", "stepText"]);
						var actor = actorFactory.createActor("relation", idObj.id, textObj.text);
						if($.notNull(idObj.stepId)){
							actorFactory.addStep(actor, idObj.stepId, textObj.stepText);
						}
						actorFactory.addActor(str, actor);
					}else if(id.indexOf("customfunction") == 0){
						var idObj = $.arr2Obj(id.split("@@@"), ["id", "customfunctionId"]);
						var textObj = $.arr2Obj(relation_myGrid.cellById(id, 0).getValue().split("#"), ["text", "customfunctionText"]);
						var actor = actorFactory.createActor("relation", idObj.id, textObj.text);
						if($.notNull(idObj.customfunctionId)){
							actorFactory.addCustomfunction(actor, idObj.customfunctionId, textObj.customfunctionText);
						}
						actorFactory.addActor(str, actor);
					}else if(id.indexOf("variable") == 0){
						var idObj = $.arr2Obj(id.split("@@@"), ["id", "typeId", "variableId"]);
						var textObj = $.arr2Obj(relation_myGrid.cellById(id, 0).getValue().split("#"), ["text", "typeText", "variableText"]);
						var actor = actorFactory.createActor("relation", idObj.id, textObj.text);
						if($.notNull(idObj.variableId)){
							actorFactory.addVariable(actor, idObj.variableId, textObj.variableText);
						}
						if($.notNull(idObj.typeId)){
							actorFactory.addVariableType(actor, idObj.typeId, textObj.typeText);
						}
						actorFactory.addActor(str, actor);
					}else if(id.indexOf("expression") == 0){
						
					}
				});
				if(actorFactory.containsActorsById(str)){
					$(self).prev(".prop_txt").val(actorFactory.getActorsTextById(str));
					$(self).prev(".prop_txt").attr("actorsId", str);
				}else{
					$(self).prev(".prop_txt").val("");
					$(self).prev(".prop_txt").attr("actorsId", "");
				}
				myWin.close();
			}
		});
	},
	/*********************以下是选人框相关代码***************************************************************/
	/**
	 * 构建dhtmlXGridObject,存储选择项
	 * @param myForm
	 * @param container
	 * @param header
	 * @returns {dhtmlXGridObject}
	 */
	createPersonGrid : function(myForm, container, header){
		var myGrid = new dhtmlXGridObject(myForm.getContainer(container));
		myGrid.setImagePath(_imgPath + "dhxgrid_" + _skin + "/");
		myGrid.enableEditEvents(false, false, false);
		myGrid.setHeader(header);
		myGrid.setColAlign("left");
		myGrid.setColTypes("ed");
		myGrid.init();
		myGrid.attachEvent("onRowDblClicked", function(rId,cInd){
			myGrid.deleteRow(rId)
		});
		return myGrid;
	},
	/**
	 * 为普通选择树添加事件
	 * @param myTree
	 * @param myGrid
	 * @param name
	 */
	attachPersonTreeEvent : function(myTree, myGrid, name){
		myTree.attachEvent("onDblClick", function(id){
			if(id != "root"){
				if(myGrid.doesRowExist(id)){
					if(mxClient.IS_IE8){
						parent.dhtmlxUtils.message("该" + name + "已经存在");
					}else{
						dhtmlxUtils.message("该" + name + "已经存在");
					}
				}else{
					var text = myTree.getItemText(id);
					myGrid.addRow(id, [text]);
				}
				myGrid.selectRowById(id);
			}
		});
	},
	/**
	 * 岗位选择框
	 * @param parentWin
	 * @param deptTree
	 * @param dept_myGrid
	 * @param treeId
	 */
	createPositionWin : function(parentWin, deptTree, dept_myGrid, treeId){
		var myWin;
		if(mxClient.IS_IE8){
			myWin = parent.dhtmlxUtils.createModalWin("myWin", "岗位选择框", 300, _maxHeight);
		}else{
			myWin = dhtmlxUtils.createModalWin("myWin", "岗位选择框", 300, _maxHeight);
		}
		myWin.attachEvent("onClose", function(win){
			parentWin.setModal(true);
			return true;
		});
		myWin.denyResize();
		var myTree = myWin.attachTree();
		myTree.setImagePath(_imgPath + "dhxtree_" + _skin + "/");
		$.ajax({
			type : "GET",
			url : _controlPath + "getAllPositionList",
			dataType : "json",
			success : function(node) {
				var treeXml = propUtils.createTree();
				var root = propUtils.createTreeNode("root", "所有岗位", "avicit/org.gif");
				propUtils.addPositionTree(root, node);
				treeXml.appendChild(root);
				myTree.loadXMLString(ComUtils.getPrettyXml(treeXml));
				myTree.openItem("root");
				myTree.selectItem("root");
			}
		});
		//定义toolbar
		var toolbar = myWin.attachToolbar({
			icons_path : _iconPath,
			items : [ {
				id : "ok",
				type : "button",
				text : "确定",
				img : "save.gif",
				img_disabled : "save_dis.gif"
			} ]
		});
		toolbar.attachEvent("onClick", function(id) {
			if (id == "ok") {
				var dept_position_id = treeId;
				var dept_position_text = deptTree.getItemText(treeId);
				var positionId = myTree.getSelectedItemId();
				var positionText = myTree.getSelectedItemText();
				if(positionId != "root"){
					dept_position_id += "@@@" + positionId;
					dept_position_text += "#" + positionText;
				}
				if(dept_myGrid.doesRowExist(dept_position_id)){
					if(mxClient.IS_IE8){
						parent.dhtmlxUtils.message("该部门岗位已经存在");
					}else{
						dhtmlxUtils.message("该部门岗位已经存在");
					}
				}else{
					dept_myGrid.addRow(dept_position_id, [dept_position_text]);
				}
				dept_myGrid.selectRowById(dept_position_id);
				myWin.close();
			}
		});
	},
	/**
	 * 流程变量选择框
	 * @param parentWin
	 * @param relationTree
	 * @param relation_myGrid
	 * @param treeId
	 */
	createRelationVariableWin : function(parentWin, relationTree, relation_myGrid, treeId){
		var obj = propUtils.createChooseVWin();
    	if(!$.notNull(obj)){
    		return;
    	}
    	var myGrid = obj.myGrid;
        var toolbar = obj.toolbar;
        var addWin = obj.myWin;
        addWin.attachEvent("onClose", function(win){
			parentWin.setModal(true);
			return true;
		});
        toolbar.attachEvent("onClick", function(id) {
			if (id == "ok") {
				var selectedId = myGrid.getSelectedRowId();
				var cell = myGrid.cellById(selectedId, 1);
				var variable_id = treeId + "@@@user@@@#{" + cell.getValue() + "}";
				var variable_text = relationTree.getItemText(treeId) + "#用户#" + cell.getValue();
				if(relation_myGrid.doesRowExist(variable_id)){
					if(mxClient.IS_IE8){
						parent.dhtmlxUtils.message("该关系已经存在");
					}else{
						dhtmlxUtils.message("该关系已经存在");
					}
				}else{
					relation_myGrid.addRow(variable_id, [variable_text]);
				}
				relation_myGrid.selectRowById(variable_id);
				addWin.close();
			}
		});
	},
	/**
	 * 函数输入框
	 * @param parentWin
	 * @param relationTree
	 * @param relation_myGrid
	 * @param treeId
	 */
	createClWin : function(parentWin, relationTree, relation_myGrid, treeId){
        var obj = propUtils.createQxClWin();
        var myForm = obj.myForm;
        var toolbar = obj.toolbar;
        var addWin = obj.myWin;
        addWin.attachEvent("onClose", function(win){
			parentWin.setModal(true);
			return true;
		});
        toolbar.disableItem("ok");
        myForm.load(_designerPath + "config/form_cl.xml", function(){
        	myForm.hideItem("alias");
        });
        myForm.attachEvent("onInputChange", function(name, value) {
			if ($.trim(value) == "") {
				toolbar.disableItem("ok");
			} else {
				toolbar.enableItem("ok");
			}
		});
		toolbar.attachEvent("onClick", function(id) {
			if (id == "ok") {
				var name = myForm.getItemValue("name");
				var cl_id = treeId + "@@@" + name;
				var cl_text = relationTree.getItemText(treeId) + "#" + name;
				if(relation_myGrid.doesRowExist(cl_id)){
					if(mxClient.IS_IE8){
						parent.dhtmlxUtils.message("该关系已经存在");
					}else{
						dhtmlxUtils.message("该关系已经存在");
					}
				}else{
					relation_myGrid.addRow(cl_id, [cl_text]);
				}
				relation_myGrid.selectRowById(cl_id);
				addWin.close();
			}
		});
	},
	/**
	 * 某一节点处理人
	 * @param parentWin
	 * @param relationTree
	 * @param relation_myGrid
	 * @param treeId
	 */
	createStepuserWin : function(parentWin, relationTree, relation_myGrid, treeId){
        var obj = propUtils.createQxTaskWin();
        var myGrid = obj.myGrid;
        var toolbar = obj.toolbar;
        var addWin = obj.myWin;
        addWin.attachEvent("onClose", function(win){
			parentWin.setModal(true);
			return true;
		});
		toolbar.attachEvent("onClick", function(id) {
			if (id == "ok") {
				var selectedId = myGrid.getSelectedRowId();
				var name = myGrid.cellById(selectedId, 1).getValue();
				var alias = myGrid.cellById(selectedId, 2).getValue();
				var task_id = treeId + "@@@" + name;
				var task_text = relationTree.getItemText(treeId) + "#" + alias;
				if(relation_myGrid.doesRowExist(task_id)){
					if(mxClient.IS_IE8){
						parent.dhtmlxUtils.message("该关系已经存在");
					}else{
						dhtmlxUtils.message("该关系已经存在");
					}
				}else{
					relation_myGrid.addRow(task_id, [task_text]);
				}
				relation_myGrid.selectRowById(task_id);
				addWin.close();
			}
		});
	},
	/**
	 * 部门级别、岗位选择框
	 * @param parentWin
	 * @param relationTree
	 * @param relation_myGrid
	 * @param id
	 */
	createDeptAndPositionWin : function(parentWin, relationTree, relation_myGrid, treeId){
		var myWin;
		if(mxClient.IS_IE8){
			myWin = parent.dhtmlxUtils.createModalWin("myWin", "部门级别、岗位选择框", 300, _maxHeight);
		}else{
			myWin = dhtmlxUtils.createModalWin("myWin", "部门级别、岗位选择框", 300, _maxHeight);
		}
		myWin.attachEvent("onClose", function(win){
			parentWin.setModal(true);
			return true;
		});
		myWin.denyResize();
		var myLayout = myWin.attachLayout({
			pattern : "2E"
		});
		myLayout.cells("a").hideHeader();
		myLayout.cells("b").hideHeader();
		myLayout.cells("a").setHeight(70);
		myLayout.cells("a").fixSize(true, true);
		var myForm = myLayout.cells("a").attachForm();
		myForm.load(_designerPath + "config/form_deptlevel.xml");
		var myTree = myLayout.cells("b").attachTree();
		myTree.setImagePath(_imgPath + "dhxtree_" + _skin + "/");
		$.ajax({
			type : "GET",
			url : _controlPath + "getAllPositionList",
			dataType : "json",
			success : function(node) {
				var treeXml = propUtils.createTree();
				var root = propUtils.createTreeNode("root", "所有岗位", "avicit/org.gif");
				propUtils.addPositionTree(root, node);
				treeXml.appendChild(root);
				myTree.loadXMLString(ComUtils.getPrettyXml(treeXml));
				myTree.openItem("root");
				myTree.selectItem("root");
			}
		});
		//定义toolbar
		var toolbar = myWin.attachToolbar({
			icons_path : _iconPath,
			items : [ {
				id : "ok",
				type : "button",
				text : "确定",
				img : "save.gif",
				img_disabled : "save_dis.gif"
			} ]
		});
		toolbar.attachEvent("onClick", function(id) {
			if (id == "ok") {
				var arr = ["", "顶级部门", "上上级部门", "上级部门", "当前部门"];
				var deptlevel = myForm.getItemValue("deptlevel");
				var dept_position_id = treeId + "@@@" + deptlevel;
				var dept_position_text = relationTree.getItemText(treeId) + "#" + arr[deptlevel];
				var positionId = myTree.getSelectedItemId();
				var positionText = myTree.getSelectedItemText();
				if(positionId != "root"){
					dept_position_id += "@@@" + positionId;
					dept_position_text += "#" + positionText;
				}
				if(relation_myGrid.doesRowExist(dept_position_id)){
					if(mxClient.IS_IE8){
						parent.dhtmlxUtils.message("该关系已经存在");
					}else{
						dhtmlxUtils.message("该关系已经存在");
					}
				}else{
					relation_myGrid.addRow(dept_position_id, [dept_position_text]);
				}
				relation_myGrid.selectRowById(dept_position_id);
				myWin.close();
			}
		});
	},
	/*********************以下是树结构相关代码，暂时是全部读取、前台组装，后续需要改为异步加载数据，提高效率***********************/
	/**
	 * 组织
	 * @param parentXml
	 * @param node
	 */
	addOrgTree : function(parentXml, node) {
		$.each(node, function(i, n){
			var nodeXml = propUtils.createTreeNode(n.id, n.orgName, "avicit/org.gif");
			propUtils.addOrgTree(nodeXml, n.orgList);
			propUtils.addDeptTree(nodeXml, n.deptList);
			parentXml.appendChild(nodeXml);
		});
	},
	/**
	 * 正文模板树
	 * @param parentXml
	 * @param node
	 */
	addWordTempletTree : function(parentXml, node) {
		$.each(node, function(i, n){
			var nodeXml = propUtils.createTreeNode(n.id, n.bpmCatalogName, "folderClosed.gif");
			propUtils.addWordTempletTree(nodeXml, n.bpmCatalogList);
			parentXml.appendChild(nodeXml);
		});
	},
	/**
	 * 部门
	 * @param parentXml
	 * @param node
	 */
	addDeptTree : function(parentXml, node) {
		$.each(node, function(i, n){
			var userdatas = [ {
				name : "type",
				text : "dept"
			} ];
			var nodeXml = propUtils.createTreeNode(n.id, n.deptName, "avicit/dept.gif", userdatas);
			propUtils.addDeptTree(nodeXml, n.deptList);
			propUtils.addUserTree(nodeXml, n.userList);
			parentXml.appendChild(nodeXml);
		});
	},
	/**
	 * 人员
	 * @param parentXml
	 * @param node
	 */
	addUserTree : function(parentXml, node) {
		$.each(node, function(i, n){
			var userdatas = [ {
				name : "type",
				text : "user"
			} ];
			propUtils.addTreeNode(parentXml, n.id, n.userName, "avicit/user.gif", userdatas);
		});
	},
	/**
	 * 角色
	 * @param parentXml
	 * @param node
	 */
	addRoleTree : function (parentXml, node) {
		$.each(node, function(i, n){
			propUtils.addTreeNode(parentXml, n.id, n.roleName, "avicit/role.gif");
		});
	},
	/**
	 * 群组
	 * @param parentXml
	 * @param node
	 */
	addGroupTree : function (parentXml, node) {
		$.each(node, function(i, n){
			propUtils.addTreeNode(parentXml, n.id, n.groupName, "avicit/group.gif");
		});
	},
	/**
	 * 岗位
	 * @param parentXml
	 * @param node
	 */
	addPositionTree : function (parentXml, node) {
		$.each(node, function(i, n){
			propUtils.addTreeNode(parentXml, n.id, n.positionName, "avicit/position.gif");
		});
	},
	/**
	 * 构建树节点并添加到对应父节点上
	 * @param parentXml
	 * @param id
	 * @param text
	 * @param img
	 * @param userdatas
	 */
	addTreeNode : function(parentXml, id, text, img, userdatas){
		parentXml.appendChild(this.createTreeNode(id, text, img, userdatas));
	},
	/**
	 * 构建树节点
	 * @param id
	 * @param text
	 * @param img
	 * @param userdatas
	 * @returns
	 */
	createTreeNode : function(id, text, img, userdatas){
		var nodeXml = ComUtils.createElement("item");
		nodeXml.setAttribute("id", id);
		nodeXml.setAttribute("text", text);
		nodeXml.setAttribute("im0", img);
		nodeXml.setAttribute("im1", img);
		nodeXml.setAttribute("im2", img);
		if($.notNull(userdatas)){
			$.each(userdatas, function(i, n){
				var userdata = ComUtils.createElement("userdata");
				userdata.setAttribute("name", n.name);
				userdata.appendChild(ComUtils.createTextNode(n.text));
				nodeXml.appendChild(userdata);
			})
		}
		return nodeXml;
	},
	/**
	 * 构建树
	 * @returns
	 */
	createTree : function(){
		var treeXml = ComUtils.createElement("tree");
		treeXml.setAttribute("id", "0");
		return treeXml;
	}
};
/**
 * 定义actors操作类
 */
var actorFactory = {
	/**
	 * 存放所有的actors
	 */
	actors : new Map(),
	
	/**
	 * 获取actors,没有就创建一个
	 * @param id
	 * @returns
	 */
	getActorsById : function(id) {
		if (this.containsActorsById(id)) {
			return this.actors.get(id);
		}
		var actors = new Array();
		this.actors.put(id, actors);
		return actors;
	},
	/**
	 * 添加actor
	 * @param id
	 * @param actor
	 */
	addActor : function(id, actor) {
		this.getActorsById(id).push(actor);
	},
	/**
	 * 创建acotr
	 * @param type
	 * @param id
	 * @param name
	 * @returns {___anonymous27444_27448}
	 */
	createActor : function(type, id, name) {
		var actor = new Object();
		actor.type = type;
		actor.id = id;
		actor.name = name;
		return actor;
	},
	/**
	 * 添加position
	 * @param actor
	 * @param id
	 * @param name
	 */
	addPosition : function(actor, id, name) {
		var position = new Object();
		position.id = id;
		position.name = name;
		actor.position = position;
	},
	/**
	 * 添加部门级别
	 * @param actor
	 * @param id
	 * @param name
	 */
	addDeptlevel : function(actor, id, name) {
		var deptlevel = new Object();
		deptlevel.id = id;
		deptlevel.name = name;
		actor.deptlevel = deptlevel;
	},
	/**
	 * 添加自定义函数
	 * @param actor
	 * @param id
	 * @param name
	 */
	addCustomfunction : function(actor, id, name) {
		var customfunction = new Object();
		customfunction.id = id;
		customfunction.name = name;
		actor.customfunction = customfunction;
	},
	/**
	 * 添加流程变量
	 * @param actor
	 * @param id
	 * @param name
	 */
	addVariable : function(actor, id, name) {
		var variable = new Object();
		variable.id = id;
		variable.name = name;
		actor.variable = variable;
	},
	/**
	 * 流程变量中间夹杂着一个type，暂时不知是什么意思
	 * @param actor
	 * @param id
	 * @param name
	 */
	addVariableType : function(actor, id, name) {
		var variableType = new Object();
		variableType.id = id;
		variableType.name = name;
		actor.variableType = variableType;
	},
	/**
	 * 添加流程某一节点处理人
	 * @param actor
	 * @param id
	 * @param name
	 */
	addStep : function(actor, id, name) {
		var step = new Object();
		step.id = id;
		step.name = name;
		actor.step = step;
	},
	/**
	 * 清空actors,实际为删除
	 * @param id
	 */
	clearActorsById : function(id) {
		this.actors.remove(id);
	},
	/**
	 * 判断是否存在actors
	 * @param id
	 * @returns
	 */
	containsActorsById : function(id) {
		return this.actors.containsKey(id);
	},
	/**
	 * 返回文字描述的信息
	 * @param id
	 * @returns {String}
	 */
	getActorsTextById : function(id) {
		var deptStr = "";
		var userStr = "";
		var roleStr = "";
		var groupStr = "";
		var positionStr = "";
		var relationStr = "";
		$.each(this.getActorsById(id), function(i, n){
			if(n.type == "dept"){
				deptStr += n.name;
				if($.notNull(n.position)){
					deptStr += "#" + n.position.name;
				}
				deptStr += ";";
			} else if (n.type == "user"){
				userStr += n.name + ";";
			} else if (n.type == "role"){
				roleStr += n.name + ";";
			} else if (n.type == "group"){
				groupStr += n.name + ";";
			} else if (n.type == "position"){
				positionStr += n.name + ";";
			} else if (n.type == "relation"){
				relationStr += n.name;
				if($.notNull(n.deptlevel)){
					relationStr += "#" + n.deptlevel.name;
				}
				if($.notNull(n.position)){
					relationStr += "#" + n.position.name;
				}
				if($.notNull(n.customfunction)){
					relationStr += "#" + n.customfunction.name;
				}
				if($.notNull(n.variableType)){
					relationStr += "#" + n.variableType.name;
				}
				if($.notNull(n.variable)){
					relationStr += "#" + n.variable.name;
				}
				if($.notNull(n.step)){
					relationStr += "#" + n.step.name;
				}
				// TO DO
				//未完待续脚本选人
				relationStr += ";";
			}
		});
		var str = "";
		if($.notNull(deptStr)){
			str += "【部门】" + deptStr;
		}
		if($.notNull(userStr)){
			str += "【用户】" + userStr;
		}
		if($.notNull(roleStr)){
			str += "【角色】" + roleStr;
		}
		if($.notNull(groupStr)){
			str += "【群组】" + groupStr;
		}
		if($.notNull(positionStr)){
			str += "【岗位】" + positionStr;
		}
		if($.notNull(relationStr)){
			str += "【关系】" + relationStr;
		}
		return str;
	}
};