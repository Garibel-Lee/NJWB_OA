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
    
    <title>修改账户</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="/js/jquery-1.8.3.js"></script>
	<style type="text/css">
		body,div,table,tr,td{
			margin: 0px;
			padding: 0px;
		}
		#Table{
			font-size: 15px;
			border-collapse: collapse;
			width: 350px;
			margin: 20px auto;	
		}
		
		#Table td{
			height: 40px;
		}
		#container{
			width: 200px;
			margin: 0 auto;
		}
		a{
			text-decoration : none;
		}
	</style>
	<script type="text/javascript">
		console.log("/");
		//动态获取角色名称
		function getAllRoleName(){
			$.ajax({
					type:"POST",
  					url:"/role/getAllRole.do",
  					success:function(msg){
  						var roles = $.parseJSON(msg);
  						var roleName = $("#roleName");
  						for(var i = 0; i < roles.length;i++){
  							var option = $("<option>"+roles[i].roleName+"</option>");
  							roleName.append(option);
  						}
  					}
				});
		}
		function refresh(){
			var userId = $("#hiddenInput").val();
			$.ajax({
			   type : "POST",
			   url: "/userVO/getUserVOByUserId.do",
			   data: {"userId":userId},
			   success: function(msg){
				  var userVO = $.parseJSON(msg);
				  var userStatus = $("#userStatus");
				  var roleName = $("#roleName");
				  $("#userAccount").val(userVO.userAccount);
				  $("#empNo").val(userVO.empNo);
				  $("#empName").val(userVO.empName);
				  userStatus.val(userVO.userStatus);
				  roleName.val(userVO.roleName);
				}
			 });
		}
		function checkBeforeSubmit(){
			var userAccount = $("#userAccount").val();
			if(userAccount == ""){
				alert("帐号不能为空");
				return false;
			}
			var empNo = $("#empNo").val();
			if(empNo == ""){
				alert("员工编码不能为空");
				return false;
			}
			var empName = $("#empName").val();
			if(empName == ""){
				alert("员工姓名不能为空");
				return false;
			}
			return true;
		}
		window.onload = function(){
  			getAllRoleName();
			refresh();
  			
		}
	</script>
  </head>
  
  <body>
  	<%
   		String userId = request.getParameter("userId");
   		request.setAttribute("userId",userId);
   	%>
    <div id="container">
	  	<h3 class="title">修改账户</h3>
	  </div>
	  <form action="user/updateUser.do" method="post" onsubmit="return checkBeforeSubmit()">
	   	<table id = "Table">
	   		<tr>
	   			<td>
	   			帐号:
	   			</td>
	   			<td>
	   				<input type = "text" name="userAccount" id="userAccount" readonly="readonly"/>
	   			</td>
	   		</tr>
	   		<tr>
	   			<td>
	   			员工编码:
	   			</td>
	   			<td>
	   				<input type = "text" name="empNo" id="empNo"/>
	   			</td>
	   		</tr>  
	   		<tr>
	   			<td>
	   			员工姓名:
	   			</td>
	   			<td>
	   				<input type = "text" name="empName" id="empName"/>
	   			</td>
	   		</tr>  
			<tr>
	   			<td>
	   			状态:
	   			</td>
	   			<td>
	   				<select name="userStatus" id="userStatus" style="width: 100px">
	   					<option>注销</option>
	   					<option>正常</option>
	   				</select>
	   			</td>
	   		</tr>  
	   		<tr>
	   			<td>
	   			角色:
	   			</td>
	   			<td>
	   				<select name="roleName" id="roleName" style="width: 100px">
	   				</select>
	   			</td>
	   		</tr>  
	   		
	   		<tr>
	   			<td colspan="2">
	   				<input type = "submit" value="保存"/>
	   				<input type = "button" value="重置" onclick="refresh();"/>
					<a href="/user/user.jsp " target="contentPage"><input type="button" value="返回"></a>
	   			</td>
	   		</tr>  	
	   	</table>
   		<input type="hidden" value="${userId}" id="hiddenInput" name="userId">
   	</form>
   	<c:if test="${isError}">
		<script type="text/javascript">
			alert("${errorMessage}");
		</script>
	</c:if>
  </body>
</html>
