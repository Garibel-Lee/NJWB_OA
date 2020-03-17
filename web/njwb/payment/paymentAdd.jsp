<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="/">
    
    <title>报销管理添加页面</title>
    
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
			text-decoration:none;
		}
		body,div,table,tr,td{
			margin: 0px;
			padding: 0px;
		}
		#paymentAddTable{
			font-size: 15px;
			border-collapse: collapse;
			width: 350px;
			margin: 20px auto;	
		}
		#paymentAddTable td{
			height: 40px;
		}
	</style>
	<script type="text/javascript">
		function addPayment(applyStatus){
			//报销类型的判断
			var paymentType = $("#paymentType").val();
			if(paymentType == "请选择"){
				alert("请选择报销类型");
				return ;
			}
			//摘要的判断
			var paymentIntro = $("#paymentIntro").val();
			if(paymentIntro == ""){
				alert("摘要不能为空");
				return;
			}
			//金额的判断
			var money = $("#money").val();
			if(money == ""){
				alert("金额不能为空");
				return;
			}
			//非负浮点数
			var reg = /^\d+(\.\d+)?$/; 
			if(!reg.test(money)){
				alert("输入金额格式错误！");
				return;
			}
			alert("添加成功！");
			
			//将页面的数据传到后台去
			$.ajax({
			   type : "POST",
			   url: "/payment/addPayment.do",
			   data: {"paymentType":paymentType,//报销类型
				   	  "paymentIntro":paymentIntro,//摘要
				   	  "money":money,//金额
				   	  "applyStatus":applyStatus//申请状态
				   }
			 });
		}
	</script>
	
	

  </head>
  
  <body>
  	<div style="width: 200px;margin: 0 auto;">
	  	<h3 class="title">添加报销 </h3>
	  </div>
	  
	   	<table id = "paymentAddTable">
	   		<tr>
	   			<td>
	   			报销类型：
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
	   			摘要：
	   			</td>
	   			<td>
	   				<textarea rows="3" cols="25" name="paymentIntro" id="paymentIntro"></textarea>
	   			</td>
	   		</tr>  
	   		<tr>
	   			<td>
	   			金额：
	   			</td>
	   			<td>
	   				<input type = "text" name="money" id="money"/>
	   			</td>
	   		</tr>  
	   		
	   		<tr>
	   			<td colspan="2">
	   				<input type = "button" value="草稿" onclick="addPayment('草稿')"/>
	   				<input type = "button" value="提交" onclick="addPayment('已提交')"/>
	   				<input type = "reset" value="重置"/>
					<a href="/payment/payment.jsp" target="contentPage"><input type="button" value="返回"></a>
	   			</td>
	   		</tr>  	
	   	</table>
	
  </body>
</html>
