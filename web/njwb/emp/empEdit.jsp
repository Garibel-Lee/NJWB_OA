<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>员工修改</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=basePath %>js/jquery-1.8.3.js"></script>
	<script type="text/javascript" src="<%=basePath %>js/laydate/laydate.js"></script>
	<style type="text/css">
		body,div,table,tr,td{
			margin: 0px;
			padding: 0px;
		}
		#container{
			width: 500px;
			margin: 0 auto;
		}
		#deptEditTable{
			font-size: 15px;
			border-collapse: collapse;
			width: 350px;
			margin: 20px auto;
		}
		#deptEditTable td{
			height: 40px;
		}
		a{
			text-decoration: none;
		}
	</style>
	<script type="text/javascript">
		$(document).ready(function(){
			$.ajax({
					type:"POST",
  					url:"<%=basePath%>dept/getAllDept.do",
  					success:function(msg){
  						//从后台得到的数据，转换成object
  						depts = $.parseJSON(msg);
  						 var empDept = $("#empDept");
  						  //每次获取时清空
  						 empDept.html("");
  						 var op = $("<option></option>");
  						 op.html("请选择");
  						 empDept.append(op);
  						 //遍历
						for(var i = 0; i < depts.length;i++){
							var option = $("<option>"+depts[i].deptName+"</option>");
							empDept.append(option);
						}
  					}
				});
			refresh();
  		});
		var oldDeptName;
		function refresh(){
			//用一个隐藏框取出后台的数据
			var empNo = $("#hiddenInput").val();
			var deptName;
			$.ajax({
			   type : "POST",
			   url: "<%=basePath%>emp/getEmpByEmpNo.do",
			  //根据员工编号修改信息
			   data: {"empNo":empNo},
			   success: function(msg){
				 var emp = $.parseJSON(msg);
				  var empNo = emp.empNo;
				  var empName = emp.empName;
				  //当部门名为空的时候 请选择
				  if(emp.deptName ==""){
					  deptName = "请选择";
				  }else{
					  //如果不是 显示当前部门名称
				  	deptName = emp.deptName;
				  }
				  $("#empDept").val(deptName);
				  oldDeptName = emp.empDept;
				  var sex = emp.sex;
				  var education = emp.education;
				  var phone = emp.phone;
				  var entryDate = emp.entryTime;
				  var entryTimeF = (entryDate.year+1900)+"-"+(entryDate.month+1)+"-"+(entryDate.date);
				  $("#empNo").val(empNo);
				  $("#empName").val(empName);
				  $("#sex").val(sex);
				  $("#education").val(education);
				  $("#phone").val(phone);
				  $("#entryTime").val(entryTimeF);
				}
			 });
		}
		function checkBeforeSubmit(){
			//验证员工姓名
			var empName = $("#empName").val();
			if(empName == ""){
				alert("员工姓名不能为空");
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
	<%
   		String empNo = request.getParameter("empNo");
   		request.setAttribute("empNo",empNo);
   	%>
   	<div id="container">
   		<h3 style="width: 200px;margin: 0 auto;">员工修改</h3>
	   	<form action="emp/updateEmp.do" method="post" onsubmit="return checkBeforeSubmit()">
		   	<table id = "empEditTable">
		   		<tr>
		   			<td>
		   			员工编号:
		   			</td>
		   			<td>
		   				<input type = "text" name="empNo" id="empNo" readonly="readonly"/>
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
		   			所属部门:
		   			</td>
		   			<td>
		   				<select name="empDept" id="empDept" style="width: 100px">
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
		   				<input type = "submit" value="修改"/>
		   				<input type = "button" value="重置" onclick="refresh()"/>
						<a href="<%=basePath%>emp/emp.jsp" target="contentPage"><input type="button" value="返回"></a>
		   			</td>
		   		</tr>  	
		   	</table>
	   	</form>
   	</div>
   	<input type="hidden" value="${empNo}" id="hiddenInput">
   	<c:if test='${isError}'>
    	<script type="text/javascript">
    		alert("${errorMessage}");
    	</script>
    </c:if>
  </body>
</html>
