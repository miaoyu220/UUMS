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
		var span = $('<span><input type="hidden" class="coding-value" value="'+ t.val() +'"></span>').insertAfter(target);
		//替换input
		var name = $(target).attr('name');
		if (name){
			span.find('input.coding-value').attr('name', name);
			$(target).removeAttr('name').attr('oldName', name);
		}

		return {
			coding: span
		};
	}
	
	/**
	 * 展示页面
	 */
	function showCoding(target){
		var opts = $.data(target, 'coding').options;
		var coding = $.data(target, 'coding').coding;

		if((opts.codingId && opts.codingId != '') || (opts.codingName && opts.codingName != '')){
			var url = getPath() +'/platform/sysCodingSelectController/getSysCodingData.json';
			$.ajax({
		        cache: true,
		        type: "POST",
		        url: url,
		        data : {baseId: opts.codingId, codingName: opts.codingName},
		        dataType:"json",
		        async: false,
		        timeout:10000,
		        success: function(data) {
		        	if(data && data.segmentList){
		        		if(opts.codingId == null || opts.codingId == ''){
		        			opts.codingId = data.baseId;
		        		}
		        		$.data(target, 'coding').segmentList = data.segmentList;
		        		for(var i = 0; i < data.segmentList.length; i++){
		        			var segment = data.segmentList[i];
		        			var codingList = data.codingList[i];
		        			var divSelect = $('<div class="coding-div" style="float:left;padding:0 2px 0 2px;"></div>');
		        			coding.append(divSelect);
		        			divSelect.append(getContent(segment));
		        			setCodingValues(segment, divSelect, codingList);
		        			setCodingEvents(segment, divSelect, i);
		        		}
		        		//如果第一个码段是分类码或者特征码，如果只有一个选项默认选上
		        		if(data.segmentList.length > 0){
		        			var divSelect = $(coding.find('div.coding-div')[0]);
		        			var segment = data.segmentList[0];
		        			var codingList = data.codingList[0];
		        			if(segment.segmentType == '1' || segment.segmentType == '2'){
		        				if(codingList.length == 1){
									divSelect.find('.easyui-combobox').combobox('setValue', codingList[0].code);
								}
		        			}
		        		}
		        		//加载流水码
		        		loadSerialNumber(target);
					}
		        }
		    });
		}
		
		/**
		 * 获取码段的展现内容(多个选项为下拉框，日期和时间为时间选择，流水码和随机数为span)
		 */
		function getContent(segment){
			var content = '';
			var segmentPrefixion = '';
			var segmentSuffix = '';
			if(segment != null && segment.segmentPrefixion != null){
				segmentPrefixion = segment.segmentPrefixion;
			}
			if(segment != null && segment.segmentSuffix != null){
				segmentSuffix = segment.segmentSuffix;
			}
			content += segmentPrefixion;
			
			if(segment.segmentType == '4'){
				if(segment.classify == '1'){
					content += '<span name="uuid" style="line-height:20px;"></span>';
				}else{
					if(segment.isCurrentTime == 'Y'){
						content += '<span name="currentTime" style="line-height:20px;"></span>';
					}else{
						if(segment.format.indexOf('HHmmss') > -1){
							content += '<input type="text" class="easyui-datetimebox" style="width: 140px;"/>';
						}else{
							var width = segment.format.length * 8 + 20;
							content += '<input type="text" class="easyui-datebox" style="width: '+ width +'px;"/>';
						}
					}
				}
			}else if(segment.segmentType == '3'){
				var width = segment.segmentLength * 7 + 10;
				content += '<input type="text" class="easyui-numberbox" style="width: '+ width +'px;text-align: center;" readonly="true" value="" />';
			}else{
				content += '<input type="text" class="easyui-combobox" style="width: 80px;" data-options="valueField:\'code\',textField:\'name\',panelHeight : \'auto\'" />';
			}
			content += segmentSuffix;
			return content;
		}
		
		/**
		 * 增加码值
		 */
		function setCodingValues(segment, divSelect, codingList){
			var value = "";
			if(codingList[0] && codingList[0].name){
				value = codingList[0].name;
			}
			if(segment.segmentType == '4'){
				if(segment.classify == '1'){
					divSelect.find('span[name="uuid"]').text(value);
				}else{
					if(segment.isCurrentTime == 'Y'){
						divSelect.find('span[name="currentTime"]').text(value);
					}
				}
			}else if(segment.segmentType == '3'){
				var segmentLength = segment.segmentLength;
				divSelect.find('.easyui-numberbox').numberbox({    
				    min: segment.serialNumberStart,
				    max: segment.serialNumberEnd,
				    value: value,
				    formatter: function(value){
				    	var returnValue = '';
				    	if(value != null && value != ''){
				    		returnValue = value + '';
				    		if(segmentLength != null && segmentLength != '' && segmentLength > 0){
				    			if (value.length < segmentLength){
				    				for(var i = value.length; i < segmentLength; i++){
				    					returnValue = '0' + returnValue;
				    				}
				    			}
				    		}
				    	}
				    	return returnValue;
				    }
				}); 
			}else{
				var maxWidth = 0;
				for(var cIndex = 0; cIndex < codingList.length; cIndex++){
					var name = codingList[cIndex].name;
					var hzNumber = name.getHzNumber();
					var upperNumber = name.getUpperNumber();
					var otherNumber = name.length - hzNumber - upperNumber;
					var thisWidth = parseInt(hzNumber * 12 + upperNumber * 8 + otherNumber * 6.7);
					if(thisWidth > maxWidth){
						maxWidth = thisWidth;
					}
				}
				if(segment.segmentRelation != null && segment.segmentRelation != ''){
					divSelect.find('.easyui-combobox').combobox({
						width: maxWidth + 30
					});
				}else{
					divSelect.find('.easyui-combobox').combobox({
						data: codingList,
						width: maxWidth + 30
					});
				}
			}
		}
		
		/**
		 * 增加事件
		 */
		function setCodingEvents(segment, divSelect, index){
			if(segment.segmentType == '4' && segment.classify == '2' && segment.isCurrentTime == 'N'){
				if(segment.format.indexOf('HHmmss') > -1){
					divSelect.find('.easyui-datetimebox').datetimebox({
						required:true,
						editable: false,
						onChange: function(newValue, oldValue){
							doSelectCoding(target, index);
						}
					});
				}else{
					divSelect.find('.easyui-datebox').datebox({
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
			}else if(segment.segmentType == '1' || segment.segmentType == '2'){
				divSelect.find('.easyui-combobox').combobox({
					onChange: function(newValue, oldValue){
						doChangeCoding(target, index, newValue, oldValue);
					}
				});
			}
		}
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
			state.coding.find('.easyui-combobox').combobox('destroy');
			state.coding.find('.easyui-datebox').datebox('destroy');
			state.coding.find('.easyui-datetimebox').datetimebox('destroy');
			state.coding.find('.easyui-numberbox').numberbox('destroy');
			state.coding.find('div.coding-div').remove();
			showCoding(target);
		}
	}
	
	/**
	 * 获取值
	 */
	function getValue(target){
		var state = $.data(target, 'coding');
		var coding = state.coding;
		var value = getCodingValue(target);
		if(value != false){
			setValue(target, value);
		}
		return coding.find('input.coding-value').val();
	}
	
	/**
	 * 设置值
	 */
	function setValue(target, value){
		var state = $.data(target, 'coding');
		var coding = state.coding;
		coding.find('input.coding-value').val(value);
	}
	
	/**
	 * 获取每个码段长度
	 */
	function getLengths(target){
		var state = $.data(target, 'coding');
		var codingLengths = getCodingLengths(target);
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
		coding.find('input.coding-value').val('');
	}
	
	/**
	 * 摧毁方法
	 */
	function destroy(target){
		var state = $.data(target, 'coding');
		state.coding.find('.easyui-combobox').combobox('destroy');
		state.coding.find('.easyui-datebox').datebox('destroy');
		state.coding.find('.easyui-datetimebox').datetimebox('destroy');
		state.coding.find('.easyui-numberbox').numberbox('destroy');
		state.coding.remove();
		$(target).remove();
	}
	
	/**
	 * 选择码值
	 */
	function doChangeCoding(target, index, newValue, oldValue){
		var state = $.data(target, 'coding');
		var lastIndex = state.coding.find('div.coding-div').length;
		if(index < lastIndex - 1){
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
		var lastIndex = state.coding.find('div.coding-div').length;
		if(index < lastIndex - 1){
			clearCoding(target, index);
			loadSerialNumber(target);
		}
	}
	
	/**
	 * 清除之后依赖本码段的码值
	 */
	function clearCoding(target, index){
		var state = $.data(target, 'coding');
		var segmentList = state.segmentList;
		if(segmentList == null || segmentList == undefined){
			return false;
		}
		
		var lastIndex = state.coding.find('div.coding-div').length;
		var beginIndex = index + 1;
		for(var i = beginIndex; i < lastIndex; i++){
			var segment = segmentList[i];
			var divSelect = $(state.coding.find('div.coding-div')[i]);
			if(segment.segmentType == '3'){
				var segmentRelation = segment.segmentRelation;
				if(segmentRelation && isDependIndex(index)){
					divSelect.find('.easyui-numberbox').numberbox('clear');
				}
			}else if(segment.segmentType == '1' || segment.segmentType == '2'){
				var segmentRelation = segment.segmentRelation;
				if(segmentRelation && isDependIndex(index)){
					divSelect.find('.easyui-combobox').combobox('clear');
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
		var lastIndex = state.coding.find('div.coding-div').length;
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
			if(segmentRelation){
				//判断依赖码段是否都有值
				if(isSelectedValue(target, serialIndex)){
					loadCoding(target, serialIndex);
				}
			}
		}
	}
	
	/**
	 * 是否已经选择必要的值
	 */
	function isSelectedValue(target, index){
		var state = $.data(target, 'coding');
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
		var divSelect = $(state.coding.find('div.coding-div')[index]);
		var segmentList = state.segmentList;
		if(codingId == null || codingId == undefined || codingId == ''){
			return;
		}
		if(segmentList == null || segmentList == undefined){
			return;
		}
		if(getSegmentValue(target, index) != ''){
			return;
		}
		
		var segment = segmentList[index];
		if(segment.segmentType != '4'){
			if(segment.segmentRelation){
				getSegmentValuesData();
			}else{
				if(segment.segmentType == '1' || segment.segmentType == '2'){
					var data = divSelect.find('.easyui-combobox').combobox('getData');
					if(data.length == 1){
						divSelect.find('.easyui-combobox').combobox('setValue', data[0].code);
					}else{
						divSelect.find('.easyui-combobox').combobox('showPanel');
					}
				}
			}
		}
		
		/**
		 * 获取对应码值
		 */
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
				divSelect.find('.easyui-combobox').combobox('loadData',data);
				if(data.length == 1){
					divSelect.find('.easyui-combobox').combobox('setValue', data[0].code);
				}else{
					divSelect.find('.easyui-combobox').combobox('showPanel');
				}
			}else if(segment.segmentType == '3'){
				divSelect.find('.easyui-numberbox').numberbox('setValue', data[0].code);
			} 
		}
	}
	
	/**
	 * 获取码段的值
	 */
	function getSegmentValue(target, index){
		var state = $.data(target, 'coding');
		var divSelect = $(state.coding.find('div.coding-div')[index]);
		var segmentList = state.segmentList;
		if(segmentList == null || segmentList == undefined){
			return false;
		}
		var segment = segmentList[index];
		var value = "";
		if(segment.segmentType == '4'){
			if(segment.classify == '1'){
				value = divSelect.find('span[name="uuid"]').text();
			}else{
				if(segment.isCurrentTime == 'Y'){
					value = divSelect.find('span[name="currentTime"]').text();
				}else{
					if(segment.format.indexOf('HHmmss') > -1){
						var obj = divSelect.find('.easyui-datetimebox');
						value = obj.datetimebox('getValue');
						if(value){
							var opts = obj.datetimebox('options');
							var date = opts.parser.call(obj, value);
							value = date.format(segment.format);
						}
					}else{
						var obj = divSelect.find('.easyui-datebox');
						value = obj.datebox('getValue');
					}
				}
			}
		}else if(segment.segmentType == '3'){
			var serialNumber = divSelect.find('.easyui-numberbox').numberbox('getValue');
			if(serialNumber && serialNumber != ''){
				value = getFormatSerialNumber(serialNumber, segment.segmentLength)
			}
		}else{
			value = divSelect.find('.easyui-combobox').combobox('getValue');
		}
		return value;
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
		var lastIndex = state.coding.find('div.coding-div').length;
		var segmentList = state.segmentList;
		if(segmentList == null || segmentList == undefined){
			return false;
		}
		var codingValue = "";
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
		
		return codingValue;
	}

	/**
	 * 返回生成的编码的每个码段长度
	 */
	function getCodingLengths(target){
		var state = $.data(target, 'coding');
		var lastIndex = state.coding.find('div.coding-div').length;
		var segmentList = state.segmentList;
		if(segmentList == null || segmentList == undefined){
			return false;
		}
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
					previousValue: null
				});
				$(this).removeAttr('disabled');
			}
			showCoding(this);
		});
	};
	
	/**
	 * 方法
	 */
	$.fn.coding.methods = {
		options: function(jq){
			return $.data(jq[0], 'coding').options;
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
		return $.extend({}, $.parser.parseOptions(target, ['codingId']), 
				{codingId: t.attr('codingId') || undefined,
				 codingName: t.attr('codingName') || undefined});
	};

	/**
	 * 默认参数
	 */
	$.fn.coding.defaults = {
		codingId: '',
		codingName: ''
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

/**
 * 获取字符串中汉字的个数
 */
String.prototype.getHzNumber = function(){
	return this.replace(/[^\x00-\xff]/g, "**").length - this.length;
};

/**
 * 获取字符串中大写字母的个数
 */
String.prototype.getUpperNumber = function(){
	return this.replace(/[A-Z]/g, "**").length - this.length;
};