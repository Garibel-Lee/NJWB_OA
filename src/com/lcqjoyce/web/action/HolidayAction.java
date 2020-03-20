package com.lcqjoyce.web.action;

import com.lcqjoyce.entity.Employee;
import com.lcqjoyce.entity.Holiday;
import com.lcqjoyce.entity.User;
import com.lcqjoyce.service.EmployeeService;
import com.lcqjoyce.service.HolidayService;
import com.lcqjoyce.util.page.PageIndex;
import com.lcqjoyce.util.page.PageResult;
import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;


public class HolidayAction {

    private static Logger logger = Logger.getLogger(HolidayAction.class);
    private HolidayService holidayService;
    private EmployeeService employeeService;

    public void setEmployeeService(EmployeeService employeeService) {
        this.employeeService = employeeService;
    }

    public void setHolidayService(HolidayService holidayService) {
        this.holidayService = holidayService;
    }


    //更新请假记录
    public String updateHoliday(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String resultString = "success";
        Holiday holiday = new Holiday();
        holiday.setHolidayNo((String) request.getParameter("holidayNo"));
        holiday.setHolidayUser((String) request.getParameter("holidayUser"));
        holiday.setHolidayType(((String) request.getParameter("holidayType")));
        holiday.setHolidayBz(((String) request.getParameter("holidayBz")));
        holiday.setStartTime(LocalDate.parse((String) request.getParameter("startTime")));
        holiday.setEndTime(LocalDate.parse((String) request.getParameter("endTime")));
        holiday.setHolidayStatus("1");
        logger.info(holiday.toString());
        if (holidayService.updateHoliday(holiday) == 1)
            return resultString;
        return "fail";
    }

    /**
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */
    public String queryHoliday(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String empName = request.getParameter("empName");
        String holidayType = request.getParameter("holidayType");
        String holidayStatus = request.getParameter("holidayStatus");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        Employee emp = employeeService.getEmployeeByNo(user.getEmpNo());
        //请假功能的权限控制
        if (user.getRoleId() > 1)
            empName = emp.getEmpName();
        Integer currentPage = 1;
        if (null != request.getParameter("currentPage") && !"".equals(request.getParameter("currentPage"))) {
            currentPage = Integer.valueOf(request.getParameter("currentPage").toString());
        }
        //holidayResult  获取成功
        PageResult holidayResult = holidayService.getHolidaysWithConditionByPage(empName, holidayType, holidayStatus, currentPage);
        PageIndex holidayIndex = PageIndex.getPageIndex(3, currentPage, holidayResult.getTotalPage());
        logger.info(holidayResult.getListData());
        request.setAttribute("holidayResult", holidayResult);
        request.setAttribute("holidayIndex", holidayIndex);
        request.setAttribute("empName", empName);
        request.setAttribute("holidayType", holidayType);
        request.setAttribute("holidayStatus", holidayStatus);
        return "success";
    }


    //删除 holidayNo  deleteHoliday
    public String deleteHoliday(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String resultString = "success";
        Holiday holiday = new Holiday();
        holiday.setHolidayNo((String) request.getParameter("holidayNo"));
        logger.info(holiday.toString());
        if (holidayService.deleteHoliday(holiday) == 1)
            return resultString;
        return "fail";
    }

    public String addHoliday(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String holidayType = request.getParameter("holidayType");
        String holidayCause = request.getParameter("holidayCause");
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");
        String holidayStatus = request.getParameter("holidayStatus");


        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        Employee emp = employeeService.getEmployeeByNo(user.getEmpNo());

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        LocalDate dateStartTime = null;
        LocalDate dateEndTime = null;
        try {
            dateStartTime = LocalDate.parse(startTime, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            dateEndTime = LocalDate.parse(endTime, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        } catch (Exception e) {
            e.printStackTrace();
        }


        String empName = emp.getEmpName();

        Holiday holiday = new Holiday();
        holiday.setHolidayBz(holidayCause);
        holiday.setHolidayNo(Holiday.getNumber());
        holiday.setHolidayType(holidayType);
        holiday.setStartTime(dateStartTime);
        holiday.setEndTime(dateEndTime);
        holiday.setHolidayUser(emp.getEmpName());
        holiday.setHolidayStatus(holidayStatus);
        if (holidayStatus.equals("草稿")) {
            holidayStatus = "0";
            holiday.setCreateTime(null);
        }

        if (holidayStatus.equals("已提交")) {
            holidayStatus = "1";
            holiday.setCreateTime(LocalDateTime.now());
        }


        holidayService.addHoliday(holiday);
        return "success";
    }

}
