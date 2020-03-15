package com.lcqjoyce.dao.impl;

import com.lcqjoyce.My_JDBC.Handle.JdbcTemplate;
import com.lcqjoyce.dao.EmployeeDao;
import com.lcqjoyce.dao.mapper.EmployeeMapper;
import com.lcqjoyce.entity.Employee;
import org.apache.log4j.Logger;

import java.util.List;

/**
 * @author ：LCQJOYCE
 * @date ：Created in 2020/3/15 14:25
 * @description：
 * @version: $
 */
public class EmployeeDaoImpl implements EmployeeDao {
    private static Logger logger = Logger.getLogger(EmployeeDaoImpl.class);

    public List<Employee> getEmployeeByDeptNo(String deptNo) {

        logger.debug("EmployeeDaoImpl，调用getEmployeeByDeptNo");
        String sql ="SELECT\n" +
                "t_employee.id,\n" +
                "t_employee.t_emp_no,\n" +
                "t_employee.t_emp_name,\n" +
                "t_employee.t_emp_dept,\n" +
                "t_employee.t_sex,\n" +
                "t_employee.t_education,\n" +
                "t_employee.t_email,\n" +
                "t_employee.t_phone,\n" +
                "t_employee.t_entry_time,\n" +
                "t_employee.t_create_time\n" +
                "FROM\n" +
                "t_employee\n" +
                "WHERE\n" +
                "t_employee.t_emp_dept = ?";
        Object[] objects = {deptNo};
        List<Employee> lists= JdbcTemplate.executeQuery(sql, new EmployeeMapper(), objects);
       /* if(null!=lists && lists.size()==1){
            employeeResult = lists.get(0);
            return employeeResult;
        }*/

        return lists;
    }
}
