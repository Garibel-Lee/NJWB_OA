package com.lcqjoyce.service;

import com.lcqjoyce.My_JDBC.Transaction.Transaction;
import com.lcqjoyce.dao.UserDao;
import com.lcqjoyce.entity.User;
import com.lcqjoyce.util.page.PageResult;

import java.util.List;

public interface UserService {
    public int insert(User user);
    public int update(User user);
    public int delete(User user);
    public User getUserById(int id);
    public User getUserByEmpNo(String id);
    public User getUserByName(String name);
    public List<User> getAllUsers();
    public void setUserDao(UserDao dao);//通过xml解析获得dao，然后注入到service中
    public void setTransaction(Transaction transaction);//通过xml解析获得transaction，然后注入到service中
    public User login(User user);


    PageResult getUsersWithConditionByPage(String userAccount, String residueTimes, String roleId,Integer currentPage);

    List<User> getUsersPerPage(int currentPage, int size);


    List<User> getUsersByRoleId(Integer roleId);

    User selectUserByIdAndPwd(Integer id, String encode);

    int updateUserByPwd(Integer id, String encodeNewPwd);

    int addUser(User user);
}
