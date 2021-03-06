/**
 * 
 */
function UumsLogSynchUser(datagrid,url,searchD,form,initDataGrid){
	if(!datagrid || typeof(datagrid)!=='string'&&datagrid.trim()!==''){
		throw new Error("datagrid不能为空！");
	}
	var _selectId='';
    var	_url=url;
    this.getUrl = function(){
    	return _url;
    }
	this._datagridId="#"+datagrid;
	this._doc = document;
	this._formId="#"+form;
	this._searchDiaId ="#"+searchD;
	this._initDataGrid = initDataGrid;
	this.init.call(this);
};
//初始化操作
UumsLogSynchUser.prototype.init=function(){
	var _self = this;
	this.searchDialog =$(this._searchDiaId).css('display','block').dialog({
		title:'查询'
	});
	this.searchForm = $(this._formId).form();
	this.searchForm.find('input').on('keyup',function(e){
		if(e.keyCode == 13){
			_self.searchData();
		}
	});
	this.searchDialog.dialog('close',true);
	if(this._initDataGrid){
		this._datagrid=$(this._datagridId).datagrid({
			url:this.getUrl()+"getUumsLogSynchUsersByPage.json"
			});
	}else{
		this._datagrid=$(this._datagridId);
	}
};
//添加页面
UumsLogSynchUser.prototype.insert=function(){
	this.nData = new CommonDialog("insert","600","400",this.getUrl()+'Add/null',"添加",false,true,false);
	this.nData.show();
};
//修改页面
UumsLogSynchUser.prototype.modify=function(){
	var rows = this._datagrid.datagrid('getChecked');
	if(rows.length !== 1){
		alert("请选择一条数据编辑！");
		return false;
	}
	this.nData = new CommonDialog("edit","600","400",this.getUrl()+'Edit/'+rows[0].id,"修改",false,true,false);
	this.nData.show();
};
//详细页
UumsLogSynchUser.prototype.detail=function(id){
	this.nData = new CommonDialog("edit","600","400",this.getUrl()+'Detail/'+id,"详情",false,true,false);
	this.nData.show();
};
//保存功能
UumsLogSynchUser.prototype.save=function(form,id){
	var _self = this;
	$.ajax({
		 url:_self.getUrl()+"save",
		 data : {data :JSON.stringify(form)},
		 type : 'post',
		 
		 dataType : 'json',
		 success : function(r){
			 if (r.flag == "success"){
				 _self.reLoad();
				 _self._datagrid.datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
				 $(id).dialog('close');
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
};
//删除
UumsLogSynchUser.prototype.del=function(){
	var rows = this._datagrid.datagrid('getChecked');
	var _self = this;
	var ids = [];
	var l =rows.length;
	if(l > 0){
	  $.messager.confirm('请确认','您确定要删除当前所选的数据？',function(b){
		 if(b){
			 for(;l--;){
				 ids.push(rows[l].id);
			 }
			 $.ajax({
				 url:_self.getUrl()+'delete',
				 data:	JSON.stringify(ids),
				 contentType : 'application/json',
				 type : 'post',
				 dataType : 'json',
				 success : function(r){
					 if (r.flag == "success") {
						 _self.reLoad();
						 _self._datagrid.datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
						 $.messager.show({
							 title : '提示',
							 msg : '删除成功！'
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
	  });
	}else{
	  $.messager.alert('提示','请选择要删除的记录！','warning');
	}
};
//重载数据
UumsLogSynchUser.prototype.reLoad=function(){
	this._datagrid.datagrid('load',{});
};
//关闭对话框
UumsLogSynchUser.prototype.closeDialog=function(id){
	$(id).dialog('close');
};

//打开查询框
UumsLogSynchUser.prototype.openSearchForm =function(){
	$("#appId2").val(currTreeNode.id);
	$("#appName2").val(currTreeNode.text);
	this.searchDialog.dialog('open',true);
};
//去后台查询
UumsLogSynchUser.prototype.searchData =function(){
	this._datagrid.datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
	this._datagrid.datagrid('load',{ param : JSON.stringify(serializeObject(this.searchForm))});
};
//隐藏查询框
UumsLogSynchUser.prototype.hideSearchForm =function(){
	this.searchDialog.dialog('close',true);
};
/*清空查询条件*/
UumsLogSynchUser.prototype.clearData =function(){
	this.searchForm.find('input').val('');
	$("#appId2").val(currTreeNode.id);
	$("#appName2").val(currTreeNode.text);
	this.searchData();
};
UumsLogSynchUser.prototype.formate=function(value){
	if(value){
		return new Date(value).format("yyyy-MM-dd");
	}
	return '';
};
UumsLogSynchUser.prototype.formateDateTime=function(value){
	if(value){
		return new Date(value).format("yyyy-MM-dd hh:mm:ss");
	}
	return '';
};

                        UumsLogSynchUser.prototype.synchFlag=[];
Platform6.fn.lookup.getLookupType('UUMS_SYNCH_RESULT',function(r){r&&( UumsLogSynchUser.prototype.synchFlag=r);});  
       UumsLogSynchUser.prototype.operFlag=[];
Platform6.fn.lookup.getLookupType('UUMS_OPER_FLAG',function(r){r&&( UumsLogSynchUser.prototype.operFlag=r);});  
       UumsLogSynchUser.prototype.synchType=[];
Platform6.fn.lookup.getLookupType('UUMS_SYNCH_OPER_TYPE',function(r){r&&( UumsLogSynchUser.prototype.synchType=r);});  
                                    