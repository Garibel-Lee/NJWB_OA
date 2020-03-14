<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>修改权限</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=basePath %>js/jquery-1.8.3.js"></script>
	<style type="text/css">
		body,div,table,tr,td{
			margin: 0px;
			padding: 0px;
		}
		#perAEditTable{
			font-size: 15px;
			border-collapse: collapse;
			width: 350px;
			margin: 20px auto;
		}
		#perAEditTable td{
			height: 40px;
		}
		a{
			text-decoration: none;
		}
	</style>
	<script type="text/javascript">
		function checkBeforeSubmit(){
			var menuName = $("#menuName").val();
			if(menuName == "请选择"){
				alert("请选择菜单名称");
				return false;
			}
			var roleName = $("#roleName").val();
			if(roleName == "请选择"){
				alert("请选择角色名称");
				return false;
			}
			return true;
		}
		function getAllMenuName(){
			$.ajax({
					type:"POST",
  					url:"<%=basePath%>menu/getAllMenu.do",
  					success:function(msg){
  						var menus = $.parseJSON(msg);
  						var menuName = $("#menu");
  						for(var i = 0; i < menus.length;i++){
  							var option = $("<option>"+menus[i].menuName+"</option>");
  							menuName.append(option);
  						}
  					}
				});
		}
		function getAllRoleName(){
			$.ajax({
					type:"POST",
  					url:"<%=basePath%>role/getAllRole.do",
  					success:function(msg){
  						var roles = $.parseJSON(msg);
  						var roleName = $("#role");
  						for(var i = 0; i < roles.length;i++){
  							var option = $("<option>"+roles[i].roleName+"</option>");
  							roleName.append(option);
  						}
  					}
				});
		}
		function refresh(){
			var permissionId = $("#hiddenInput").val();
			$.ajax({
			   type : "POST",
			   url: "<%=basePath%>permissionVO/getpermissionVOById.do",
			   data: {"permissionId":permissionId},
			   success: function(msg){
				  var permissionVO = $.parseJSON(msg);
				  var roleName = permissionVO.roleName;
				  var menuName = permissionVO.menuName;
				  var role = $("#role");
				  role.val(roleName);
				  var menu = $("#menu");
				  menu.val(menuName);
				}
			 });
		}
		$(document).ready(function(){
			getAllRoleName();
			getAllMenuName();
  			refresh();
  		});
	</script>
  </head>
  
  <body>
  	<%
   		String permissionId = request.getParameter("permissionId");
   		request.setAttribute("permissionId",permissionId);
   	%>
	<form action="permission/updatePermission.do" method="post" onsubmit="return checkBeforeSubmit()">
	   	<table id = "perAEditTable">
	   		<tr>
	   			<td>
	   			角色：
	   			</td>
	   			<td>
	   				<select name="roleName" id="role" style="width: 100px ;">
	   				</select>
	   			</td>
	   		</tr>
	   		<tr>
	   			<td>
	   			菜单：
	   			</td>
	   			<td>
	   				<select name="menuName" id="menu" style="width: 100px">
	   				</select>
	   			</td>
	   		</tr>
	   		
	   		<tr>
	   			<td colspan="2">
	   				<input type = "submit" value="保存" />
	   				<input type = "button" value="重置" onclick="refresh();"/>
					<a href="<%=basePath%>permissions/permissions.jsp" target="contentPage"><input type="button" value="返回"></a>
	   			</td>
	   		</tr>  	
	   	</table>
	   	<input type="hidden" value="${permissionId}" name="permissionId">
   	</form>
   	<input type="hidden" value="${permissionId}" id="hiddenInput">
   	<c:if test="${isError}">
		<script type="text/javascript">
			alert("${errorMessage}");
		</script>
	</c:if>
  </body>
</html>
