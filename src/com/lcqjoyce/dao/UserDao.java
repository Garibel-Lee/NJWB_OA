package com.lcqjoyce.dao;

import com.lcqjoyce.entity.User;

import java.sql.SQLException;
import java.util.List;

/**
 * @author ：LCQJOYCE
 * @date ：Created in 2020/3/13 14:05
 * @description：
 * @version: $
 */
public  interface UserDao {
    public int insert(User user) throws SQLException;
    public int update(User user) throws SQLException;
    public int delete(User user) throws SQLException;
    public User getUserById(int id);
    public User getUserByName(String name);
    public User login(User user);
    public User getUserByEmpNo(String id);
    public List<User> getAllUsers();
}
