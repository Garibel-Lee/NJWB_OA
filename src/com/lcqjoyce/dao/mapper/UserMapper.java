package com.lcqjoyce.dao.mapper;

import com.lcqjoyce.My_JDBC.Handle.RowMapper;
import com.lcqjoyce.entity.Employee;
import com.lcqjoyce.entity.Role;
import com.lcqjoyce.entity.User;
import org.apache.log4j.Logger;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

/**
 * @author ：LCQJOYCE
 * @date ：Created in 2020/3/13 14:08
 * @description：
 * @version: $
 */
//哪边用不了

public class UserMapper implements RowMapper<User> {
    private static Logger logger = Logger.getLogger(UserMapper.class);

    public List<User> mapperList(ResultSet rs) throws SQLException {
        logger.debug("获得t_user表中数据，这是t_user表与User类的映射");
        List<User> list = new ArrayList<User>();
        //数据封装 rs是一个只读只进，只读--不能用于修改，只进--不能回头
        while (rs.next()) {
            System.out.println("rs不为空");
            User user = new User();
            user.setId(rs.getInt("t_id"));
            user.setUserAccount(rs.getString("t_user_account"));
            user.setUserPwd(rs.getString("t_user_pwd"));
            user.setEmpNo(rs.getString("t_emp_no"));
            user.setRoleId(rs.getInt("t_role_id"));
            Role role = new Role();
            role.setId(rs.getInt("t_role_id"));
            try {
                if (!rs.getString("r_role_name").isEmpty())
                    role.setRoleName(rs.getString("r_role_name"));
            }catch (Exception e){
                logger.info("未使用左连接r_role_name");
            }

            Employee emp = new Employee();
            emp.setEmpNo(rs.getString("t_emp_no"));

            try {
                if (!rs.getString("e_emp_name").isEmpty())
                    emp.setEmpName(rs.getString("e_emp_name"));
            }catch (Exception e){
                logger.info("未使用左连接e_emp_name");
            }

            user.setRole(role);
            user.setEmployee(emp);

            user.setResidueTimes(rs.getInt("t_residueTimes"));
            try {
                user.setCreateTime(LocalDate.parse(rs.getString("t_create_time"), DateTimeFormatter.ofPattern("yyyy-MM-dd")));

            } catch (NullPointerException e) {
                logger.debug("setCreateTime 日期转化 失败");

                user.setCreateTime(null);
                e.printStackTrace();
            }
            try {

                String timeStamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(rs.getTimestamp("t_create_time"));
                logger.info("t_create_time()" + timeStamp);


                DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                LocalDateTime dateTest = LocalDateTime.parse(timeStamp, df);
                user.setLockTime(dateTest);
            } catch (NullPointerException e) {
                user.setLockTime(null);
                logger.debug("setCreateTime 日期转化 失败");
                user.setLockTime(null);
                user.setCreateTime(null);
                e.printStackTrace();
            }


            list.add(user);
        }
        logger.debug("UserMapper数据分装成功");
        return list;
    }
}
