/**
 * 一些工具类的方法
 */
var ComUtils = {
	/**
	 * 构建xml的工具
	 */
	doc : mxUtils.createXmlDocument(),
	/**
	 * 构建xml元素
	 * 
	 * @param value
	 * @returns
	 */
	createElement : function(value) {
		return this.doc.createElement(value);
	},
	/**
	 * 构建xmltext元素
	 * 
	 * @param value
	 * @returns
	 */
	createTextNode : function(value) {
		return this.doc.createTextNode($.trim(value));
	},
	/**
	 * 重写的mxUtils中的方法，因为原方法在处理text类型时会多加一个空格
	 * 
	 * @param node
	 * @param tab
	 * @param indent
	 * @returns
	 */
	getPrettyXml : function(node, tab, indent) {
		var result = [];

		if (node != null) {
			tab = tab || '  ';
			indent = indent || '';

			if (node.nodeType == mxConstants.NODETYPE_TEXT) {
				result.push(node.nodeValue);
			} else {
				result.push(indent + '<' + node.nodeName);

				// Creates the string with the node attributes
				// and converts all HTML entities in the values
				var attrs = node.attributes;

				if (attrs != null) {
					for (var i = 0; i < attrs.length; i++) {
						var val = mxUtils.htmlEntities(attrs[i].nodeValue);
						result.push(' ' + attrs[i].nodeName + '="' + val + '"');
					}
				}

				// Recursively creates the XML string for each
				// child nodes and appends it here with an
				// indentation
				var tmp = node.firstChild;

				if (tmp != null) {
					var temIndent = "";
					result.push('>');
					if (tmp.nodeType != mxConstants.NODETYPE_TEXT) {
						temIndent = indent;
						result.push('\n');
					}

					while (tmp != null) {
						result.push(ComUtils.getPrettyXml(tmp, tab, indent
								+ tab));
						tmp = tmp.nextSibling;
					}

					result.push(temIndent + '</' + node.nodeName + '>\n');
				} else {
					result.push('/>\n');
				}
			}
		}

		return result.join('');
	}
};
/*
 * MAP对象，实现MAP功能
 * 
 * 接口： size() 获取MAP元素个数 isEmpty() 判断MAP是否为空 clear() 删除MAP所有元素 put(key, value)
 * 向MAP中增加元素（key, value) remove(key) 删除指定KEY的元素，成功返回True，失败返回False get(key)
 * 获取指定KEY的元素值VALUE，失败返回NULL element(index)
 * 获取指定索引的元素（使用element.key，element.value获取KEY和VALUE），失败返回NULL containsKey(key)
 * 判断MAP中是否含有指定KEY的元素 containsValue(value) 判断MAP中是否含有指定VALUE的元素 values()
 * 获取MAP中所有VALUE的数组（ARRAY） keys() 获取MAP中所有KEY的数组（ARRAY）
 * 
 * 例子： var map = new Map();
 * 
 * map.put("key", "value"); var val = map.get("key") ……
 * 
 */
function Map() {
	this.elements = new Array();

	// 获取MAP元素个数
	this.size = function() {
		return this.elements.length;
	};

	// 判断MAP是否为空
	this.isEmpty = function() {
		return (this.elements.length < 1);
	};

	// 删除MAP所有元素
	this.clear = function() {
		this.elements = new Array();
	};

	// 向MAP中增加元素（key, value)
	this.put = function(_key, _value) {
		this.elements.push({
			key : _key,
			value : _value
		});
	};

	// 删除指定KEY的元素，成功返回True，失败返回False
	this.remove = function(_key) {
		var bln = false;
		try {
			for (var i = 0; i < this.elements.length; i++) {
				if (this.elements[i].key == _key) {
					this.elements.splice(i, 1);
					return true;
				}
			}
		} catch (e) {
			bln = false;
		}
		return bln;
	};

	// 获取指定KEY的元素值VALUE，失败返回NULL
	this.get = function(_key) {
		try {
			for (var i = 0; i < this.elements.length; i++) {
				if (this.elements[i].key == _key) {
					return this.elements[i].value;
				}
			}
		} catch (e) {
			return null;
		}
	};

	// 获取指定索引的元素（使用element.key，element.value获取KEY和VALUE），失败返回NULL
	this.element = function(_index) {
		if (_index < 0 || _index >= this.elements.length) {
			return null;
		}
		return this.elements[_index];
	};

	// 判断MAP中是否含有指定KEY的元素
	this.containsKey = function(_key) {
		var bln = false;
		try {
			for (var i = 0; i < this.elements.length; i++) {
				if (this.elements[i].key == _key) {
					bln = true;
				}
			}
		} catch (e) {
			bln = false;
		}
		return bln;
	};

	// 判断MAP中是否含有指定VALUE的元素
	this.containsValue = function(_value) {
		var bln = false;
		try {
			for (var i = 0; i < this.elements.length; i++) {
				if (this.elements[i].value == _value) {
					bln = true;
				}
			}
		} catch (e) {
			bln = false;
		}
		return bln;
	};

	// 获取MAP中所有VALUE的数组（ARRAY）
	this.values = function() {
		var arr = new Array();
		for (var i = 0; i < this.elements.length; i++) {
			arr.push(this.elements[i].value);
		}
		return arr;
	};

	// 获取MAP中所有KEY的数组（ARRAY）
	this.keys = function() {
		var arr = new Array();
		for (var i = 0; i < this.elements.length; i++) {
			arr.push(this.elements[i].key);
		}
		return arr;
	};
}
/**
 * 自增长字符串控制
 */
var countUtils = function() {
	var start = 0;
	var end = 0;
	var task = 0;
	var java = 0;
	var sql = 0;
	var ws = 0;
	var state = 0;
	var fork = 0;
	var join = 0;
	var exclusive = 0;
	var subprocess = 0;
	var foreach = 0;
	var jms = 0;
	var custom = 0;
	var selfId = 2;
	return {
		getStart : function() {
			return ++start;
		},
		getEnd : function() {
			return ++end;
		},
		getTask : function() {
			return ++task;
		},
		getJava : function() {
			return ++java;
		},
		getSql : function() {
			return ++sql;
		},
		getWs : function() {
			return ++ws;
		},
		getState : function() {
			return ++state;
		},
		getFork : function() {
			return ++fork;
		},
		getJoin : function() {
			return ++join;
		},
		getExclusive : function() {
			return ++exclusive;
		},
		getSubprocess : function() {
			return ++subprocess;
		},
		getForeach : function() {
			return ++foreach;
		},
		getJms : function() {
			return ++jms;
		},
		getCustom : function() {
			return ++custom;
		},
		getSelfId : function() {
			return "" + selfId++;
		},
		setStart : function(value) {
			if (value > start) {
				start = value;
			}
		},
		setEnd : function(value) {
			if (value > end) {
				end = value;
			}
		},
		setTask : function(value) {
			if (value > task) {
				task = value;
			}
		},
		setJava : function(value) {
			if (value > java) {
				java = value;
			}
		},
		setSql : function(value) {
			if (value > sql) {
				sql = value;
			}
		},
		setWs : function(value) {
			if (value > ws) {
				ws = value;
			}
		},
		setState : function(value) {
			if (value > state) {
				state = value;
			}
		},
		setFork : function(value) {
			if (value > fork) {
				fork = value;
			}
		},
		setJoin : function(value) {
			if (value > join) {
				join = value;
			}
		},
		setExclusive : function(value) {
			if (value > exclusive) {
				exclusive = value;
			}
		},
		setSubprocess : function(value) {
			if (value > subprocess) {
				subprocess = value;
			}
		},
		setForeach : function(value) {
			if (value > foreach) {
				foreach = value;
			}
		},
		setJms : function(value) {
			if (value > jms) {
				jms = value;
			}
		},
		setCustom : function(value) {
			if (value > custom) {
				custom = value;
			}
		}
	};
};
/**
 * 定义message位置
 */
dhtmlx.message.position = "bottom";
/**
 * dhtmlxUtils
 */
var dhtmlxUtils = {
	isMenuItemId : null,
	hasMenuItemId : function(menu){
		if(this.isMenuItemId == null){
			this.isMenuItemId = false;
			var self = this;
			menu.forEachItem(function(itemId){
				if("view" == itemId){
					self.isMenuItemId = true;
				}
			});
		}
		return this.isMenuItemId;
	},
	/**
	 * 因为dhtmlx4.3通过点击按钮关闭window的方法有bug，会在关闭后触发mouse事件，所有采取延时关闭解决
	 * 
	 * @param parent
	 *            字符串，窗口父对象
	 * @param win
	 *            要关闭的窗口
	 */
	closeWin : function(parent, win) {
		win.hide();
		setTimeout(parent + ".window('" + win.getId() + "').close()", 200);
	},
	/**
	 * 创建模式化窗口显示内容
	 * 
	 * @param id
	 *            窗口ID
	 * @param text
	 *            窗口标题
	 * @param width
	 *            窗口宽度
	 * @param height
	 *            窗口高度
	 */
	createModalWin : function(id, text, width, height) {
		var win = _myLayout.dhxWins.createWindow(id, 0, 0, width, height);
		win.setText(text);
		win.center();// 置中
		win.setModal(true);// 模式化
		win.keepInViewport(true);// 使视图不超过区域
		// 重写关闭按钮点击事件
		win.button("close").attachEvent("onClick", function(win) {
			dhtmlxUtils.closeWin("_myLayout.dhxWins", win);
		});
		return win;
	},
	/**
	 * message
	 * 
	 * @param value
	 */
	message : function(value) {
		dhtmlx.message(value);
	},
	/**
	 * error
	 * 
	 * @param value
	 */
	error : function(value) {
		dhtmlx.message({
			title : "错误",
			type : "alert-error",
			text : value
		});
	},
	/**
	 * alter
	 * 
	 * @param value
	 */
	alter : function(value) {
		dhtmlx.message({
			title : "提示",
			type : "alert",
			text : value
		});
	}
};
function guid() {
	return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
		var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
		return v.toString(16);
	});
}