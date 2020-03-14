<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>请假修改</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="<%=basePath %>js/jquery-1.8.3.js"></script>
	<script type="text/javascript" src="<%=basePath %>js/laydate/laydate.js"></script>
	<style type="text/css">
		#container{
			width: 500px;;
			margin: 0 auto;
		}
		a{
			text-decoration:none;
		}
	</style>
	<script type="text/javascript">
		$(document).ready(function(){
			refresh();
  		});
		function refresh(){
			var holidayNo = $("#hiddenInput").val();
			$.ajax({
			   type : "POST",
			   url: "<%=basePath%>njwb/holiday/getHolidayByHolidayNo.do",
			   data: {"holidayNo":holidayNo},
			   success: function(msg){
				  var holiday = $.parseJSON(msg);
				  var holidayType = holiday.holidayType;
				  var holidayCause = holiday.holidayCause;
				  var startDate = holiday.holidayStartTime;
				  var startTime = (startDate.year+1900)+"-"+(startDate.month+1)+"-"+(startDate.date);
				  var endDate = holiday.holidayEndTime;
				  var endTime = (endDate.year+1900)+"-"+(endDate.month+1)+"-"+(endDate.date);
				  var holidayStatus = holiday.holidayStatus;
				  $("#holidayNo").val(holidayNo);
				  $("#holidayType").val(holidayType);
				  $("#holidayCause").val(holidayCause);
				  $("#startTime").val(startTime);
				  $("#endTime").val(endTime);
				  $("#holidayStatus").val(holidayStatus);
				  if(holidayStatus == "已提交"){
					  var updateInput = $("#updateInput");
					  updateInput.prop("disabled",true);
				  }
				}
			 });
		}
		function checkBeforeSubmit(){
			var holidayType = $("#holidayType").val();
			if(holidayType == "请选择"){
				alert("请选择请假类型");
				return false;
			}
			var holidayCause = $("#holidayCause").val();
			if(holidayCause == ""){
				alert("请假事由不能为空");
				return false;
			}
			var startTime = $("#startTime").val();
			if(startTime == ""){
				alert("开始时间不能为空");
				return false;
			}
			var endTime = $("#endTime").val();
			if(endTime == ""){
				alert("结束时间不能为空");
				return false;
			}
			return true;
		}
	</script>
  </head>
  
  <body>
  	<%
   		String holidayNo = request.getParameter("holidayNo");
   		request.setAttribute("holidayNo",holidayNo);
   	%>
  	<div id="container">
	    <form action="holiday/updateHoliday.do" method="post" onsubmit="return checkBeforeSubmit()">
		   	<table id = "deptEditTable">
		   		<tr>
		   			<td>
		   			请假编号:
		   			</td>
		   			<td>
		   				<input type = "text" name="holidayNo" id="holidayNo" readonly="readonly"/>
		   			</td>
		   		</tr>
		   		<tr>
		   			<td>
		   			请假类型:
		   			</td>
		   			<td>
		   				<select id="holidayType" name = "holidayType" style="width: 100px;margin-right: 20px;" >
			   					<option>请选择</option>
		         				<option>事假</option>
		         				<option>婚假</option>
		         				<option>年假</option>
		         				<option>调休</option>
		         				<option>病假</option>
		         				<option>丧假</option>
			   			</select>
		   			</td>
		   		</tr>  
		
		   		<tr>
		   			<td>
		   			请假事由:
		   			</td>
		   			<td>
		   				<textarea rows="3" cols="25" name="holidayCause" id="holidayCause"></textarea>
		   			</td>
		   		</tr>  
		   		<tr>
		   			<td>
		   			开始时间:
		   			</td>
		   			<td>
		   				<input type = "text" name ="startTime" id="startTime" onclick="laydate()"/>
		   			</td>
			   	</tr>  
		   		<tr>
		   			<td>
		   			结束时间:
		   			</td>
		   			<td>
		   				<input type = "text" id="endTime" name="endTime" onclick="laydate()"/>
		   			</td>
			   	</tr>  
		   		<tr>
		   			<td>
		   			申请状态:
		   			</td>
		   			<td>
		   				<select id="holidayStatus" name="holidayStatus">
		   					<option>草稿</option>
		   					<option>已提交</option>
		   				</select>
		   			</td>
			   	</tr>  
		   		<tr>
		   			<td colspan="2">
		   				<input type = "submit" value="修改" id="updateInput"/>
		   				<input type = "button" value="重置" onclick="refresh()"/>
						<a href="<%=basePath%>holiday/holiday.jsp" target="contentPage"><input type="button" value="返回"></a>
		   			</td>
		   		</tr>  	
		   	</table>
	   	</form>
   	</div>
   	<input type="hidden" value="${holidayNo}" id="hiddenInput">
   	<c:if test="${isError}">
		<script type="text/javascript">
			alert("${errorMessage}");
		</script>
	</c:if>
  </body>
</html>
