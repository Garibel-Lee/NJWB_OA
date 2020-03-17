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

    <title>权限管理</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <link rel="stylesheet" type="text/css" href="/css/reset.css">
    <link rel="stylesheet" type="text/css" href="/css/main.css">
    <script type="text/javascript" src="/js/jquery-1.8.3.js"></script>
    <script type="text/javascript">
        function getAllRoleName() {
            $.ajax({
                type: "POST",
                url: "/permissions/getAllRoleName.do",
                success: function (msg) {
                    var roles = $.parseJSON(msg);
                    var roleName = $("#roleName");
                    for (var i = 0; i < roles.length; i++) {
                        var option = $("<option value=" + roles[i].id + ">" + roles[i].roleName + "</option>");
                        roleName.append(option);
                    }
                }
            });
        }

        function getAllMenuName() {
            $.ajax({
                type: "POST",
                url: "/permissions/getAllMenu.do",
                success: function (msg) {
                    var menus = $.parseJSON(msg);
                    var menuName = $("#menuName");
                    for (var i = 0; i < menus.length; i++) {
                        var option = $("<option>" + menus[i].menuName + "</option>");
                        menuName.append(option);
                    }
                }
            });
        }

        function del(permissionId) {
            var result = window.confirm("确认要删除吗?");
            if (true == result) {
                $.ajax({
                    type: "POST",
                    url: "/permission/deletePermissionById.do",
                    data: {"permissionId": permissionId},
                    success: function (msg) {
                        alert("删除成功");
                        search(1);
                    }
                });
            }
        }

        $(document).ready(function () {
            getAllRoleName();
            getAllMenuName();

        });
    </script>
</head>

<body>
<h1 class="title">首页 &gt;&gt;权限管理 </h1>

<div class="add">
    <a href="/permissions/perAdd.jsp" target="contentPage"><img src="img/add.png" width="18px" height="18px">添加权限</a>
</div>
<div style="margin-top: 50px;width: 750px;margin-left: 100px;">
    &nbsp;&nbsp;&nbsp;&nbsp;角色：
    <select id="roleName" style="width: 100px;margin-left: 10px;">
        <option>请选择</option>
    </select>
    &nbsp;&nbsp;&nbsp;&nbsp;菜单：
    <select id="menuName" style="width: 100px;margin-left: 10px;">
        <option>请选择</option>
    </select>
    <input type="button" value="查询" onclick="search(1)" style="width: 50px;margin-left: 30px;">
</div>
<table class="deptInfo">
    <tr class="titleRow">
        <td>角色名称</td>
        <td>菜单名称</td>
        <td>操作列表</td>
    </tr>
    <tbody>
    <c:forEach var="permissions" items="${permissionsResult.listData}">
        <tr>
                <%--<td>${roleMap[permissions.roleId]}</td>
                <td>${menuMap[permissions.menuId]}</td>--%>
            <c:set var="temp" value="${permissions.roleId+''}"/>
            <td>
                    ${permissions.role.roleName}
            </td>
            <c:set var="val" value="${permissions.menuId+''}"/>
            <td>
                    ${menuMap[val]}
            </td>
            <td>
                <img id=${holiday.holidayNo} alt="删除" src="/img/delete.png" class="operateImg" onclick="del(id)">
                <a href="/njwb/holiday/edit.jsp?holidayNo=${holiday.holidayNo}" target="contentPage"><img alt=""
                                                                                                          src="/img/edit.png"
                                                                                                          class="operateImg"></a>
                <a href="/njwb/holiday/detail.jsp?holidayNo=${holiday.holidayNo}" target="contentPage"><img alt=""
                                                                                                            src="/img/detail.png"
                                                                                                            class="operateImg"></a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div style="width: 500px; margin-left: 150px;margin-top: 10px;">

</div>
</body>
</html>
