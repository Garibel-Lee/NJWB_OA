package com.lcqjoyce.service.impl;

import com.lcqjoyce.My_JDBC.Transaction.Transaction;
import com.lcqjoyce.dao.DeptDao;
import com.lcqjoyce.dao.EmployeeDao;
import com.lcqjoyce.entity.Dept;
import com.lcqjoyce.entity.Employee;
import com.lcqjoyce.service.DeptService;
import org.apache.log4j.Logger;

import java.sql.SQLException;
import java.util.List;

/**
 * @author ：LCQJOYCE
 * @date ：Created in 2020/3/15 11:52
 * @description：
 * @version: $
 */
public class DeptServiceImpl implements DeptService {
    private static Logger logger = Logger.getLogger(DeptServiceImpl.class);


    private EmployeeDao employeeDao;
    private DeptDao deptDao;
    private Transaction transaction;

    public void setTransaction(Transaction transaction) {
        this.transaction = transaction;
    }

    public List<Dept> getDeptsPerPage(int currentPage, int size) throws SQLException {
        logger.debug("在MoodServiceImpl类中，调用getMoodsPerPage方法");
        return deptDao.getDeptsPerPage(currentPage, size);
    }

    @Override
    public int addDept(Dept dept) {
        int count = 0;
          logger.debug("DeptServiceImpl类中，调用addDept");
        try {
                    //开始事务
                transaction.begin();
                count = deptDao.addDept(dept);
                //一旦执行成功就提交
                transaction.commit();

        } catch (Exception e) {
            logger.warn("DeptServiceImpl，addDept方法出现异常");
            //一旦异常就回滚
            transaction.rollback();
            e.printStackTrace();
        }


        return count;
    }

    @Override
    public int updateDept(Dept dept) {
        int count = 0;
        logger.debug("DeptServiceImpl类中，调用addDept");
        try {
            //开始事务
            transaction.begin();
            count = deptDao.updateDept(dept);
            //一旦执行成功就提交
            transaction.commit();

        } catch (Exception e) {
            logger.warn("DeptServiceImpl，addDept方法出现异常");
            //一旦异常就回滚
            transaction.rollback();
            e.printStackTrace();
        }


        return count;
    }

    @Override
    public List<Dept> getAllDepts() {
        return deptDao.ListAll();
    }

    @Override
    public Dept getByDeptNo(String deptNo) {
        return deptDao.getByDeptNo(deptNo);
    }

    @Override
    public int deleteByDeptNo(String deptNo) {

        int count = 0;
        List<Employee> lists = employeeDao.getEmployeeByDeptNo(deptNo);
        logger.debug("DeptServiceImpl类中，调用deleteByDeptNo");
        try {
            if (lists.size() == 0) {
                //开始事务
                transaction.begin();
                count = deptDao.delteByDeptNo(deptNo);
                //一旦执行成功就提交
                transaction.commit();
            }else
            {logger.debug("存在其他员工");}
        } catch (Exception e) {
            logger.warn("DeptServiceImpl，delete方法出现异常");
            //一旦异常就回滚
            transaction.rollback();
            e.printStackTrace();
        }


        return count;
    }

    public void setDeptDao(DeptDao deptDao) {
        this.deptDao = deptDao;
    }

    public void setEmployeeDao(EmployeeDao employeeDao) {
        this.employeeDao = employeeDao;
    }
}
