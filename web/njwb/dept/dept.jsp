<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
  <head>
    <title>部门管理</title>
	
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="this is my page">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    
    <link rel="stylesheet" type="text/css" href="../../css/reset.css">
    <link rel="stylesheet" type="text/css" href="../../css/main.css">
    <script type="text/javascript" src="../../js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="../../js/layer/layer.js"></script>

	<style type="text/css">
	
	
	</style>
	
	<script type="text/javascript">
		
		function del(){
			var result = window.confirm("确认要删除吗?");
			if(true == result){
				alert("删除成功");
			}
		}
	
	</script>
  </head>
  
  <body>
         	<h1 class="title">首页  &gt;&gt;部门管理 </h1>
         	
         	<div class="add">
         		<a href="deptAdd.jsp" target="contentPage"><img alt="" src="../../img/add.png" width="18px" height="18px">添加部门</a>
         	</div>
         	
         	<table class="deptInfo">
         		<tr class="titleRow">
         			<td>部门编号</td>
         			<td>部门名称</td>
         			<td>部门位置</td>
         			<td>部门负责人</td>
         			<td>操作列表</td>
         		</tr>
         		<tr>
         			<td>A0001</td>
         			<td>总经办</td>
         			<td>101室</td>
         			<td>李雷</td>
         			<td>
         				<img alt="" src="../../img/delete.png" class="operateImg" onclick="del()">
         				<a href="deptEdit.jsp" target="contentPage"><img alt="" src="../../img/edit.png" class="operateImg" ></a>
         				<a href="deptDetail.jsp" target="contentPage"><img alt="" src="../../img/detail.png" class="operateImg"></a>
         			</td>
         		</tr>
          		<tr>
         			<td>A0002</td>
         			<td>渠道部</td>
         			<td>102室</td>
         			<td>韩梅梅</td>
         			<td>
         				<img alt="" src="../../img/delete.png" class="operateImg">
         				<a href="deptEdit.jsp" target="contentPage"><img alt="" src="../../img/edit.png" class="operateImg"></a>
         				<a href="deptDetail.jsp" target="contentPage"><img alt="" src="../../img/detail.png" class="operateImg"></a>
         			</td>         			
         		</tr>  
          		<tr>
         			<td>A0003</td>
         			<td>市场营销部</td>
         			<td>103室</td>
         			<td>张三丰</td>
         			<td>
         				<img alt="" src="../../img/delete.png" class="operateImg">
         				<a href="deptEdit.jsp" target="contentPage"><img alt="" src="../../img/edit.png" class="operateImg"></a>
         				<a href="deptDetail.jsp" target="contentPage"><img alt="" src="../../img/detail.png" class="operateImg"></a>
         			</td>         			
         		</tr>  
          		<tr>
         			<td>A0004</td>
         			<td>教质部</td>
         			<td>104室</td>
         			<td>李莫愁</td>
         			<td>
         				<img alt="" src="../../img/delete.png" class="operateImg">
         				<a href="deptEdit.jsp" target="contentPage"><img alt="" src="../../img/edit.png" class="operateImg"></a>
         				<a href="deptDetail.jsp" target="contentPage"><img alt="" src="../../img/detail.png" class="operateImg"></a>
         			</td>         			
         		</tr> 
          		<tr>
         			<td>A0005</td>
         			<td>教学部</td>
         			<td>105室</td>
         			<td>白字画</td>
         			<td>
         				<img alt="" src="../../img/delete.png" class="operateImg">
         				<a href="deptEdit.jsp" target="contentPage"><img alt="" src="../../img/edit.png" class="operateImg"></a>
         				<a href="deptDetail.jsp" target="contentPage"><img alt="" src="../../img/detail.png" class="operateImg"></a>
         			</td>         			
         		</tr> 
          		<tr>
         			<td>A0006</td>
         			<td>就业部</td>
         			<td>106室</td>
         			<td>花千骨</td>
         			<td>
         				<img alt="" src="../../img/delete.png" class="operateImg">
         				<a href="deptEdit.jsp" target="contentPage"><img alt="" src="../../img/edit.png" class="operateImg"></a>
         				<a href="deptDetail.jsp" target="contentPage"><img alt="" src="../../img/detail.png" class="operateImg"></a>
         			</td>         			
         		</tr>           		     		         	
         	</table>
  </body>
</html>
