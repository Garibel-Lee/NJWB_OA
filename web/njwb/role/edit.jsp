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
    
    <title>修改角色</title>
    
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
		a{
			text-decoration:none;
		}
	</style>
	<script type="text/javascript">
		$(document).ready(function(){
			refresh();
  		});
		function refresh(){
			//得到输入框的值
			var roleId = $("#hiddenInput").val();
			$.ajax({
			   type : "POST",
			   url: "/role/getRoleByRoleId.do",
			   data: {"roleId":roleId},
			   success: function(msg){
				  var role = $.parseJSON(msg);
				  $("#roleName").val(role.roleName);//角色名
				  $("#roleId").val(roleId);//角色ID
				}
			 });
			
		}
		//验证
		function checkBeforeSubmit(){
			var roleName = $("#roleName").val();
			if(roleName == ""){
				alert("角色名不能为空");
				return false;
			}
		}
	</script>
  </head>
  
   <body>
  	<%
   		String roleId = request.getParameter("roleId");
   		request.setAttribute("roleId",roleId);
   	%>
  	<div id="container">
	    <form action="role/updateRole.do" method="post">
		   	<table id = "roleEditTable">
		   		<tr>
		   			<td>
		   			角色ID:
		   			</td>
		   			<td>
		   				<input type = "text" name="roleId" id="roleId" readonly="readonly"/>
		   			</td>
		   		</tr>
		   		<tr>
		   			<td>
		   			角色名称:
		   			</td>
		   			<td>
		   				<input id="roleName" name="roleName">
		   			</td>
		   		</tr>  
		   		<tr>
		   			<td colspan="2">
		   				<input type = "submit" value="保存" id="updateInput" style="margin-top: 20px;"/>
		   				<input type = "button" value="重置" onclick="refresh()" style="margin-top: 20px;"/>
						<a href="/role/role.jsp" target="contentPage" style="margin-top: 20px;"><input type="button" value="返回"></a>
		   			</td>
		   		</tr>  	
		   	</table>
	   	</form>
   	</div>
   	<input type="hidden" value="${roleId}" id="hiddenInput">
   	<c:if test="${isError}">
		<script type="text/javascript">
			alert("${errorMessage}");
		</script>
	</c:if>
  </body>
</html>
