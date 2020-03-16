<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    String deptNo = request.getParameter("deptNo");
    request.setAttribute("deptNo", deptNo);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">

    <title>部门编辑</title>

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

        #deptEditTable {
            font-size: 15px;
            border-collapse: collapse;
            width: 350px;
            margin: 20px auto;
        }

        #deptEditTable td {
            height: 40px;
        }

        a {
            text-decoration: none;
        }

        #deptNo {
            -moz-user-select: none;
        }
    </style>
    <script type="text/javascript">
        function checkBeforeSubmit() {
            var deptName = $("#deptName").val();

            if (deptName == "") {
                alert("部门名称不能为空");
                return false;
            }
            var deptLocation = $("#deptLoc").val();
            if (deptLocation == "") {
                alert("部门位置不能为空");
                return false;
            }
            var deptManager = $("#deptMaster").val();
            if (deptManager == "") {
                alert("部门负责人不能为空");
                return false;
            }
            return true;
        }
    </script>
</head>

<body>

<form action="dept/deptUpdate.do" method="post" onsubmit="return checkBeforeSubmit()">
    <table id="deptEditTable">
        <tr>
            <td>
                部门编号:
            </td>
            <td>
                <input type="text" name="deptNo" id="deptNo" value=${deptNo} readonly="readonly"/>
            </td>
        </tr>
        <tr>
            <td>
                部门名称:
            </td>
            <td>
                <input type="text" name="deptName" id="deptName"/>
            </td>
        </tr>

        <tr>
            <td>
                部门位置:
            </td>
            <td>
                <input type="text" name="deptLocation" id="deptLocation"/>
            </td>
        </tr>

        <tr>
            <td>
                部门负责人:
            </td>
            <td>
                <input type="text" name="deptManager" id="deptManager"/>
            </td>
        </tr>

        <tr>
            <td colspan="2">
                <input type="submit" value="修改"/>
                <input type="button" value="重置" onclick="refresh()"/>
                <a href="/njwb/dept/dept.jsp" target="contentPage"><input type="button" value="返回"></a>
            </td>
        </tr>
    </table>
</form>
<input type="hidden" value="${deptNo}" id="hiddenInput">
<c:if test='${isError}'>
    <script type="text/javascript">
        alert("${errorMessage}");
    </script>
</c:if>
</body>

</html>
