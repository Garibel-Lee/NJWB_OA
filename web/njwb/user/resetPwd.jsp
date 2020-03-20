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

    <title>密码重置</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <script type="text/javascript" src="/js/jquery-1.8.3.js"></script>
    <style type="text/css">
        body, div, table, tr, td {
            margin: 0px;
            padding: 0px;
        }

        #passwordResetTable {
            font-size: 15px;
            border-collapse: collapse;
            width: 350px;
            margin: 20px auto;
        }

        #passwordResetTable td {
            height: 40px;
        }
    </style>
    <script type="text/javascript">

        function checkBeforeSubmit() {
            var oldPassword = $("#oldPassword").val();
            if (oldPassword == "") {
                alert("原密码不能为空");
                return false;
            }
            var newPassword = $("#newPassword").val();
            if (newPassword == "") {
                alert("新密码不能为空");
                return false;
            }
            var surePassword = $("#surePassword").val();
            if (surePassword == "") {
                alert("确认密码不能为空");
                return false;
            }
            if (surePassword != newPassword) {
                alert("新密码与确认密码不一致！");
                return false;
            }
            return true;
        }
    </script>
</head>

<body>
<div id="container">
    <form action="/resetPwd.do" method="post" onsubmit="return checkBeforeSubmit()" >
        <table id="passwordResetTable">
            <tr>
                <td>
                    原密码:
                </td>
                <td>
                    <input type="text" name="oldPassword" id="oldPassword"/>
                </td>

            </tr>
            <tr>
                <td>
                    新密码:
                </td>
                <td>
                    <input type="text" name="newPassword" id="newPassword"/>
                </td>

            </tr>

            <tr>
                <td>
                    确认密码:
                </td>
                <td>
                    <input type="text" name="surePassword" id="surePassword"/>
                </td>

            </tr>
            <tr>
                <td colspan="2">
                    <input type="submit" value="修改" />
                </td>
            </tr>
        </table>
    </form>
</div>
<c:if test="${isError}">
    <script type="text/javascript">
        alert("${errorMessage}");
    </script>
</c:if>
</body>
</html>
