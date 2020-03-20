package com.lcqjoyce.dao.impl;

import com.lcqjoyce.My_JDBC.Handle.JdbcTemplate;
import com.lcqjoyce.My_JDBC.Handle.RowMapper;
import com.lcqjoyce.dao.UserDao;
import com.lcqjoyce.dao.mapper.UserMapper;
import com.lcqjoyce.entity.User;
import org.apache.log4j.Logger;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
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
        String sql = "INSERT INTO `njwb_oa`.`t_user`(`t_user_account`, `t_user_pwd`, `t_emp_no`, `t_role_id`, `t_create_time`, ) " +
                "VALUES ( ?, ?, ?, 3,now())";


        return 0;
    }

    @Override
    public int update(User user) throws SQLException {
        return 0;
    }

    @Override
    public int delete(User user) throws SQLException {
        int count = 0;
        logger.debug("在DeptDaoImpl类中，delete");
        String sql = "delete from t_user where t_id=?";//所有的占位符必须是英文的问号
        Object[] objects = {user.getId()};
        try {
            count = JdbcTemplate.executeUpdate(sql, objects);
            logger.info("执行delete返回结果是：" + count);
        } catch (SQLException e) {
            logger.error(count);
        }
        return count;
    }

    @Override
    public User getUserById(int id) {
        User userResult = null;
        logger.debug("在UserDaoImpl类中，调用login方法");
        String sql = "SELECT\n" +
                "t_user.t_id,\n" +
                "t_user.t_user_account,\n" +
                "t_user.t_user_pwd,\n" +
                "t_user.t_emp_no,\n" +
                "t_user.t_role_id,\n" +
                "t_user.t_create_time,\n" +
                "t_user.t_residueTimes\n" +

                "FROM\n" +
                "t_user\n" +
                "WHERE\n" +
                "t_user.t_id = ?";
        Object[] objects = {id};
        List<User> users = JdbcTemplate.executeQuery(sql, new UserMapper(), objects);
        if (null != users && users.size() == 1) {
            userResult = users.get(0);
        }
        return userResult;
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
                "t_user.t_create_time,\n" +
                "t_user.t_residueTimes\n" +

                "FROM\n" +
                "t_user\n" +
                "WHERE\n" +
                "t_user.t_user_account = ?";
        Object[] objects = {name};
        List<User> users = JdbcTemplate.executeQuery(sql, new UserMapper(), objects);
        if (null != users && users.size() == 1) {
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
                "t_user.t_residueTimes,\n" +
                "t_user.t_emp_no,\n" +
                "t_user.t_role_id,\n" +
                "t_user.t_create_time\n" +
                "FROM\n" +
                "t_user\n" +
                "WHERE\n" +
                "t_user.t_user_account = ? AND \n" +
                "t_user.t_user_pwd = ?";
        Object[] objects = {user.getUserAccount(), user.getUserPwd()};
        List<User> users = JdbcTemplate.executeQuery(sql, new UserMapper(), objects);
        if (null != users && users.size() == 1) {
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
                "t_user.t_residueTimes,\n" +
                "t_user.t_user_pwd,\n" +
                "t_user.t_emp_no,\n" +
                "t_user.t_role_id,\n" +
                "t_user.t_create_time\n" +
                "FROM\n" +
                "t_user\n" +
                "WHERE\n" +
                "t_user.t_emp_no = ?";
        Object[] objects = {id};
        List<User> users = JdbcTemplate.executeQuery(sql, new UserMapper(), objects);
        if (null != users && users.size() == 1) {
            userResult = users.get(0);
        }
        return userResult;
    }

    @Override
    public List<User> getAllUsers() {
        return null;
    }

    @Override
    public List<User> getUsersPerPage(int currentPage, int size) {
        logger.debug("getUsersPerPage+");

        int begin = (currentPage - 1) * size; //当前页-1 再乘以显示的大小
        //如果使用数据分页，只能使用字符串拼接的方式
        String sql = "select * from t_user LIMIT " + begin + " , " + size;
        //limit 不支持占位符
        //String sql="select * from t_mood LIMIT ?,?";
        //String[] objs= {begin+"",size+""};
        return JdbcTemplate.executeQuery(sql, new UserMapper(), new Object[]{});
    }

    @Override
    public List<User> queryByPage(String userAccount, String residueTimes, String roleId, Integer currentPage, int pageSize) {
        StringBuffer sql = new StringBuffer("SELECT\n" +
                "t_user.t_id,\n" +
                "t_user.t_user_account,\n" +
                "t_user.t_residueTimes,\n" +
                "t_user.t_user_pwd,\n" +
                "t_user.t_emp_no,\n" +
                "t_user.t_role_id,\n" +
                "t_user.t_create_time,\n" +
                "t_employee.t_emp_no AS e_emp_no,\n" +
                "t_employee.t_emp_name AS e_emp_name,\n" +
                "t_role.t_role_name AS r_role_name,\n" +

                "t_role.t_id AS r_id\n" +
                "FROM\n" +
                "t_user\n" +
                "LEFT JOIN t_employee ON t_user.t_emp_no = t_employee.t_emp_no\n" +
                "LEFT JOIN t_role ON t_user.t_role_id = t_role.t_id\n" +

                "WHERE 1=1 ");
        if (!(userAccount == null || "".equals(userAccount))) {
            sql.append(" and t_user_account like  '%" + userAccount + "%'");
        }
        if (!(residueTimes == null || "".equals(residueTimes))) {
            if (Integer.valueOf(residueTimes) == 0)
                sql.append(" and t_residueTimes=0");
            if (Integer.valueOf(residueTimes) > 0)
                sql.append(" and t_residueTimes>0");
        }
        if (!(roleId == null || "".equals(roleId))) {
            sql.append(" and t_role_id=" + roleId);
        }
        sql.append(" limit ?, ?");
        Object objects[] = {(currentPage - 1) * pageSize, pageSize};
        return JdbcTemplate.executeQuery(sql.toString(), new UserMapper(), objects);
    }


    @Override
    public int queryForCount(String userAccount, String residueTimes, String roleId) {
        StringBuffer sql = new StringBuffer();
        sql.append("select count(t_id) from t_user where 1=1 ");
        if (!(userAccount == null || "".equals(userAccount))) {
            sql.append(" and t_user_account like  '%" + userAccount + "%'");
        }
        if (!(residueTimes == null || "".equals(residueTimes))) {
            if (Integer.valueOf(residueTimes) == 0)
                sql.append(" and t_residueTimes=0");
            if (Integer.valueOf(residueTimes) > 0)
                sql.append(" and t_residueTimes>0");
        }
        if (!(roleId == null || "".equals(roleId))) {
            sql.append(" and t_role_id=" + roleId);
        }

        int result = 0;
        try {
            result = JdbcTemplate.executeQuery(sql.toString(), new RowMapper<Integer>() {
                @Override
                public List<Integer> mapperList(ResultSet rs) throws SQLException {
                    List<Integer> list = new ArrayList<>();
                    if (rs.next()) {
                        list = new ArrayList<>();
                        list.add(rs.getInt(1));
                        return list;
                    }
                    return list;
                }

            }, new Object[0]).get(0);
        } catch (Exception e) {
            logger.error("获取user记录集合总数出问题");
        }
        logger.info("queryForCount" + result);
        return result;
    }

    @Override
    public List<User> getUsersByRoleId(Integer roleId) {
        logger.debug("getUsersByRoleId+");

        String sql = "select * from t_user where t_role_id=?";

        return JdbcTemplate.executeQuery(sql, new UserMapper(), roleId);


    }

    @Override
    public User selectUserByIdAndPwd(Integer id, String encodeOldPwd) {
        User userResult = null;
        logger.debug("在UserDaoImpl类中，调用selectUserByIdAndPwd方法");
        String sql = "SELECT\n" +
                "t_user.t_id,\n" +
                "t_user.t_user_account,\n" +
                "t_user.t_residueTimes,\n" +
                "t_user.t_user_pwd,\n" +
                "t_user.t_emp_no,\n" +
                "t_user.t_role_id,\n" +
                "t_user.t_create_time\n" +
                "FROM\n" +
                "t_user\n" +
                "WHERE\n" +
                "t_user.t_id = ?  and  t_user_pwd=?";
        Object[] objects = {id, encodeOldPwd};
        List<User> users = JdbcTemplate.executeQuery(sql, new UserMapper(), objects);
        if (null != users && users.size() == 1) {
            userResult = users.get(0);
        }
        return userResult;
    }

    @Override
    public int updateUserByPwd(Integer id, String encodeNewPwd) {
        Object[] objects = {encodeNewPwd, id};
        String sql = " update t_user  set  t_user_pwd=? where t_id=? ";
        int count = 0;
        logger.debug("UserDaoImpl  updateUserByPwd");

        try {
            count = JdbcTemplate.executeUpdate(sql, objects);
        } catch (Exception e) {
            logger.error("更新密码结果：" + count);
            e.printStackTrace();
        }

        return count;
    }

    @Override
    public int addUser(User user) {
        int count = 0;
        logger.info("在HolidayDaoImpl类中，addHoliday");
        String sql = "INSERT INTO `njwb_oa`.`t_user`( `t_user_account`, `t_user_pwd`, `t_emp_no`, `t_role_id`, `t_create_time`, `t_residueTimes`)" +
                " VALUES ( ?, ?, ?, ?, now(), ?);";//所有的占位符必须是英文的问号
        logger.info(user.toString());
        Object[] objects = {user.getUserAccount(), user.getUserPwd(), user.getEmpNo(), user.getRoleId(), user.getResidueTimes()};
        try {
            count = JdbcTemplate.executeUpdate(sql, objects);
            logger.info("addholiday执行insert返回结果是：" + count);
        } catch (SQLException e) {
            logger.error(count);
        }
        return count;
    }
}
