package com.lcqjoyce.dao.impl;

import com.lcqjoyce.My_JDBC.Handle.JdbcTemplate;
import com.lcqjoyce.dao.RoleDao;
import com.lcqjoyce.dao.mapper.RoleMapper;
import com.lcqjoyce.entity.Role;
import org.apache.log4j.Logger;

import java.util.List;


/**
 * @author ：LCQJOYCE
 * @date ：Created in 2020/3/17 21:40
 * @description：
 * @version: $
 */
public class RoleDaoImpl implements RoleDao {
    private static Logger logger= Logger.getLogger("RoleDaoImpl");
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
}
