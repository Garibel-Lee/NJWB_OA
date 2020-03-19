package com.lcqjoyce.service.impl;

import com.lcqjoyce.My_JDBC.Transaction.Transaction;
import com.lcqjoyce.dao.MenuDao;
import com.lcqjoyce.dao.PermissionsDao;
import com.lcqjoyce.dao.RoleDao;
import com.lcqjoyce.entity.Menu;
import com.lcqjoyce.entity.Permissions;
import com.lcqjoyce.service.PermissionsService;
import com.lcqjoyce.util.page.PageResult;
import org.apache.log4j.Logger;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author ：LCQJOYCE
 * @date ：Created in 2020/3/14 1:15
 * @description：
 * @version: $
 */
public class PermissionsServiceImpl implements PermissionsService {
    private static Logger logger = Logger.getLogger(UserServiceImpl.class);


    private PermissionsDao permissionsDao;
    private Transaction transaction ;
    private MenuDao menuDao;
    private RoleDao roleDao;

    public void setRoleDao(RoleDao roleDao) {
       roleDao = roleDao;
    }

    public static void setLogger(Logger logger) {
        PermissionsServiceImpl.logger = logger;
    }

    public void setMenuDao(MenuDao menuDao) {
        this.menuDao = menuDao;
    }


    public Map<Menu, List<Menu>> listAll(Integer roleId) {
        Map<Menu, List<Menu>> results = new HashMap<Menu, List<Menu>>();
      /*  Map<Menu, List<Menu>> results = new ConcurrentSkipListMap<Menu, List<Menu>>(
                new Comparator<Menu>() {
                    @Override
                    public int compare(Menu o1, Menu o2) {

                        return o1.getParentId()-o2.getParentId();
                    }
                }
        );*/
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

    @Override
    public PageResult getPermissionsWithConditionByPage(String roleId, String menuId, Integer currentPage) {
        int count = permissionsDao.queryForCount(roleId, menuId);
        if (count > 0) {
            List<Permissions> permissions = permissionsDao.queryByPage(roleId, menuId, currentPage, 4);
            return new PageResult(permissions, count, Integer.valueOf(currentPage), 4);
        }
        return PageResult.empty(4);
    }

    @Override
    public List<Permissions> getPermissionsPerPage(int currentPage, int size) {
        return permissionsDao.getPermissionsPerPage(currentPage, size);
    }

    @Override
    public int addPermissions(Permissions permissions) {

        int count = 0;
        logger.debug("PermissionsServiceImpl类中，调用addPermissions");
        try {
            //开始事务
            transaction.begin();
            count = permissionsDao.addPermissions(permissions);
            //一旦执行成功就提交
            transaction.commit();

        } catch (Exception e) {
            logger.warn("PermissionsServiceImpl，addPermissions方法出现异常");
            //一旦异常就回滚
            transaction.rollback();
            e.printStackTrace();
        }


        return count;

    }
}