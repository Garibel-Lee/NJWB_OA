<%@ page language="java" import="com.lcqjoyce.My_JDBC.Init.BeanFactory" pageEncoding="UTF-8" %>
<%@ page import="com.lcqjoyce.entity.Employee" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.lcqjoyce.service.EmployeeService" %>
<%
    /*
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";

    EmployeeService service = (EmployeeService) BeanFactory.getObject("employeeService");
    List<Employee> employees = service.getQueryEmployees(empName, empNo);
    List<Employee> employee = service.getAllEmployees();
    List<Employee> fenyeEmployees = null;
    //集合获得了，如何让EL表达式可以访问
    pageContext.setAttribute("list", employees);

    int size = 4;

    //9条数据，显示为三页,+1是处理不满一页的情况
    int totalCount = employees.size() % size == 0 ? employees.size() / size : employees.size() / size + 1;
    if (null != currPage) {
        fenyeEmployees = service.getEmployeesPerPage(Integer.parseInt(currPage), size);
        pageContext.setAttribute("currentPage", Integer.parseInt(currPage));
    } else {
        fenyeEmployees = service.getEmployeesPerPage(1, size);
        pageContext.setAttribute("currentPage", "1");//如果是null代表当前页是第一页
    }
    pageContext.setAttribute("some", fenyeEmployees);
    pageContext.setAttribute("totalCount", totalCount);
    pageContext.setAttribute("total", employees.size());
    pageContext.setAttribute("empNo", empNo);
    pageContext.setAttribute("empName", empName);*/
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="/">
    <title>员工管理</title>
    <link rel="stylesheet" type="text/css" href="/css/reset.css">
    <link rel="stylesheet" type="text/css" href="/css/main.css">
    <script type="text/javascript" src="/js/emp.js"></script>
    <script type="text/javascript" src="/js/jquery-1.8.3.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $.ajax({
                type: "POST",
                url: "dept/deptGetall.do",
                success: function (msg) {
                    var depts = $.parseJSON(msg);
                    var empDept = $("#empDept");
                    for (var i = 0; i < depts.length; i++) {
                        var option = $("<option value=" + depts[i].deptNo + ">" + depts[i].deptName + "</option>");
                        empDept.append(option);
                    }
                }
            });
        });
    </script>
</head>

<body>
<h1 class="title">首页 &gt;&gt;员工管理 </h1>

<div class="add">
    <a href="/njwb/emp/empAdd.jsp" target="contentPage"><img src="/img/add.png" width="18px" height="18px">添加员工</a>
</div>
<div style="margin-top: 50px;width: 750px;margin-left: 50px;">
    <form action="emp/queryEmp.do" method="post">
        姓名：<input type="text" id="empName" name="empName" style="width: 100px;height: 20px">
        部门：

        <select id="empDept" name="empDept" style="width: 100px;height: 20px">
            <option value="">请选择</option>
        </select>
        <input type="submit" value="查询" style="width: 50px;">
    </form>
</div>
<table class="deptInfo">
    <thead>
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
    </thead>
    <tbody>
    <c:forEach var="employee" items="${empResult.listData}">
        <tr>
            <td>${employee.empNo}</td>
            <td>${employee.empName}</td>
            <td>${employee.empDept}</td>
            <td>${employee.sex}</td>
            <td>${employee.education}</td>
            <td>${employee.phone}</td>
            <td>${employee.entryTime}</td>
            <td>
                <img id=${employee.empNo} alt="删除" src="/img/delete.png" class="operateImg" onclick="del(id)">
                <a href="/njwb/emp/empEdit.jsp?empNo=${employee.empNo}" target="contentPage"><img alt=""
                                                                                                  src="/img/edit.png"
                                                                                                  class="operateImg"></a>
                <a href="/njwb/emp/empDetail.jsp?empNo=${employee.empNo}" target="contentPage"><img alt=""
                                                                                                    src="/img/detail.png"
                                                                                                    class="operateImg"></a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
    <tfoot></tfoot>
</table>
<div style="width: 500px; margin-left: 270px;margin-top: 10px;">
    <a href="emp/queryEmp.do?currentPage=1" target="contentPage">首页</a> &nbsp;
    <c:if test="${empResult.currentPage==1}" var="pre">
        <a href="emp/queryEmp.do?currentPage=1">上一页</a> &nbsp;
    </c:if>
    <c:if test="${ ! pre }">
        <a href="emp/queryEmp.do?empName=${empName}&empDept=${empDept}&currentPage=${empResult.currentPage-1}"
           target="contentPage">上一页</a> &nbsp;
    </c:if>
    <c:forEach begin="${empIndex.beginIndex}" end="${empIndex.endIndex}" var="index">
        <c:choose>
            <c:when test="${empResult.currentPage} == ${index}">
                <a id="middleIndex" href="emp/queryEmp.do?empName=${empName}&empDept=${empDept}&currentPage=${index}"
                   target="contentPage">${index}</a>
            </c:when>
            <c:otherwise>
                <a href="emp/queryEmp.do?empName=${empName}&empDept=${empDept}&currentPage=${index}"
                   target="contentPage">${index}</a>&nbsp;
            </c:otherwise>
        </c:choose>
    </c:forEach>
    <c:if test="${empResult.currentPage==empResult.totalPage}" var="next">
        <a href="emp/queryEmp.do?empName=${empName}&empDept=${empDept}&currentPage=${empResult.totalPage}"
           target="contentPage">下一页</a>&nbsp;
    </c:if>
    <c:if test="${ ! next }">
        <a href="emp/queryEmp.do?empName=${empName}&empDept=${empDept}&currentPage=${empResult.currentPage+1}"
           target="contentPage">下一页</a>&nbsp;
    </c:if>
    <a href="emp/queryEmp.do?empName=${empName}&empDept=${empDept}&currentPage=${empResult.totalPage}"
       target="contentPage">末
        页</a><br/>
    &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;一共${empResult.totalPage}页,一共${empResult.totalCount}条
</div>
</body>
</html>
