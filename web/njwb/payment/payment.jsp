 <%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>报销管理</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="<%=basePath %>css/reset.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath %>css/main.css">
	<script type="text/javascript" src="<%=basePath %>js/jquery-1.8.3.js"></script>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style type="text/css">
		td{
			-webkit-user-select:none;
		}
		
	</style>
	<script type="text/javascript">
		
		function search(){
			//搜索框的数据
  			var paymentType = $("#paymentType").val();
  			var applyStatus = $("#applyStatus").val();
  			$.ajax({
  				//提交方式POST
  				type:"POST",
  				//目标地址
  				url:"<%=basePath%>payment/getPayment.do",
  				//表示传到服务器的值
  				data:{
  					  "paymentType": paymentType,
  					  "applyStatus": applyStatus
  					  },
  				//回调函数  msg是response.write的数据通常使用json格式传值
  				success:function(msg){
  					//从后台得到的数据，转换成object
  					var array = $.parseJSON(msg);
  					//表格
  					var resultTable = $(".deptInfo");
  					//标题栏
  					resultTable.html($("table tr")[0]);
  					//遍历
  					for(var i = 0; i < array.length;i++){
  						var tr = $("<tr></tr>");
  						var paymentNoTd = $("<td>"+array[i].paymentNo+"</td>");//撤销编号
  						var paymentNameTd = $("<td>"+array[i].paymentName+"</td>"); //申请人
  						var paymentTypeTd = $("<td>"+array[i].paymentType+"</td>"); //报销类型
  						var moneyTd = $("<td>"+array[i].money+"</td>"); //金额
  							//申请时间
  						var applyTimeDate = array[i].applyTime;
  						var applyTimeF = (applyTimeDate.year+1900)+"-"+(applyTimeDate.month+1)+"-"+(applyTimeDate.date);
  						var applyTimeFTd = $("<td>"+applyTimeF+"</td>"); 
  						var applyStatusTd = $("<td>"+array[i].applyStatus+"</td>"); //申请状态
  						//操作列表Td
  						var operationTd = $("<td></td>");
  						//删除图标，根据id
						var deleteImg = $('<img id="'+array[i].id+'"src="img/delete.png" class="operateImg" onclick="del(id)">');
						//修改图标,根据撤销编号选中
						var editImg = $('<img src="img/edit.png" class="operateImg" >');
						var deptEditA = $('<a href="payment/paymentEdit.jsp?paymentNo='+ array[i].paymentNo+'" target="contentPage"></a>');
						//查看详情图标,根据撤销编号选中
						var detailImg = $('<img src="img/detail.png" class="operateImg">');
						var detailA = $('<a href="payment/paymentDetail.jsp?paymentNo='+array[i].paymentNo+'" target="contentPage"></a>');
						//图标的拼接
						deptEditA.append(editImg);
						detailA.append(detailImg);
						operationTd.append(deleteImg);
						operationTd.append(deptEditA);
						operationTd.append(detailA);
						//数据表格拼接
  						tr.append(paymentNoTd).append(paymentNameTd).append(paymentTypeTd)
  							.append(moneyTd).append(applyTimeFTd).append(applyStatusTd)
  							.append(operationTd);
  						resultTable.append(tr);
  					}
  					
				}
  			});
  		}
		function del(paymentId){
			//二次确认是否删除
			var result = window.confirm("确认要删除吗?");
			//点击确认
			if(true == result){
				$.ajax({
					type:"POST",
  					url:"<%=basePath%>payment/deletePaymentById.do",
  					//通过报销表ID删除该用户
  					data:{"paymentId":paymentId},
  					success:function(msg){
  						if(msg != ""){//错误信息提示
  							alert(msg);
  						}else{
							//删除成功之后刷新界面
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
  	<h1 class="title">首页  &gt;&gt;报销管理 </h1>
         	
         	<div class="add">
         		<a href="<%=basePath%>payment/paymentAdd.jsp" target="contentPage"><img src="img/add.png" width="18px" height="18px">添加报销</a>
         	</div>
         	<div style="margin-top: 50px;width: 750px;margin-left: 50px;">
	         	报销类型：
	         	<select id="paymentType" style="width: 100px">
	         		<option >请选择</option>
	         		<option >差旅费</option>
	         		<option >招待费</option>
	         		<option >办公费</option>
	         	</select>
	         	申请状态： 
	         	<select id="applyStatus" style="width: 100px">
	         		<option >请选择</option>
	         		<option >草稿</option>
	         		<option >已提交</option>
	         	</select>
	         	<input type="button" value="查询" onclick="search(1)" style="width: 50px;">
         	</div>
         	<table class="deptInfo">
         		<tr class="titleRow">
         			<td>报销编号</td>
         			<td>申请人</td>
         			<td>报销类型</td>
         			<td>金额</td>
         			<td>申请时间</td>
         			<td>申请状态</td>
         			<td>操作列表</td>
         		</tr>         	
         	</table>
  </body>
</html>
