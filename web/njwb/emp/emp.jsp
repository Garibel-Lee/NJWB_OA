<%@ page language="java" import="com.lcqjoyce.My_JDBC.Init.BeanFactory" pageEncoding="UTF-8" %>
<%@ page import="com.lcqjoyce.entity.Employee" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.lcqjoyce.service.EmployeeService" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    String currPage = request.getParameter("currentPage");
/*    String empName=request.getParameter("empName");
    String empDo=request.getParameter("empNo");*/

    EmployeeService service = (EmployeeService) BeanFactory.getObject("employeeService");
    /*    List<Employee> employees = service.getQueryEmployees("李","");*/
    List<Employee> employees = service.getAllEmployees();
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
    <style type="text/css">
        td {
            -webkit-user-select: none;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            $.ajax({
                type: "POST",
                async:true,
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
        function del(empNo) {
            var result = window.confirm("确认要删除吗?");
            if (true == result) {
                window.location.href = "emp/empDelete.do?empNo=" + empNo;
            }
        }
    </script>
</head>

<body>
<h1 class="title">首页 &gt;&gt;员工管理 </h1>

<div class="add">
    <a href="/njwb/emp/empAdd.jsp" target="contentPage"><img src="/img/add.png" width="18px" height="18px">添加员工</a>
</div>
<div style="margin-top: 50px;width: 750px;margin-left: 50px;">

    姓名：<input type="text" id="empName"  name="empName" style="width: 100px;height: 20px">
    部门：
    <select id="empDept" name="empDept" style="width: 100px;height: 20px">
        <option>请选择</option>
    </select>
    <input type="submit" value="查询" style="width: 50px;">

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
    <c:forEach var="employee" items="${some}">
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
    <a href="/njwb/emp/emp.jsp?currentPage=1" target="contentPage">首页</a> &nbsp;
    <c:if test="${currentPage==1}" var="pre">
        <a href="/njwb/emp/emp.jsp?currentPage=1">上一页</a> &nbsp;
    </c:if>
    <c:if test="${ ! pre }">
        <a href="/njwb/emp/emp.jsp?currentPage=${currentPage-1}" target="contentPage">上一页</a> &nbsp;
    </c:if>
    <c:if test="${currentPage==totalCount}" var="next">
        <a href="/njwb/emp/emp.jsp?currentPage=${totalCount}" target="contentPage">下一页</a>&nbsp;
    </c:if>
    <c:if test="${ ! next }">
        <a href="/njwb/emp/emp.jsp?currentPage=${currentPage+1}" target="contentPage">下一页</a>&nbsp;
    </c:if>
    <a href="/njwb/emp/emp.jsp?currentPage=${totalCount }" target="contentPage">末 页</a><br/>
    &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;一共${totalCount}页,一共${total}条
</div>
</body>
</html>
