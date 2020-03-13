package com.lcqjoyce.dao.impl;

import com.lcqjoyce.My_JDBC.Handle.JdbcTemplate;
import com.lcqjoyce.dao.UserDao;
import com.lcqjoyce.dao.mapper.UserMapper;
import com.lcqjoyce.entity.User;
import org.apache.log4j.Logger;

import java.sql.SQLException;
import java.util.List;

/**
 * @author ：LCQJOYCE
 * @date ：Created in 2020/3/13 14:18
 * @description：
 * @version: $
 */
public class UserDaoImpl implements UserDao {
    private static Logger logger = Logger.getLogger(UserDaoImpl.class);
    @Override
    public int insert(User user) throws SQLException {
        return 0;
    }

    @Override
    public int update(User user) throws SQLException {
        return 0;
    }

    @Override
    public int delete(User user) throws SQLException {
        return 0;
    }

    @Override
    public User getUserById(int id) {
        return null;
    }

    @Override
    public User getUserByName(String name) {
        User userResult = null;
        logger.debug("在UserDaoImpl类中，调用login方法");
        String sql = "SELECT\n" +
                "t_user.t_id,\n" +
                "t_user.t_user_account,\n" +
                "t_user.t_user_pwd,\n" +
                "t_user.t_emp_no,\n" +
                "t_user.t_role_id,\n" +
                "t_user.t_create_time\n" +
                "FROM\n" +
                "t_user\n" +
                "WHERE\n" +
                "t_user.t_user_account = ?";
        Object[] objects = {name};
        List<User> users= JdbcTemplate.executeQuery(sql, new UserMapper(), objects);
        if(null!=users && users.size()==1){
            userResult = users.get(0);
        }
        return userResult;
    }

    @Override
    public User login(User user) {
        User userResult = null;
        logger.debug("在UserDaoImpl类中，调用login方法");
        String sql = "SELECT\n" +
                "t_user.t_id,\n" +
                "t_user.t_user_account,\n" +
                "t_user.t_user_pwd,\n" +
                "t_user.t_emp_no,\n" +
                "t_user.t_role_id,\n" +
                "t_user.t_create_time\n" +
                "FROM\n" +
                "t_user\n" +
                "WHERE\n" +
                "t_user.t_user_account = ? AND \n" +
                "t_user.t_user_pwd = ?";
        Object[] objects = {user.getUserAccount(),user.getUserPwd()};
        List<User> users= JdbcTemplate.executeQuery(sql, new UserMapper(), objects);
        if(null!=users && users.size()==1){
            userResult = users.get(0);
        }
        return userResult;
    }

    @Override
    public User getUserByEmpNo(String id) {
        User userResult = null;
        logger.debug("在UserDaoImpl类中，调用login方法");
        String sql = "SELECT\n" +
                "t_user.t_id,\n" +
                "t_user.t_user_account,\n" +
                "t_user.t_user_pwd,\n" +
                "t_user.t_emp_no,\n" +
                "t_user.t_role_id,\n" +
                "t_user.t_create_time\n" +
                "FROM\n" +
                "t_user\n" +
                "WHERE\n" +
                "t_user.t_emp_no = ?";
        Object[] objects = {id};
        List<User> users= JdbcTemplate.executeQuery(sql, new UserMapper(), objects);
        if(null!=users && users.size()==1){
            userResult = users.get(0);
        }
        return userResult;
    }

    @Override
    public List<User> getAllUsers() {
        return null;
    }
}
