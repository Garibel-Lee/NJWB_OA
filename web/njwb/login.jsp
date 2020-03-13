<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
  <head>
    <title>用户登录</title>
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
  	<form action="login.do" method="post">
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
     	  			<td>&nbsp;</td>
     	  			<td colspan="2">
     	  				<input type= "submit" value="登&nbsp;录" class="btn" onclick="myJson()"/>
     	  			</td>
     	  		</tr>
     	  		    	  		     	  
     	  </table>
     </div>
	</form>
  </body>
</html>
