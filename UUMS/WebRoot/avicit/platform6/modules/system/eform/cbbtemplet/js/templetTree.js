function CbbTempletTree(treeId,searchId,menuId,search_width){
	if(!treeId ||typeof(treeId)!=='string'&& !treeId.trim()){
		 throw new Error("树id不能为空！");
	}
	if(!searchId || typeof(searchId)!=='string'&& !searchId.trim()){
		throw new Error("查询id不能为空！");
	}
	this._treeId="#"+treeId;
	this._searchId="#"+searchId;
	this._menuId = "#"+menuId;
	this._doc = document;
	this._appId = '';
	this.search_width = search_width|| 150;
	var _url="platform/cbbTemplet/";
	this.getUrl = function(){
    	return _url;
    };
    //当前选中的node
	var _selectNode={};
	this._iDg={};//添加窗口对象
	this._eDg={};//编辑窗口对象
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
CbbTempletTree.prototype.init=function(appId){
	var _self = this;
	this._appId = appId;
	$(this._searchId).searchbox({
	 	width: _self.search_width,
        searcher: function (value) {
        	if(value==null||value==""){
        		_self._tree.tree('reload');
        		return;
        	}else{
	        	$.ajax({
	                cache: true,
	                type: "post",
	                url:_self.getUrl()+appId+"/search.json",
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
        	}
        },
        prompt: "请输入应用名称！"
    });
	this._tree=$(this._treeId).tree({    
		url:_self.getUrl()+appId+"/ROOT/2/getTempletTree.json",
		method:'GET',
		loadFilter: function(data){
	         if (data.treeNodeList){	
	              return data.treeNodeList;
	          } else {
	              return data;
	          }
  		},
  		onContextMenu: function(e, node){
  			e.preventDefault();
  			// 查找节点
  			$(_self._tree).tree('select', node.target);

  			// 显示快捷菜单
  			$(_self._menuId).menu('show', {
  				left: e.pageX,
  				top: e.pageY
  			});
  			_self.setSelectNode(node);
  		},
  		onSelect:function(node){
			_self.getOnSelect()(_self,node);
			_self.setSelectNode(node);
			},
		onClick:function(node){
			_self.getOnClick()(_self,node);
			},
		onLoadSuccess:function(node, data){
			if(!node){
				_self.getOnLoadSuccess()(_self,node,data);
			}
		},
		onBeforeExpand:function(node,param){
			 if(node){
				 _self._tree.tree('options').url = _self.getUrl()+appId+"/"+node.id+"/1/getTempletTree.json"
			 }
		 }
		});
};

CbbTempletTree.prototype.openinsert=function(){
	if(this.getSelectNode().attributes.type=== 'C'){
		$.messager.alert("提示", '模版类型无法再添加子节点！',"warning");
		return;
	}
	this._iDg = new CommonDialog("insert","700","400",this.getUrl()+this._appId+'/'+this.getSelectNode().id+'/'+this.getSelectNode().attributes.type+'/operation/add',"添加",false,true,false);
	this._iDg.show();
};

CbbTempletTree.prototype.openedit=function(){
	if(this.getSelectNode()._parentId=== 'ROOT'){
		$.messager.alert("提示", '不能编辑根节点！',"warning");
		return;
	}
	this._eDg = new CommonDialog("edit","700","400",this.getUrl()+this._appId+'/'+this.getSelectNode().id+'/'+this._tree.tree('getParent',this.getSelectNode().target).attributes.type+'/operation/edit',"编辑",false,true,false);
	this._eDg.show();
};

//关闭对话框
CbbTempletTree.prototype.closeDialog=function(id){
	$(id).dialog('close');
};

//保存功能
CbbTempletTree.prototype.save=function(form,dialog){
	var _self = this;
	$.ajax({
		 url:this.getUrl()+'/saveTree.json',
		 data : JSON.stringify(form),
		 type : 'post',
		 contentType : 'application/json',
		 dataType : 'json',
		 async : false,
		 success : function(r){
			 if (r.flag == "success"){
				 if(r.type =='1'){//新建
					 var selected = _self._tree.tree('find',r.pid);
					 _self._tree.tree('append', {
					 	parent: selected.target,
					 	data: [r.data]
					 });
					 selected.state='open';
				 }else if(r.type =='2'){//修改
					 _self._tree.tree('update',{
						 				target:_self.getSelectNode().target,
						 				text:form.tempName
					 				  });
					 
				 }
				 $(dialog).dialog('close');
				 $.messager.show({
					 title : '提示',
					 msg : '保存成功！'
				 });
				
			 }else{
				 $.messager.show({
					 title : '提示',
					 msg : r.error
				});
			 } 
		 }
	 });
}

CbbTempletTree.prototype.del=function(){
	var _self = this;
	if (this.getSelectNode().attributes.type == "R"){
		$.messager.alert("提示", '根节点不能被删除！',"warning");
		return;
	}
	var ids = [];
	ids.push(this.getSelectNode().id);
	var nodes = this._tree.tree('getChildren',this.getSelectNode().target);
	for (var i in nodes){
		ids.push(nodes[i].id);
	}
	  $.messager.confirm('请确认','您确定要删除当前节点及其子节点？',function(b){
		 if(b){
			 $.ajax({
				 url:'platform/cbbTemplet/operation/deleteTree.json',
				 data:	JSON.stringify(ids),
				 contentType : 'application/json',
				 type : 'post',
				 dataType : 'json',
				 success : function(r){
					 if (r.flag == "success") {
						 _self._tree.tree('remove',_self.getSelectNode().target);
						 $.messager.show({
							 title : '提示',
							 msg : '删除成功！'
						 });
						 //删除当前节点，选择父节点
						 var node =_self._tree.tree('find',_self.getSelectNode()._parentId);
						 if(node){
							 node.attributes.count--;
							 _self._tree.tree('select', node.target);
						 }
						
					}else{
						$.messager.show({
							 title : '提示',
							 msg : r.error
						});
					}
				 }
			 });
		 } 
	  });
};

