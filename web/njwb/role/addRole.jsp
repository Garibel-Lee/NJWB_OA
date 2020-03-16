<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="/">
    
    <title>添加角色</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="/js/jquery-1.8.3.js"></script>
	<style type="text/css">
		#container{
			width: 500px;;
			margin: 0 auto;
		}
		#header{
			width: 200px;
			margin: 0 auto;
		}
		
		a{
			text-decoration:none;
		}
	</style>
	<script type="text/javascript">
		function checkBeforeSubmit(){
			var roleName = $("#roleName").val();
			if(roleName == ""){
				alert("角色名不能为空");
				return false;
			}
			return true;
		}
		
	</script>
  </head>
  
  <body>
    <div id="container">
    	<div id="header">
    		<h4>添加角色</h4>
    	</div>
	    <form action="role/addRole.do" method="post" onsubmit="return checkBeforeSubmit()">
		   	<table id = "roleEditTable">
		   		<tr>
		   			<td>
		   			角色名称:
		   			</td>
		   			<td>
		   				<input type = "text" name="roleName" id="roleName"/>
		   			</td>
		   		</tr>  
		   		<tr>
		   			<td colspan="2">
		   				<input type = "submit" value="添加" style="margin-top: 20px;"/>
		   				<input type = "reset" value="重置" style="margin-top: 20px;"/>
						<a href="/role/role.jsp" target="contentPage" style="margin-top: 20px;"><input type="button" value="返回"></a>
		   			</td>
		   		</tr>  	
		   	</table>
	   	</form>
   	</div>
   	<c:if test="${isError}">
		<script type="text/javascript">
			alert("${errorMessage}");
		</script>
	</c:if>
  </body>
</html>
