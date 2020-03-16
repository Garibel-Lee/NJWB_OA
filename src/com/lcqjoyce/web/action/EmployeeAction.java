package com.lcqjoyce.web.action;

import com.lcqjoyce.entity.Employee;
import com.lcqjoyce.service.EmployeeService;
import com.lcqjoyce.util.page.PageIndex;
import com.lcqjoyce.util.page.PageResult;
import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;

/**
 * @author ：LCQJOYCE
 * @date ：Created in 2020/3/15 18:42
 * @description：
 * @version: $
 */
public class EmployeeAction {

    private static Logger logger = Logger.getLogger(EmployeeAction.class);
    private EmployeeService employeeService;

    public void setEmployeeService(EmployeeService employeeService) {
        this.employeeService = employeeService;
    }

    /**
     * 员工查询
     *
     * @param request
     * @param response
     * @return
     * @throws ServletException
     * @throws IOException
     */

    public String queryEmp(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String empName = request.getParameter("empName");
        String empDept = request.getParameter("empDept");
        Integer currentPage = 1;
        if(null != request.getParameter("currentPage") && !"".equals(request.getParameter("currentPage"))){
            currentPage = Integer.valueOf(request.getParameter("currentPage").toString());
        }
        //empResult  获取成功
        PageResult empResult = employeeService.getEmployeesWithConditionByPage(empName, empDept, currentPage);
        PageIndex empIndex = PageIndex.getPageIndex(3,currentPage,empResult.getTotalPage());
        logger.info(empResult.getListData());
        request.setAttribute("empResult",empResult);
        request.setAttribute("empIndex",empIndex);
        request.setAttribute("some",empResult.getListData());
        request.setAttribute("empName",empName);
        request.setAttribute("empDept",empDept);
        return "success";
    }

    //添加员工
    public String addEmp(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String resultString = "success";
        Employee emp = new Employee();
        emp.setEmpName((String) request.getParameter("empName"));
        emp.setEmpDept((String) request.getParameter("empDept"));
        emp.setEducation((String) request.getParameter("education"));
        emp.setEmpNo(Employee.getNumber());
        emp.setSex((String) request.getParameter("sex"));
        emp.setPhone((String) request.getParameter("phone"));
        emp.setEntryTime(LocalDate.parse((String) request.getParameter("entryTime")));

        logger.info(emp.toString());
        if (employeeService.addEmployee(emp) == 1)
            return resultString;

        return "fail";
    }

    public String empUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String resultString = "success";
        Employee emp = new Employee();
        emp.setEmpName((String) request.getParameter("empName"));
        emp.setEmpDept((String) request.getParameter("empDept"));
        emp.setEducation((String) request.getParameter("education"));
        emp.setEmpNo((String) request.getParameter("empNo"));
        emp.setSex((String) request.getParameter("sex"));
        emp.setPhone((String) request.getParameter("phone"));
        emp.setEntryTime(LocalDate.parse((String) request.getParameter("entryTime")));

        logger.info(emp.toString());
        if (employeeService.updateEmployee(emp) == 1)
            return resultString;

        return "fail";
    }

    public String empDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String resultString = "success";
        Employee emp = new Employee();
        emp.setEmpNo((String) request.getParameter("empNo"));
        logger.info(emp.toString());
        if (employeeService.deleteEmployee(emp) == 1)
            return resultString;

        return "fail";
    }

}
