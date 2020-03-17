<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
  <head>
    <title>用户登录</title>

	  <title>用户登录</title>

	  <meta http-equiv="pragma" content="no-cache">
	  <meta http-equiv="cache-control" content="no-cache">
	  <meta http-equiv="expires" content="0">
	  <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	  <meta http-equiv="description" content="This is my page">
	  <link rel="stylesheet" type="text/css" href="/css/reset.css">
	  <link rel="stylesheet" type="text/css" href="/css/login.css">
	  <script type="text/javascript" src="/js/jquery-1.8.3.js"></script>
	  <style type="text/css">
		  body{
			  background-color: #0070A2;
		  }
	  </style>
	  <script type="text/javascript">
		 /* //页面加载时，生成随机验证码
		  window.onload=function(){
			  createCode(4);
		  }*/

		 /*//生成4位验证码的方法
		 function createCode(length) {
			 var code = "";
			 var codeLength = parseInt(length); //验证码的长度
			 //var checkCode =  $(".checkCode");
			 var checkCode = document.getElementById("checkCode");
			 //所有候选组成验证码的字符
			 var codeChars = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9,
					 'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',
					 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z');
			 //循环组成验证码的字符串
			 for (var i = 0; i < codeLength; i++){
				 //获取随机验证码下标
				 var charNum = Math.floor(Math.random() * 62);//返回最大整数
				 //组合成指定字符验证码
				 code += codeChars[charNum];
			 }
			 if (checkCode){
				 //为验证码区域添加样式名
				 checkCode.className = "code";
				 //将生成验证码赋值到显示区
				 checkCode.innerHTML = code;
			 }
		 }*/

		  //判断用户名，密码，验证码是否正确
		  function checkBeforeSubmit(){
			/*		  //获取输入的验证码
					  var inputCode =  $("#code").val();
					  //获取显示区生成的验证码
					  var checkCode = document.getElementById("checkCode").innerHTML;
					  //var checkCode =  $(".checkCode").innerHTML();
					  if (inputCode == ""){
						  alert("验证码不能为空");
						  return false;
					  }else if (inputCode.toUpperCase() != checkCode.toUpperCase()){
						  alert("验证码输入有误");
						  createCode(4);
						  return false;
					  }*/

			  var userAccount = $("#userName").val();
			  if(userAccount == ""){
				  alert("用户名不能为空");
				  return false;
			  }
			  //非法字符
			  var patrn=/[\^\*<>\/[\]]/;
			  if(patrn.test(userAccount)){
				  alert("用户名格式错误：不可非法字符（< > / \ * ^）");
				  return false;
			  }
			  var password = $("#userPwd").val();
			  if(password == ""){
				  alert("密码不能为空");
				  return false;
			  }
			  return true;
		  }
	  </script>



	  <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
	  <script type="text/javascript">
		  $(function(){
			  $("#userName").blur(function(){
				  var str ="ajaxloginName.do?name="+$("#userName").val();//(1)字符串拼接的方式，
				  $.ajax({
					  url:str,//要请求的url
					  async:true,//是否异步提交
					  success:function(res){
						  //res 技术服务端返回的内容
						  if (res.toString()=="不存在")
						  document.getElementById("spMessage").style.color="red";
						  document.getElementById("spMessage").style.color="blue";
						  $("#spMessage").html(res);
					  },//返回成功后处理函数
				  });//调用ajax的方法
			  });//失去焦点事件
		  });
		  function myJson(){
			  //服务端获取，我们通过后面学习springMvc获得
			  var name = $("#userName").val();
			  var pwd=$("#userPwd").val();
			  var obj={myName:name,myPwd:pwd};
			  $.ajax({
				  url:str,//要请求的url
				  data:JSON.stringify(obj),//提交的数据
				  contentType:"application/json;charset=utf8",//请求内容的字符集，header中的内容
				  dataType:"json",//服务器返回的数据类型
				  type:"POST",//提交的类型
				  async:true,//是否异步提交
				  success:function(res){
					  //res 技术服务端返回的内容
					  $("#spMessage").html(res);
				  },//返回成功后处理函数
				  error:function(){
				  },//请求失败的执行代码
			  });//调用ajax的方法
		  }
	  </script>
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="this is my page">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="/css/reset.css">
    <link rel="stylesheet" type="text/css" href="/css/login.css">

   <style type="text/css">
   body{
   	 background-color: #0070A2;
   }
   </style>
  </head>

  <body>
  	<form action="/login.do" method="post"  onsubmit="return checkBeforeSubmit()">
     <div id = "login">
     	  <div id = "title">
     	  		NJWB管理系统
     	  </div>
     	  
     	  <table id="loginTable">
     	  		<tr>
     	  			<td>用户名:&nbsp;</td>
     	  			<td>
     	  				<input type= "text" name = "userName" id = "userName"/>
     	  			</td>
     	  			<td>&nbsp;<span style="font-size:8px"  id="spMessage"></span></td>
     	  		</tr>
     	  		<tr>
     	  			<td>密&nbsp;&nbsp;&nbsp;码:&nbsp;</td>
     	  			<td>
     	  				<input type= "password" name = "userPwd" id = "userPwd"/>
     	  			</td>
     	  			<td>&nbsp;</td>
     	  		</tr>
      	  		<tr>
     	  			<td>验证码:&nbsp;</td>
     	  			<td>
     	  				<input type= "text" name = "code" id = "code"/>
     	  			</td>
     	  			<td>

     	  			</td>
     	  		</tr>
     	  		
     	  		<tr>
     	  			<td><span id="sliding"></span></td>
     	  			<td colspan="2">
     	  				<input type= "submit" id="submit" value="登&nbsp;录" class="btn" onclick="myJson()"/>
     	  			</td>
     	  		</tr>
     	  		    	  		     	  
     	  </table>
     </div>
	</form>
	<c:if test="${isError}">
		<script type="text/javascript">
			alert("${errorMessage}");
		</script>
	</c:if>
  </body>
</html>
