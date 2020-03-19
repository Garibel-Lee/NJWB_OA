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

    <title>添加权限</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <script type="text/javascript" src="/js/jquery-1.8.3.js"></script>
    <style type="text/css">
        a {
            text-decoration: none;
        }

        body, div, table, tr, td {
            margin: 0px;
            padding: 0px;
        }

        #perAddTable {
            font-size: 15px;
            border-collapse: collapse;
            width: 350px;
            margin: 20px auto;
        }

        #perAddTable td {
            height: 40px;
        }

        a {
            text-decoration: none;
        }
    </style>

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

        function getAllMenuName() {
            $.ajax({
                type: "POST",
                url: "/permissions/getAllMenu.do",
                success: function (msg) {
                    var menus = $.parseJSON(msg);
                    var menuName = $("#menuId");
                    for (var i = 0; i < menus.length; i++) {
                        if (menus[i].id > 3) {
                            var option = $("<option value=" + menus[i].id + ">" + menus[i].menuName + "</option>");
                            menuName.append(option);
                        }
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

    <script type="text/javascript">
        function checkBeforeSubmit() {
            var menuName = $("#menuName").val();
            if (menuName == "请选择") {
                alert("请选择菜单名称");
                return false;
            }
            var roleName = $("#roleName").val();
            if (roleName == "请选择") {
                alert("请选择角色名称");
                return false;
            }
            return true;
        }
    </script>
</head>

<body>
<form action="/permissions/addPermissions.do" method="post" onsubmit="return checkBeforeSubmit()">
    <table id="perAddTable">
        <tr>
            <td>
                角色：
            </td>
            <td>
                <select name="roleId" id="roleId" style="width: 100px ;">
                    <option>请选择</option>
                </select>
            </td>
        </tr>
        <tr>
            <td>
                菜单：
            </td>
            <td>
                <select name="menuId" id="menuId" style="width: 100px">
                    <option>请选择</option>
                </select>
            </td>
        </tr>

        <tr>
            <td colspan="2">
                <input type="submit" value="保存"/>
                <input type="reset" value="重置"/>
                <a href="/njwb/permissions/queryPermissions.do" target="contentPage"><input type="button" value="返回"></a>
            </td>
        </tr>
    </table>
</form>
<c:if test="${isError}">
    <script type="text/javascript">
        alert("${errorMessage}");
    </script>
</c:if>
</body>
</html>
