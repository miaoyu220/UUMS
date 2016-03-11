/**
 * @author zhanglei
 */
var _01={};
function SysAppRole(datagrid,searchD,url,form){
	if(!datagrid || typeof(datagrid)!=='string'&&datagrid.trim()!==''){
		throw new Error("datagrid不能为空！");
	}
	this._dgName=datagrid;
	this._datagridId="#"+datagrid;
	this._formId="#"+form;
	this._searchDiaId ="#"+searchD;
	this._doc = document;
	//this._url=url;
	this.getUrl = function(){
	    	return url;
	    }
	//是否可以结束编辑
	this.init.call(this);
	_01=this;
}
/**
 * 初始化
 */
SysAppRole.prototype.init=function(){
	var _self = this;
	this._datagrid=$(this._datagridId).datagrid({
		url:this.getUrl() +'/all.json',
		onClickCell:function(rowIndex, field, value){_self.clickCell(rowIndex, field, value,_self)}
	});
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
};
SysAppRole.prototype.clickCell=function(rowIndex, field, value,_s){
	if(field=="sysroleName"){
		var rows = _s._datagrid.datagrid("getRows");
		var _00=new GridCommonSelector("role",_s._dgName,rowIndex,"role",{targetId:'sysroleId'},_s.callBack,'{"appId":"'+rows[rowIndex].sysappId+'"}',null,null,false);
		var rows = _s._datagrid.datagrid("getRows");
		_00.init(rows[rowIndex]);
		return;
	}
};
SysAppRole.prototype.callBack=function(rowIndex,data,dialogDivId){
	var a = [];
	var b = [];
	var c=_01._datagrid;
	var l =data.length;
	for (;l--;) {
		a.push(data[l].id);
		b.push(data[l].roleName);
	}
	c.datagrid('beginEdit', rowIndex);
	var ed = c.datagrid('getEditor', {index:rowIndex,field:'sysroleName'});
	$(ed.target).val(b);
	ed=c.datagrid('getEditor', {index:rowIndex,field:'sysroleId'});
	$(ed.target).val(a);
	c.datagrid('endEdit', rowIndex);
	return;
};

//打开查询框
SysAppRole.prototype.openSearchForm =function(){
	this.searchDialog.dialog('open',true);
};
//去后台查询
SysAppRole.prototype.searchData =function(){
	this._datagrid.datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
	this._datagrid.datagrid('load',{ param : JSON.stringify(serializeObject(this.searchForm))});
};
//隐藏查询框
SysAppRole.prototype.hideSearchForm =function(){
	this.searchDialog.dialog('close',true);
};
/*清空查询条件*/
SysAppRole.prototype.clearData =function(){
	this.searchForm.find('input').val('');
	this._datagrid.datagrid('load',{ param : ''});
};
//******************************查询方法  end  ***********************************
//保存
SysAppRole.prototype.save=function(){
	var rows = this._datagrid.datagrid('getChanges');
	var data =JSON.stringify(rows);
	var _self = this;
	if(rows.length > 0){
		 $.ajax({
			 url: _self.getUrl()+'/save.json',
			 data : {datas : data},
			 type : 'post',
			 dataType : 'json',
			 success : function(r){
				 if (r.flag == "success"){
					 _self._datagrid.datagrid('reload',{});//刷新当前页
					 _self._datagrid.datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
					 $.messager.show({
						 title : '提示',
						 msg : '保存成功！'
					 });
				 }else{
					 $.messager.show({
						 title : '提示',
						 msg : r.e
					});
				 } 
			 }
		 });
	 }else{
		 $.messager.show({
			 title : '提示',
			 msg : '没有要提交的数据！'
		});
	 } 
};
