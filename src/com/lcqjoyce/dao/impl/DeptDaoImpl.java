package com.lcqjoyce.dao.impl;

import com.lcqjoyce.My_JDBC.Handle.JdbcTemplate;
import com.lcqjoyce.dao.DeptDao;
import com.lcqjoyce.dao.mapper.DeptMapper;
import com.lcqjoyce.entity.Dept;
import org.apache.log4j.Logger;

import java.sql.SQLException;
import java.util.List;

/**
 * @author ：LCQJOYCE
 * @date ：Created in 2020/3/15 10:26
 * @description：
 * @version: $
 */
public class DeptDaoImpl implements DeptDao {
    private static Logger logger = Logger.getLogger(DeptDaoImpl.class);

    @Override
    public List<Dept> ListAll() {
        List<Dept> results = null;
        logger.debug("在DeptDaoImpl类中，调用ListAll方法");
        String sql = "SELECT\n" +

                "* FROM\n" +
                "t_dept";
        Object[] objects = {};
        results = JdbcTemplate.executeQuery(sql, new DeptMapper(), objects);
        return results;
    }

    @Override
    public Dept getByDeptNo(String deptNo) {
        List<Dept> results = null;
        logger.debug("在UserDaoImpl类中，调用login方法");
        String sql = "SELECT\n" +
                "* FROM\n" +
                "t_dept  where t_dept_no=?";
        Object[] objects = {};
        results = JdbcTemplate.executeQuery(sql, new DeptMapper(), deptNo);
        if (results.size() > 0) {
            return results.get(0); //查到了
        }
        logger.info("deptNo未能查询到改部门信息");
        return null;//没有查到
    }

    @Override
    public List<Dept> getDeptsPerPage(int currentPage, int size) throws SQLException {
        logger.debug("在DeptDaoImpl类中，getDeptsPerPage");

        int begin = (currentPage - 1) * size; //当前页-1 再乘以显示的大小
        //如果使用数据分页，只能使用字符串拼接的方式
        String sql = "select * from t_dept LIMIT " + begin + " , " + size;
        //limit 不支持占位符
        //String sql="select * from t_mood LIMIT ?,?";
        //String[] objs= {begin+"",size+""};
        return JdbcTemplate.executeQuery(sql, new DeptMapper(), null);
    }

    @Override
    public int delteByDeptNo(String deptNo) {
        int count = 0;
        logger.debug("在DeptDaoImpl类中，delete");
        String sql = "delete from t_dept where t_dept_no=?";//所有的占位符必须是英文的问号
        String[] objects = {deptNo};
        try {
            count = JdbcTemplate.executeUpdate(sql, objects);
            logger.info("执行delete返回结果是：" + count);
        } catch (SQLException e) {
            logger.error(count);
        }
        return count;
    }

    @Override
    public int addDept(Dept dept) {
        int count = 0;
        logger.debug("在DeptDaoImpl类中，addDept");
        String sql = "INSERT INTO t_dept(t_dept_no, t_dept_name, t_dept_loc, t_dept_manager,t_dept_intro) " +
                "VALUES (?,?,?,?,?)";//所有的占位符必须是英文的问号
        String[] objects = {dept.getDeptNo(),dept.getDeptName(),dept.getDeptLoc(),dept.getDeptManager(),dept.getDeptIntro()};
        try {
            count = JdbcTemplate.executeUpdate(sql, objects);
            logger.info("DeptDaoImpl执行insert返回结果是：" + count);
        } catch (SQLException e) {
            logger.error(count);
        }
        return count;
    }

    @Override
    public int updateDept(Dept dept) {
        int count = 0;
        logger.debug("在DeptDaoImpl类中，updateDept");
        String sql = "update t_dept set  t_dept_name =?, t_dept_loc=?, t_dept_manager=? where t_dept_no=?";
        String[] objects = {dept.getDeptName(),dept.getDeptLoc(),dept.getDeptManager(),dept.getDeptNo()};
        try {
            count = JdbcTemplate.executeUpdate(sql, objects);
            logger.info("DeptDaoImpl执行update返回结果是：" + count);
        } catch (SQLException e) {
            logger.error(count);
        }
        return count;
    }
}
