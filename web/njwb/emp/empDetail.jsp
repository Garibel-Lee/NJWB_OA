<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="/">
    
    <title>员工明细</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="/js/jquery-1.8.3.js"></script>
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
	
		#deptEditTable{
			font-size: 15px;
			border-collapse: collapse;
			width: 350px;
			margin: 20px auto;	
		}
		
		#deptEditTable,td{
			height: 40px;
			margin-left: 20px;
		}
		table,tr,td,th{
			border: solid 2px pink;
		}
		th{
			background-color: #FFEED0;
		}
		#header{
			width: 300px;
			margin: 0 auto;
		}
	</style>
	<script type="text/javascript">
		//加载页面时刷新
		$(document).ready(function(){
			refresh();
  		});
		function refresh(){
			//用一个隐藏框取出后台的数据
			var empNo = $("#hiddenInput").val();
			console.log(empNo);
			$.ajax({
			   type : "POST",
			   url: "/emp/getEmpByEmpNo.do",
			   data: {"empNo":empNo},
			   success: function(msg){
				  var emp = $.parseJSON(msg);
				  var resultTable = $("#resultTable");
				  var tr = $("<tr></tr>");
				  //对每个属性进行定义
				  var empNoTd = $("<td>"+emp.empNo+"</td>");
				  var empNameTd = $("<td>"+emp.empName+"</td>"); 
				  var empDeptTd = $("<td>"+emp.deptName+"</td>");
				  var sexTd = $("<td>"+emp.sex+"</td>");
				  var educationTd = $("<td>"+emp.education+"</td>");
				  var phoneTd = $("<td>"+emp.phone+"</td>");
				  //得到入职时间
				  var entryDate = emp.entryTime;
				  var entryTimeF = (entryDate.year+1900)+"-"+(entryDate.month+1)+"-"+(entryDate.date);
				  var deptManagerTd = $("<td>"+entryTimeF+"</td>");
				  //得到创建时间
				  var createDate = emp.empCreateTime;
				  var createTimeF = (createDate.year+1900)+"-"+(createDate.month+1)+"-"+(createDate.date);
				  var deptCreateTimeTd = $("<td>"+createTimeF+"</td>");
				  //数据表格拼接
				  tr.append(empNoTd).append(empNameTd).append(empDeptTd).append(sexTd)
				  .append(educationTd).append(phoneTd).append(deptManagerTd).append(deptCreateTimeTd);
				  resultTable.append(tr);
				 }
			 });
		}
	</script>

  </head>
  
  <body>
	<%
   		String empNo = request.getParameter("empNo");
   		request.setAttribute("empNo",empNo);
   	%>
   	<div id="header">
   		<h3>员工详情</h3>
   	</div>
   	<table id="resultTable">
   		<tr>
    		<th>员工编号</th>
    		<th>员工姓名</th>
    		<th>所属部门</th>
    		<th>性别</th>
    		<th>学历</th>
    		<th>手机</th>
    		<th>入职时间</th>
    		<th>创建时间</th>
    	</tr>
   	</table>
   	<div id="back">
		<a href="emp.jsp" target="contentPage"><input type="button" value="返回"></a>
	</div>
	<input type="hidden" value="${empNo}" id="hiddenInput">
  </body>
</html>
