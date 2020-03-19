<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="/">

    <title>账户管理</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <link rel="stylesheet" type="text/css" href="/css/reset.css">
    <link rel="stylesheet" type="text/css" href="/css/main.css">
    <link rel="stylesheet" type="text/css" href="/css/table.css">
    <style type="text/css">
        td {
            -moz-user-select: none;
        }

        table {
            width: 780px;
            margin-left: 10px;
            margin-top: 20px;
        }

        td {
            width: 60px;
            margin-left: 10px;
        }

        a {
            text-decoration: none;
        }
    </style>
    <script type="text/javascript" src="/js/jquery-1.8.3.js"></script>
    <script type="text/javascript">

        function getAllRoleName() {
            $.ajax({
                type: "POST",
                url: "/permissions/getAllRoleName.do",
                success: function (msg) {
                    var roles = $.parseJSON(msg);
                    var roleName = $("#roleId");
                    for (var i = 0; i < roles.length; i++) {
                        var option = $("<option value=" + roles[i].id + ">" + roles[i].roleName + "</option>");
                        roleName.append(option);
                    }
                }
            });
        }

        function del(userId) {
            var result = window.confirm("确认要删除吗?");
            if (true == result) {
                $.ajax({
                    type: "POST",
                    url: "/user/deleteUserById.do",
                    data: {"userId": userId},
                    success: function (msg) {
                        if (msg != "") {
                            alert(msg);
                        } else {
                            alert("删除成功");
                            search();
                        }
                    }
                });
            }
        }

        $(document).ready(function () {
            getAllRoleName();
            search();
        });
    </script>
</head>

<body>
<h1 class="title">首页 &gt;&gt;账户管理 </h1>

<div class="add">
    <a href="/njwb/user/addUser.jsp" target="contentPage"><img src="/img/add.png" width="18px" height="18px">添加账户</a>
</div>
<div style="margin-top: 50px;width: 750px;margin-left: 50px;">
    <form action="/queryUsers.do" method="post">
        帐号：<input type="text" id="userAccount" name="userAccount" style="width: 100px;margin-right: 20px;">
        帐号状态：<select id="residueTimes" name="residueTimes" style="width: 100px;margin-right: 20px;">
        <option value="">请选择</option>
        <option value="1">正常</option>
        <option value="0">已锁定</option>
    </select>

        角色：<select id="roleId" name="roleId" style="width: 100px;margin-left: 20px;">
        <option value="">请选择</option>
    </select>
        <input type="submit" value="查询" style="width: 50px;margin-left: 20px;">
    </form>
</div>
<table class="userInfo">
    <tr class="titleRow">
        <td>帐号</td>
        <td>员工姓名</td>
        <td>状态</td>
        <td>角色</td>
        <td>操作列表</td>
    </tr>
    <tbody>
    <c:forEach var="users" items="${usersResult.listData}">
        <tr>
            <td>
                    ${users.userAccount}
            </td>
            <td>
                    ${users.empNo}
            </td>

            <td>
                    ${users.residueTimes==0?'已锁定':'正常'}
            </td>

            <td>
                    ${users.roleId}
            </td>
            <td>
             <%--   <img id=${users.id} alt="删除" src="/img/delete.png" class="operateImg" onclick="del(id)">
                <a href="/njwb/permissions/perEdit.jsp?users=${users.id}" target="contentPage"><img alt=""
                                                                                                                  src="/img/edit.png"
                                                                                                                  class="operateImg"></a>--%>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<div style="width: 500px; margin-left: 260px;margin-top: 10px;">
    <a href="/queryUsers.do?userAccount=${userAccount}&roleId=${roleId}&residueTimes=${residueTimes}&currentPage=1" target="contentPage">首页</a> &nbsp;
    <c:if test="${usersResult.currentPage==1}" var="pre">
        <a href="/queryUsers.do?userAccount=${userAccount}&roleId=${roleId}&residueTimes=${residueTimes}&currentPage=1">上一页</a> &nbsp;
    </c:if>
    <c:if test="${ ! pre }">
        <a href="/queryUsers.do?userAccount=${userAccount}&roleId=${roleId}&residueTimes=${residueTimes}&currentPage=${usersResult.currentPage-1}"
           target="contentPage">上一页</a> &nbsp;
    </c:if>
    <c:forEach begin="${permissionsIndex.beginIndex}" end="${permissionsIndex.endIndex}" var="index">
        <c:choose>
            <c:when test="${usersResult.currentPage} == ${index}">
                <a id="middleIndex" href="/queryUsers.do?userAccount=${userAccount}&roleId=${roleId}&residueTimes=${residueTimes}&currentPage=${index}"
                   target="contentPage">${index}</a>
            </c:when>
            <c:otherwise>
                <a href="/queryUsers.do?userAccount=${userAccount}&roleId=${roleId}&residueTimes=${residueTimes}&currentPage=${index}"
                   target="contentPage">${index}</a>&nbsp;
            </c:otherwise>
        </c:choose>
    </c:forEach>
    <c:if test="${usersResult.currentPage==usersResult.totalPage}" var="next">
        <a href="/queryUsers.do?userAccount=${userAccount}&roleId=${roleId}&residueTimes=${residueTimes}&currentPage=${usersResult.totalPage}"
           target="contentPage">下一页</a>&nbsp;
    </c:if>
    <c:if test="${ ! next }">
        <a href="/queryUsers.do?userAccount=${userAccount}&roleId=${roleId}&residueTimes=${residueTimes}&currentPage=${usersResult.currentPage+1}"
           target="contentPage">下一页</a>&nbsp;
    </c:if>
    <a href="/queryUsers.do?userAccount=${userAccount}&roleId=${roleId}&residueTimes=${residueTimes}&currentPage=${usersResult.totalPage}"
       target="contentPage">末       页</a><br/>
    &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;一共${usersResult.totalPage}页,一共${usersResult.totalCount}条
</div>
</body>
</html>
