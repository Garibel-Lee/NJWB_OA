package com.lcqjoyce.service;

import com.lcqjoyce.My_JDBC.Init.BeanFactory;
import com.lcqjoyce.entity.Employee;
import org.junit.Test;

import java.util.List;

/**
 * @author ：LCQJOYCE
 * @date ：Created in 2020/3/15 19:26
 * @description：
 * @version: $
 */
public class empService {
    @Test
    public void test(){
        EmployeeService service = (EmployeeService) BeanFactory.getObject("employeeService");
        List<Employee> employees = service.getAllEmployees();
        System.out.println(employees.toString());
        System.out.println( Employee.getNumber()); ;

    }
}
