
var dialog_first_row_tip = "提示：您为"; 
var dialog_second_row_tip = "密码要求：您的密码"; 
var dialog_third_row_tip = "最大长度不要超过"; 
var dialog_fourth_row_tip = "最小长度不能小于";
var dialog_five_row_tip = "其中大写字母、小写字母、数字、特殊字符至少要包含";
var dialog_five_row_end_tip = "位"; 
var dialog_six_row_begin_tip = "不能和前";
var dialog_six_row_end_tip = "次密码重复";

var dialog_seven_row_begin_tip = "不能和旧密码有";
var dialog_seven_row_end_tip = "位（连续）重复";

var dialog_eight_row_begin_tip = "请在";
var dialog_eight_row_middle_tip = "天"; 
var dialog_eight_row_end_tip = "前修改密码";

var password_length_tip = "位";

var shangeSelfPasswordVo; 

$(function(){

	$('#passwordEditForm input').bind('keyup',function(e){
		if(e.keyCode == 13){
			e.preventDefault();
			changePassword();
		}
	});
	$.ajax({
		url : 'platform/syspassword/sysPasswordController/getChangeSelfPasswordVo',
		type : 'post',
		dataType : 'json',
		success : function(r) {
			if(r){
				shangeSelfPasswordVo=r;
				generateTipContent();
			}
		},
		error :function(request){
			alert('操作失败，服务请求状态：'+request.status+' '+request.statusText+' 请检查服务是否可用！');
		}
	}); 
	
}); 

function generateTipContent()
{
	var tipContent = $("#tipContent");

	var maxlength = shangeSelfPasswordVo.maxlength;
	var intensity = shangeSelfPasswordVo.intensity;
	var distinctBefore = shangeSelfPasswordVo.distinctBefore;
	var minlength = shangeSelfPasswordVo.minlength;
	var difference = shangeSelfPasswordVo.difference;
	var oldPassword = shangeSelfPasswordVo.oldPassword;
	var secretLevelName = shangeSelfPasswordVo.secretLevelName;
	helpMessage = dialog_first_row_tip+"<font color='red'>"+secretLevelName+"</font><br/>";
	helpMessage+="　　　"+dialog_second_row_tip+"<br/>";
	if(maxlength){
		helpMessage+="　　　"+dialog_third_row_tip+" <font color='red'>"+maxlength+"</font> "+password_length_tip+"<br/>";
	}
	if(minlength){
		helpMessage+="　　　"+dialog_fourth_row_tip+" <font color='red'>"+minlength+"</font> "+password_length_tip+"<br/>";
	}
	if(intensity){
		helpMessage+="　　　"+dialog_five_row_tip+" <font color='red'>"+intensity+"</font> "+dialog_five_row_end_tip+"<br/>	";
	}
	if(distinctBefore){
		helpMessage+="　　　"+dialog_six_row_begin_tip+" <font color='red'>"+distinctBefore+"</font> "+dialog_six_row_end_tip+"<br/>";
	}
	if(difference){
		helpMessage+="　　　"+dialog_seven_row_begin_tip+" <font color='red'>"+difference+"</font> "+dialog_seven_row_end_tip+"<br/>";
	}
	var noticeDateBeforeNum = null;
	if (shangeSelfPasswordVo.howLongModify &&shangeSelfPasswordVo.howLongModify>0) {
		noticeDateBeforeNum = shangeSelfPasswordVo.howLongModify; 
	} 
	if (null != noticeDateBeforeNum) {
		var dateStr = shangeSelfPasswordVo.sysPsw;
		helpMessage+="　　　"+dialog_eight_row_begin_tip+" <font color='red'>"+dateStr+"</font>"+dialog_eight_row_end_tip+"<br/>";
	}
	helpMessage =helpMessage.substring(0,helpMessage.length-1);
	helpMessage+=".";
	tipContent.html(helpMessage);
	tipContent.css("margin-top:120px;width: 400px; overflow-x: hidden; overflow-y: auto; position: relative; left: 0px; bottom: 0px;");
	tipContent.attr("visible",true);
}

function add0(m){
	return m<10?'0'+m:m ;
}

function format(timeStamp){
	//timeStamp是整数，否则要parseInt转换
	var time = new Date(timeStamp);
	var y = time.getFullYear();
	var m = time.getMonth()+1;
	var d = time.getDate()+1;
	var h = time.getHours()+1;
	var mm = time.getMinutes()+1;
	var s = time.getSeconds()+1;
	return y+'-'+add0(m)+'-'+add0(d)+' '+add0(h)+':'+add0(mm)+':'+add0(s);
}

function closeParentDialog(state){
	if(state == '1'){
		alert("密码修改成功，请用新密码重新登录！");
		parent.$("#modify_dialog").dialog('close');
	}else{
		parent.$("#modify_dialog").dialog('close');
	}
}

function hasText(str,trim){
	var tmp = str;
	if(null == tmp){
		return false;
	}
	if(trim){
		tmp = tmp.replace(/\s*/g,"");
	}
	if(0 == str.length){
		return false;
	}
	return true;
}

function mate(password)
{
	var digit=0;
	var smallChar=0;
	var bigChar=0;
	var other=0;
	
	for(var i=0;i<password.length;i++)
	{
		var c=password.charAt(i);
		
		if(c<='9' && c>='0')
			digit=1;
		else if(c<='z' && c>='a')
			smallChar=1;
		else if(c<='Z' && c>='A')
			bigChar=1;
		else
			other=1;
	}
	
	return digit+smallChar+bigChar+other;
	
}

function changePassword(){
	
	var maxlength = shangeSelfPasswordVo.maxlength;
	var intensity = shangeSelfPasswordVo.intensity;
	var distinctBefore = shangeSelfPasswordVo.distinctBefore;
	var minlength = shangeSelfPasswordVo.minlength;
	var difference = shangeSelfPasswordVo.difference;
	var secretLevelName = shangeSelfPasswordVo.secretLevelName;
	
	var oldPassword = $("#oldPassword").val();
	var newPassword = $("#newPassword").val();
	var confirmPassword = $("#confirmPassword").val();
	
	if(!hasText(oldPassword)){
		$.messager.alert('提示',"原密码不能为空",'warning');
		return;
	}
	if(!hasText(newPassword)){
		$.messager.alert('提示',"新密码不能为空",'warning');
		return;
	}
	if(!hasText(confirmPassword)){
		$.messager.alert('提示',"确认密码不能为空",'warning');
		return;
	}
	if(confirmPassword != newPassword){
		$.messager.alert('提示',"确认密码和新密码不一致",'warning');
		return;
	}

	if(oldPassword == newPassword){
		$.messager.alert('提示',"新密码不能和原密码一致",'warning');
		return;
	}


	var level = 0;
	if(minlength){
		if(newPassword.length < minlength){
		  alert("新密码的长度不能小于"+minlength+"位");
		  return false;
	    }
	}else{
	}
	if(maxlength){
		if(newPassword.length > maxlength&&newPassword.length<=100){
		   alert("新密码的长度不能大于"+maxlength+"位");
		   return false;
	    }
	}else{
	}

	level= mate(newPassword);
	if(intensity!="" && intensity !=null && level<intensity){
		 alert("新密码的密码强度要求为"+intensity+",而输入的密码强度为"+level+" .(密码强度其中包含数字，小写字母，大写字母，特殊字符<包含标点符号>，它们各为一级，最高为四级)");
		 return false;
	}
	
	$.ajax({
		url : 'platform/syspassword/sysPasswordController/changePassword',
		data : {oldPassword: oldPassword,newPassword: newPassword},
		type : 'post',
		dataType : 'json',
		success : function(r) {
			if(r.s){
				alert(r.s);
			}else{
				alert(r.f);
			}
		}
	}); 
};












