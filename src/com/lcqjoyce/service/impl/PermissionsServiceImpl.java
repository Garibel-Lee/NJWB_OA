package com.lcqjoyce.service.impl;

import com.lcqjoyce.My_JDBC.Transaction.Transaction;
import com.lcqjoyce.dao.MenuDao;
import com.lcqjoyce.dao.PermissionsDao;
import com.lcqjoyce.dao.impl.MenuDaoImpl;
import com.lcqjoyce.dao.impl.PermissionsDaoImpl;
import com.lcqjoyce.entity.Menu;
import com.lcqjoyce.service.PermissionsService;
import org.apache.log4j.Logger;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * @author ：LCQJOYCE
 * @date ：Created in 2020/3/14 1:15
 * @description：
 * @version: $
 */
public class PermissionsServiceImpl implements PermissionsService {
    private static Logger logger = Logger.getLogger(UserServiceImpl.class);


    private PermissionsDao permissionsDao=new PermissionsDaoImpl();
    private MenuDao menuDao=new MenuDaoImpl();

    public static void setLogger(Logger logger) {
        PermissionsServiceImpl.logger = logger;
    }

    public void setMenuDao(MenuDao menuDao) {
        this.menuDao = menuDao;
    }

    private Transaction transaction;

    public Map<Menu, List<Menu>> listAll(Integer roleId) {
        Map<Menu, List<Menu>> results = new ConcurrentHashMap<Menu, List<Menu>>();
        List<Menu> lists = permissionsDao.ListAll(roleId);
        logger.info(lists.toString());
        if (null != lists)  {
            for (Menu menu : lists) {
                Menu temp=menuDao.getMenuByID(menu.getParentId());
                if (!results.containsKey(temp)) {
                    List<Menu> menus = new ArrayList<Menu>();
                    menus.add(menu);
                    results.put(temp, menus);
                }
                else{
                    results.get(temp).add(menu);
                }
            }
        } else
            ;
        return results;

    }


    public void setPermissionsDao(PermissionsDao permissionsDao) {
        this.permissionsDao = permissionsDao;
    }

    public void setTransaction(Transaction transaction) {
        this.transaction = transaction;
    }
}
