<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="/">
    
    <title>添加部门</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="/js/jquery-1.8.3.js"></script>
	<style type="text/css">
		a{
			text-decoration:none;
		}
		body,div,table,tr,td{
			margin: 0px;
			padding: 0px;
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
	</style>
	<script type="text/javascript">
		function checkBeforeSubmit(){
			var deptNo = $("#deptNo").val();
			if(deptNo == ""){
				alert("部门编号不能为空");
				return false;
			}
			var deptName = $("#deptName").val();
			if(deptName == ""){
				alert("部门名称不能为空");
				return false;
			}
			var deptLocation = $("#deptLocation").val();
			if(deptLocation == ""){
				alert("部门位置不能为空");
				return false;
			}
			var deptManager = $("#deptManager").val();
			if(deptManager == ""){
				alert("部门负责人不能为空");
				return false;
			}
			var deptIntro = $("#deptIntro").val();
			if(deptIntro == ""){
				alert("部门介绍不能为空");
				return false;
			}
			return true;
		}
	</script>
  </head>
  
  <body>
   	<form action="dept/deptAdd.do" method="post" onsubmit="return checkBeforeSubmit()">
	   	<table id = "deptEditTable">
	   		<tr>
	   			<td>
	   			部门编号:
	   			</td>
	   			<td>
	   				<input type = "text" name="deptNo" id="deptNo" style="-moz-user-select:none;"/>
	   			</td>
	   		</tr>
	   		<tr>
	   			<td>
	   			部门名称:
	   			</td>
	   			<td>
	   				<input type = "text" name="deptName" id="deptName"/>
	   			</td>
	   		</tr>  
	
	   		<tr>
	   			<td>
	   			部门位置:
	   			</td>
	   			<td>
	   				<input type = "text" name="deptLocation" id="deptLocation"/>
	   			</td>
	   		</tr>  
	
	   		<tr>
	   			<td>
	   			部门负责人:
	   			</td>
	   			<td>
	   				<input type = "text" name="deptManager" id="deptManager"/>
	   			</td>
	   		</tr>  
	   		
	   		<tr>
	   			<td>
	   			部门介绍:
	   			</td>
	   			<td>
	   				<textarea rows="3" cols="25" name="deptIntro" id="deptIntro"></textarea>
	   			</td>
	   		</tr>  
	   		
	   		<tr>
	   			<td colspan="2">
	   				<input type = "submit" value="添加"/>
	   				<input type = "reset" value="重置"/>
					<a href="/njwb/dept/dept.jsp" target="contentPage"><input type="button" value="返回"></a>
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
