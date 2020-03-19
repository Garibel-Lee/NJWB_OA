<%@ page language="java" import="com.lcqjoyce.My_JDBC.Init.BeanFactory" pageEncoding="UTF-8" %>
<%@ page import="com.lcqjoyce.service.HolidayService" %>
<%@ page import="com.lcqjoyce.entity.Holiday" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
    <title>请假修改</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <script type="text/javascript" src="/js/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="/js/laydate/laydate.js"></script>
    <script type="text/javascript" src="/js/laydate/theme/default/laydate.css"></script>
    <style type="text/css">
        #container {
            width: 500px;;
            margin: 0 auto;
        }

        a {
            text-decoration: none;
        }
    </style>

    <script type="text/javascript">
        $(document).ready(function () {
            var start = {

                elem: '#startTime',
                format: 'YYYY/MM/DD',
                min: laydate.now(), //设定最小日期为当前日期
                max: '2099-06-16 23:59:59', //最大日期
                istime: true,
                istoday: false,
                choose: function (datas) {
                    if (datas >= laydate.now()) {
                        end.min = datas; //开始日选好后，重置结束日的最小日期
                        end.start = datas; //将结束日的初始值设定为开始日
                    } else {
                        end.min = laydate.now();
                        end.start = laydate.now();
                    }

                }
            };
            var end = {
                elem: '#endTime',
                format: 'YYYY/MM/DD',
                min: laydate.now(),
                max: '2099-06-16 23:59:59',
                istime: true,
                istoday: false,
                choose: function (datas) {
                    start.max = datas; //结束日选好后，重置开始日的最大日期
                }
            };

            laydate(start);
            laydate(end);
            $("#holidayType").find("option[value=${holiday.holidayType}]").attr("selected", true);
            $("#holidayStatus").find("option[value=${holiday.holidayStatus}]").attr("selected", true);
        });

        function checkBeforeSubmit() {
            var holidayType = $("#holidayType").val();
            if (holidayType == "请选择") {
                alert("请选择请假类型");
                return false;
            }
            var holidayCause = $("#holidayCause").val();
            if (holidayCause == "") {
                alert("请假事由不能为空");
                return false;
            }
            var startTime = $("#startTime").val();
            if (startTime == "") {
                alert("开始时间不能为空");
                return false;
            }
            var endTime = $("#endTime").val();
            if (endTime == "") {
                alert("结束时间不能为空");
                return false;
            }
            var gnl = confirm("确定要提交?提交之后无法修改哦");
            if (gnl == true) {
                return true;
            } else {
                return false;
            }
            return true;
        }


    </script>
</head>

<body>

<div id="container">
    <form action="/holiday/updateHoliday.do" method="post" onsubmit="return checkBeforeSubmit()">
        <table id="deptEditTable">
            <tr>
                <td>
                    请假编号:
                </td>
                <td>
                    <input type="text" name="holidayNo" value="${holiday.holidayNo}" id="holidayNo"
                           readonly="readonly"/>
                </td>
            </tr>
            <tr>
                <td>
                    请假类型:
                </td>
                <td>
                    <select id="holidayType" name="holidayType" style="width: 100px;margin-right: 20px;">
                        <option value="">请选择</option>
                        <option value="事假"> 事假</option>
                        <option value="婚假">婚假</option>
                        <option value="年假">年假</option>
                        <option value="调休">调休</option>
                        <option value="病假">病假</option>
                        <option value="丧假">丧假</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td>
                    请假事由:
                </td>
                <td>
                    <textarea rows="3" cols="25" name="holidayBz" id="holidayBz">${holiday.holidayBz}</textarea>
                </td>
            </tr>
            <tr>
                <td>
                    开始时间:
                </td>
                <td>
                    <input type="text" id="startTime" name="startTime" value="${holiday.startTime}"/>
                </td>
            </tr>
            <tr>
                <td>
                    结束时间:
                </td>
                <td>
                    <input type="text" id="endTime" name="endTime" value="${holiday.endTime}">
                </td>
            </tr>
            <tr>
                <td>
                    申请状态:
                </td>
                <td>
                    <select id="holidayStatus" value="${holiday.holidayStatus}" name="holidayStatus">
                        <option value="0">草稿</option>
                        <option value="1">已提交</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <input type="submit" value="提交" onclick="sumbit()" id="updateInput"/>
                    <a href="/njwb/holiday/edit.jsp?holidayNo=${holiday.holidayNo}" target="contentPage"><input type="button" value="重置" /></a>
                    <a href="holiday/queryHoliday.do" target="contentPage"><input type="button" value="返回"></a>
                </td>
            </tr>
        </table>
        <input type="hidden" id="holidayUser" name="holidayUser" value="${holiday.holidayUser}">
    </form>
</div>

<c:if test="${isError}">
    <script type="text/javascript">
        alert("${errorMessage}");
    </script>
</c:if>
</body>
</html>
