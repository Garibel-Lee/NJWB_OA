	var tripMsgs = new Array();
    	tripMsgs["userName"] = "用户名以字母打头，其后可以是数字+字母，长度为5-8位";
    	tripMsgs["password"] = "密码长度是4-6位";
    	tripMsgs["confirmPwd"] = "确认密码长度是4-6位";
    	
    	
    	var errorMsgs = new Array();
    	//js中数组，除了可以使用  errorMsgs[0]赋值外 还可以使用errorMsgs[字符串]  ：key
    	errorMsgs["userName"] = [
    	                           "用户名不能为空",
    	                           "用户名长度必须是5-8",
    	                           "用户名只能是字母打头+数字"
    	
    	                        ];
    	errorMsgs["password"] = [
    	                            "密码不能为空",
    	                            "密码长度为4-6位"
    	
    	                        ];
    	
        //提示输入信息
    	function  inputPrompt(obj,promptMsg){
    	
    		    $(obj).text(promptMsg);
    		    $(obj).removeClass("errorMsg");
    		    $(obj).removeClass("sussMsg");
    		    $(obj).addClass("tripMsg");
    	
    	}
    	
    	//提示错误信息
    	function  inputError(foucsObj,spanObj,errorMsg){
    		$(spanObj).text(errorMsg);
    		$(spanObj).removeClass("sussMsg");
    		$(spanObj).addClass("errorMsg");
    		$(foucsObj).removeClass("selected");
    	
    	}
    	
    	
    	//输入成功
    	//foucsObj触发焦点的那个对象
    	//spanObj用于提示的span
    	function  inputSuccess(foucsObj,spanObj){
    		$(spanObj).html("<img src = '../img/accept.png' width='20px' height='20px'/>");
    		$(foucsObj).removeClass("selected");
    		
    	}