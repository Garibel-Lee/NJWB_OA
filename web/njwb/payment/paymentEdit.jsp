<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="/">
    
    <title>报销管理修改</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="/js/jquery-1.8.3.js"></script>
	<script type="text/javascript" src="/js/laydate/laydate.js"></script>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style type="text/css">
		body,div,table,tr,td{
			margin: 0px;
			padding: 0px;
		}
		#paymentEditTable{
			font-size: 15px;
			border-collapse: collapse;
			width: 350px;
			margin: 20px auto;
		}
		#paymentEditTable td{
			height: 40px;
		}
		a{
			text-decoration: none;
		}
	</style>
	<script type="text/javascript">
		$(document).ready(function(){
			refresh();
  		});
		function refresh(){
			var paymentNo = $("#hiddenInput").val();
			$.ajax({
			   type : "POST",
			   url: "/payment/getPaymentByPaymentNo.do",
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
				  
				  $("#paymentNo").val(paymentNo);
				  $("#paymentType").val(paymentType);
				  $("#paymentIntro").val(paymentIntro);
				  $("#money").val(money);
				  $("#applyTime").val(applyTime);
				  $("#applyStatus").val(applyStatus);
				  
				  if(applyStatus == "已提交"){
					  var updateInput = $("#updateInput");
					  updateInput.prop("disabled",true);
				  }
				}
			 });
		}
		function checkBeforeSubmit(){
			var paymentType = $("#paymentType").val();
			if(paymentType == "请选择"){
				alert("请选择报销类型");
				return false;
			}
			var paymentIntro = $("#paymentIntro").val();
			if(paymentIntro == ""){
				alert("摘要不能为空");
				return false;
			}
			var money = $("#money").val();
			if(money == ""){
				alert("金额不能为空");
				return false;
			}
			//非负浮点数
			var reg = /^\d+(\.\d+)?$/;
			if(!reg.test(money)){
				alert("输入金额格式错误！");
				return false;
			}
			var applyTime = $("#applyTime").val();
			if(applyTime == ""){
				alert("申请时间不能为空");
				return false;
			}
			return true;
		}
	</script>
	
	

  </head>
  
  <body>
	<%
   		String paymentNo = request.getParameter("paymentNo");
   		request.setAttribute("paymentNo",paymentNo);
   	%>
   	<div style="width: 200px;margin: 0 auto;">
	  	<h3 class="title">修改报销 </h3>
	  </div>
   	<form action="payment/updatePayment.do" method="post" onsubmit="return checkBeforeSubmit()">
	   	<table id = "paymentEditTable">
	   		<tr>
	   			<td>
	   			撤销编号:
	   			</td>
	   			<td>
	   				<input type = "text" name="paymentNo" id="paymentNo" readonly="readonly"/>
	   			</td>
	   		</tr>
			<tr>
	   			<td>
	   			报销类型:
	   			</td>
	   			<td>
	   				<select name="paymentType" id="paymentType" style="width: 100px">
		         		<option >请选择</option>
		         		<option >差旅费</option>
		         		<option >招待费</option>
		         		<option >办公费</option>
	   				</select>
	   			</td>
	   		</tr>  
	   		<tr>
	   			<td>
	   			摘要:
	   			</td>
	   			<td>
	   				<textarea rows="3" cols="25" name="paymentIntro" id="paymentIntro"></textarea>
	   			</td>
	   		</tr>  
	   		<tr>
	   			<td>
	   			金额:
	   			</td>
	   			<td>
	   				<input type = "text" name="money" id="money"/>
	   			</td>
	   		</tr>  
	   		<tr>
	   			<td>
	   			申请时间:
	   			</td>
	   			<td>
	   				<input type = "text" name="applyTime" id="applyTime" onclick="laydate({istime:true,format:'YYYY-MM-DD hh:mm:ss'})"/>
	   			</td>
	   		</tr>  
	   		<tr>
	   			<td>
	   			申请状态:
	   			</td>
	   			<td>
	   				<select id="applyStatus" name="applyStatus">
	   					<option>草稿</option>
	   					<option>已提交</option>
	   				</select>
	   			</td>
			</tr>  
	   		
	   		<tr>
	   			<td colspan="2">
	   				<input type = "submit" value="修改" id="updateInput"/>
	   				<input type = "button" value="重置" onclick="refresh()"/>
					<a href="/payment/payment.jsp" target="contentPage"><input type="button" value="返回"></a>
	   			</td>
	   		</tr>  	
	   	</table>
   	</form>
   	<input type="hidden" value="${paymentNo}" id="hiddenInput">
  </body>
</html>
