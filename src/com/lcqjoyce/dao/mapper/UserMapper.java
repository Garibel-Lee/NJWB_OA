package com.lcqjoyce.dao.mapper;

import com.lcqjoyce.My_JDBC.Handle.RowMapper;
import com.lcqjoyce.entity.User;
import org.apache.log4j.Logger;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
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
        while(rs.next()){
            System.out.println("rs不为空");
            User user = new User();
            user.setId(rs.getInt("t_id"));
            user.setUserAccount(rs.getString("t_user_account"));
            user.setUserPwd(rs.getString("t_user_pwd"));
            user.setEmpNo(rs.getString("t_emp_no"));
            user.setRoleId(rs.getInt("t_role_id"));
            try {
                user.setCreateTime(LocalDate.parse(rs.getString("t_create_time"), DateTimeFormatter.ofPattern("yyyy-MM-dd")));
            } catch (NullPointerException e2){
                logger.debug("datatime localtime日期转化 空指针失败");
                e2.printStackTrace();
            }
            System.out.println(rs.getString("t_create_time"));

            list.add(user);
        }
        logger.debug("UserMapper数据分装成功");
        return list;
    }
}
