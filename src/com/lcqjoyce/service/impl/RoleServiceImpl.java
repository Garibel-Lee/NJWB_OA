package com.lcqjoyce.service.impl;

import com.lcqjoyce.My_JDBC.Transaction.Transaction;
import com.lcqjoyce.dao.RoleDao;
import com.lcqjoyce.entity.Role;
import com.lcqjoyce.service.RoleService;
import org.apache.log4j.Logger;

import java.util.List;

/**
 * @author ：LCQJOYCE
 * @date ：Created in 2020/3/17 21:45
 * @description：
 * @version: $
 */
public class RoleServiceImpl implements RoleService {
    private static Logger logger = Logger.getLogger(RoleServiceImpl.class);
    private RoleDao roleDao;
    private Transaction transaction;

    public void setTransaction(Transaction transaction) {
        this.transaction = transaction;
    }


    public void setRoleDao(RoleDao roleDao) {
        this.roleDao = roleDao;
    }


    @Override
    public List<Role> getAllroles() {
        return roleDao.getAllroles();
    }
}
