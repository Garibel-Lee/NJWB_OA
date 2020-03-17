<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="/">
    
    <title>员工添加</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="/js/jquery-1.8.3.js"></script>
	<script type="text/javascript" src="/js/laydate/laydate.js"></script>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style type="text/css">
		a{
			text-decoration:none;
		}
		body,div,table,tr,td{
			margin: 0px;
			padding: 0px;
		}
		#empEditTable{
			font-size: 15px;
			border-collapse: collapse;
			width: 350px;
			margin: 20px auto;	
		}
		
		#empEditTable td{
			height: 40px;
		}
		#container{
			width: 200px;
			margin: 0 auto;
		}
	</style>
	<script type="text/javascript">
		$(document).ready(function(){
			$.ajax({
					type:"POST",
  					url:"dept/deptGetall.do",
  					success:function(msg){
  						var depts = $.parseJSON(msg);
  						var empDept = $("#empDept");
  						for(var i = 0; i < depts.length;i++){
  							var option = $("<option value="+depts[i].deptNo+">"+depts[i].deptName+"</option>");
  							empDept.append(option);
  						}
  					}
				});
  		});

		function checkBeforeSubmit(){
			//验证员工姓名
			var empName = $("#empName").val();
			if(empName == ""){
				alert("员工姓名不能为空");
				return false;
			}
			var patrn=/[\^\*<>\/[\]]/;
			if(patrn.test(empName)){
				alert("员工姓名格式错误：不可非法字符（< > / \ * ^）");
				return false;
			}
			//验证手机
			var patrnP=/^1[0-9]{10}$/;
			var phone = $("#phone").val();
			if(phone == ""){
				alert("手机不能为空");
				return false;
			}
			if(!patrnP.test(phone)){
				alert("手机格式错误（例：1xxxxxxxxxx(共11位)）");
				return false;
			}
			
			
			//验证入职时间
			var entryTime = $("#entryTime").val();
			if(entryTime == ""){
				alert("入职时间不能为空");
				return false;
			}
			//验证性别
			var sex = $("#sex").val();
			if(sex == "请选择"){
				alert("请选择性别 ");
				return false;
			}
			//验证学历
			var education = $("#education").val();
			if(education == "请选择"){
				alert("请选择学历 ");
				return false;
			}
			return true;
		}
	
	
	</script>

  </head>
  
  <body>
  	  <div id="container">
	  	<h3 class="title">员工新增 </h3>
	  </div>
	  <form action="emp/addEmp.do" method="post" onsubmit="return checkBeforeSubmit()">
	   	<table id = "empEditTable">
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
	   			所属部门:
	   			</td>
	   			<td>
	   				<select name="empDept" id="empDept" style="width: 100px">
		         		<option >请选择</option>
	   				</select>
	   			</td>
	   		</tr>  
	   		<tr>
	   			<td>
	   			性别:
	   			</td>
	   			<td>
	   				<select name="sex" id="sex" style="width: 100px">
		         		<option >请选择</option>
		         		<option >男</option>
		         		<option >女</option>
	   				</select>
	   			</td>
	   		</tr>  
	   		<tr>
	   			<td>
	   			学历:
	   			</td>
	   			<td>
	   				<select name="education" id="education" style="width: 100px">
		         		<option >请选择</option>
		         		<option >博士</option>
		         		<option >研究生</option>
		         		<option >大学</option>
		         		<option >高中</option>
		         		<option >初中</option>
		         		<option >其他</option>
	   				</select>
	   			</td>
	   		</tr>  
	   		<tr>
	   			<td>
	   			手机:
	   			</td>
	   			<td>
	   				<input type = "text" name="phone" id="phone"/>
	   			</td>
	   		</tr>  
	   		<tr>
	   			<td>
	   			入职时间:
	   			</td>
	   			<td>
	   				<input type = "text" name="entryTime" id="entryTime" onclick="laydate()"/>
	   			</td>
	   		</tr>  
	   		
	   		<tr>
	   			<td colspan="2">
	   				<input type = "submit" value="添加"/>
	   				<input type = "reset" value="重置"/>
					<a href="emp/queryEmp.do" target="contentPage"><input type="button" value="返回"></a>
	   			</td>
	   		</tr>  	
	   	</table>
   	</form>
   	<c:if test='${isError}'>
    	<script type="text/javascript">
    		alert("${errorMessage}");
    	</script>
    </c:if>
	

  </body>
</html>
