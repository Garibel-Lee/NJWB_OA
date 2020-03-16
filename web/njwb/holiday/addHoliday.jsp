<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="/">
    
    <title>添加请假</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="/js/jquery-1.8.3.js"></script>
	<script type="text/javascript" src="/js/laydate/laydate.js"></script>
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
		function addHoliday(holidayStatus){
			var holidayType = $("#holidayType").val();
			if(holidayType == "请选择"){
				alert("请选择请假类型");
				return;
			}
			var holidayCause = $("#holidayCause").val();
			if(holidayCause == ""){
				alert("请假事由不能为空");
				return;
			}
			var startTime = $("#startTime").val();
			if(startTime == ""){
				alert("开始时间不能为空");
				return;
			}
			var endTime = $("#endTime").val();
			if(endTime == ""){
				alert("结束时间不能为空");
				return;
			}
			$.ajax({
			   type : "POST",
			   url: "/holiday/addHoliday.do",
			   data: {"holidayType":holidayType,
				   	  "holidayCause":holidayCause,
				   	  "startTime":startTime,
				   	  "endTime":endTime,
				   	  "holidayStatus":holidayStatus
				   },
				success:function(msg){
  						if(msg != ""){
  							alert(msg);
  						}else{
  							alert("添加成功！");
  						}
  					}
			 });
		}
		function reset(){
			$("#holidayType").val("请选择");
			$("#holidayCause").val("");
			$("#startTime").val("");
			$("#endTime").val("");
			$("#holidayType").val("请选择");
		}
	</script>
  </head>
  
  <body>
  <div id="container">
	    
		   	<table id = "addHolidayTable">
		   		<tr>
		   			<td>
		   			请假类型:
		   			</td>
		   			<td>
		   				<select id="holidayType" style="width: 100px;margin-right: 20px;" >
		   					<option>请选择</option>
	         				<option>事假</option>
	         				<option>婚假</option>
	         				<option>年假</option>
	         				<option>调休</option>
	         				<option>病假</option>
	         				<option>丧假</option>
	         				<option>产假</option>
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
		   				<input type = "text" id="startTime" onclick="laydate()"/>
		   			</td>
		   		</tr>  
		
		   		<tr>
		   			<td>
		   			结束时间:
		   			</td>
		   			<td>
		   				<input type = "text" id="endTime" onclick="laydate()"/>
		   			</td>
		   		</tr>  
		   		
		   		<tr>
		   			<td colspan="2">
		   				<input type = "button" value="草稿" onclick="addHoliday('草稿')"/>
		   				<input type = "button" value="提交" onclick="addHoliday('已提交')"/>
		   				<input type = "button" value="重置" onclick="reset()"/>
						<a href="/holiday.jsp" target="contentPage"><input type="button" value="返回"></a>
		   			</td>
		   		</tr>  	
		   	</table>
   	</div>
  </body>
</html>
