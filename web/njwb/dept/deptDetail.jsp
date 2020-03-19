<%@ page language="java" import="com.lcqjoyce.My_JDBC.Init.BeanFactory" pageEncoding="UTF-8" %>
<%@ page import="com.lcqjoyce.entity.Dept" %>
<%@ page import="com.lcqjoyce.service.DeptService" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
	DeptService service=(DeptService) BeanFactory.getObject("deptService");
	String deptNo = request.getParameter("deptNo");
    Dept dept=service.getByDeptNo(deptNo);
    request.setAttribute("dept", dept);

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="/">

    <title>部门明细</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
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

        table, tr, td, th {
            border: solid 2px pink;
        }

        #deptEditTable {
            font-size: 15px;
            border-collapse: collapse;
            width: 350px;
            margin: 20px auto;
        }

        #deptEditTable td {
            height: 40px;
            margin-left: 20px;
        }

    </style>
    <script type="text/javascript" src="/js/jquery-1.8.3.js"></script>

</head>

<body>

<table id="resultTable">
    <tr>
        <th>部门编号</th>
        <th>部门名称</th>
        <th>部门位置</th>
        <th>部门负责人</th>
        <th>部门创建时间</th>
        <th>部门介绍</th>
    </tr>

    <tr>
        <td>${dept.deptNo}</td>
        <td>${dept.deptName}</td>
        <td>${dept.deptLoc}</td>
        <td>${dept.deptManager}</td>
        <td>${dept.createTime}</td>
        <td>${dept.deptIntro}</td>
    </tr>

</table>
<div id="back">
    <a href="/njwb/dept/dept.jsp" target="contentPage"><input type="button" value="返回"></a>
</div>
<input type="hidden" value="${deptNo}" id="hiddenInput">
</body>

</html>
