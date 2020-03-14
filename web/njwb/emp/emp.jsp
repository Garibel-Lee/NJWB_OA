<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>员工管理</title>
    
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
		//当前页
		var currentPage;
		//上一次查询的员工姓名
		var oldEmpName = "";
		//上一次查询的员工部门
		var oldEmpDept = "";
		function search(pageNo){
			//得到输入框的数据
  			var empName = $("#empName").val();
  			var empDept = $("#empDept").val();
  			//分页查询 搜索框有搜索结果时点下一页，返回第一页
  			if(oldEmpName != empName||oldEmpDept != empDept ){
  				pageNo = 1;
  			}
  			oldEmpName = empName;
  			oldEmpDept = empDept;
  			$.ajax({
  				type:"POST",
  				url:"<%=basePath%>emp/getEmpByPage.do",
  				//把前台数据传给后台
  				data:{"pageNo":pageNo,
  					  "empName": empName,
  					  "empDept": empDept,
  					  },
  				success:function(msg){
  					//分页定义
  					//把String页数转换成object
  					var pager = $.parseJSON(msg);
  					currentPage = pager;
  					//每页的列表
  					var datas = pager.list;
  					//表格
  					var resultTable = $(".deptInfo");
  					//显示标题栏
  					resultTable.html($("table tr")[0]);
  					//员工表进行遍历
  					for(var i = 0; i < datas.length;i++){
  						var tr = $("<tr></tr>");
  						//对每个属性进行定义
						var empNo = datas[i].empNo;
						var sex = datas[i].sex;
						var education = datas[i].education;
						var phone = datas[i].phone;
  						//定义时间格式
  						var entryDate = datas[i].entryTime;
  						var entryTimeF = (entryDate.year+1900)+"-"+(entryDate.month+1)+"-"+(entryDate.date);
  						//单元格
  						var empNoTd = $("<td>"+empNo+"</td>");
  						var empNameTd = $("<td>"+datas[i].empName+"</td>");
	  					var empDeptTd = $("<td>"+datas[i].deptName+"</td>"); 
  						var sexTd = $("<td>"+sex+"</td>"); 
  						var educationTd = $("<td>"+education+"</td>"); 
  						var phoneTd = $("<td>"+phone+"</td>"); 
  						var entryTimeTd = $("<td>"+entryTimeF+"</td>"); 
						var operationTd = $("<td></td>");
						//console.log(entryTimeF);
						//删除图标
						var deleteImg = $('<img id="'+datas[i].empNo+'"src="img/delete.png" class="operateImg" onclick="del(id)">');
						//修改图标
						var editImg = $('<img src="img/edit.png" class="operateImg" >');
						var empEditA = $('<a href="emp/empEdit.jsp?empNo='+ datas[i].empNo+'" target="contentPage"></a>');
						//查看详情图标
						var detailImg = $('<img src="img/detail.png" class="operateImg">');
						var detailA = $('<a href="emp/empDetail.jsp?empNo='+ datas[i].empNo+'" target="contentPage"></a>');
						//图标的拼接
						empEditA.append(editImg);
						detailA.append(detailImg);
						operationTd.append(deleteImg);
						operationTd.append(empEditA);
						operationTd.append(detailA);
						//数据表格拼接
  						tr.append(empNoTd).append(empNameTd).append(empDeptTd).append(sexTd).append(educationTd).append(phoneTd).append(entryTimeTd).append(operationTd);
  						resultTable.append(tr);
  					}
  					
  					//每页数据显示
  					for(;i<4;i++){
  						var tr = $("<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>");
  						resultTable.append(tr);
  					}
  					//按钮
  					var startPage = $("#startPage");
  					var lastPage = $("#lastPage");
  					lastPage.attr("onclick","search("+(pager.pageNo - 1)+")");
  					var nextPage = $("#nextPage");
  					nextPage.attr("onclick","search("+(pager.pageNo + 1)+")");
  					var endPage = $("#endPage");
  					endPage.attr("onclick","search("+pager.totalPage+")");
  					//当首页时 首页上一页 不可点 
  					//当末页时 末页下一页 不可点 
  					var state = false;  					
  					if(pager.pageNo == 1){
  						state = true;
  					}
  					startPage.prop("disabled",state);
  					lastPage.prop("disabled",state);
  					state = false;
  					if(pager.pageNo == pager.totalPage || pager.totalPage == 0){
  						state = true;
  					}
  					nextPage.prop("disabled",state);
  					endPage.prop("disabled",state);
  					
  				}
  			});
  		}
		
		//删除按键
		function del(empNo){
			var result = window.confirm("确认要删除吗?");
			console.log(empNo);
			if(true == result){
				$.ajax({
					type:"POST",
  					url:"<%=basePath%>emp/deleteEmpByEmpNo.do",
  					data:{"empNo":empNo},
  					success:function(msg){
  						if(msg != ""){
  							alert(msg);
  						}else{
							alert("删除成功");
	  						search(1);
  						}
  					}
				});
			}
		}
		function getAllDeptName(){
			$.ajax({
					type:"POST",
  					url:"<%=basePath%>dept/getAllDept.do",
  					success:function(msg){
  						var depts = $.parseJSON(msg);
  						var empDept = $("#empDept");
  						for(var i = 0; i < depts.length;i++){
  							var option = $("<option>"+depts[i].deptName+"</option>");
  							empDept.append(option);
  						}
  					}
				});
		}
		$(document).ready(function(){
  			search(1);
  			getAllDeptName();
  		});
	</script>

  </head>
  
  <body>
		<h1 class="title">首页  &gt;&gt;员工管理 </h1>
         	
         	<div class="add">
         		<a href="empAdd.jsp" target="contentPage"><img src="img/add.png" width="18px" height="18px">添加员工</a>
         	</div>
         	<div style="margin-top: 50px;width: 750px;margin-left: 50px;">
	         	姓名：<input type="text" id="empName" style="width: 100px">
	         	部门：
	         	<select id="empDept" style="width: 100px">
	         		<option >请选择</option>
	         	</select>
	         	<input type="button" value="查询" onclick="search(1)" style="width: 50px;">
         	</div>
         	<table class="deptInfo">
         		<tr class="titleRow">
         			<td>员工编号</td>
         			<td>员工姓名</td>
         			<td>所属部门</td>
         			<td>性别</td>
         			<td>学历</td>
         			<td>手机</td>
         			<td>入职时间</td>
         			<td>操作列表</td>
         		</tr>         	
         	</table>
         	<div style="width: 500px; margin-left: 150px;margin-top: 10px;">
         		<input id="startPage" type="button" value="首页" onclick="search(1)" style="width: 60px">
		  		<input id="lastPage" type="button" value="上一页" style="width: 60px">
		  		<input id="nextPage" type="button" value="下一页" style="width: 60px">
		  		<input id="endPage" type="button" value="末页" style="width: 60px">
         	</div>
  </body>
</html>
