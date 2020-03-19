<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="/">

    <title>角色管理</title>

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

        table {
            width: 600px;
            margin-top: 20px;
        }

        td {
            width: 40px;
        }

        a {
            text-decoration: none;
        }

        #container {
            width: 600px;
            margin: 30px auto;
        }

    </style>
    <script type="text/javascript">

        function del(roleId) {
            //二次确认是否删除
            var result = window.confirm("确认要删除吗?");
            if (true == result) {
                $.ajax({
                    type: "POST",
                    url: "/role/deleteRoleById.do",
                    //通过角色ID删除该用户
                    data: {"roleId": roleId},
                    success: function (msg) {
                        if (msg != "") {
                            alert(msg);
                        } else {
                            alert("删除成功");

                        }
                    }
                });
            }
        }

    </script>
</head>

<body>
<h1 class="title">首页 &gt;&gt;角色管理 </h1>

<div class="add">
    <a href="/njwb/role/addRole.jsp" target="contentPage"><img src="/img/add.png" width="18px" height="18px">添加角色</a>
</div>
<div id="container">
    <table class="roleInfo">
        <tr class="titleRow">
            <td>角色ID</td>
            <td>角色名称</td>
            <td>操作列表</td>
        </tr>

        <tbody>
        <c:forEach var="roles" items="${rolesResult.listData}">
            <tr>
                <td>
                        ${roles.id}
                </td>
                <td>
                        ${roles.roleName}
                </td>
                <td>
                    <img id=${roles.id} alt="删除" src="/img/delete.png" class="operateImg" onclick="del(id)">
                    <a href="/njwb/role/perEdit.jsp?roleId=${roles.id}&roleName=${roles.roleName}" target="contentPage"><img alt=""
                                                                                                 src="/img/edit.png"
                                                                                                 class="operateImg"></a>
                </td>
            </tr>
        </c:forEach>
        </tbody>


    </table>
</div>
</body>
<c:if test="${isError}">
    <script type="text/javascript">
        alert("${errorMessage}");
    </script>
</c:if>
</html>
