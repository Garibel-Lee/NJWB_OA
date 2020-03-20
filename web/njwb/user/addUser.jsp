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
    
    <title>添加账户</title>
    
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
		//动态获取角色名称

		$(document).ready(function () {
			$.ajax({
				type: "POST",
				url: "/permissions/getAllRoleName.do",
				success: function (msg) {
					var roles = $.parseJSON(msg);
					var roleName = $("#roleId");
					for (var i = 0; i < roles.length; i++) {
						var option = $("<option value=" + roles[i].id + ">" + roles[i].roleName + "</option>");
						roleName.append(option);
					}
				}
			});
			$.ajax({
				type: "POST",
				url: "emp/empGetall.do",
				success: function (msg) {
					var emps = $.parseJSON(msg);
					var empNo = $("#empNo");
					var empName=$("#empName");
					for (var i = 0; i < emps.length; i++) {
						var option1 = $("<option value=" + emps[i].empNo + ">" + emps[i].empName + "</option>");
						empName.append(option1);
						var option2 = $("<option value=" + emps[i].empNo + ">" + emps[i].empNo + "</option>");
						empNo.append(option2);

					}
				}
			});
		});



		function checkBeforeSubmit(){
			var userAccount = $("#userAccount").val();
			if(userAccount == ""){
				alert("帐号不能为空");
				return false;
			}
			var patrn=/[\^\*<>\/[\]]/;
			if(patrn.test(userAccount)){
				alert("用户名格式错误：不可非法字符（< > / \ * ^）");
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
			var userStatus = $("#userStatus").val();
			if(userStatus == "请选择"){
				alert("请选择账户状态");
				return false;
			}
			var roleName = $("#roleName").val();
			if(roleName == "请选择"){
				alert("请选择角色名");
				return false;
			}
			if(empName!=empNo){
				alert("请选择对应的员工编号与姓名");
				return false;}
			return true;
		}

	</script>
  </head>
  
  <body>
	<div id="container">
	  	<h3 class="title">添加账户</h3>
	  </div>
	  <form action="/addUser.do" method="post" onsubmit="return checkBeforeSubmit()">
	   	<table id = "Table">
	   		<tr>
	   			<td>
	   			帐号:
	   			</td>
	   			<td>
	   				<input type = "text" name="userAccount" id="userAccount"/>
	   			</td>
	   		</tr>
	   		<tr>
	   			<td>
	   			员工编码:
	   			</td>
	   			<td>

					<select name="empNo" id="empNo" style="width: 100px">
					</select>



	   			</td>
	   		</tr>  
	   		<tr>
	   			<td>
	   			员工姓名:
	   			</td>
	   			<td>

					<select name="empName" id="empName" style="width: 100px">
					</select>


	   			</td>
	   		</tr>  
			<tr>
	   			<td>
	   			状态:
	   			</td>
	   			<td>
	   				<select name="userStatus" id="userStatus" style="width: 100px">
		         		<option value="" >请选择</option>
		         		<option value="1" >正常</option>
		         		<option value="0" >锁定</option>
	   				</select>
	   			</td>
	   		</tr>  
	   		<tr>
	   			<td>
	   			角色:
	   			</td>
	   			<td>
	   				<select name="roleId" id="roleId" style="width: 100px">
		         		<option value="">请选择</option>
	   				</select>
	   			</td>
	   		</tr>  
	   		
	   		<tr>
	   			<td colspan="2">
	   				<input type = "submit" value="保存" />
	   				<input type = "reset" value="重置"/>
					<a href="/queryUsers.do" target="contentPage"><input type="button" value="返回"/></a>
	   			</td>
	   		</tr>  	
	   	</table>
   	</form>
   	<c:if test="${isError}">
		<script type="text/javascript">
			alert("${errorMessage}");
		</script>
	</c:if>
  </body>
</html>