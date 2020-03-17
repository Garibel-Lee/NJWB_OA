<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="/">

    <title>请假管理</title>

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
            width: 780px;
            margin-left: 10px;
            margin-top: 20px;

        }

        td {
            width: 60px;
            margin-left: 10px;
        }
    </style>
    <script type="text/javascript">
        function del(holidayNo) {
            var result = window.confirm("确认要删除吗?");
            if (true == result) {
                window.location.href = "holiday/deleteHoliday.do?holidayNo=" + holidayNo;
            }
        }

    </script>
</head>

<body>
<h1 class="title">首页 &gt;&gt;请假管理 </h1>

<div class="add">
    <a href="/njwb/holiday/addHoliday.jsp" target="contentPage"><img src="/img/add.png" width="18px" height="18px">添加请假</a>
</div>

<form action="/holiday/queryHoliday.do" method="post">
    <div style="margin-top: 50px;width: 750px;margin-left: 50px; border: 1px; ">
        申请人：<input type="text" id="empName" name="empName" style="width: 100px;margin-right: 20px;">
        请假类型：<select id="holidayType" name="holidayType" style="width: 100px;margin-right: 20px;">
        <option value="">请选择</option>
        <option>事假</option>
        <option>婚假</option>
        <option>年假</option>
        <option>调休</option>
        <option>病假</option>
        <option>丧假</option>
        <option>产假</option>
    </select>

        申请状态：<select id="holidayStatus" name="holidayStatus" style="width: 100px;margin-left: 20px;">
        <option value="">请选择</option>
        <option value="0">草稿</option>
        <option value="1">已提交</option>
    </select>
        <input type="submit" value="搜索" style="width: 100px;margin-left: 20px;">
    </div>
</form>
<table class="holidayInfo">
    <thead>
    <tr class="titleRow">
        <td>请假编号</td>
        <td>申请人</td>
        <td>请假类型</td>
        <td>请假事由</td>
        <td>开始时间</td>
        <td>结束时间</td>
        <td>申请状态</td>
        <td>提交时间</td>
        <td>操作列表</td>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="holiday" items="${holidayResult.listData}">
        <tr>
            <td>${holiday.holidayNo}</td>
            <td>${holiday.holidayUser}</td>
            <td>${holiday.holidayType}</td>
            <td>${holiday.holidayBz}</td>
            <td>${holiday.startTime}</td>
            <td>${holiday.endTime}</td>
            <td>
                    ${holiday.holidayStatus eq 1 ? "已提交" :"草稿"} </td>
            <td>${holiday.createTime}</td>
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
    <tfoot></tfoot>
</table>

<div style="width: 500px; margin-left: 270px;margin-top: 10px;">
    <a href="/holiday/queryHoliday.do?empName=${empName}&holidayType=${holidayType}&holidayStatus=${holidayStatus}&currentPage=1"
       target="contentPage">首页</a> &nbsp;
    <c:if test="${holidayResult.currentPage==1}" var="pre">
        <a href="/holiday/queryHoliday.do?empName=${empName}&holidayType=${holidayType}&holidayStatus=${holidayStatus}&currentPage=1">上一页</a> &nbsp;
    </c:if>
    <c:if test="${ ! pre }">
        <a href="/holiday/queryHoliday.do?empName=${empName}&holidayType=${holidayType}&holidayStatus=${holidayStatus}&currentPage=${holidayResult.currentPage-1}"
           target="contentPage">上一页</a> &nbsp;
    </c:if>
    <c:forEach begin="${holidayIndex.beginIndex}" end="${holidayIndex.endIndex}" var="index">
        <c:choose>
            <c:when test="${holidayResult.currentPage} == ${index}">
                <a id="middleIndex"
                   href="/holiday/queryHoliday.do?empName=${empName}&holidayType=${holidayType}&holidayStatus=${holidayStatus}&currentPage=${index}"
                   target="contentPage">${index}</a>
            </c:when>
            <c:otherwise>
                <a href="/holiday/queryHoliday.do?empName=${empName}&holidayType=${holidayType}&holidayStatus=${holidayStatus}&currentPage=${index}"
                   target="contentPage">${index}</a>&nbsp;
            </c:otherwise>
        </c:choose>
    </c:forEach>
    <c:if test="${holidayResult.currentPage==holidayResult.totalPage}" var="next">
        <a href="holiday/queryHoliday.do?empName=${empName}&holidayType=${holidayType}&holidayStatus=${holidayStatus}&currentPage=${holidayResult.totalPage}"
           target="contentPage">下一页</a>&nbsp;
    </c:if>
    <c:if test="${ ! next }">
        <a href="holiday/queryHoliday.do?empName=${empName}&holidayType=${holidayType}&holidayStatus=${holidayStatus}&currentPage=${holidayResult.currentPage+1}"
           target="contentPage">下一页</a>&nbsp;
    </c:if>
    <a href="holiday/queryHoliday.do?empName=${empName}&holidayType=${holidayType}&holidayStatus=${holidayStatus}&currentPage=${holidayResult.totalPage}"
       target="contentPage">末
        页</a><br/>
    &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;一共${holidayResult.totalPage}页,一共${holidayResult.totalCount}条
</div>
</body>
</html>
