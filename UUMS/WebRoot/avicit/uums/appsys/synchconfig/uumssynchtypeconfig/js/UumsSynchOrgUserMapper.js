/**
 * 
 */
function UumsSynchOrgUserMapper(datagrid,url){
	if(!datagrid || typeof(datagrid)!=='string'&&datagrid.trim()!==''){
		throw new Error("datagrid不能为空！");
	}
    var	_url=url;
    this.editIndex = undefined;//当前正在编辑的行
    this.getUrl = function(){
    	return _url;
    };
	this._datagridId="#"+datagrid;
	this._doc = document;
	//this.init.call(this);
};

function getRnd(){
	var rnd = Math.random();
	return rnd;
};
//初始化操作
UumsSynchOrgUserMapper.prototype.init=function(pid){
	this._datagrid=$(this._datagridId).datagrid({
		url:this.getUrl()+"getUumsSynchOrgUserMapper/"+pid
		});
};
UumsSynchOrgUserMapper.prototype.loadByPid=function(pid, uumsType){
	//console.info(this.getUrl() +"getUumsSynchOrgUserMapper/"+ pid+"/"+uumsType);
	return this._datagrid.datagrid({url : this.getUrl() +"getUumsSynchOrgUserMapper/"+ pid+"/"+uumsType});
	//return this._datagrid ? this._datagrid.datagrid({url : this.getUrl() +"getUumsSynchOrgUserMapper/add/"+ pid}):this.init(pid);
};
//添加页面
UumsSynchOrgUserMapper.prototype.insert=function(pid){
	this.nData = new CommonDialog("insert","600","400",this.getUrl()+'Add/'+pid,"添加",false,true,false);
	this.nData.show();
};

//修改页面
UumsSynchOrgUserMapper.prototype.modify=function(){
	var rows = this._datagrid.datagrid('getChecked');
	if(rows.length !== 1){
		alert("请选择一条数据编辑！");
		return false;
	}
	this.nData = new CommonDialog("edit","600","400",this.getUrl()+'Edit/'+rows[0].id,"编辑",false,true,false);
	this.nData.show();
};
//详细页
UumsSynchOrgUserMapper.prototype.detail=function(id){
	this.nData = new CommonDialog("edit","600","400",this.getUrl()+'Detail/'+id,"详情",false,true,false);
	this.nData.show();
};
//保存功能
UumsSynchOrgUserMapper.prototype.save=function(form,id){
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
UumsSynchOrgUserMapper.prototype.del=function(datagridId){
	var rows = $('#'+datagridId).datagrid('getChecked');
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
						 _self.reLoad(datagridId);
						 $('#'+datagridId).datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
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
UumsSynchOrgUserMapper.prototype.reLoad=function(datagridId){
	var rnd = getRnd();
	$('#'+datagridId).datagrid('load',{avic_random : rnd});
};
//关闭对话框
UumsSynchOrgUserMapper.prototype.closeDialog=function(id){
	$(id).dialog('close');
};
                   UumsSynchOrgUserMapper.prototype.dataType=[];
Platform6.fn.lookup.getLookupType('UUMS_DB_DATA_TYPE',function(r){r&&(UumsSynchOrgUserMapper.prototype.dataType=r);}); 

                                                