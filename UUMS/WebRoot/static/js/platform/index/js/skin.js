/**
 * 切换皮肤
 * @param skin
 */
function switchSkin(skin){
	
	if(skinSwitch != null && skinSwitch == 'false'){
			return;
	}
    //动态切换皮肤
    doChangeSkin(skin, window);
    
   
    //保存用户新皮肤
    saveUserSkin(skin);
    
    //切换皮肤后重新计算是否菜单滚动和滚动长度
    if(typeof(doLoadMenuScroll) != "undefined"){
    	setTimeout(function(){doLoadMenuScroll();},1000);
    }
};

/**
 * 动态切换皮肤
 * @param skin
 * @param win
 */
function doChangeSkin(skin, win){
	//有优先皮肤时不能切换皮肤
	/*if(skinSwitch != null && skinSwitch == 'false'){
		return;
	}*/
	//首页平台皮肤切换,todo和portlet样式切换
	var beginHref = 'static/css/platform/themes/';
	switchHref(skin, beginHref, win);
	
	//首页客户自定义皮肤切换,todo和portlet样式切换
	beginHref = 'static/css/custom/themes/';
	switchHref(skin, beginHref, win);
	//easyui换肤
	var beginHref = 'static/js/platform/component/jQuery/jquery-easyui-1.3.5/themes/';
	switchHref(skin, beginHref, win);
	//子页面换肤
	var frames = win.document.getElementsByTagName("iframe");
	for(var i = 0; i < frames.length; i++){
		var childwin = frames[i].contentWindow;
	    if(childwin){
			try {
		      doChangeSkin(skin, childwin);
			}catch(e) {
			  // 在跨域情况下换肤会报错，导致整个换肤失败，所以要吃掉这个异常	
			}
	    }
	}
};

/**
 * 修改link的href
 * @param skin
 * @param beginHref
 * @param win
 */
function switchHref(skin, beginHref, win){
	var links = win.$('link[rel="stylesheet"]');
	for (var i = 0; i < links.length; i++) {
		var href = $(links[i]).attr('href');
		if (href && href.indexOf(beginHref) != -1) {
			var beginIndex = href.indexOf(beginHref) + beginHref.length;
			var endIndex = href.indexOf("/", beginIndex);
			if(endIndex != -1){
				var newHref = href.substring(0, beginIndex) + skin + href.substring(endIndex);
				$(links[i]).attr('href', newHref);
			}
		}
	}
};

/**
 * 保存皮肤设置
 * @param skin
 */
function saveUserSkin(skin){
	$.ajax({
		url : 'platform/syscustomed/sysCustomedController/saveCustomesSkin.json',
		data : {skin : skin},
		type : 'post',
		dataType : 'json',
		success : function(result) {
			if (result.flag == 'success') {
				
			} else {
				
			}
		}
	});
};
(function init(){
	$.ajax({
		url: 'platform/syslookuptype/getLookUpCode/PLATFORM_SYSTEM_SKIN.json',
		type :'get',
		dataType :'json',
		success : function(r){
			if(r){
				$.each(r,function(i,n){
					var child =$('<div></div>');
					child.addClass('skin-'+n.lookupCode);
					child.attr('title',n.lookupName);  
					(function(code){
						child.bind("click",function(e){
							e.preventDefault();
							switchSkin(code);
						});
					})(n.lookupCode);
					child.appendTo($('#skinList'));
				});
			}
		}
	});
})();