(function($){

	/**
	 * 用class名称加载
	 */
	$(function(){
		if($('.easyui-coding').length > 0){
			$('.easyui-coding').coding({});
		}
	});
	
	/**
	 * 创建编码选择
	 */
	function init(target){
		var t = $(target);
		t.addClass('coding-f').hide();
		var span = $(
				'<span class="combo">' +
				'<input type="text" class="combo-text" autocomplete="off" readonly="readonly" value="'+ t.val() +'">' +
				'<span><span class="combo-arrow"></span></span>' +
				'<input type="hidden" class="combo-value" value="'+ t.val() +'">' +
				'</span>'
				).insertAfter(target);
		
		var panel = $(
				'<div class="combo-panel">'+
				'<div class="easyui-layout">'+
					'<div region="center" border="false">'+
						'<div class="easyui-tabs" tabPosition="top" fit="true" border="false" style="padding:0px;" >'+
						'</div>'+
					'</div>'+
					'<div region="south" border="false" style="height: 30px;">'+
						'<div align="right" class="datagrid-toolbar" style="height: 26px;"></div>'+
					'</div>'+
				'</div></div>').appendTo('body');
		
		panel.panel({
			doSize: false,
			closed: true,
			cls:'combo-p',
			style:{
				position:'absolute',
				zIndex:10
			},
			onOpen:function(){
				$(this).panel('resize');
			},
			onClose:function(){
				var state = $.data(target, 'coding');
				if (state){
					//state.options.onHidePanel.call(target);
				}
			}
		});
		
		//加载layout
		var layout = panel.find(".easyui-layout");
		layout.layout({fit:true});
		
		//加载按钮
		var toolbar = layout.find('.datagrid-toolbar');
		var buttonConfrim = $('<a class="easyui-linkbutton" href="javascript:void(0);">确定</a>').appendTo(toolbar);
		buttonConfrim.linkbutton({plain:"true", iconCls:"icon-ok"});
		var buttonClear = $('<a class="easyui-linkbutton" href="javascript:void(0);">清除</a>').appendTo(toolbar);
		buttonClear.linkbutton({plain:"true", iconCls:"icon-cancel"});
		var buttonCancel = $('<a class="easyui-linkbutton" href="javascript:void(0);">关闭</a>').appendTo(toolbar);
		buttonCancel.linkbutton({plain:"true", iconCls:"icon-no"});
		
		//按钮增加事件
		buttonConfrim.bind('click', function(){
			var value = getCodingValue(target);
			var codingLengths = getCodingLengths(target);
			if(value != false){
				setValue(target, value);
		        hidenPanel(target);
		        $.data(target, 'coding').codingLengths = codingLengths;
			}
	    }); 
		buttonClear.bind('click', function(){    
			clear(target);
	    }); 
		buttonCancel.bind('click', function(){    
			hidenPanel(target);
	    });
		
		//加载tabs
		var tabs = panel.find(".easyui-tabs");
		tabs.tabs({});
		
		//替换input
		var name = $(target).attr('name');
		if (name){
			span.find('input.combo-value').attr('name', name);
			$(target).removeAttr('name').attr('comboName', name);
		}

		return {
			coding: span,
			panel: panel,
			tabs: tabs
		};
	}
	
	/**
	 * 修改大小
	 */
	function setSize(target){
		var state = $.data(target, 'coding');
		var opts = state.options;
		var coding = state.coding;
		var panel = state.panel;
		
		var c = $(target).clone();
		c.css('visibility','hidden');
		c.appendTo('body');
		var width = c.outerWidth();
		var height = c.outerHeight();
		c.remove();

		var input = coding.find('input.combo-text');
		var arrow = coding.find('.combo-arrow');
		var arrowWidth = arrow._outerWidth();
		
		coding._outerWidth(width)._outerHeight(height);
		input._outerWidth(coding.width() - arrowWidth);
		input.css({
			height: coding.height()+'px',
			lineHeight: coding.height()+'px'
		});
		arrow._outerHeight(coding.height());

		panel.panel('resize', {
			width: opts.panelWidth,
			height: opts.panelHeight
		});
		
		coding.insertAfter(target);
	}
	
	/**
	 * 绑定事件
	 */
	function bindEvents(target){
		var state = $.data(target, 'coding');
		var coding = state.coding;
		var panel = state.panel;
		var arrow = coding.find('.combo-arrow');

		arrow.bind('click.combo', function(){
			togglePanel.call(this);
		}).bind('mouseenter.combo', function(){
			$(this).addClass('combo-arrow-hover');
		}).bind('mouseleave.combo', function(){
			$(this).removeClass('combo-arrow-hover');
		});
		
		function togglePanel(){
			if (panel.is(':visible')){
				hidenPanel(target);
			} else {
				showPanel(target);
			}
		}
	}
	
	/**
	 * 加载默认值
	 */
	function setDefaultValue(target){
		var opts = $.data(target, 'coding').options;
		var value = getValue(target);
		//参数showDefaultValue为true，并且没有值的时候获取默认值
		if(opts.showDefaultValue == true && value == '' && opts.codingId != null && opts.codingId != undefined && opts.codingId != ''){
			var url = getPath() +'/platform/sysCodingSelectController/getDefaultCodingValue.json?baseId=' + opts.codingId;
			$.ajax({
		        cache: true,
		        type: "POST",
		        url: url,
		        dataType:"json",
		        async: false,
		        timeout:10000,
		        error: function(request) {
		        	alert("操作失败，服务请求状态："+request.status+" "+request.statusText+" 请检查服务是否可用！");
		        },
		        success: function(data) {
		        	if(data && data.defaultCodingValue && data.lengths){
		        		if(data.defaultCodingValue != ''){
		        			setValue(target, data.defaultCodingValue);
		        			//不同码段的长度
		        			var codingLengths = data.lengths.split(",");
		        			$.data(target, 'coding').codingLengths = codingLengths;
		        		}
					}
		        }
		    });
		}
	}
	
	/**
	 * 打开下拉页面
	 */
	function showPanel(target){
		var opts = $.data(target, 'coding').options;
		var coding = $.data(target, 'coding').coding;
		var panel = $.data(target, 'coding').panel;
		var tabs = $.data(target, 'coding').tabs;
		if ($.fn.window){
			panel.panel('panel').css('z-index', $.fn.window.defaults.zIndex++);
		}
		panel.panel('move', {
			left: coding.offset().left,
			top:getTop()
		});
		if (panel.panel('options').closed){
			//加载编码规则
			if(tabs.tabs('tabs').length == 0){
				if(opts.codingId && opts.codingId != ''){
					var url = getPath() +'/platform/sysCodingSelectController/getSysCodingData.json?baseId=' + opts.codingId;
					$.ajax({
				        cache: true,
				        type: "POST",
				        url: url,
				        dataType:"json",
				        async: false,
				        timeout:10000,
				        success: function(data) {
				        	if(data && data.segmentList){
				        		$.data(target, 'coding').segmentList = data.segmentList;
				        		for(var i = 0; i < data.segmentList.length; i++){
				        			var segment = data.segmentList[i];
				        			var codingList = data.codingList[i];

				        			tabs.tabs('add',{    
					    			    title:segment.segmentName,
					    			    content: getContent(segment, codingList, i),
					    			    selected: true,
					    			    closable: false
					    			});
				        			setCodingValues(segment, tabs, i, codingList);
				        			setCodingEvents(segment, tabs, i);
				        		}
				        		tabs.tabs('select', 0);
							}else{
								//编码不可使用的情况下
								tabs.tabs('add',{    
				    			    title:'提示',
				    			    content: '<div style="padding:5px 0 0 5px;color:blue;">编码不可用</div>', 
				    			    selected: true,
				    			    closable: false
				    			});
							}
				        }
				    });
				}else{
					//没有设置编码规则
					tabs.tabs('add',{    
	    			    title:'提示',
	    			    content: '<div style="padding:5px 0 0 5px;color:blue;">没有设置编码规则</div>', 
	    			    selected: true,
	    			    closable: false
	    			});
				}
			}
			
			panel.panel('open');
		}
		
		/**
		 * 左坐标
		 */
		function getLeft(){
			var left = coding.offset().left;
			if (left + panel._outerWidth() > $(window)._outerWidth() + $(document).scrollLeft()){
				left = $(window)._outerWidth() + $(document).scrollLeft() - panel._outerWidth();
			}
			if (left < 0){
				left = 0;
			}
			return left;
		}
		
		/**
		 * 高度坐标
		 */
		function getTop(){
			var top = coding.offset().top + coding._outerHeight();
			if (top + panel._outerHeight() > $(window)._outerHeight() + $(document).scrollTop()){
				top = coding.offset().top - panel._outerHeight();
			}
			if (top < $(document).scrollTop()){
				top = coding.offset().top + coding._outerHeight();
			}
			return top;
		}
		
		/**
		 * 获取码段的展现内容(多个选项为下拉框，日期和时间为时间选择，流水码和随机数为span)
		 */
		function getContent(segment){
			var content = '';
			if(segment.segmentType == '4'){
				if(segment.classify == '1'){
					content = '<table border="0"><tr>'
					   + '<td align="right" width="50px">随机数:</td><td><span name="uuid" style="padding:0 0 0 5px;color:blue;" ></span></td></tr></table>';
				}else{
					if(segment.isCurrentTime == 'Y'){
						content = '<table border="0"><tr>'
							+ '<td align="right" width="50px">时   间:</td><td><span name="currentTime" style="padding:0 0 0 5px;color:blue;" ></span></td></tr></table>';
					}else{
						if(segment.format.indexOf('HHmmss') > -1){
							content = '<input type="text" class="easyui-datetimebox" style="width: '+ (opts.panelWidth - 5) +'px;" />';
						}else{
							content = '<input type="text" class="easyui-datebox" style="width: '+ (opts.panelWidth - 5) +'px;" />';
						}
					}
				}
			}else if(segment.segmentType == '3'){
				if(opts.multiSerial){
					content = '<table style="width: '+ (opts.panelWidth - 5) +'px;" border="0"><tr>'
							+ '<td align="right" width="50px">流水号:</td><td><span name="serialNumber" style="padding:0 0 0 5px;color:blue;" ></span></td>'
						    + '<td align="right">数目:</td><td width="65px"><input type="text" class="easyui-numberspinner" value="1"/></td></tr></table>';
				}else{
					content = '<table style="width: '+ (opts.panelWidth - 5) +'px;" border="0"><tr>'
					+ '<td align="right" width="50px">流水号:</td><td><span name="serialNumber" style="padding:0 0 0 5px;color:blue;" ></span></td></tr></table>';
				}
			}else{
				content = '<input type="text" class="easyui-combobox" style="width: '+ (opts.panelWidth - 5) +'px;" data-options="valueField:\'code\',textField:\'name\',panelHeight : \'auto\'" />';
			}

			return content;
		}
		
		/**
		 * 增加码值
		 */
		function setCodingValues(segment, tabs, index, codingList){
			var tab = tabs.tabs('getTab', index);
			var value = "";
			if(codingList[0] && codingList[0].name){
				value = codingList[0].name;
			}
			if(segment.segmentType == '4'){
				if(segment.classify == '1'){
					tab.find('span[name="uuid"]').text(value);
				}else{
					if(segment.isCurrentTime == 'Y'){
						tab.find('span[name="currentTime"]').text(value);
					}
				}
			}else if(segment.segmentType == '3'){
				tab.find('span[name="serialNumber"]').text(value);
			}else{
				if(segment.segmentRelation != null && segment.segmentRelation != ''){
					tab.find('.easyui-combobox').combobox({
					});
				}else{
					tab.find('.easyui-combobox').combobox({
						data: codingList
					});
				}
			}
		}
		
		/**
		 * 增加事件
		 */
		function setCodingEvents(segment, tabs, index){
			var tab = tabs.tabs('getTab', index);
			if(segment.segmentType == '4' && segment.classify == '2' && segment.isCurrentTime == 'N'){
				if(segment.format.indexOf('HHmmss') > -1){
					tab.find('.easyui-datetimebox').datetimebox({
						required:true,
						editable: false,
						onChange: function(newValue, oldValue){
							doSelectCoding(target, index);
						}
					});
				}else{
					tab.find('.easyui-datebox').datebox({
						required:true,
						editable: false,
						formatter: function(date){
							return date.format(segment.format);
						},
						onChange: function(newValue, oldValue){
							doSelectCoding(target, index);
						}
					});
				}
			}else if(segment.segmentType == '3'){
				tab.find('.easyui-numberspinner').numberspinner({
					required:true,
					min:1,
					max:100,
					width: 60,
					height: 20,
					editable: true
				});
			}else if(segment.segmentType == '1' || segment.segmentType == '2'){
				tab.find('.easyui-combobox').combobox({
					onChange: function(newValue, oldValue){
						doChangeCoding(target, index, newValue, oldValue);
					}
				});
			}
		}
	}
	
	/**
	 * 关闭下拉页面
	 */
	function hidenPanel(target){
		var panel = $.data(target, 'coding').panel;
		panel.panel('close');
	}
	
	/**
	 * 得到编码规则ID
	 */
	function getCodingId(target){
		var state = $.data(target, 'coding');
		var opts = state.options;
		return opts.codingId;
	}
	
	/**
	 * 设置编码规则ID
	 */
	function setCodingId(target, value){
		var state = $.data(target, 'coding');
		var opts = state.options;
		var oldCodingId = opts.codingId;
		opts.codingId = value;
		if(oldCodingId != value){
			//清空tabs
			var tabs = state.tabs;
			if(tabs && tabs.tabs('tabs').length > 0){
				tabs.children().remove();
				tabs.removeClass('tabs-container');
				var tabsParent = tabs.parent();
				var tabsHtml = tabsParent.html();
				tabs.remove();
				tabsParent.append(tabsHtml);
				var newTabs = tabsParent.find(".easyui-tabs");
				newTabs.tabs({});
				state.tabs = newTabs
			}
			//设置默认值
			setDefaultValue(target);
		}
	}
	
	/**
	 * 获取值
	 */
	function getValue(target){
		var state = $.data(target, 'coding');
		var coding = state.coding;
		return coding.find('input.combo-value').val();
	}
	
	/**
	 * 设置值
	 */
	function setValue(target, value){
		var state = $.data(target, 'coding');
		var coding = state.coding;
		coding.find('input.combo-value').val(value);
		coding.find('input.combo-text').val(value);
	}
	
	/**
	 * 获取每个码段长度
	 */
	function getLengths(target){
		var state = $.data(target, 'coding');
		var codingLengths = state.codingLengths;
		if(codingLengths != null){
			return codingLengths.join(",");
		}
		return null;
	}

	/**
	 * 清除内容
	 */
	function clear(target){
		var state = $.data(target, 'coding');
		var coding = state.coding;
		coding.find('input.combo-value').val('');
		coding.find('input.combo-text').val('');
	}
	
	/**
	 * 摧毁方法
	 */
	function destroy(target){
		var state = $.data(target, 'coding');
		state.panel.panel('destroy');
		state.coding.remove();
		$(target).remove();
	}
	
	/**
	 * 选择码值
	 */
	function doChangeCoding(target, index, newValue, oldValue){
		var state = $.data(target, 'coding');
		var tabs = state.tabs;
		if(index < tabs.tabs('tabs').length - 1){
			tabs.tabs('select', index + 1);
			clearCoding(target, index);
			if(isSelectedValue(target, index + 1)){
				loadCoding(target, index + 1);
			}
			loadSerialNumber(target);
		}
	}
	
	/**
	 * 选择码值(计算码：日期和时间)
	 */
	function doSelectCoding(target, index){
		var state = $.data(target, 'coding');
		var tabs = state.tabs;
		if(index < tabs.tabs('tabs').length - 1){
			tabs.tabs('select', index + 1);
			clearCoding(target, index);
			loadSerialNumber(target);
		}
	}

	/**
	 * 清除之后依赖本码段的码值
	 */
	function clearCoding(target, index){
		var state = $.data(target, 'coding');
		var tabs = state.tabs;
		var segmentList = state.segmentList;
		if(segmentList == null || segmentList == undefined){
			return false;
		}
		
		var lastIndex = tabs.tabs('tabs').length;
		var beginIndex = index + 1;
		for(var i = beginIndex; i < lastIndex; i++){
			var segment = segmentList[i];
			var tab = tabs.tabs('getTab', i);
			if(segment.segmentType == '3'){
				var segmentRelation = segment.segmentRelation;
				if(segmentRelation && isDependIndex(index)){
					tab.find('span[name="serialNumber"]').text('');
				}
			}else if(segment.segmentType == '1' || segment.segmentType == '2'){
				var segmentRelation = segment.segmentRelation;
				if(segmentRelation && isDependIndex(index)){
					tab.find('.easyui-combobox').combobox('clear');
				}
			}
		}
		
		/**
		 * 是否依赖本码段
		 */
		function isDependIndex(index){
			var idDepend = false;
			var relations = segmentRelation.split("@@");
			for(var i = 0; i < relations.length; i++){
				var dependIndex = parseInt(relations[i]) - 1;
				if(index == dependIndex){
					idDepend = true;
					break;
				}
			}
			return idDepend;
		}
	}
	
	/**
	 * 加载流水码
	 */
	function loadSerialNumber(target){
		var state = $.data(target, 'coding');
		var tabs = state.tabs;
		var lastIndex = tabs.tabs('tabs').length;
		var segmentList = state.segmentList;
		if(segmentList == null || segmentList == undefined){
			return false;
		}
		//获取流水号信息(只考虑只有一个流水号)
		var isHasSerial = false;//是否有流水号
		var serialIndex = -1; 
		for(var i = 0; i < lastIndex; i++){
			var segment = segmentList[i];
			if(segment.segmentType == '3'){
				isHasSerial = true;
				serialIndex = i;
				break;
			}
		}
		//判断是否存在流水码
		if(isHasSerial == true){
			var segment = segmentList[serialIndex];
			var segmentRelation = segment.segmentRelation;
			if(segmentRelation && getSegmentValue(target, serialIndex) == ''){
				loadCoding(target, serialIndex);
			}
		}
	}
	
	/**
	 * 是否已经选择必要的值
	 */
	function isSelectedValue(target, index){
		var state = $.data(target, 'coding');
		var tabs = state.tabs;
		var segmentList = state.segmentList;
		if(segmentList == null || segmentList == undefined){
			return false;
		}
		var isSelected = true;
		var segment = segmentList[index];
		var segmentRelation = segment.segmentRelation;
		if(segmentRelation){
			var relations = segmentRelation.split("@@");
			for(var i = 0; i < relations.length; i++){
				var index = parseInt(relations[i]) - 1;
				var value = getSegmentValue(target, index);
				if(value == null || value == ""){
					isSelected = false;
					break;
				}
			}
		}
		return isSelected;
	}
	
	/**
	 * 获取码值
	 */
	function loadCoding(target, index){
		var state = $.data(target, 'coding');
		var opts = state.options;
		var codingId = opts.codingId;
		var tabs = state.tabs;
		var lastIndex = tabs.tabs('tabs').length;
		var tab = tabs.tabs('getTab', index);
		var segmentList = state.segmentList;
		if(codingId == null || codingId == undefined || codingId == ''){
			return;
		}
		if(segmentList == null || segmentList == undefined){
			return;
		}
		if(getSegmentValue(target, index) != ''){
			if(index < lastIndex){
				tabs.tabs('select', index + 1);
			}
			return;
		}
		
		var segment = segmentList[index];
		if(segment.segmentType != '4'){
			if(segment.segmentRelation){
				getSegmentValuesData();
			}else{
				if(segment.segmentType == '1' || segment.segmentType == '2'){
					var data = tab.find('.easyui-combobox').combobox('getData');
					if(data.length == 1){
						tab.find('.easyui-combobox').combobox('setValue', data[0].code);
					}else{
						tab.find('.easyui-combobox').combobox('showPanel');
					}
				}
			}
		}
		
		function getSegmentValuesData(){
			var param = {
				baseId: codingId,
				segmentIndex: segment.segmentIndex
			};
			for(var i = 0; i < index; i++){
				param['segmentValue' + (i + 1)] = getSegmentValue(target, i);
			}

			$.ajax({
		        cache: true,
		        type: "POST",
		        url: getPath() + '/platform/sysCodingSelectController/getSegmentValuesData.json',
		        data : param,
		        dataType:"json",
		        async: false,
		        timeout:10000,
		        error: function(request) {
		        	
		        },
		        success: function(data) {
		        	doSuccess(data);
		        }
		    });
		}
		
		function doSuccess(data){
			if(segment.segmentType == '1' || segment.segmentType == '2'){
				tab.find('.easyui-combobox').combobox('loadData',data);
				if(data.length == 1){
					tab.find('.easyui-combobox').combobox('setValue', data[0].code);
				}else{
					tab.find('.easyui-combobox').combobox('showPanel');
				}
			}else if(segment.segmentType == '3'){
				tab.find('span[name="serialNumber"]').text(data[0].name);
			} 
		}
	}
	
	/**
	 * 获取码段的值
	 */
	function getSegmentValue(target, index){
		var state = $.data(target, 'coding');
		var tabs = state.tabs;
		var tab = tabs.tabs('getTab', index);
		var segmentList = state.segmentList;
		if(segmentList == null || segmentList == undefined){
			return false;
		}
		var segment = segmentList[index];
		
		var value = "";
		if(segment.segmentType == '4'){
			if(segment.classify == '1'){
				value = tab.find('span[name="uuid"]').text();
			}else{
				if(segment.isCurrentTime == 'Y'){
					value = tab.find('span[name="currentTime"]').text();
				}else{
					if(segment.format.indexOf('HHmmss') > -1){
						var obj = tab.find('.easyui-datetimebox');
						value = obj.datetimebox('getValue');
						if(value){
							var opts = obj.datetimebox('options');
							var date = opts.parser.call(obj, value);
							value = date.format(segment.format);
						}
					}else{
						var obj = tab.find('.easyui-datebox');
						value = obj.datebox('getValue');
					}
				}
			}
		}else if(segment.segmentType == '3'){
			value = tab.find('span[name="serialNumber"]').text();
		}else{
			value = tab.find('.easyui-combobox').combobox('getValue');
		}
		return value;
	}
	
	/**
	 * 获取流水号批量数量
	 */
	function getSerialCount(target, index){
		var state = $.data(target, 'coding');
		var opts = state.options;
		var tabs = state.tabs;
		var tab = tabs.tabs('getTab', index);
		var segmentList = state.segmentList;
		var segment = segmentList[index];
		
		var count = 1;
		
		if(segment.segmentType == '3' && opts.multiSerial == true){
			count = tab.find('.easyui-numberspinner').numberspinner('getValue');
			count = parseInt(count, 10);
		}
		return count;
	}	
	
	/**
	 * 得到格式化后的流水码
	 */
	function getFormatSerialNumber(serialNumber, segmentLength){
		var formatSerialNumber = serialNumber;
		var serialLength = (serialNumber + "").length;
		for(var i = 0; i < segmentLength - serialLength; i++){
			formatSerialNumber = '0' + formatSerialNumber;
		}
		return formatSerialNumber;
	}

	/**
	 * 返回生成的编码
	 */
	function getCodingValue(target){
		var state = $.data(target, 'coding');
		var opts = state.options;
		var tabs = state.tabs;
		var segmentList = state.segmentList;
		if(segmentList == null || segmentList == undefined){
			return false;
		}
		var codingValue = "";
		var lastIndex = tabs.tabs('tabs').length;
		
		//获取流水号信息(只考虑只有一个流水号)
		var isHasSerial = false;//是否有流水号
		var serialCount = 1;
		var serialIndex = -1; 
		for(var i = 0; i < lastIndex; i++){
			var segment = segmentList[i];
			if(segment.segmentType == '3'){
				isHasSerial = true;
				serialIndex = i;
				serialCount = getSerialCount(target, i);
				break;
			}
		}

		if(isHasSerial == true && serialCount > 1){
			for(var j = 0; j < serialCount; j++){
				for(var i = 0; i < lastIndex; i++){
					var segmentValue = getSegmentValue(target, i);
					if(segmentValue != null && segmentValue != ''){
						var segment = segmentList[i];
						var segmentPrefixion = '';
						var segmentSuffix = '';
						if(segment != null && segment.segmentPrefixion != null){
							segmentPrefixion = segment.segmentPrefixion;
						}
						if(segment != null && segment.segmentSuffix != null){
							segmentSuffix = segment.segmentSuffix;
						}
						
						if(serialIndex == i){
							var serialNumber = parseInt(segmentValue, 10) + j * parseInt(segment.serialStep, 10);
							var formatSerialNumber = getFormatSerialNumber(serialNumber, segment.segmentLength);
							codingValue += segmentPrefixion + formatSerialNumber + segmentSuffix;
						}else{
							codingValue += segmentPrefixion + segmentValue + segmentSuffix;
						}
					}else{
						return false;
					}
				}
				
				//增加分隔符
				if(j < serialCount - 1){
					codingValue += opts.separator;
				}
			}
		}else{
			for(var i = 0; i < lastIndex; i++){
				var segmentValue = getSegmentValue(target, i);
				if(segmentValue != null && segmentValue != ''){
					var segment = segmentList[i];
					var segmentPrefixion = '';
					var segmentSuffix = '';
					if(segment != null && segment.segmentPrefixion != null){
						segmentPrefixion = segment.segmentPrefixion;
					}
					if(segment != null && segment.segmentSuffix != null){
						segmentSuffix = segment.segmentSuffix;
					}
					codingValue += segmentPrefixion + segmentValue + segmentSuffix;
				}else{
					return false;
				}
			}
		}
		
		return codingValue;
	}
	
	/**
	 * 返回生成的编码的每个码段长度
	 */
	function getCodingLengths(target){
		var state = $.data(target, 'coding');
		var tabs = state.tabs;
		var segmentList = state.segmentList;
		
		if(segmentList == null || segmentList == undefined){
			return false;
		}
		var lastIndex = tabs.tabs('tabs').length;
		
		var segmentValueLength = [];//不同码段的长度
		for(var i = 0; i < lastIndex; i++){
			var segmentValue = getSegmentValue(target, i);
			if(segmentValue != null && segmentValue != ''){
				segmentValueLength.push(segmentValue.length);
			}else{
				return false;
			}
		}
		
		return segmentValueLength;
	}
	
	/**
	 * 构造方法
	 */
	$.fn.coding = function(options, param){
		if (typeof options == 'string'){
			return $.fn.coding.methods[options](this, param);
		}
		options = options || {};
		return this.each(function(){
			var state = $.data(this, 'coding');
			if (state){
				$.extend(state.options, options);
			} else {
				var r = init(this);
				state = $.data(this, 'coding', {
					options: $.extend({}, $.fn.coding.defaults, $.fn.coding.parseOptions(this), options),
					coding: r.coding,
					panel: r.panel,
					tabs: r.tabs,
					previousValue: null
				});
				$(this).removeAttr('disabled');
			}
			setSize(this);
			bindEvents(this);
			setDefaultValue(this);
		});
	};
	
	/**
	 * 方法
	 */
	$.fn.coding.methods = {
		options: function(jq){
			return $.data(jq[0], 'coding').options;
		},
		panel: function(jq){
			return $.data(jq[0], 'coding').panel;
		},
		getCodingId: function(jq){
			return getCodingId(jq[0]);
		},
		setCodingId: function(jq, value){
			return jq.each(function(){
				setCodingId(this, value);
			});
		},
		clear: function(jq){
			return jq.each(function(){
				clear(this);
			});
		},
		getValue: function(jq){
			return getValue(jq[0]);
		},
		setValue: function(jq, value){
			return jq.each(function(){
				setValue(this, value);
			});
		},
		getLengths: function(jq){
			return getLengths(jq[0]);
		},
		destroy: function(jq){
			return jq.each(function(){
				destroy(this);
			});
		}
	};
	
	/**
	 * 获取参数
	 */
	$.fn.coding.parseOptions = function(target){
		var t = $(target);
		return $.extend({}, $.parser.parseOptions(target, [
			 'codingId','separator',{panelWidth:'number',panelHeight:'number', multiSerial:'boolean', showDefaultValue:'boolean'}
		]), {
			codingId: t.attr('codingId') || undefined,
			separator: t.attr('separator') || undefined,
			panelWidth: parseInt(t.attr('panelWidth'), 10) || undefined,
			panelHeight: parseInt(t.attr('panelHeight'), 10) || undefined,
			multiSerial: (t.attr('multiSerial') ? (t.attr('multiSerial') == 'true') : undefined),
			showDefaultValue: (t.attr('showDefaultValue') ? ((t.attr('showDefaultValue') == 'false') ? false: true) : undefined)
		});
		
	};

	/**
	 * 默认参数
	 */
	$.fn.coding.defaults = {
		codingId: '',
		separator: ',',
		panelWidth: 300,
		panelHeight: 87,
		multiSerial: false,
		showDefaultValue: true
	};
})(jQuery);

/**
 * 这里用到一个javascript的Date类型的拓展方法，这个是自己添加的拓展方法
 * @param format
 * @returns
 */
Date.prototype.format = function (format) {
    var o = {           
   	    "M+" : this.getMonth()+1, //月份            
   	    "d+" : this.getDate(), //日            
   	    "h+" : this.getHours()%12 == 0 ? 12 : this.getHours()%12, //小时            
   	    "H+" : this.getHours(), //小时            
   	    "m+" : this.getMinutes(), //分            
   	    "s+" : this.getSeconds(), //秒            
   	    "q+" : Math.floor((this.getMonth()+3)/3), //季度            
   	    "S" : this.getMilliseconds() //毫秒            
   	};       
    
    if (/(y+)/.test(format)){
    	format = format.replace(RegExp.$1,(this.getFullYear() + "").substr(4 - RegExp.$1.length));
    }
    
    for (var k in o) {
    	if (new RegExp("(" + k + ")").test(format)){
    		format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
    	}
    }
    return format;
};

/**
 * 返回path
 * @returns
 */
function getPath(){
	var localObj = window.location;
  	var contextPath = localObj.pathname.split("/")[1];
  	if (contextPath != ""){
  		contextPath = "/" + contextPath;
  	}
  	return contextPath;
}