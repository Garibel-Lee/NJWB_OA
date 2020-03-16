package com.lcqjoyce.dao;

import com.lcqjoyce.entity.Employee;

import java.util.List;

/**
 * @author ：LCQJOYCE
 * @date ：Created in 2020/3/15 14:24
 * @description：
 * @version: $
 */
public interface EmployeeDao {
    public List<Employee> getEmployeeByDeptNo(String deptNo);

    List<Employee> getAllEmployees();


    List<Employee> getEmployeesPerPage(int currentPage, int size);

    int addEmployee(Employee emp);

    Employee getEmployeeByNo(String empNo);

    int updateEmployee(Employee emp);

    List<Employee> getQueryEmployees(String empName, String empNo);

    int deleteEmployee(Employee emp);

    Integer queryForCount(String empName, String empDept);

    List<Employee> queryByPage(String empName, String empDept,Integer currentPage,Integer pageSize);
}
