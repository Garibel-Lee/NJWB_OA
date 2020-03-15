<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.lcqjoyce.entity.Dept" %>
<%@ page import="com.lcqjoyce.service.DeptService" %>
<%@ page import="com.lcqjoyce.My_JDBC.Init.BeanFactory" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	DeptService service=(DeptService) BeanFactory.getObject("deptService");

Dept dept=service.getByDeptNo(${})

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>部门明细</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style type="text/css">
		a{
			text-decoration: none;
		}
		#back{
			width: 100px;
			margin: 80px auto;
		}
		body,div,table,tr,td{
			margin: 0px;
			padding: 0px;
		}
		table,tr,td,th{
			border: solid 2px pink;
		}
		#deptEditTable{
			font-size: 15px;
			border-collapse: collapse;
			width: 350px;
			margin: 20px auto;	
		}
		
		#deptEditTable td{
			height: 40px;
			margin-left: 20px;
		}
	
	</style>
	<script type="text/javascript" src="<%=basePath %>js/jquery-1.8.3.js"></script>

  </head>
  
  <body>
  	<%
   		String deptNo = request.getParameter("deptNo");
   		request.setAttribute("deptNo",deptNo);
   	%>
   	<table id="resultTable">
   		<tr>
    		<th>部门编号</th>
    		<th>部门名称</th>
    		<th>部门位置</th>
    		<th>部门负责人</th>
    		<th>部门创建时间</th>
    		<th>部门介绍</th>
    	</tr>
   	</table>
   	<div id="back">
		<a href="/njwb/dept/dept.jsp" target="contentPage"><input type="button" value="返回"></a>
	</div>
	<input type="hidden" value="${deptNo}" id="hiddenInput">
  </body>
  
</html>
