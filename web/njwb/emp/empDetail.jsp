<%@ page language="java" import="com.lcqjoyce.My_JDBC.Init.BeanFactory" pageEncoding="UTF-8" %>
<%@ page import="com.lcqjoyce.entity.Employee" %>
<%@ page import="com.lcqjoyce.service.EmployeeService" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    String empNo = (String) request.getParameter("empNo");
    EmployeeService service = (EmployeeService) BeanFactory.getObject("employeeService");
    Employee emp = service.getEmployeeByNo(empNo);
    request.setAttribute("emp", emp);

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="/">

    <title>员工明细</title>

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
        a {
            text-decoration: none;
        }

        #back {
            width: 100px;
            margin: 80px auto;
        }

        body, div, table, tr, td {
            margin: 0px;
            padding: 0px;
        }

        #deptEditTable {
            font-size: 15px;
            border-collapse: collapse;
            width: 350px;
            margin: 20px auto;
        }

        #deptEditTable, td {
            height: 40px;
            margin-left: 20px;
        }

        table, tr, td, th {
            border: solid 2px pink;
        }

        th {
            background-color: #FFEED0;
        }

        #header {
            width: 300px;
            margin: 0 auto;
        }
    </style>
    <script type="text/javascript">

    </script>

</head>

<body>
<div id="header">
    <h3>员工详情</h3>
</div>
<table id="resultTable">
    <tr>
        <th>员工编号</th>
        <th>员工姓名</th>
        <th>所属部门</th>
        <th>性别</th>
        <th>学历</th>
        <th>手机</th>
        <th>入职时间</th>
        <th>创建时间</th>
    </tr>
    <tr>
        <td>${emp.empNo}</td>
        <td>${emp.empName}</td>
        <td>${emp.dept.deptNo}</td>
        <td>${emp.sex}</td>
        <td>${emp.education}</td>
        <td>${emp.phone}</td>
        <td>${emp.entryTime}</td>
        <td>${emp.createTime}</td>
    </tr>
</table>
<div id="back">
    <a href="emp/queryEmp.do" target="contentPage"><input type="button" value="返回" /></a>
</div>
<input type="hidden" value="${empNo}" id="hiddenInput">
</body>
</html>
