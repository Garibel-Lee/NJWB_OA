<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>权限管理</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="<%=basePath %>css/reset.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath %>css/main.css">
	<script type="text/javascript" src="<%=basePath %>js/jquery-1.8.3.js"></script>
	<script type="text/javascript">
		var currentPage;
		var oldRoleName = "";
		var oldMenuName = "";
		function search(pageNo){
  			var roleName = $("#roleName").val();
  			var menuName = $("#menuName").val();
  			if(oldRoleName != roleName||oldMenuName != menuName){
  				pageNo = 1;
  			}
  			oldRoleName = roleName;
  			oldMenuName = menuName;
  			$.ajax({
  				type:"POST",
  				url:"<%=basePath%>permissionVO/getPermissionVOByPage.do",
  				data:{"pageNo":pageNo,
  					  "roleName": roleName,
  					  "menuName": menuName
  				},
  				success:function(msg){
  					var pager = $.parseJSON(msg);
  					currentPage = pager;
  					var datas = pager.list;
  					var resultTable = $(".deptInfo");
  					resultTable.html($("table tr")[0]);
  					for(var i = 0; i < datas.length;i++){
  						var tr = $("<tr></tr>");
  						var roleNameTd = $("<td>"+datas[i].roleName+"</td>");
  						var menuNameTd = $("<td>"+datas[i].menuName+"</td>"); 
						var deleteImg = $('<img id="'+datas[i].id+'"src="img/delete.png" class="operateImg" onclick="del(id)">');
						var editImg = $('<img src="img/edit.png" class="operateImg" >');
						var permissionEditA = $('<a href="permissions/perEdit.jsp?permissionId='+ datas[i].id+'" target="contentPage"></a>');
						permissionEditA.append(editImg);
						var operationTd = $("<td></td>");
						operationTd.append(deleteImg);
						operationTd.append(permissionEditA);
  						tr.append(roleNameTd).append(menuNameTd).append(operationTd);
  						resultTable.append(tr);
  					}
  					
  					for(;i<4;i++){
  						var tr = $("<tr><td></td><td></td><td></td></tr>");
  						resultTable.append(tr);
  					}
  					var startPage = $("#startPage");
  					var lastPage = $("#lastPage");
  					lastPage.attr("onclick","search("+(pager.pageNo - 1)+")");
  					var nextPage = $("#nextPage");
  					nextPage.attr("onclick","search("+(pager.pageNo + 1)+")");
  					var endPage = $("#endPage");
  					endPage.attr("onclick","search("+pager.totalPage+")"); 					
  					var state = false;  					
  					if(pager.pageNo == 1){
  						state = true;
  					}
  					startPage.prop("disabled",state);
  					lastPage.prop("disabled",state);
  					state = false;
  					if(pager.pageNo == pager.totalPage || pager.totalPage == 0){
  						state = true;
  					}
  					nextPage.prop("disabled",state);
  					endPage.prop("disabled",state);
  				}
  			});
  		}
		function getAllRoleName(){
			$.ajax({
					type:"POST",
  					url:"<%=basePath%>role/getAllRole.do",
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
		function getAllMenuName(){
			$.ajax({
					type:"POST",
  					url:"<%=basePath%>menu/getAllMenu.do",
  					success:function(msg){
  						var menus = $.parseJSON(msg);
  						var menuName = $("#menuName");
  						for(var i = 0; i < menus.length;i++){
  							var option = $("<option>"+menus[i].menuName+"</option>");
  							menuName.append(option);
  						}
  					}
				});
		}
		function del(permissionId){
			var result = window.confirm("确认要删除吗?");
			if(true == result){
				$.ajax({
					type:"POST",
  					url:"<%=basePath%>permission/deletePermissionById.do",
  					data:{"permissionId":permissionId},
  					success:function(msg){
						alert("删除成功");
	  					search(1);
  					}
				});
			}
		}
		$(document).ready(function(){
			getAllRoleName();
			getAllMenuName();
  			search(1);
  		});
	</script>
  </head>
  
  <body>
	<h1 class="title">首页  &gt;&gt;权限管理 </h1>
         	
         	<div class="add">
         		<a href="<%=basePath%>permissions/perAdd.jsp" target="contentPage"><img src="img/add.png" width="18px" height="18px">添加权限</a>
         	</div>
         	<div style="margin-top: 50px;width: 750px;margin-left: 100px;">
	         	&nbsp;&nbsp;&nbsp;&nbsp;角色：
	         	<select id="roleName" style="width: 100px;margin-left: 10px;">
	         		<option >请选择</option>
	         	</select>
	         	&nbsp;&nbsp;&nbsp;&nbsp;菜单： 
	         	<select id="menuName" style="width: 100px;margin-left: 10px;">
	         		<option >请选择</option>
	         	</select>
	         	<input type="button" value="查询" onclick="search(1)" style="width: 50px;margin-left: 30px;">
         	</div>
         	<table class="deptInfo">
         		<tr class="titleRow">
         			<td>角色名称</td>
         			<td>菜单名称</td>
         			<td>操作列表</td>
         		</tr>         	
         	</table>
         	<div style="width: 500px; margin-left: 150px;margin-top: 10px;">
         		<input id="startPage" type="button" value="首页" onclick="search(1)" style="width: 60px">
		  		<input id="lastPage" type="button" value="上一页" style="width: 60px">
		  		<input id="nextPage" type="button" value="下一页" style="width: 60px">
		  		<input id="endPage" type="button" value="末页" style="width: 60px">
         	</div>
  </body>
</html>
