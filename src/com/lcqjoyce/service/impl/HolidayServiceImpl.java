package com.lcqjoyce.service.impl;

import com.lcqjoyce.My_JDBC.Transaction.Transaction;
import com.lcqjoyce.dao.DeptDao;
import com.lcqjoyce.dao.EmployeeDao;
import com.lcqjoyce.dao.HolidayDao;
import com.lcqjoyce.entity.Holiday;
import com.lcqjoyce.service.HolidayService;
import com.lcqjoyce.util.page.PageResult;
import org.apache.log4j.Logger;

import java.util.List;

/**
 * @author ：LCQJOYCE
 * @date ：Created in 2020/3/17 8:47
 * @description：
 * @version: $
 */
public class HolidayServiceImpl implements HolidayService {

    private static Logger logger = Logger.getLogger(HolidayServiceImpl.class);
    private EmployeeDao employeeDao;
    private DeptDao deptDao;
    private HolidayDao holidayDao;
    private Transaction transaction;

    public void setEmployeeDao(EmployeeDao employeeDao) {
        this.employeeDao = employeeDao;
    }

    public void setDeptDao(DeptDao deptDao) {
        this.deptDao = deptDao;
    }

    public void setHolidayDao(HolidayDao holidayDao) {
        this.holidayDao = holidayDao;
    }

    public void setTransaction(Transaction transaction) {
        this.transaction = transaction;
    }


    @Override
    public int addHoliday(Holiday holiday) {
        int count = 0;
        logger.debug("EmployeeServiceImpl类中，addEmployee");
        try {
            //开始事务
            transaction.begin();
            count = holidayDao.addHoliday(holiday);
            //一旦执行成功就提交
            transaction.commit();

        } catch (Exception e) {
            logger.warn("HolidayServiceImpl类中,addHoliday");
            //一旦异常就回滚
            transaction.rollback();
            e.printStackTrace();
        }
        return count;
    }

    @Override
    public int deleteHoliday(Holiday holiday) {
        int count = 0;
        logger.debug("HolidayServiceImpl类中，deleteHoliday");
        try {
            //开始事务
            transaction.begin();
            count = holidayDao.deleteHoliday(holiday);
            //一旦执行成功就提交
            transaction.commit();

        } catch (Exception e) {
            logger.warn("HolidayServiceImpl类中,deleteHoliday");
            //一旦异常就回滚
            transaction.rollback();
            e.printStackTrace();
        }
        return count;

    }

    @Override
    public int updateHoliday(Holiday holiday) {
        int count = 0;
        logger.debug("HolidayServiceImpl类中，updateHoliday");
        try {
            //开始事务
            transaction.begin();
            count = holidayDao.updateHoliday(holiday);
            //一旦执行成功就提交
            transaction.commit();

        } catch (Exception e) {
            logger.warn("HolidayServiceImpl类中,updateHoliday");
            //一旦异常就回滚
            transaction.rollback();
            e.printStackTrace();
        }
        return count;
    }

    @Override
    public List<Holiday> getAllHolidays() {
        return null;
    }

    @Override
    public Holiday getHolidayByempNo(String empNo) {
        return null;
    }

    @Override
    public PageResult getHolidaysWithConditionByPage(String empName, String holidayType, String holidayStatus, Integer currentPage) {
        int count = holidayDao.queryForCount(empName, holidayType, holidayStatus);
        if (count > 0) {
            List<Holiday> holidays = holidayDao.queryByPage(empName, holidayType,holidayStatus, currentPage, 4);
            return new PageResult(holidays, count, Integer.valueOf(currentPage), 4);
        }
        return PageResult.empty(4);
    }

    @Override
    public List<Holiday> getHolidaysPerPage(int currentPage, int size) {
        return holidayDao.getHolidaysPerPage(currentPage, size);
    }

    @Override
    public Holiday getHolidayByNo(String holidayNo) {
        return  holidayDao.getHolidayByNo(holidayNo);
    }
}
