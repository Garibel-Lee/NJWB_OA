<%@ page language="java" import="com.lcqjoyce.My_JDBC.Init.BeanFactory" pageEncoding="UTF-8" %>
<%@ page import="com.lcqjoyce.entity.Holiday" %>
<%@ page import="com.lcqjoyce.service.HolidayService" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";

    String holidayNo = (String) request.getParameter("holidayNo");
    HolidayService service = (HolidayService) BeanFactory.getObject("holidayService");
    Holiday holiday = service.getHolidayByNo(holidayNo);
    System.out.println(holiday.toString());
    request.setAttribute("holiday", holiday);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="/">

    <title>请假详情</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <script type="text/javascript" src="/js/jquery-1.8.3.js"></script>
    <style type="text/css">
        ul {
            width: 200px;
            margin: 50px auto;
        }

        li {
            margin-top: 20px;
        }

        #back {
            width: 100px;
            margin: 50px auto;
        }

        #header {
            width: 200px;
            margin: 0 auto;
        }

        a {
            text-decoration: none;
        }
    </style>
    <script type="text/javascript">

    </script>
</head>

<body>

<div id="header">
    <h1>请假详情</h1>
</div>
<ul id="result">
    <li>
        请假编号：<span id="holidayNo">${holiday.holidayNo}</span>
    </li>
    <li>
        申请人：<span id="applyName">${holiday.holidayUser}</span>
    </li>
    <li>
        请假类型：<span id="holidayType">${holiday.holidayType}</span>
    </li>
    <li>
        请假事由：<span id="holidayCause">${holiday.holidayBz}</span>
    </li>
    <li>
        开始时间：<span id="startTime">${holiday.startTime}</span>
    </li>
    <li>
        结束时间：<span id="endTime">${holiday.endTime}</span>
    </li>
    <li>
        申请状态：<span id="holidayStatus">${holiday.holidayStatus eq 1 ? '已提交' :'草稿'}</span>
    </li>
</ul>
<div id="back">
    <a href="holiday/queryHoliday.do" target="contentPage"><input type="button" value="返回"></a>
</div>
<input type="hidden" value="${holidayNo}" id="hiddenInput">
</body>
</html>
