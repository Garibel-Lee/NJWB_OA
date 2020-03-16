<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="/">
    
    <title>账户管理</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="/css/reset.css">
    <link rel="stylesheet" type="text/css" href="/css/main.css">
	<style type="text/css">
		td{
			-moz-user-select:none;
		}
		table {
			width: 780px;
			margin-left: 10px;
			margin-top: 20px;
		}
		td{
			width: 60px;
			margin-left: 10px;
		}
		a{
			text-decoration : none;
		}
	</style>
	<script type="text/javascript" src="/js/jquery-1.8.3.js"></script>
	<script type="text/javascript">
		function search(){
  			var userAccount = $("#userAccount").val();
  			var userStatus = $("#userStatus").val();
  			var roleName = $("#roleName").val();
  			$.ajax({
  				type:"POST",
  				url:"/userVO/getUserVO.do",
  				data:{
  					  "userAccount": userAccount,
  					  "userStatus": userStatus,
  					  "roleName": roleName
  					  },
  				success:function(msg){
  					var array = $.parseJSON(msg);
  					console.log(array);
  					var resultTable = $(".userInfo");
  					resultTable.html($("table tr")[0]);
  					for(var i = 0; i < array.length;i++){
  						var tr = $("<tr></tr>");
  						var userAccountTd = $("<td>"+array[i].userAccount+"</td>");
  						var empNameTd = $("<td>"+array[i].empName+"</td>"); 
  						var userStatusTd = $("<td>"+array[i].userStatus+"</td>"); 
  						var roleNameTd = $("<td>"+array[i].roleName+"</td>"); 
  						var operationTd = $("<td></td>");
						var deleteImg = $('<img id="'+array[i].id+'"src="img/delete.png" class="operateImg" onclick="del(id)">');
						var editImg = $('<img src="img/edit.png" class="operateImg" >');
						var userEditA = $('<a href="user/edit.jsp?userId='+ array[i].id+'" target="contentPage"></a>');
						userEditA.append(editImg);
						operationTd.append(deleteImg);
						operationTd.append(userEditA);
  						tr.append(userAccountTd).append(empNameTd).append(userStatusTd).append(roleNameTd).append(operationTd);
  						resultTable.append(tr);
  					}
  					
				}
  			});
  		}
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
		function del(userId){
			var result = window.confirm("确认要删除吗?");
			if(true == result){
				$.ajax({
					type:"POST",
  					url:"/user/deleteUserById.do",
  					data:{"userId":userId},
  					success:function(msg){
  							if(msg != ""){
  								alert(msg);
  							}else{
								alert("删除成功");
		  						search();
  							}
  					}
				});
			}
		}
		$(document).ready(function(){
  			getAllRoleName();
  			search();
  		});
	</script>
  </head>
  
  <body>
         	<h1 class="title">首页  &gt;&gt;账户管理 </h1>
         	
         	<div class="add">
         		<a href="/user/addUser.jsp" target="contentPage"><img src="/img/add.png" width="18px" height="18px">添加账户</a>
         	</div>
         	<div style="margin-top: 50px;width: 750px;margin-left: 50px;">
	         	帐号：<input type="text" id="userAccount" style="width: 100px;margin-right: 20px;">
	         	帐号状态：<select id="userStatus" style="width: 100px;margin-right: 20px;" >
	         				<option>请选择</option>
	         				<option>正常</option>
	         				<option>注销</option>
	         			</select>
	         	
	         	角色：<select id="roleName" style="width: 100px;margin-left: 20px;">
	         				<option>请选择</option>
	         			</select>
	         	<input type="button" value="查询" onclick="search()" style="width: 50px;margin-left: 20px;">
         	</div>
         	<table class="userInfo">
         		<tr class="titleRow">
         			<td>帐号</td>
         			<td>员工姓名</td>
         			<td>状态</td>
         			<td>角色</td>
         			<td>操作列表</td>
         		</tr>         	
         	</table>
  </body>
</html>
