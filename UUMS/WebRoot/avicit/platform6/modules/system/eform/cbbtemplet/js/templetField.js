
function TempletField(datagrid,url,searchD,form){
	if(!datagrid || typeof(datagrid)!=='string'&&datagrid.trim()!==''){
		throw new Error("datagrid不能为空！");
	}
	var _selectId='';
    var	_url=url;
    this._editIndex=0;//用于编辑保存后
    this.validation={};//有效标识
    this.level={};//级别
    this.modifier={};//使用级别
    this._iDg={};//添加窗口对象
	this._eDg={};//编辑窗口对象
	this._lDg={};//编辑窗口对象
	this._imp={};
    this.getUrl = function(){
    	return _url;
    }
    var _onSelectRow=function(){};//对象化封装，防止别人篡改
    this.getOnSelectRow=function(){
    	return _onSelectRow;
    }
    this.setOnSelectRow=function(f){
    	_onSelectRow = f;
    }
    var _onLoadSuccess=function(){};//数据导入成功回调
    this.getOnLoadSuccess=function(){
    	return _onLoadSuccess;
    }
    this.setOnLoadSuccess=function(f){
    	_onLoadSuccess=f;
    }
	this._datagridId="#"+datagrid;
	this._doc = document;
	this._formId="#"+form;
	this._searchDiaId ="#"+searchD;
}
TempletField.prototype.treeId='';
//初始化操作
TempletField.prototype.init=function(){
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
	$.ajax({
		url: 'platform/syslookuptype/getLookUpCode/PLATFORM_VALID_FLAG',
		type :'get',
		async:false,
		dataType :'json',
		success : function(r){
			if(r){
				_self.validation =r;
			}
		}
	});
	
	this._datagrid=$(this._datagridId).datagrid({
		onSelect: function(rowIndex, rowData){
				_self._selectId=rowData.id;
				_self.getOnSelectRow()(rowIndex, rowData,rowData.id);
			},
		onLoadSuccess :function(data){
			_self._datagrid.datagrid('clearChecked').datagrid('clearSelections');
			_self._datagrid.datagrid('doCellTip',   
					{   
						onlyShowInterrupt:true,   
						position:'bottom',
						tipStyler:{'backgroundColor':'#FFFFFF',boxShadow:'1px 1px 3px #292929'}
					}); 
			_self.getOnLoadSuccess()();
			if(data.total>0){
				_self._datagrid.datagrid('selectRow',0);
				
			}else{
				_self.getOnSelectRow()(null, null,-1);
			}
		}
		});
}

/**
 * 按照应用id加载
 */
TempletField.prototype.loadByTreeId=function(treeId,appId){
	TempletField.prototype.treeId=treeId;
	this.init();

	var opts = this._datagrid.datagrid('options');
	var pager = this._datagrid.datagrid('getPager');
	opts.pageNumber = 1;
    opts.pageSize = opts.pageSize;
	pager.pagination('refresh',{
	    	pageNumber:1,
	    	pageSize:opts.pageSize
	});
	this._datagrid.datagrid({url:this.getUrl()+treeId+"/"+appId+"/searchByPage.json"});

};
//***************格式化显示********************
//格式化
TempletField.prototype.formatValid=function(value){
	if(value ==null ||value == '') return '';
	var l=this.validation.length;
	for(;l--;){
		if(this.validation[l].lookupCode == value){
			return this.validation[l].lookupName;
		}
	}
}
//******************************查询方法  start***********************************
//打开查询框
TempletField.prototype.openSearchForm =function(){
	this.searchDialog.dialog('open',true);
}
//去后台查询
TempletField.prototype.searchData =function(){
	this._datagrid.datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
	this._datagrid.datagrid('load',{ param : JSON.stringify(serializeObject(this.searchForm))});
}
//隐藏查询框
TempletField.prototype.hideSearchForm =function(){
	this.searchDialog.dialog('close',true);
}
/*清空查询条件*/
TempletField.prototype.clearData =function(){
	this.searchForm.find('input').val('');
	this.searchData();
};
//******************************查询方法  end  ***********************************
//******************************增删改操作  start ***********************************
//打开添加框
TempletField.prototype.insert=function(appId){
	this.nData = new CommonDialog("insert","700","500",this.getUrl()+'/'+appId+'/'+this.treeId+'/operation/add/null',"添加",false,true,false);
	this.nData.show();
}
//关闭对话框
TempletField.prototype.closeDialog=function(id){
	$(id).dialog('close');
}
//打开编辑框
TempletField.prototype.modify=function(appId){
	var rows = this._datagrid.datagrid('getChecked');
	this._editIndex = this._datagrid.datagrid('getRowIndex',rows[0]);
	if(rows.length !== 1){
		$.messager.alert('提示','请选择一条数据编辑！','warning');
		return false;
	}
	this.eData = new CommonDialog("edit","700","500",this.getUrl()+'/'+appId+'/'+this.treeId +'/operation/edit/'+rows[0].id,"编辑",false,true,false);
	this.eData.show();
}

/**
 * 导入数据从excel中
 */
TempletField.prototype.import=function(appId){
	var result = "{\"templetId\" : \""+this.treeId+"\",\"appId\":\""+appId+"\"}";
	this._imp = new CommonDialog("importData","700","400",'platform/excelImportController/excelimport/importEformfieldInfo/xls?extPara='+result,"Excel数据导入",false,true,false);
	this._imp.show();
}

TempletField.prototype.openSyslookup=function(appId){
	var _self = this;
	var rows = this._datagrid.datagrid('getChecked');
	this._editIndex = this._datagrid.datagrid('getRowIndex',rows[0]);
	if(rows.length !== 1){
		$.messager.alert('提示','请选择一条数据编辑！','warning');
		return false;
	}
	var id = rows[0].id
	this._lDg = new CommonDialog("syslookup","700","500",'avicit/platform6/modules/system/eform/cbbtemplet/addLookup.jsp',"选择通用代码");
	var buttons = [{
		text:'添加',
		id : 'formSubimt',
		handler:function(){
			 var frmId = $('#syslookup iframe').attr('id');
			 var frm = document.getElementById(frmId).contentWindow;
			 
			 var myDatagrid=frm.$('#dgUser');
			 var rows = myDatagrid.datagrid('getChecked');
			 
			 if(rows.length==0)
			 {
				 $.messager.alert('提示',"请选择你要添加的通用代码",'warning');
				 return;
			 }else if(rows.length > 1){
				 $.messager.alert('提示',"只能选择一条记录",'warning');
				 return;
			 }
			 var sysLookupId = rows[0].lookupType;
			 
			 $.ajax({
		        cache: true,
		        type: "POST",
		        url:_self.getUrl()+ 'saveFieldLookup.json',
		        dataType:"json",
		        data: {fieldId: id, sysLookupId: sysLookupId,sysId : appId,templetId : _self.treeId},
		        error: function(request) {
		        	$.messager.alert('提示','操作失败，服务请求状态：'+request.status+' '+request.statusText+' 请检查服务是否可用！','warning');
		        },
		        success: function(data) {
					if(data.result==0){
						
						_self.reLoad();
						
						_self._lDg.close();
						
						$.messager.show({
							title : '提示',
							msg : '添加成功'
						});
					}else{
						$.messager.alert('提示',data.msg,'warning');
					}
		        }
		    }); 
		}
	}];
	this._lDg.createButtonsInDialog(buttons);
	this._lDg.show();
}

//保存功能
TempletField.prototype.save=function(form,id){
	var _self = this;
	$.ajax({
		 url:this.getUrl()+"/saveField",
		 data : JSON.stringify(form),
		 type : 'post',
		 contentType : 'application/json',
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
}
//删除
TempletField.prototype.del=function(){
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
				 url:_self.getUrl()+"/operation/deleteField",
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
}

//删除
TempletField.prototype.delLookup=function(){
	var rows = this._datagrid.datagrid('getChecked');
	var _self = this;
	var ids = [];
	var l =rows.length;
	if(l > 0){
	  $.messager.confirm('请确认','您确定要删除当前所选记录与通用代码的关联？',function(b){
		 if(b){
			 for(;l--;){
				 ids.push(rows[l].id);
			 }
			 $.ajax({
				 url:_self.getUrl()+"/operation/deleteSysCode",
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
	  $.messager.alert('提示','请先选择记录！','warning');
	}
}
//重载数据
TempletField.prototype.reLoad=function(){
	this._datagrid.datagrid('reload',{});
}
