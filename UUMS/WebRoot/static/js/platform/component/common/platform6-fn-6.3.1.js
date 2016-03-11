/**
 * 
 */
var Platform6 =Platform6 ||{};
Platform6.fn =Platform6.fn||{};
Platform6.fn.lookup =Platform6.fn.lookup||{};
/**
 * 获得系统可用的通用代码
 * @param type 通用代码code
 * @param func 回调函数
 */
Platform6.fn.lookup.getLookupType=function(type,func){
	$.ajax({
		url: 'platform/syslookuptype/getLookUpCode/'+type+'.json',
		type :'get',
		dataType :'json',
		success : func
	});
};
/**
 * 格式化显示通用代码
 * @param value 通用代码code
 * @param array 通用代码列表
 * @returns
 */
Platform6.fn.lookup.formatLookupType=function(value,array){
	if(!value) return '';
	var l=array.length;
	for(;l--;){
		if(array[l].lookupCode == value){
			return array[l].lookupName;
		}
	}
};
Platform6.fn.profile =Platform6.fn.profile||{};
Platform6.fn.profile.getProfile=function(type,func){
	$.ajax({
		url: 'platform/sysprofile/getProfile/'+type+'.json',
		type :'get',
		dataType :'text',
		success : func
	});
};
Platform6.fn.role =Platform6.fn.role||{};
Platform6.fn.role.getRole=function(type,func){
	$.ajax({
		url: 'platform/sysrole/getRoleByCode/'+type+'.json',
		type :'get',
		dataType :'json',
		success : func
	});
};