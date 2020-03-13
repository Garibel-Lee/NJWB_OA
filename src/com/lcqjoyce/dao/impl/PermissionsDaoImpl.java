package com.lcqjoyce.dao.impl;

import com.lcqjoyce.My_JDBC.Handle.JdbcTemplate;
import com.lcqjoyce.dao.PermissionsDao;
import com.lcqjoyce.dao.mapper.PermissionsMapper;
import com.lcqjoyce.entity.Menu;
import org.apache.log4j.Logger;

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
        logger.debug("在UserDaoImpl类中，调用login方法");
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
}
