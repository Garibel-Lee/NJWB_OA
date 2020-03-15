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
}
