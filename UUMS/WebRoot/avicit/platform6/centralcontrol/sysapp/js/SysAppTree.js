/**
 * @author zhanglei
 */
var APP_= APP_ || {PUBLIC:0,PRIVATE:1};
function SysAppTree(treeId,searchId,type,iconCls,search_width){
	if(!treeId ||typeof(treeId)!=='string'&& !treeId.trim()){
		 throw new Error("应用树id不能为空！");
	}
	if(!searchId || typeof(searchId)!=='string'&& !searchId.trim()){
		throw new Error("查询id不能为空！");
	}
	if(typeof(type)!='number'){
		throw new Error("应用类型参数不正确！");
	}
	this._treeId="#"+treeId;
	this._searchId="#"+searchId;
	this._doc = document;
	this.search_width = search_width|| 150;
	var iconCls =iconCls||'null';
	var _url="platform/cc/sysapp/sysapptree/"+type+"/"+iconCls;
	this.getUrl = function(){
    	return _url;
    };
    //当前选中的node
	var _selectNode={};
	this.getSelectNode=function(){
		return _selectNode;
	};
	this.setSelectNode=function(node){
		_selectNode=node;
	};
	
    /***********************封装各种事件***********/
	var _onLoadSuccess=function(){};//加载数据和查找数据成功后的回调
	this.getOnLoadSuccess=function(){
		return _onLoadSuccess;
	};
	this.setOnLoadSuccess=function(func){
		_onLoadSuccess=func;
	};
	var _onSelect=function(){};//选中node事件
	this.getOnSelect=function(){
		return _onSelect;
	};
	this.setOnSelect=function(func){
		_onSelect=func;
	};
	var _onClick=function(){};//单击node事件
	this.getOnClick=function(){
		return _onClick;
	};
	this.setOnClick=function(func){
		_onClick=func;
	};
};
/**
 * 初始化
 */
SysAppTree.prototype.init=function(){
	var _self = this;
	
	$(this._searchId).searchbox({
	 	width: _self.search_width,
        searcher: function (value) {
        	if(value==null||value==""){
        		_self._tree.tree('reload');
        		return;
        	}
        	$.ajax({
                cache: true,
                type: "post",
                url:_self.getUrl()+"/search",
                dataType:"json",
                data:{search_text:value},
                async: false,
                error: function(request) {
                	throw new Error('操作失败，服务请求状态：'+request.status+' '+request.statusText+' 请检查服务是否可用！');
                },
                success: function(data) {
					if(data){
						_self._tree.tree('loadData',data);
					}else{
						_self._tree.tree('loadData',{});
					}
                }
            });
        },
        prompt: "请输入应用名称！"
    });
	
	this._tree=$(this._treeId).tree({    
		url:_self.getUrl(),
		method:'GET',
		onSelect:function(node){
			_self.setSelectNode(node);
			_self.getOnSelect()(_self,node);
			},
		onClick:function(node){
			_self.getOnClick()(_self,node);
			},
		onLoadSuccess:function(node, data){
			if(!node){
				_self.getOnLoadSuccess()(_self,node,data);
				_self.selectRootNode(_self,data);
			}
		}
		});
};
//选择系统应用
SysAppTree.prototype.selectRootNode=function(self,data){
	var id;

	if(data.length >0){
		id=data[0].id;
	}else{
		this.getOnSelect()(self,{id:'gg'});
		return;
	}
	var node = self._tree.tree('find', id);
	if(node){
		this._tree.tree('select', node.target);
	}
};

