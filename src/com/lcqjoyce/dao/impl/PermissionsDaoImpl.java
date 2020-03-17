package com.lcqjoyce.dao.impl;

import com.lcqjoyce.My_JDBC.Handle.JdbcTemplate;
import com.lcqjoyce.My_JDBC.Handle.RowMapper;
import com.lcqjoyce.dao.PermissionsDao;
import com.lcqjoyce.dao.mapper.PermissionMapper;
import com.lcqjoyce.dao.mapper.PermissionsMapper;
import com.lcqjoyce.entity.Menu;
import com.lcqjoyce.entity.Permissions;
import org.apache.log4j.Logger;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * @author ：LCQJOYCE
 * @date ：Created in 2020/3/14 0:45
 * @description：
 * @version: $
 */
public class PermissionsDaoImpl implements PermissionsDao {
    private static Logger logger = Logger.getLogger(PermissionsDaoImpl.class);


    @Override
    public List<Menu> ListAll(int role) {

        List<Menu> results = null;
        logger.debug("在PermissionsDaoImpl类中，调用ListAll方法");
        String sql = "SELECT\n" +
                "t_menu.t_id,\n" +
                "t_menu.t_menu_name,\n" +
                "t_menu.t_href_url,\n" +
                "t_menu.t_parent_id,\n" +
                "t_menu.t_create_time\n" +
                "FROM\n" +
                "t_menu\n" +
                "LEFT JOIN t_permissions ON t_menu.t_id = t_permissions.t_menu_id\n" +
                "WHERE\n" +
                "t_permissions.t_role_id = ?";
        Object[] objects = {role};
        results = JdbcTemplate.executeQuery(sql, new PermissionsMapper(), objects);
        if (null != results && results.size() == 1) {
            Menu menu = results.get(0);
        }
        return results;
    }

    @Override
    public int queryForCount(String roleId, String menuId) {
        StringBuffer sql = new StringBuffer();
        sql.append("select count(t_id) from t_permissions  where 1=1 ");
        if (!(roleId == null || "".equals(roleId))) {
            sql.append(" and t_role_id=" + roleId);
        }
        if (!(menuId == null || "".equals(menuId))) {
            sql.append(" and t_menu_id=" +menuId);
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
            logger.error("获取权限记录集合总数出问题");
        }
        logger.info("queryForCount" + result);
        return result;
    }

    @Override
    public List<Permissions> queryByPage(String roleId, String menuId, Integer currentPage, Integer pageSize) {
        StringBuffer sql = new StringBuffer("SELECT\n" +

                "* FROM\n" +
                "t_permissions\n" +
                "where 1=1  ");
        if (!(roleId == null || "".equals(roleId))) {
            sql.append(" and t_role_id=" + roleId );
        }
        if (!(menuId == null || "".equals(menuId))) {
            sql.append(" and t_menu_id=" +menuId);
        }


        sql.append(" limit ?, ?");
        Object objects[] = {(currentPage - 1) * pageSize, pageSize};
        return JdbcTemplate.executeQuery(sql.toString(), new PermissionMapper(), objects);
    }

    @Override
    public List<Permissions> getPermissionsPerPage(int currentPage, int size) {
        logger.debug("getPermissionsPerPage+");

        int begin = (currentPage - 1) * size; //当前页-1 再乘以显示的大小
        //如果使用数据分页，只能使用字符串拼接的方式
        String sql = "select * from t_permissions LIMIT " + begin + " , " + size;
        //limit 不支持占位符
        //String sql="select * from t_mood LIMIT ?,?";
        //String[] objs= {begin+"",size+""};
        return JdbcTemplate.executeQuery(sql, new PermissionMapper(), null);
    }
}
