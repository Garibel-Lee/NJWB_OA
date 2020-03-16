<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="/">
    
    <title>报销管理明细</title>
    
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
		table,tr,td,th{
			border: solid 2px pink;
		}
		th{
			background-color: #FFEED0;
		}
	
	</style>
		<script type="text/javascript">
		$(document).ready(function(){
			refresh();
  		});
		function refresh(){
			//用一个隐藏框取出后台的数据
			var paymentNo = $("#hiddenInput").val();
			$.ajax({
			   type : "POST",
			   //目标地址
			   url: "/payment/getPaymentByPaymentNo.do",
			   //得到后台的
			   data: {"paymentNo":paymentNo},
			   success: function(msg){
				  var payment = $.parseJSON(msg);
				  var paymentName = payment.paymentName;//申请人
				  var paymentType = payment.paymentType;//报销类型
				  var paymentIntro = payment.paymentIntro;//摘要
				  var money = payment.money;//金额
				  var applyDate = payment.applyTime;//申请时间 （年-月-日）
				  var applyTime = (applyDate.year+1900)+"-"+(applyDate.month+1)+"-"+(applyDate.date);
				  var applyStatus = payment.applyStatus;//申请状态
				  $("#paymentNo").html(paymentNo);
				  $("#paymentName").html(paymentName);
				  $("#paymentType").html(paymentType);
				  $("#paymentIntro").html(paymentIntro);
				  $("#money").html(money);
				  $("#applyTime").html(applyTime);
				  $("#applyStatus").html(applyStatus);
				 }
			 });
		}
	</script>

  </head>
  
  <body>
	<%
   		String paymentNo = request.getParameter("paymentNo");
   		request.setAttribute("paymentNo",paymentNo);
   	%>
   	<div style="width: 200px;margin: 0 auto;">
	  	<h3 class="title">报销单详情 </h3>
	</div>
    <ul id="result">
    	<li>
    		报销编号：<span id="paymentNo"></span>
    	</li>
    	<li>
    		申请人：<span id="paymentName"></span>
    	</li>
    	<li>
    		报销类型：<span id="paymentType"></span>
    	</li>
    	<li>
    		摘要：<span id="paymentIntro"></span>
    	</li>
    	<li>
    		金额：<span id="money"></span>
    	</li>
    	<li>
    		申请时间：<span id="applyTime"></span>
    	</li>
    	<li>
    		申请状态：<span id="applyStatus"></span>
    	</li>
    </ul>
    <div id="back">
		<a href="/payment/payment.jsp" target="contentPage"><input type="button" value="返回"></a>
	</div>
    <input type="hidden" value="${paymentNo}" id="hiddenInput">
  </body>
</html>
