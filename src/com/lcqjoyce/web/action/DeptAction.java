package com.lcqjoyce.web.action;

import com.lcqjoyce.My_JDBC.Init.BeanFactory;
import com.lcqjoyce.entity.Dept;
import com.lcqjoyce.service.DeptService;
import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author ：LCQJOYCE
 * @date ：Created in 2020/3/15 14:13
 * @description：
 * @version: $
 */
public class DeptAction {
    private static Logger logger = Logger.getLogger(DeptAction.class);
    private DeptService deptService;

    public void setDeptService(DeptService deptService) {
        this.deptService = deptService;
    }

    //删除部门
    public String deptDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String resultString = "success";
        String deptNo = request.getParameter("deptNo");
        if (deptService.deleteByDeptNo(deptNo) == 1)
            return resultString;
        else
            resultString = "fail";
        logger.info("删除部门失败");
        return resultString;


    }

    public String deptAdd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String resultString = "success";
        Dept dept = new Dept();
        dept.setDeptName((String) request.getParameter("deptName"));
        dept.setDeptNo((String)request.getParameter("deptNo"));
        dept.setDeptLoc((String) request.getParameter("deptLocation"));
        dept.setDeptManager((String)request.getParameter("deptManager"));
        dept.setDeptIntro((String)request.getParameter("deptIntro"));
        logger.info(dept.toString());
        DeptService service=(DeptService) BeanFactory.getObject("deptService");
       if(service.addDept(dept)==1)
           return resultString;

        return "fail";
    }

    public String deptUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String resultString = "success";
        Dept dept = new Dept();
        dept.setDeptName((String) request.getParameter("deptName"));
        dept.setDeptNo((String)request.getParameter("deptNo"));
        dept.setDeptLoc((String) request.getParameter("deptLocation"));
        dept.setDeptManager((String)request.getParameter("deptManager"));
        dept.setDeptIntro((String)request.getParameter("deptIntro"));
        logger.info(dept.toString());
        DeptService service=(DeptService) BeanFactory.getObject("deptService");
        if(service.updateDept(dept)==1)
            return resultString;

        return "fail";
    }


}
