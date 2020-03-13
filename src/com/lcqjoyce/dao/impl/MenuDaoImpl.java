package com.lcqjoyce.dao.impl;

import com.lcqjoyce.My_JDBC.Handle.JdbcTemplate;
import com.lcqjoyce.dao.MenuDao;
import com.lcqjoyce.dao.mapper.MenuMapper;
import com.lcqjoyce.entity.Menu;
import org.apache.log4j.Logger;

import java.util.List;

/**
 * @author ：LCQJOYCE
 * @date ：Created in 2020/3/14 2:01
 * @description：
 * @version: $
 */
public class MenuDaoImpl implements MenuDao {
    private static Logger logger = Logger.getLogger(MenuDaoImpl.class);
    @Override
    public Menu getMenuByID(Integer id) {
       Menu menuResult=null; ;
        logger.debug("MenuDaoImpl，调用getMenuByID方法");
        String sql = "SELECT\n" +
                "t_menu.t_id,\n" +
                "t_menu.t_menu_name,\n" +
                "t_menu.t_href_url,\n" +
                "t_menu.t_parent_id,\n" +
                "t_menu.t_create_time\n" +
                "FROM\n" +
                "t_menu\n" +
                "WHERE\n" +
                "t_menu.t_id = ?";
        Object[] objects = {id};
        List<Menu> menus= JdbcTemplate.executeQuery(sql, new MenuMapper(), objects);
        if(null!=menus && menus.size()==1){
            menuResult = menus.get(0);
        }
        return menuResult;
    }
}
