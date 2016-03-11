/**
 * @author zhanglei
 */

function SysUserLockLog(datagrid,searchD,url,username){
	if(!datagrid || typeof(datagrid)!=='string'&&datagrid.trim()!==''){
		throw new Error("datagrid不能为空！");
	}
	this._dgName=datagrid;
	this._datagridId="#"+datagrid;
	this._searchDiaId ="#"+searchD;
	this._doc = document;
	this.getUsername = function(){
		return username;
	}
	//this._url=url;
	this.getUrl = function(){
	    	return url;
	    }
	//是否可以结束编辑
	this.init.call(this);
}
/**
 * 初始化
 */
SysUserLockLog.prototype.init=function(){
	var _self = this;
	this._datagrid=$(this._datagridId).datagrid({
		url:this.getUrl()+'/'+this.getUsername() +'/getUserLockLog.json',
		onLoadSuccess:function(data){
			$("#filter_LIKE_loginName").val(data.total);
			_self.cellTip();
		}
	});
	/**
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
	**/
};



SysUserLockLog.prototype.cellTip = function(){
	this._datagrid.datagrid('doCellTip',   
	{   
		onlyShowInterrupt:false,   
		position:'bottom',
		tipStyler:{'backgroundColor':'#FFFFFF',boxShadow:'1px 1px 3px #292929'}
	}); 
}

//打开查询框
SysUserLockLog.prototype.openSearchForm =function(){
	this.searchDialog.dialog('open',true);
};
//去后台查询
SysUserLockLog.prototype.searchData =function(){
	this._datagrid.datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
	this._datagrid.datagrid('load',{ param : JSON.stringify(serializeObject(this.searchForm))});
};
//隐藏查询框
SysUserLockLog.prototype.hideSearchForm =function(){
	this.searchDialog.dialog('close',true);
};
/*清空查询条件*/
SysUserLockLog.prototype.clearData =function(){
	this.searchForm.find('input').val('');
	this._datagrid.datagrid('load',{ param : ''});
};
//******************************查询方法  end  ***********************************
//保存
SysUserLockLog.prototype.save=function(){
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
