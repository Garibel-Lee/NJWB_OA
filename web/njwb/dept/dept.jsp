<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="com.lcqjoyce.My_JDBC.Init.BeanFactory" pageEncoding="UTF-8" %>
<%@ page import="com.lcqjoyce.service.DeptService" %>
<%@ page import="java.util.List" %>
<%@ page import="com.lcqjoyce.entity.Dept" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    DeptService service = (DeptService) BeanFactory.getObject("deptService");
    List<Dept> depts = service.getAllDepts();
    List<Dept> fenyeDepts = null;
    //集合获得了，如何让EL表达式可以访问
    pageContext.setAttribute("list", depts);
    String currPage = request.getParameter("currentPage");
    int size = 3;
    //9条数据，显示为三页,+1是处理不满一页的情况
    int totalCount = depts.size() % size == 0 ? depts.size() / size : depts.size() / size + 1;
    if (null != currPage) {
        fenyeDepts = service.getDeptsPerPage(Integer.parseInt(currPage), size);
        pageContext.setAttribute("currentPage", Integer.parseInt(currPage));
    } else {
        fenyeDepts = service.getDeptsPerPage(1, size);
        pageContext.setAttribute("currentPage", "1");//如果是null代表当前页是第一页
    }
    pageContext.setAttribute("some", fenyeDepts);
    pageContext.setAttribute("totalCount", totalCount);
    pageContext.setAttribute("total", depts.size());

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="/">

    <title>部门管理</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <link rel="stylesheet" type="text/css" href="/css/reset.css">
    <link rel="stylesheet" type="text/css" href="/css/main.css">
    <script type="text/javascript" src="/js/jquery-1.8.3.js"></script>

    <style type="text/css">
        td {
            -moz-user-select: none;
        }
    </style>

    <script type="text/javascript">

        function del(deptNo) {
            var result = window.confirm("确认要删除吗?");
            if(true == result){
                window.location.href="dept/deptDelete.do?deptNo="+deptNo;
            }
        }

    </script>
</head>

<body>
<h1 class="title">首页 &gt;&gt;部门管理 </h1>

<div class="add">
    <a href="/njwb/dept/deptAdd.jsp" target="contentPage"><img src="/img/add.png" width="18px"
                                                                            height="18px">添加部门</a>
</div>
<%--
<div style="margin-top: 50px;width: 750px;margin-left: 50px;">
    部门名称：<input type="text" id="deptName" style="width: 100px">
    部门位置：<input type="text" id="deptLocation" style="width: 100px">
    部门负责人：<input type="text" id="deptManager" style="width: 100px">
    <input type="button" value="搜索" onclick="search(1)" style="width: 50px;">
</div>
--%>

<table class="deptInfo">
    <tr class="titleRow">
        <th>部门编号</th>
        <th>部门名称</th>
        <th>部门位置</th>
        <th>部门负责人</th>
        <th>操作列表</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="dept" items="${some}">
        <tr>
            <td>${dept.deptNo}</td>
            <td>${dept.deptName}</td>
            <td>${dept.deptLoc}</td>
            <td>${dept.deptManager}</td>
            <td>
                <img id=${dept.deptNo} alt="删除" src="../../img/delete.png" class="operateImg"  onclick="del(id)">
                <a href="/njwb/dept/deptEdit.jsp?deptNo=${dept.deptNo}" target="contentPage"><img alt=""
                                                                                                  src="../../img/edit.png"
                                                                                                  class="operateImg"></a>
                <a href="/njwb/dept/deptDetail.jsp?deptNo=${dept.deptNo}" target="contentPage"><img alt=""
                                                                                                    src="../../img/detail.png"
                                                                                                    class="operateImg"></a>

            </td>
        </tr>
    </c:forEach>
    </tbody>
    <tfoot></tfoot>
</table>


<div style="width: 500px; margin-left: 270px;margin-top: 10px;">
    <a href="/njwb/dept/dept.jsp?currentPage=1" target="contentPage">首页</a> &nbsp;
    <c:if test="${currentPage==1}" var="pre">
        <a href="/njwb/dept/dept.jsp?currentPage=1">上一页</a> &nbsp;
    </c:if>
    <c:if test="${ ! pre }">
        <a href="/njwb/dept/dept.jsp?currentPage=${currentPage-1}" target="contentPage">上一页</a> &nbsp;
    </c:if>
    <c:if test="${currentPage==totalCount}" var="next">
        <a href="/njwb/dept/dept.jsp?currentPage=${totalCount}" target="contentPage">下一页</a>&nbsp;
    </c:if>
    <c:if test="${ ! next }">
        <a href="/njwb/dept/dept.jsp?currentPage=${currentPage+1}" target="contentPage">下一页</a>&nbsp;
    </c:if>
    <a href="/njwb/dept/dept.jsp?currentPage=${totalCount }" target="contentPage">末 页</a><br/>
    &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;一共${totalCount}页,一共${total}条
</div>
</body>
</html>
