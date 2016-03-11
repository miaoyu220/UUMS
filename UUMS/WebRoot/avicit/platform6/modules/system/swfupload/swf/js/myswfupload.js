var swfu;
var au;

SWFUpload.onload = function () {
	var _K = 1024;
	var _M = _K*1024;
	var _G = _M*1024;
	var file_limit;
	if (file_size_limit.indexOf('K')>0){
		file_limit = parseInt(file_size_limit.split('K')[0])*_K;
	}else if(file_size_limit.indexOf('M')>0){
		file_limit = parseInt(file_size_limit.split('M')[0])*_M;
	}else if(file_size_limit.indexOf('G')>0){
		file_limit = parseInt(file_size_limit.split('G')[0])*_G;
	}else if (file_size_limit.indexOf('B')>0){
		file_limit = parseInt(file_size_limit.split('K')[0]); 
	}
	var settings = {
		flash_url : baseurl + "/avicit/platform6/modules/system/swfupload/swf/js/swfupload.swf",
		flash9_url : baseurl + "/avicit/platform6/modules/system/swfupload/swf/js/swfupload_fp9.swf",
		//upload_url: baseurl + "/platform/swfUploadController/doUpload",
		upload_url: baseurl + "/swfUpload",
		post_params: {
			"form_code" : form_code,
			"form_id" : form_id,
			"form_field" : form_field,
			"save_type":save_type,
			"swf":"true",
			"file_size_limit":file_limit
		},
		file_size_limit : file_size_limit,
		file_types : file_types,
		file_types_description : file_types,
		file_upload_limit : file_upload_limit,
		custom_settings : {
			progressTarget : "fsUploadProgress",
			uploadButtonId : "btnUpload",
			myFileListTarget : "idFileList",
			allowDel:allowDel
		},
		
		auto_upload:false,
		debug: false,
		use_query_string : true,

		// Button Settings
		button_image_url : baseurl +  "/avicit/platform6/modules/system/swfupload/swf/images/button_xzwj.png",	// Relative to the SWF file
		button_placeholder_id : "spanButtonPlaceholder",
		button_width: 81,
		button_height: 22,
		button_text : "添加文件",
		button_text_top_padding:2,
		button_text_left_padding:15,
		button_window_mode:"transparent",

		// The event handler functions are defined in handlers.js
		swfupload_loaded_handler : swfUploadLoaded,
		file_queued_handler : fileQueued,
		file_queue_error_handler : fileQueueError,
		file_dialog_complete_handler : fileDialogComplete,
		upload_start_handler : uploadStart,
		upload_progress_handler : uploadProgress,
		upload_error_handler : uploadError,
		upload_success_handler : uploadSuccess,
		upload_complete_handler : uploadComplete,
		queue_complete_handler : queueComplete,	
		
		//SWFObject settings
		//minimum_flash_version : "9.0.28",
		swfupload_pre_load_handler : swfUploadPreLoad,
		swfupload_load_failed_handler : swfUploadLoadFailed

		
	};
	swfu = new SWFUpload(settings);
	au = new AttachUtil(baseurl+"/");
}
