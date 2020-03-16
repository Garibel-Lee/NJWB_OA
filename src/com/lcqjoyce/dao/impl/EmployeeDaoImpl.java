package com.lcqjoyce.dao.impl;

import com.lcqjoyce.My_JDBC.Handle.JdbcTemplate;
import com.lcqjoyce.dao.EmployeeDao;
import com.lcqjoyce.dao.mapper.EmployeeMapper;
import com.lcqjoyce.entity.Employee;
import org.apache.log4j.Logger;

import java.sql.SQLException;
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
        String sql = "SELECT\n" +
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
        List<Employee> lists = JdbcTemplate.executeQuery(sql, new EmployeeMapper(), objects);
       /* if(null!=lists && lists.size()==1){
            employeeResult = lists.get(0);
            return employeeResult;
        }*/

        return lists;
    }

    @Override
    public List<Employee> getAllEmployees() {
        logger.debug("EmployeeDaoImpl，调用getEmployeeByDeptNo");
        String sql = "SELECT\n" +
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
                "t_employee\n";
        Object[] objects = {};
        List<Employee> lists = JdbcTemplate.executeQuery(sql, new EmployeeMapper(), objects);
       /* if(null!=lists && lists.size()==1){
            employeeResult = lists.get(0);
            return employeeResult;
        }*/

        return lists;
    }

    @Override
    public List<Employee> getEmployeesPerPage(int currentPage, int size) {
        logger.debug("在EmployeeDaoImpl类中，getEmployeesPerPage");

        int begin = (currentPage - 1) * size; //当前页-1 再乘以显示的大小
        //如果使用数据分页，只能使用字符串拼接的方式
        String sql = "select * from t_employee LIMIT " + begin + " , " + size;
        //limit 不支持占位符
        //String sql="select * from t_mood LIMIT ?,?";
        //String[] objs= {begin+"",size+""};
        return JdbcTemplate.executeQuery(sql, new EmployeeMapper(), null);
    }

    @Override
    public int addEmployee(Employee emp) {
        int count = 0;
        logger.debug("在EmployeeDaoImpl类中，addDept");
        String sql = "INSERT INTO t_employee(t_emp_no,t_emp_name, t_emp_dept, t_sex, t_education, t_phone, t_entry_time,t_create_time) " +
                "VALUES (?,?,?,?,?,?,?,?)";//所有的占位符必须是英文的问号
        String[] objects = {emp.getEmpNo(), emp.getEmpName(), emp.getEmpDept(), emp.getSex(), emp.getEducation(), emp.getPhone(), emp.getEntryTime() + "", emp.getEntryTime() + ""};
        try {
            count = JdbcTemplate.executeUpdate(sql, objects);
            logger.info("addEmployee执行insert返回结果是：" + count);
        } catch (SQLException e) {
            logger.error(count);
        }
        return count;
    }

    @Override
    public Employee getEmployeeByNo(String empNo) {
        logger.debug("EmployeeDaoImpl，调用getEmployeeByDeptNo");
        String sql = "SELECT\n" +
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
                "t_employee  where t_emp_no=? \n";
        Object[] objects = {empNo};
        List<Employee> lists = JdbcTemplate.executeQuery(sql, new EmployeeMapper(), objects);
        if (null != lists && lists.size() == 1) {
            Employee employeeResult = lists.get(0);
            return employeeResult;
        }

        return null;
    }

    @Override
    public int updateEmployee(Employee emp) {
        int count = 0;
        logger.debug("在EmployeeDaoImpl类中，updateEmployee");
        String sql = "update t_employee set t_emp_name=?, t_emp_dept=?, t_sex=?, t_education=?, t_phone=?, t_entry_time=? " +
                "where t_emp_no=?";//所有的占位符必须是英文的问号
        String[] objects = {emp.getEmpName(), emp.getEmpDept(), emp.getSex(), emp.getEducation(), emp.getPhone(), emp.getEntryTime() + "", emp.getEmpNo()};
        try {
            count = JdbcTemplate.executeUpdate(sql, objects);
            logger.info("updateEmployee执行update返回结果是：" + count);
        } catch (SQLException e) {
            logger.error(count);
        }
        return count;
    }

    @Override
    public List<Employee> getQueryEmployees(String empName, String empDo) {
        logger.debug("EmployeeDaoImpl，调用getQueryEmployees");
        StringBuffer sql = new StringBuffer("SELECT\n" +
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
                "t_employee where 1=1 \n");
        Object[] objects = {};

        if (empName.equals("") && !empDo.equals("")) {
            sql.append("and t_emp_no= "+empDo);
            objects = new Object[]{empDo};
        } else if (!empName.equals("") && empDo.equals("")) {
            sql.append("and t_emp_name like  '%"+empName+"%'");
            objects = new Object[]{empName};
        } else if (!empName.equals("") && !empDo.equals("")) {
            sql.append("and t_emp_name like  '%"+empName+"%'");
            sql.append("and t_emp_no= "+empDo);
            objects = new Object[]{empName, empDo};
        }

        List<Employee> lists = JdbcTemplate.executeQuery(sql.toString(), new EmployeeMapper(), null);
       /* if(null!=lists && lists.size()==1){
            employeeResult = lists.get(0);
            return employeeResult;
        }*/

        return lists;
    }

    @Override
    public int deleteEmployee(Employee emp) {
        int count = 0;
        logger.debug("在DeptDaoImpl类中，delete");
        String sql = "delete from t_employee where t_emp_no=?";//所有的占位符必须是英文的问号
        String[] objects = {emp.getEmpNo()};
        try {
            count = JdbcTemplate.executeUpdate(sql, objects);
            logger.info("执行delete返回结果是：" + count);
        } catch (SQLException e) {
            logger.error(count);
        }
        return count;
    }
}
