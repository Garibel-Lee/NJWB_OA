package com.lcqjoyce.dao.impl;

import com.lcqjoyce.My_JDBC.Handle.JdbcTemplate;
import com.lcqjoyce.My_JDBC.Handle.RowMapper;
import com.lcqjoyce.dao.RoleDao;
import com.lcqjoyce.dao.mapper.RoleMapper;
import com.lcqjoyce.entity.Role;
import org.apache.log4j.Logger;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


/**
 * @author ：LCQJOYCE
 * @date ：Created in 2020/3/17 21:40
 * @description：
 * @version: $
 */
public class RoleDaoImpl implements RoleDao {
    private static Logger logger = Logger.getLogger("RoleDaoImpl");

    @Override
    public List<Role> getAllroles() {
        List<Role> results = null;
        logger.debug("在RoleDaoImpl类中，调用getAllroles方法");
        String sql = "SELECT\n" +
                "* FROM\n" +
                "t_role";
        Object[] objects = {};
        results = JdbcTemplate.executeQuery(sql, new RoleMapper(), objects);
        return results;
    }

    @Override
    public List<Role> queryByPage(Integer currentPage, int pageSize) {
        StringBuffer sql = new StringBuffer("SELECT\n" +
                "*  FROM\n" +
                "t_role\n" +
                "WHERE 1=1 ");

        sql.append(" limit ?, ?");
        Object objects[] = {(currentPage - 1) * pageSize, pageSize};
        return JdbcTemplate.executeQuery(sql.toString(), new RoleMapper(), objects);
    }

    @Override
    public int queryForCount() {
        StringBuffer sql = new StringBuffer();
        sql.append("select count(t_id) from t_role where 1=1 ");

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
            logger.error("获取role记录集合总数出问题");
        }
        logger.info("role_queryForCount" + result);
        return result;
    }

    @Override
    public List<Role> getRolesPerPage(int currentPage, int size) {
        logger.debug("getRolesPerPage+");

        int begin = (currentPage - 1) * size; //当前页-1 再乘以显示的大小
        //如果使用数据分页，只能使用字符串拼接的方式
        String sql = "select * from t_role LIMIT " + begin + " , " + size;
        //limit 不支持占位符
        //String sql="select * from t_mood LIMIT ?,?";
        //String[] objs= {begin+"",size+""};
        return JdbcTemplate.executeQuery(sql, new RoleMapper(), new Object[]{});
    }

    @Override
    public int deleteRoleById(Integer roleId) {
        int count = 0;
        logger.debug("deleteRoleById+");
        String sql = "delete  from t_role  where t_id=?";
        try {
            count = JdbcTemplate.executeUpdate(sql, roleId);
        } catch (Exception e) {
            e.printStackTrace();
        }


        return count;
    }

    @Override
    public List<Role> getRoleByRoleName(String roleName) {
        logger.info("getRoleByRoleName ");
        String sql = new StringBuffer()
                .append(" select ")
                .append(" 	t_id,t_role_name,t_create_time  ")
                .append(" from ")
                .append(" 	t_role ")
                .append(" where ")
                .append(" 	t_role_name = ? ")
                .toString();


        return JdbcTemplate.executeQuery(sql, new RoleMapper(), roleName);
    }

    @Override
    public int addRole(String roleName) {
        String sql = "INSERT INTO `njwb_oa`.`t_role`( `t_role_name`, `t_create_time`) VALUES ( ?, now());";
        int count = 0;
        logger.debug("RoleDaoImpl  addRole");

        try {
            count = JdbcTemplate.executeUpdate(sql,roleName);
        } catch (Exception e) {
            logger.error("addRole  结果"+count);
            e.printStackTrace();
        }


        return count;

    }
}
