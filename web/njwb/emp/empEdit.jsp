<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.lcqjoyce.entity.Employee" %>
<%@ page import="com.lcqjoyce.service.EmployeeService" %>
<%@ page import="com.lcqjoyce.My_JDBC.Init.BeanFactory" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String empNo=(String) request.getParameter("empNo");
	EmployeeService service=(EmployeeService) BeanFactory.getObject("employeeService");
	Employee emp=service.getEmployeeByNo(empNo);
	request.setAttribute("emp",emp);
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
	  <script type="text/javascript">
		  $(document).ready(function(){
			  $.ajax({
				  type:"POST",
				  url:"dept/deptGetall.do",
				  success:function(msg){
					  var depts = $.parseJSON(msg);
					  var empDept = $("#empDept");
					  for(var i = 0; i < depts.length;i++){

					  	if("${emp.empDept}"==depts[i].deptNo) {
							var option = $("<option selected=selected   value=" + depts[i].deptNo + ">" + depts[i].deptName + "</option>");
							empDept.append(option);
					  	}
						else {
							option = $("<option   value=" + depts[i].deptNo + ">" + depts[i].deptName + "</option>");
							empDept.append(option);
						}
					  }
				  }
			  });
			  $("#sex").attr("value", "${emp.sex}");

			  $("#education").attr("value", "${emp.education}");
		  });
		  function refesh() {
			  $("#empDept").attr("value", "${emp.empDept}");
		  }
	  </script>

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


  </head>
  
  <body>
   	<div id="container" >
   		<h3 style="width: 200px;margin: 0 auto;">  ${emp.empDept}的${emp.empNo}修改</h3>
	   	<form action="emp/empUpdate.do" method="post" onsubmit="return checkBeforeSubmit()">
		   	<table id = "empEditTable">
		   		<tr>
		   			<td>
		   			员工编号:
		   			</td>
		   			<td>
		   				<input type = "text" name="empNo" id="empNo" value="${emp.empNo}" readonly="readonly" />
		   			</td>
		   		</tr>
		   		<tr>
		   			<td>
		   			员工姓名:
		   			</td>
		   			<td>
		   				<input type = "text" name="empName" value="${emp.empName}" id="empName"/>
		   			</td>
		   		</tr>  
				<tr>
		   			<td>
		   			所属部门:
		   			</td>
		   			<td>
		   				<select name="empDept" id="empDept"  style="width: 100px" onblur="refesh()">
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
			         		<option value="男">男</option>
			         		<option value="女">女</option>
		   				</select>
		   			</td>
		   		</tr>  
		   		<tr>
		   			<td>
		   			学历:
		   			</td>
		   			<td>
		   				<select name="education" id="education"   style="width: 100px">
			         		<option >请选择</option>
							<option value="博士" >博士</option>
							<option  value="研究生" >研究生</option>
							<option  value="大学">大学</option>
							<option  value="高中">高中</option>
							<option  value="初中">初中</option>
							<option  value="其他">其他</option>
		   				</select>
		   			</td>
		   		</tr>  
		   		<tr>
		   			<td>
		   			手机:
		   			</td>
		   			<td>
		   				<input type = "text" name="phone" value="${emp.phone}" id="phone"/>
		   			</td>
		   		</tr>  
		   		<tr>
		   			<td>
		   			入职时间:
		   			</td>
		   			<td>
		   				<input type = "text" name="entryTime" value="${emp.entryTime}" id="entryTime"  onclick="laydate()"/>
		   			</td>
		   		</tr>  
		   		
		   		
		   		<tr>
		   			<td colspan="2">
		   				<input type = "submit" value="修改"/>
		   				<input type = "button" value="重置" onclick="refresh()"/>
						<a href="/njwb/emp/emp.jsp" target="contentPage"><input type="button" value="返回"></a>
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
