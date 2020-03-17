<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="/">
    
    <title>请假详情</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="/js/jquery-1.8.3.js"></script>
	<style type="text/css">
		ul{
			width: 200px;
			margin: 50px auto;
		}
		li{
			margin-top: 20px;
		}
		#back{
			width: 100px;
			margin: 50px auto;
		}
		#header{
			width: 200px;
			margin: 0 auto;
		}
		a{
			text-decoration: none;
		}
	</style>
	<script type="text/javascript">

	</script>
  </head>
  
  <body>
  	<%
   		String holidayNo = request.getParameter("holidayNo");
   		request.setAttribute("holidayNo",holidayNo);
   	%>
   	<div id="header">
	   	<h1>请假详情</h1>
   	</div>
    <ul id="result">
    	<li>
    		请假编号：<span id="holidayNo"></span>
    	</li>
    	<li>
    		申请人：<span id="applyName"></span>
    	</li>
    	<li>
    		请假类型：<span id="holidayType"></span>
    	</li>
    	<li>
    		请假事由：<span id="holidayCause"></span>
    	</li>
    	<li>
    		开始时间：<span id="startTime"></span>
    	</li>
    	<li>
    		结束时间：<span id="endTime"></span>
    	</li>
    	<li>
    		申请状态：<span id="holidayStatus"></span>
    	</li>
    </ul>
    <div id="back">
		<a href="/holiday/updateHoliday.do" target="contentPage"><input type="button" value="返回"></a>
	</div>
    <input type="hidden" value="${holidayNo}" id="hiddenInput">
  </body>
</html>
