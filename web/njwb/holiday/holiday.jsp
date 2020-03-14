<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>请假管理</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="<%=basePath %>css/reset.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath %>css/main.css">
	<script type="text/javascript" src="<%=basePath %>js/jquery-1.8.3.js"></script>
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
	</style>
	<script type="text/javascript">
		function search(){
  			var applyName = $("#applyName").val();
  			var holidayType = $("#holidayType").val();
  			var applyStatus = $("#applyStatus").val();
  			$.ajax({
  				type:"POST",
  				url:"<%=basePath%>holiday/getHoliday.do",
  				data:{
  					  "applyName": applyName,
  					  "holidayType": holidayType,
  					  "applyStatus": applyStatus
  					  },
  				success:function(msg){
  					var array = $.parseJSON(msg);
  					var resultTable = $(".holidayInfo");
  					resultTable.html($("table tr")[0]);
  					for(var i = 0; i < array.length;i++){
  						var tr = $("<tr></tr>");
  						var holidayNoTd = $("<td>"+array[i].holidayNo+"</td>");
  						var holidayUserTd = $("<td>"+array[i].holidayUser+"</td>"); 
  						var holidayTypeTd = $("<td>"+array[i].holidayType+"</td>"); 
  						var holidayCauseTd = $("<td>"+array[i].holidayCause+"</td>"); 
  						var startDate = array[i].holidayStartTime;
  						var startTime = (startDate.year+1900)+"-"+(startDate.month+1)+"-"+(startDate.date);
  						var holidayStartTimeTd = $("<td>"+startTime+"</td>"); 
  						var endDate = array[i].holidayEndTime;
  						var endTime = (endDate.year+1900)+"-"+(endDate.month+1)+"-"+(endDate.date);
  						var holidayEndTimeTd = $("<td>"+endTime+"</td>"); 
  						var holidayStatusTd = $("<td>"+array[i].holidayStatus+"</td>"); 
  						var createDate = array[i].createTime;
  						var createTime = (createDate.year+1900)+"-"+(createDate.month+1)+"-"+(createDate.date)+" "+(createDate.hours)+"："+(createDate.minutes)+"："+(createDate.seconds);
						var createTimeTd = $("<td>"+createTime+"</td>"); 
  						var operationTd = $("<td></td>");
						var deleteImg = $('<img id="'+array[i].id+'"src="img/delete.png" class="operateImg" onclick="del(id)">');
						//var deleteImg = $('<img src="img/delete.png" class="operateImg" onclick="del('+deptNo+')">');
						var editImg = $('<img src="img/edit.png" class="operateImg" >');
						var deptEditA = $('<a href="holiday/edit.jsp?holidayNo='+ array[i].holidayNo+'" target="contentPage"></a>');
						var detailImg = $('<img src="img/detail.png" class="operateImg">');
						var detailA = $('<a href="holiday/detail.jsp?holidayNo='+array[i].holidayNo+'" target="contentPage"></a>');
						deptEditA.append(editImg);
						detailA.append(detailImg);
						operationTd.append(deleteImg);
						operationTd.append(deptEditA);
						operationTd.append(detailA);
  						tr.append(holidayNoTd).append(holidayUserTd).append(holidayTypeTd).append(holidayCauseTd).append(holidayStartTimeTd).append(holidayEndTimeTd).append(holidayStatusTd).append(createTimeTd).append(operationTd);
  						resultTable.append(tr);
  					}
  					
				}
  			});
  		}
		function del(holidayId){
			var result = window.confirm("确认要删除吗?");
			if(true == result){
				$.ajax({
					type:"POST",
  					url:"<%=basePath%>holiday/deleteHolidayById.do",
  					data:{"holidayId":holidayId},
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
  			search();
  		});
		
	</script>
  </head>
  
 <body>
         	<h1 class="title">首页  &gt;&gt;请假管理 </h1>
         	
         	<div class="add">
         		<a href="<%=basePath%>holiday/addHoliday.jsp" target="contentPage"><img src="<%=basePath %>img/add.png" width="18px" height="18px">添加请假</a>
         	</div>
         	<div style="margin-top: 50px;width: 750px;margin-left: 50px;">
	         	申请人：<input type="text" id="applyName" style="width: 100px;margin-right: 20px;">
	         	请假类型：<select id="holidayType" style="width: 100px;margin-right: 20px;" >
	         				<option>请选择</option>
	         				<option>事假</option>
	         				<option>婚假</option>
	         				<option>年假</option>
	         				<option>调休</option>
	         				<option>病假</option>
	         				<option>丧假</option>
	         				<option>产假</option>
	         			</select>
	         	
	         	申请状态：<select id="applyStatus" style="width: 100px;margin-left: 20px;">
	         				<option>请选择</option>
	         				<option>草稿</option>
	         				<option>已提交</option>
	         			</select>
	         	<input type="button" value="搜索" onclick="search()" style="width: 50px;margin-left: 20px;">
         	</div>
         	<table class="holidayInfo">
         		<tr class="titleRow">
         			<td>请假编号</td>
         			<td>申请人</td>
         			<td>请假类型</td>
         			<td>请假事由</td>
         			<td>开始时间</td>
         			<td>结束时间</td>
         			<td>申请状态</td>
         			<td>提交时间</td>
         			<td>操作列表</td>
         		</tr>         	
         	</table>
  </body>
</html>
