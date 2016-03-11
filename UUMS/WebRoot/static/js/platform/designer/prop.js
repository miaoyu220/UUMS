/**
 * div的控制
 */
$(function() {
	// 显示名称监听 流程名称监听
	$("input[id = 'xian_shi_ming_cheng'],input[id = 'liu_cheng_ming_cheng']").ipt(function() {
		var value = $(this).val();
		_myCellMap.get(_myCurCellId).labelChanged(value);
	});
	//事件table
	$('.pc5').find('tbody').find('tr').on('click',function (){
        if(!$(this).find('td').eq(0).html())return;
        $(this).addClass('tr_on').siblings().removeClass('tr_on');
    }).on('dblclick',function (){
        $(this).parents('table').siblings('.e_edit').trigger('click');
    });
	// 添加事件
	$('.js_add_e').on('click',function (){
		var self=this;
        var obj = propUtils.createEventWin();
        var myForm = obj.myForm;
        var myGrid;
        var toolbar = obj.toolbar;
        var addWin = obj.myWin;
        myForm.load(_designerPath + "config/form_event.xml", function(){
			myGrid = new dhtmlXGridObject(myForm.getContainer("myGrid"));
			myGrid.setImagePath(_imgPath + "dhxgrid_" + _skin + "/");
			myGrid.enableEditEvents(true, false, false);
			myGrid.loadXML(_designerPath + "config/grid_event.xml");
		});
        toolbar.disableItem("ok");
		toolbar.attachEvent("onClick", function(id) {
			if (id == "ok") {
                var fnName=myForm.getItemValue("fnName").replace(/=/g,'');
                var fnEvt=myForm.getItemValue("fnEvt").replace(/=/g,'');
                var arr=[];
                myGrid.forEachRow(function(id){
                	var cellObj1 = myGrid.cellById(id, 0).getValue().replace(/=/g,'');
                	var cellObj2 = myGrid.cellById(id, 1).getValue().replace(/=/g,'');
                	if($.notNull(cellObj1)){
                		arr.push('【'+cellObj1+'='+cellObj2+'】');
                	}
                });
                var fnArg=arr.join(' ');
                $(self).siblings('table').find('tbody').find('tr').each(function (){
                    if(!$(this).find('td').eq(0).html()){
                        $(this).find('td').eq(0).html(fnName);
                        $(this).find('td').eq(1).html(fnEvt);
                        $(this).find('td').eq(2).html(fnArg);
                        return false;
                    }
                });
				addWin.close();
			}
		});
    });
	//编辑事件
    $('.js_edit_e').on('click',function (){
        var self=this;
        if(!$(this).siblings('table').find('.tr_on').size())return;
        var obj = propUtils.createEventWin();
        var myForm = obj.myForm;
        var myGrid;
        var toolbar = obj.toolbar;
        var editWin = obj.myWin;
		toolbar.attachEvent("onClick", function(id) {
			if (id == "ok") {
                var fnName=myForm.getItemValue("fnName").replace(/=/g,'');
                var fnEvt=myForm.getItemValue("fnEvt").replace(/=/g,'');
                var arr=[];
                myGrid.forEachRow(function(id){
                	var cellObj1 = myGrid.cellById(id, 0).getValue().replace(/=/g,'');
                	var cellObj2 = myGrid.cellById(id, 1).getValue().replace(/=/g,'');
                	if($.notNull(cellObj1)){
                		arr.push('【'+cellObj1+'='+cellObj2+'】');
                	}
                });
                var fnArg=arr.join(' ');
                var edit=$(self).siblings('table').find('.tr_on').find('td');
                edit.eq(0).html(fnName);
                edit.eq(1).html(fnEvt);
                edit.eq(2).html(fnArg);
                editWin.close();
			}
		});
		var aTr=$(this).siblings('table').find('.tr_on').find('td');
        var fnName=aTr.eq(0).html();
        var fnEvt=aTr.eq(1).html();
        var fnArg=aTr.eq(2).html();
        var arr=fnArg.split(' ');
        var arr1=[];
        var arr2=[];
        for(var i=0;i<arr.length;i++){
            var e=arr[i].length-1;
            var s=arr[i];
            s = s.replace("【","").replace("】","");
            arr1.push(s);
        }
        for(var i=0;i<arr1.length;i++){
            var item=arr1[i].split('=');
            arr2.push(item);
        }
        myForm.load(_designerPath + "config/form_event.xml", function(){
        	myForm.setItemValue("fnName", fnName);
            myForm.setItemValue("fnEvt", fnEvt);
			myGrid = new dhtmlXGridObject(myForm.getContainer("myGrid"));
			myGrid.setImagePath(_imgPath + "dhxgrid_" + _skin + "/");
			myGrid.enableEditEvents(true, false, false);
			myGrid.loadXML(_designerPath + "config/grid_event.xml", function(){
				for(var i=0;i<arr2.length;i++){
	        		myGrid.cellById(i, 0).setValue(arr2[i][0]);
	            	myGrid.cellById(i, 1).setValue(arr2[i][1]);
		        }
			});
		});
    });
    //删除事件
    $('.js_del').on('click',function (){
        var $tab=$(this).siblings('table');
        var $tbo=$tab.find('tbody');
        var $tron=$tab.find('.tr_on').removeClass('tr_on').appendTo($tbo);
        $tron.find('td').empty();
    });
    //添加流程变量
	$('.js_add_v').on('click',function (){
		var self=this;
        var obj = propUtils.createVariableWin();
        var myForm = obj.myForm;
        var toolbar = obj.toolbar;
        var addWin = obj.myWin;
        myForm.load(_designerPath + "config/form_variable.xml");
        toolbar.disableItem("ok");
		toolbar.attachEvent("onClick", function(id) {
			if (id == "ok") {
                var alias=myForm.getItemValue("alias");
                var name=myForm.getItemValue("name");
                var init=myForm.getItemValue("init-expr");
                var type=myForm.getItemValue("type");
                var desc=myForm.getItemValue("desc");
                
                $(self).siblings('table').find('tbody').find('tr').each(function (){
                    if(!$(this).find('td').eq(0).html()){
                        $(this).find('td').eq(0).html(alias);
                        $(this).find('td').eq(1).html(name);
                        $(this).find('td').eq(2).html(init);
                        $(this).find('td').eq(3).html(type);
                        $(this).find('td').eq(4).html(desc);
                        return false;
                    }
                });
				addWin.close();
			}
		});
    });
	//编辑流程变量
    $('.js_edit_v').on('click',function (){
        var self=this;
        if(!$(this).siblings('table').find('.tr_on').size())return;
        var obj = propUtils.createVariableWin();
        var myForm = obj.myForm;
        var toolbar = obj.toolbar;
        var editWin = obj.myWin;
		toolbar.attachEvent("onClick", function(id) {
			if (id == "ok") {
				var alias=myForm.getItemValue("alias");
                var name=myForm.getItemValue("name");
                var init=myForm.getItemValue("init-expr");
                var type=myForm.getItemValue("type");
                var desc=myForm.getItemValue("desc");
                
                var edit=$(self).siblings('table').find('.tr_on').find('td');
                edit.eq(0).html(alias);
                edit.eq(1).html(name);
                edit.eq(2).html(init);
                edit.eq(3).html(type);
                edit.eq(4).html(desc);
                editWin.close();
			}
		});
		var aTr=$(this).siblings('table').find('.tr_on').find('td');
        var alias=aTr.eq(0).html();
        var name=aTr.eq(1).html();
        var init=aTr.eq(2).html();
        var type=aTr.eq(3).html();
        var desc=aTr.eq(4).html();
        myForm.load(_designerPath + "config/form_variable.xml", function(){
        	myForm.setItemValue("alias", alias);
        	myForm.setItemValue("name", name);
        	myForm.setItemValue("init-expr", init);
        	myForm.setItemValue("type", type);
        	myForm.setItemValue("desc", desc);
        });
    });
    //触发规则
    $('.js_cfgz').on('click',function (){
		var self=this;
        var obj = propUtils.createTimeWin("触发规则");
        var myForm = obj.myForm;
        var toolbar = obj.toolbar;
        var addWin = obj.myWin;
        myForm.load(_designerPath + "config/form_time.xml", function(){
        	var str = $(self).prev('.prop_txt').val();
        	if($.notNull(str)){
        		myForm.setItemValue("sjgz", propUtils.getRecords(str)[0]);
        		myForm.setItemValue("sjlx", propUtils.getRecords(str)[1]);
        		myForm.setItemValue("sjdw", propUtils.getRecords(str)[2]);
        	}
        });
		toolbar.attachEvent("onClick", function(id) {
			if (id == "ok") {
                var sjgz=$.trim(myForm.getItemValue("sjgz"));
                var sjlx=$.trim(myForm.getItemValue("sjlx"));
                var sjdw=$.trim(myForm.getItemValue("sjdw"));
                var result = "";
                if($.notNull(sjgz)){
                	result += sjgz;
                	if($.notNull(sjlx)){
                		result += " " + sjlx;
                	}
                	if($.notNull(sjdw)){
                		result += " " + sjdw;
                	}
                }
                var $table = $(self).parents("table");
                if(!$.notNull(result)){
                	$(self).prev('.prop_txt').val("");
                	$table.find('#chi_xu_shi_jian').val("");
                	$table.find('.js_show').hide();
                	$table.find('#chao_shi_shi_jian').find("td").empty();
                	$table.find('#chao_shi_shi_jian').find('.tr_on').removeClass('tr_on');
                }else{
                	$(self).prev('.prop_txt').val(result);
                	$table.find('.js_show').show();
                }
				addWin.close();
			}
		});
    });
    //持续时间
    $('.js_cxsj').on('click',function (){
		var self=this;
		var strTime=$(this).parents('tr').prev().find(".prop_txt").val();
		if(!$.notNull(strTime)){
			dhtmlxUtils.message("请先填写触发规则！");
			return;
		}
        var obj = propUtils.createTimeWin("持续时间");
        var myForm = obj.myForm;
        var toolbar = obj.toolbar;
        var addWin = obj.myWin;
        myForm.load(_designerPath + "config/form_time.xml", function(){
        	var str = $(self).prev('.prop_txt').val();
        	if($.notNull(str)){
        		myForm.setItemValue("sjgz", propUtils.getRecords(str)[0]);
        		myForm.setItemValue("sjlx", propUtils.getRecords(str)[1]);
        		myForm.setItemValue("sjdw", propUtils.getRecords(str)[2]);
        	}
        });
		toolbar.attachEvent("onClick", function(id) {
			if (id == "ok") {
                var sjgz=$.trim(myForm.getItemValue("sjgz"));
                var sjlx=$.trim(myForm.getItemValue("sjlx"));
                var sjdw=$.trim(myForm.getItemValue("sjdw"));
                var result = "";
                if($.notNull(sjgz)){
                	result += sjgz;
                	if($.notNull(sjlx)){
                		result += " " + sjlx;
                	}
                	if($.notNull(sjdw)){
                		result += " " + sjdw;
                	}
                }
                if(!$.notNull(result)){
                	$(self).prev('.prop_txt').val("");
                }else{
                	$(self).prev('.prop_txt').val(result);
                }
				addWin.close();
			}
		});
    });
    //添加条件
	$('.js_add_c').on('click',function (){
		var self=this;
        var obj = propUtils.createConditionWin();
        var myForm = obj.myForm;
        var toolbar = obj.toolbar;
        var addWin = obj.myWin;
        myForm.load(_designerPath + "config/form_condition.xml");
        toolbar.disableItem("ok");
		toolbar.attachEvent("onClick", function(id) {
			if (id == "ok") {
				var radio = myForm.getItemValue("type");
				var value = myForm.getItemValue(radio);
                
                $(self).siblings('table').find('tbody').find('tr').each(function (){
                    if(!$(this).find('td').eq(0).html()){
                        $(this).find('td').eq(0).html(radio);
                        $(this).find('td').eq(1).html(value);
                        return false;
                    }
                });
				addWin.close();
			}
			return true;
		});
    });
	//编辑条件
    $('.js_edit_c').on('click',function (){
        var self=this;
        if(!$(this).siblings('table').find('.tr_on').size())return;
        var obj = propUtils.createConditionWin();
        var myForm = obj.myForm;
        var toolbar = obj.toolbar;
        var editWin = obj.myWin;
		toolbar.attachEvent("onClick", function(id) {
			if (id == "ok") {
				var radio = myForm.getItemValue("type");
				var value = myForm.getItemValue(radio);
                
                var edit=$(self).siblings('table').find('.tr_on').find('td');
                edit.eq(0).html(radio);
                edit.eq(1).html(value);
                editWin.close();
			}
		});
		var aTr=$(this).siblings('table').find('.tr_on').find('td');
        var radio=aTr.eq(0).html();
        var value=aTr.eq(1).text();//由html()改成text(),防止特殊字符被转义,其他类似问题也可以如此处理
        myForm.load(_designerPath + "config/form_condition.xml", function(){
        	myForm.setItemValue("type", radio);
        	myForm.setItemValue(radio, value);
        });
    });
    //选择流程变量单选
    $('.js_variable').on('click',function (){
    	var self=this;
    	var obj = propUtils.createChooseVWin();
    	if(!$.notNull(obj)){
    		return;
    	}
    	var myGrid = obj.myGrid;
        var toolbar = obj.toolbar;
        var addWin = obj.myWin;
        toolbar.attachEvent("onClick", function(id) {
			if (id == "ok") {
				var selectedId = myGrid.getSelectedRowId();
				var cell = myGrid.cellById(selectedId, 2);
               	$(self).prev('.prop_txt').val(cell.getValue());
				addWin.close();
			}
		});
    });
    //选择流程变量单选
    $('.js_variable_n').on('click',function (){
    	var self=this;
    	var obj = propUtils.createChooseVWin();
    	if(!$.notNull(obj)){
    		return;
    	}
    	var myGrid = obj.myGrid;
        var toolbar = obj.toolbar;
        var addWin = obj.myWin;
        toolbar.attachEvent("onClick", function(id) {
			if (id == "ok") {
				var selectedId = myGrid.getSelectedRowId();
				var cell = myGrid.cellById(selectedId, 2);
               	$(self).prev('.prop_txt').val("#{" + cell.getValue() + "}");
				addWin.close();
			}
		});
    });
    //添加方法参数
	$('.js_add_ffcs').on('click',function (){
		propUtils.addFfcsCybl("方法参数", "form_ffcs.xml", this);
    });
	//编辑方法参数
    $('.js_edit_ffcs').on('click',function (){
    	propUtils.editFfcsCybl("方法参数", "form_ffcs.xml", this);
    });
    //添加成员变量
	$('.js_add_cybl').on('click',function (){
		propUtils.addFfcsCybl("成员变量", "form_cybl.xml", this);
    });
	//编辑成员变量
    $('.js_edit_cybl').on('click',function (){
    	propUtils.editFfcsCybl("成员变量", "form_cybl.xml", this);
    });
    //添加查询参数
	$('.js_add_cxcs').on('click',function (){
		var self=this;
        var obj = propUtils.createCxcsWin();
        var myForm = obj.myForm;
        var toolbar = obj.toolbar;
        var addWin = obj.myWin;
        myForm.load(_designerPath + "config/form_cxcs.xml");
        toolbar.disableItem("ok");
		toolbar.attachEvent("onClick", function(id) {
			if (id == "ok") {
				var alias = myForm.getItemValue("alias");
				var name = myForm.getItemValue("name");
				var type = myForm.getItemValue("type");
				var init = myForm.getItemValue("init");
                
                $(self).siblings('table').find('tbody').find('tr').each(function (){
                    if(!$(this).find('td').eq(0).html()){
                        $(this).find('td').eq(0).html(alias);
                        $(this).find('td').eq(1).html(name);
                        $(this).find('td').eq(2).html(type);
                        $(this).find('td').eq(3).html(init);
                        return false;
                    }
                });
				addWin.close();
			}
		});
    });
	//编辑查询参数
    $('.js_edit_cxcs').on('click',function (){
    	var self=this;
        if(!$(this).siblings('table').find('.tr_on').size())return;
        var obj = propUtils.createCxcsWin();
        var myForm = obj.myForm;
        var toolbar = obj.toolbar;
        var editWin = obj.myWin;
		toolbar.attachEvent("onClick", function(id) {
			if (id == "ok") {
				var alias = myForm.getItemValue("alias");
				var name = myForm.getItemValue("name");
				var type = myForm.getItemValue("type");
				var init = myForm.getItemValue("init");
                
                var edit=$(self).siblings('table').find('.tr_on').find('td');
                edit.eq(0).html(alias);
                edit.eq(1).html(name);
                edit.eq(2).html(type);
                edit.eq(3).html(init);
                editWin.close();
			}
		});
		var aTr=$(this).siblings('table').find('.tr_on').find('td');
        var alias=aTr.eq(0).html();
        var name=aTr.eq(1).html();
        var type=aTr.eq(2).html();
        var init=aTr.eq(3).html();
        myForm.load(_designerPath + "config/form_cxcs.xml", function(){
        	myForm.setItemValue("alias", alias);
        	myForm.setItemValue("name", name);
        	myForm.setItemValue("type", type);
        	myForm.setItemValue("init", init);
        });
    });
    //添加主子参数
	$('.js_add_zhuzi').on('click',function (){
		var self=this;
        var obj = propUtils.createZhuZiWin();
        var myForm = obj.myForm;
        var toolbar = obj.toolbar;
        var addWin = obj.myWin;
        myForm.load(_designerPath + "config/form_zhuzi.xml");
        toolbar.disableItem("ok");
		toolbar.attachEvent("onClick", function(id) {
			if (id == "ok") {
				var outStr = myForm.getItemValue("out");
				var inStr = myForm.getItemValue("in");
                
                $(self).siblings('table').find('tbody').find('tr').each(function (){
                    if(!$(this).find('td').eq(0).html()){
                        $(this).find('td').eq(0).html(outStr);
                        $(this).find('td').eq(1).html(inStr);
                        return false;
                    }
                });
				addWin.close();
			}
		});
    });
	//编辑主子参数
    $('.js_edit_zhuzi').on('click',function (){
    	var self=this;
        if(!$(this).siblings('table').find('.tr_on').size())return;
        var obj = propUtils.createZhuZiWin();
        var myForm = obj.myForm;
        var toolbar = obj.toolbar;
        var editWin = obj.myWin;
		toolbar.attachEvent("onClick", function(id) {
			if (id == "ok") {
				var outStr = myForm.getItemValue("out");
				var inStr = myForm.getItemValue("in");
                
                var edit=$(self).siblings('table').find('.tr_on').find('td');
                edit.eq(0).html(outStr);
                edit.eq(1).html(inStr);
                editWin.close();
			}
		});
		var aTr=$(this).siblings('table').find('.tr_on').find('td');
        var outStr=aTr.eq(0).html();
        var inStr=aTr.eq(1).html();
        myForm.load(_designerPath + "config/form_zhuzi.xml", function(){
        	myForm.setItemValue("out", outStr);
        	myForm.setItemValue("in", inStr);
        });
    });
    $(".js_childProcess").on("click", function(){
    	var self=this;
        propUtils.createChildProcessWin(self);
    });
    //数字
    $('.num_only').on('focus',function (){
        $(this).css('ime-mode','disabled');
        $(document).on('keydown',function (e){
            var num=e.keyCode;
            if((num<48&&num!==8)||num>57&&num<96||num>105){
                return false;
            }
        });
    }).on('blur',function (){
        $(document).off('keydown');
        var str=$(this).val();
        var s=str.replace(/\D/g,'');
        $(this).val(s);
    });
    //合并方式
    $("input[name='he_bing_fang_shi']").on("change", function(){
    	var value = $(this).val();
    	var $table = $(this).parents("table");
    	if(value == "all"){
    		$table.find(".js_show").hide();
    		$table.find("#num").val("");
    		$table.find("#num").attr("disabled", true);
    	}else if(value == "condition"){
    		$table.find(".js_show").show();
    		$table.find("#num").val("");
    		$table.find("#num").attr("disabled", true);
    	}else{
    		$table.find(".js_show").hide();
    		$table.find("#num").attr("disabled", false);
    	}
    });
    //jms返回类型
    $("input[name='fan_hui_lei_xing']").on("change", function(){
    	var value = $(this).val();
    	var $table = $(this).parents("table");
    	if(value == "text"){
    		$table.find(".js_hide").show();
    		$table.find(".js_show").hide();
    		$(this).parent().next().find("span").html("文本值");
    	}else if(value == "object"){
    		$table.find(".js_hide").show();
    		$table.find(".js_show").hide();
    		$(this).parent().next().find("span").html("对象值");
    	}else{
    		$table.find(".js_hide").hide();
    		$table.find(".js_show").show();
    	}
    });
    //添加集合参数
    $(".js_add_jh").on("click", function(){
    	propUtils.addFfcsCybl("参数", "form_jh.xml", this);
    });
    //编辑集合参数
    $(".js_edit_jh").on("click", function(){
    	propUtils.editFfcsCybl("参数", "form_jh.xml", this);
    });
    //含有单选框的控制事件
    $('.js_open').on('click',function (){
        var $toggle=$(this).find('.js_onoff').prop('checked');
        if($toggle){
            $(this).nextAll().find('.js_show').show();
            $(this).parent().nextAll().find('.js_show').show();
            
            $(this).nextAll().find('.js_hide').hide();
            $(this).parent().nextAll().find('.js_hide').hide();
            
            //
            $(this).nextAll().find('.js_enabled').attr('disabled',false);
            $(this).parent().nextAll().find('.js_enabled').attr('disabled',false);
            
            $(this).nextAll().find('.js_disabled').attr('disabled',true);
            $(this).parent().nextAll().find('.js_disabled').attr('disabled',true);
            
            
        }else{
            $(this).nextAll().find('.js_show').hide();
            $(this).parent().nextAll().find('.js_show').hide();
            
            $(this).nextAll().find('.js_hide').show();
            $(this).parent().nextAll().find('.js_hide').show();
            
            //
            $(this).nextAll().find('.js_enabled').attr('disabled',true);
            $(this).parent().nextAll().find('.js_enabled').attr('disabled',true);
            
            $(this).nextAll().find('.js_disabled').attr('disabled',false);
            $(this).parent().nextAll().find('.js_disabled').attr('disabled',false);
        }
    });
    //显示图标
    $('.js_xstb').on('click',function (){
    	var self=this;
    	propUtils.createIconWin(self);
    });
    //待办标题、实例标题
    $('.js_dbbt').on('click',function (){
    	var self=this;
    	var str=$(this).prev(".prop_txt").val();
    	var title = $(this).parent().prev("td").text();
        var obj = propUtils.createDbbtWin(title);
        var myForm = obj.myForm;
        var toolbar = obj.toolbar;
        var addWin = obj.myWin;
        myForm.load(_designerPath + "config/form_dbbt.xml", function(){
        	myForm.setItemValue("value", str);
        });
		toolbar.attachEvent("onClick", function(id) {
			if (id == "ok") {
				var value = myForm.getItemValue("value");
				$(self).prev(".prop_txt").val(value);
				addWin.close();
			}
			return true;
		});
    });
    //自动打开
    $('.js_auto').on('click',function (){
    	var self=this;
        var obj = propUtils.createTransitionWin();
        var myTree = obj.myTree;
        var toolbar = obj.toolbar;
        var addWin = obj.myWin;
		toolbar.attachEvent("onClick", function(id) {
			if (id == "ok") {
				var selectedId = myTree.getSelectedItemId();
				var selectedName = myTree.getSelectedItemText();				
				$(self).prev(".prop_txt").val(selectedName);
				$(self).prev(".prop_txt").attr("userData", selectedId);
				addWin.close();
			}
		});
    });
    //意见
    $(".js_ideaType").on('change',function (){
        if($(this).val()==='cannot'){
        	$(this).parents("tbody").find('input').attr('disabled',true);
        }else{
        	$(this).parents("tbody").find('input').attr('disabled',false);
        }
    });
    //权限
    $('table.need_check').find('input[type="checkbox"]').on('change',function (){
        var key=$(this).prop('checked');
        $(this).parent().siblings().find('input').attr('disabled',!key);
        if(!$(this).parents('tr').next().find('td').eq(0).text()){
            $(this).parents('tr').next().find('input').attr('disabled',!key);
        }
    });
    //下拉框
    $('select.js_handler').on('change',function (){
        if($(this).val()==='4'){
        	$(this).parent().find('.js_status').attr('disabled',false);
        }else{
        	$(this).parent().find('.js_status').attr('disabled',true);
        	$(this).parent().find('.js_status').val('allfinish');
        	$(this).parent().find('.js_status').trigger('change');
        }
    });
    $('select.js_status').on('change',function (){
        if($(this).val()==='allfinish'){
        	$(this).parent().find("#num").val("");
        	$(this).parent().find('.js_show').hide();
        }else{
        	$(this).parent().find('.js_show').show();
            if($(this).val()=='number'){
            	$(this).parent().find('em').text('个');
            }else{
            	$(this).parent().find('em').text('%');
            }
        }
    });
    //权限处理人选择
    $('.js_who').on('click',function (){
    	var self=this;
        propUtils.createPersonWin(self);
    });
    //权限事件选择
    $('.js_cl').on('click',function (){
    	var self=this;
    	var str=$(this).prev(".prop_txt").val();
        var obj = propUtils.createQxClWin();
        var myForm = obj.myForm;
        var toolbar = obj.toolbar;
        var addWin = obj.myWin;
        myForm.load(_designerPath + "config/form_cl.xml", function(){
        	if (str != null && str.indexOf("【") > 0) {
        		var alias = $.trim(str.split("【")[0]);
        		var name = $.trim(str.split("【")[1]).replace("】", "");
    			myForm.setItemValue("alias", alias);
    			myForm.setItemValue("name", name);
    		}
        });
		toolbar.attachEvent("onClick", function(id) {
			if (id == "ok") {
				var value = "";
				var alias = myForm.getItemValue("alias");
				var name = myForm.getItemValue("name");
				if($.notNull($.trim(alias)) && $.notNull($.trim(name))){
					value = alias + "【" + name + "】";
				}
				$(self).prev(".prop_txt").val(value);
				addWin.close();
			}
		});
    });
    //权限操作点选择
    $('.js_task').on('click',function (){
    	var self=this;
    	var str=$.trim($(this).prev(".prop_txt").attr("taskNames"));
        var obj = propUtils.createMulQxTaskWin(str);
        var myGrid = obj.myGrid;
        var toolbar = obj.toolbar;
        var addWin = obj.myWin;
		toolbar.attachEvent("onClick", function(id) {
			if (id == "ok") {
				var aliass = "";
				var names = "";
				var checked=myGrid.getCheckedRows(0);
				if($.notNull(checked)){
					$.each(checked.split(","), function(i, n){
						var nameCell = myGrid.cellById(n, 1);
						var aliasCell = myGrid.cellById(n, 2);
						aliass += aliasCell.getValue() + ";";
						names += nameCell.getValue() + ";";
					});
				}
				$(self).prev(".prop_txt").attr("taskNames", names);
				$(self).prev(".prop_txt").val(aliass);
				addWin.close();
			}
		});
    });
    //文档权限
    $('.pc4_tab').on('click','li',function (){
        var $idx=$(this).index();
        $(this).addClass('on').siblings().removeClass('on');
        $(this).parent().siblings('.js_hl').eq($idx).addClass('active').siblings().removeClass('active');
    });
    $('.js_wdqx').on('change',function (){
    	var onOff=$(this).prop('checked');
        if(!onOff){
            $(this).parents(".js_hl").find("." + $(this).attr("id")).css('visibility','hidden');
        }else{
        	$(this).parents(".js_hl").find("." + $(this).attr("id")).css('visibility','visible');
        }
    });
    $('.label_for').on('click',function (){
    	$(this).prev().trigger("click");
    });
    //正文模板
    $(".zwmb_xg").on("click", function(){
    	var self=this;
        var str=$.trim($(this).prev(".prop_txt").attr("wd_text_ids"));
        var obj = propUtils.createMulQxZWMBWin(str);
        var myGrid = obj.myGrid;
        var toolbar = obj.toolbar;
        var addWin = obj.myWin;
		toolbar.attachEvent("onClick", function(id) {
			if (id == "ok") {
				var names = "";
				var ids = "";
				var checked=myGrid.getCheckedRows(0);
				if($.notNull(checked)){
					$.each(checked.split(","), function(i, n){
						var nameCell = myGrid.cellById(n, 1);
						names += nameCell.getValue() + ";";
						ids += n + ";";
					});
				}
				$(self).prev(".prop_txt").attr("wd_text_ids", ids);
				$(self).prev(".prop_txt").val(names);
				addWin.close();
			}
		});
    });
    //套红模板
    $(".thmb_xg").on("click", function(){
    	var self=this;
        var str=$.trim($(this).prev(".prop_txt").attr("wd_text_ids"));
        var obj = propUtils.createMulQxTHMBWin(str);
        var myGrid = obj.myGrid;
        var toolbar = obj.toolbar;
        var addWin = obj.myWin;
		toolbar.attachEvent("onClick", function(id) {
			if (id == "ok") {
				var names = "";
				var ids = "";
				var checked=myGrid.getCheckedRows(0);
				if($.notNull(checked)){
					$.each(checked.split(","), function(i, n){
						var nameCell = myGrid.cellById(n, 1);
						names += nameCell.getValue() + ";";
						ids += n + ";";
					});
				}
				$(self).prev(".prop_txt").attr("wd_text_ids", ids);
				$(self).prev(".prop_txt").val(names);
				addWin.close();
			}
		});
    });
    //域值同步
    $(".yztb_xg").on("click", function(){
        var self=this;
        var str=$.trim($(this).prev(".prop_txt").attr("wd_text_ids"));
        var obj = propUtils.createMulChooseVWin(str);
        if(!$.notNull(obj)){
    		return;
    	}
        var myGrid = obj.myGrid;
        var toolbar = obj.toolbar;
        var addWin = obj.myWin;
		toolbar.attachEvent("onClick", function(id) {
			if (id == "ok") {
				var names = "";
				var ids = "";
				var checked=myGrid.getCheckedRows(0);
				if($.notNull(checked)){
					$.each(checked.split(","), function(i, n){
						var nameCell = myGrid.cellById(n, 1);
						var idCell = myGrid.cellById(n, 2);
						names += nameCell.getValue() + ";";
						ids += idCell.getValue() + ";";
					});
				}
				$(self).prev(".prop_txt").attr("wd_text_ids", ids);
				$(self).prev(".prop_txt").val(names);
				addWin.close();
			}
		});
    });
});