package com.lcqjoyce.dao.mapper;

import com.lcqjoyce.My_JDBC.Handle.RowMapper;
import com.lcqjoyce.entity.Dept;
import com.lcqjoyce.entity.Employee;
import org.apache.log4j.Logger;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

/**
 * @author ：LCQJOYCE
 * @date ：Created in 2020/3/15 14:31
 * @description：
 * @version: $
 */
public class EmployeeMapper implements RowMapper {
    private static Logger logger = Logger.getLogger(EmployeeMapper.class);

    public List<Employee> mapperList(ResultSet rs) throws SQLException {
        logger.debug("获得t_employee表中数据，这是t_employee表与Employee类的映射");
        List<Employee> list = new ArrayList<Employee>();
        //数据封装 rs是一个只读只进，只读--不能用于修改，只进--不能回头
        while (rs.next()) {
            System.out.println("rs不为空");
            Employee employee = new Employee();
            employee.setId(rs.getInt("id"));
            employee.setEmpNo(rs.getString("t_emp_no"));
            employee.setEmpName(rs.getString("t_emp_name"));
            Dept dept=new Dept();
            dept.setDeptNo(rs.getString("t_emp_dept"));
           try {
               String deptName=(String) rs.getString("d_dept_name");
               if(!(deptName==null && "".equals(deptName)))
                   dept.setDeptName(deptName);

           }catch (Exception e)
           {
               logger.info("未用到实体维护");
               e.printStackTrace();
           }




            employee.setDept(dept);
            employee.setEducation(rs.getString("t_education"));
            employee.setPhone(rs.getString("t_phone"));
            employee.setSex(rs.getString("t_sex"));
            try {
              employee.setEntryTime(LocalDate.parse(rs.getString("t_entry_time"), DateTimeFormatter.ofPattern("yyyy-MM-dd")));
               employee.setCreateTime(LocalDate.parse(rs.getString("t_create_time"), DateTimeFormatter.ofPattern("yyyy-MM-dd")));
            } catch (Exception e) {
                logger.debug("datatime localtime日期转化 失败");
                e.printStackTrace();
            }
            list.add(employee);
        }
        logger.debug("EmployeeMapper数据分装成功");
        return list;
    }
}
