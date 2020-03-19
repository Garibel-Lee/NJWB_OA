package com.lcqjoyce.service.impl;

import com.lcqjoyce.My_JDBC.Transaction.Transaction;
import com.lcqjoyce.dao.RoleDao;
import com.lcqjoyce.entity.Role;
import com.lcqjoyce.service.RoleService;
import com.lcqjoyce.util.page.PageResult;
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

    @Override
    public PageResult getRolesWithConditionByPage(Integer currentPage) {
        int count = roleDao.queryForCount();
        if (count > 0) {
            //4 每一页显示数量
            List<Role> permissions = roleDao.queryByPage(currentPage, 4);
            return new PageResult(permissions, count, Integer.valueOf(currentPage), 4);
        }
        return PageResult.empty(4);
    }

    @Override
    public List<Role> getUsersPerPage(int currentPage, int size) {
        return roleDao.getRolesPerPage(currentPage, size);
    }

    @Override
    public int deleteRoleById(Integer roleId) {
        int count = 0;
        logger.debug("RoleServiceImpl类中，getUsersPerPage");
        try {
            //开始事务
            transaction.begin();
            count = roleDao.deleteRoleById(roleId);
            //一旦执行成功就提交
            transaction.commit();

        } catch (Exception e) {
            logger.warn("RoleServiceImpl类中,删除ID失败进行回滚");
            //一旦异常就回滚
            transaction.rollback();
            e.printStackTrace();
        }
        return count;
    }
}
