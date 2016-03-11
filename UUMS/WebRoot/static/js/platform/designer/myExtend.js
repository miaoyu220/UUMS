(function($) {
	$.fn.ipt = function(foo) {
		var self = this;
		var str = window.navigator.userAgent.toLowerCase();
		if (str.indexOf('msie') !== -1) {
			if (str.indexOf('msie 9.0') !== -1) {
				self.on('change', function() {
					foo && foo.call(this);
					return this;
				});
			} else {
				//propertychange //IE的propertychange总是在初始化时就执行一次，无法解决，IE只允许change吧
				self.on('change', function() {
					foo && foo.call(this);
					return this;
				});
			}
		} else {
			self.on('input', function() {
				foo && foo.call(this);
				return this;
			});
		}
	};
	$.extend({
		arr2Obj : function(arr, fieldArr) {
			var o = {};
			$.each(arr, function(i, n) {
				eval("o." + fieldArr[i] + "='" + n + "';");
			});
			return o;
		},
		notNull : function() {
			for (var i = 0; i < arguments.length; i++) {
				var obj = arguments[i];
				if (typeof obj == "undefined" || obj == null) {
					return false;
				}
				if (typeof obj == "string" && $.trim(obj) == "") {
					return false;
				}
			}
			return true;
		}
	});
})(jQuery);
