package com.lcqjoyce.service.impl;

import com.lcqjoyce.My_JDBC.Transaction.Transaction;
import com.lcqjoyce.dao.MenuDao;
import com.lcqjoyce.entity.Menu;
import com.lcqjoyce.service.MenuService;
import org.apache.log4j.Logger;

import java.util.List;


/**
 * @author ：LCQJOYCE
 * @date ：Created in 2020/3/17 23:01
 * @description：
 * @version: $
 */
public class MenuServiceImpl implements MenuService {
    private  static Logger logger= Logger.getLogger(MenuServiceImpl.class);
    private Transaction transaction;
    private MenuDao menuDao;

    public void setTransaction(Transaction transaction) {
        this.transaction = transaction;
    }

    public void setMenuDao(MenuDao menuDao) {
        this.menuDao = menuDao;
    }

    @Override
    public List<Menu> getallMenus() {
        return menuDao.getallMenus();
    }
}
