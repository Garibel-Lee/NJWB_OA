package com.lcqjoyce.service;

import com.lcqjoyce.My_JDBC.Init.BeanFactory;
import com.lcqjoyce.util.page.PageResult;
import org.junit.Test;

/**
 * @author ：LCQJOYCE
 * @date ：Created in 2020/3/15 19:26
 * @description：
 * @version: $
 */
public class empServiceTest {
    @Test
    public void test(){
        EmployeeService service = (EmployeeService) BeanFactory.getObject("employeeService");
//        List<Employee> employees = service.getAllEmployees();
//        System.out.println(employees.toString());
//        System.out.println( Employee.getNumber()); ;
        PageResult result = service.getEmployeesWithConditionByPage(null,null,1);
        System.out.println(result.getListData());

    }
}
