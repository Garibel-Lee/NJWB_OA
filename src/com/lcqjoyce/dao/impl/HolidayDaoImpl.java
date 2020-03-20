package com.lcqjoyce.dao.impl;

import com.lcqjoyce.My_JDBC.Handle.JdbcTemplate;
import com.lcqjoyce.My_JDBC.Handle.RowMapper;
import com.lcqjoyce.dao.HolidayDao;
import com.lcqjoyce.dao.mapper.HolidayMapper;
import com.lcqjoyce.entity.Holiday;
import org.apache.log4j.Logger;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


/**
 * @author ：LCQJOYCE
 * @date ：Created in 2020/3/17 8:33
 * @description：
 * @version: $
 */
public class HolidayDaoImpl implements HolidayDao {
    private static Logger logger = Logger.getLogger(HolidayDaoImpl.class);

    @Override
    public int addHoliday(Holiday holiday) {

        int count = 0;
        logger.info("在HolidayDaoImpl类中，addHoliday");
        String sql = "INSERT INTO t_holiday(t_holiday_no,t_holiday_user, t_holiday_type, t_holiday_bz, t_start_time, t_end_time, t_holiday_status) " +
                "VALUES (?,?,?,?,?,?,?)";//所有的占位符必须是英文的问号
        logger.info(holiday.toString());
        Object[] objects = {holiday.getHolidayNo(), holiday.getHolidayUser(), holiday.getHolidayType(), holiday.getHolidayBz(), holiday.getStartTime() + "", holiday.getEndTime() + "",0};
        try {
            count = JdbcTemplate.executeUpdate(sql, objects);
            logger.info("addholiday执行insert返回结果是：" + count);
        } catch (SQLException e) {
            logger.error(count);
        }
        return count;

    }

    @Override
    public int updateHoliday(Holiday holiday) {
        int count = 0;
        logger.info("在HolidayDaoImpl类中，updateHoliday");
        String sql = "update t_holiday  set t_holiday_user=?, t_holiday_type=?, t_holiday_bz=?, t_start_time=?, t_end_time=?, t_holiday_status=?,t_create_time=now() where t_holiday_no=?  ";
        Object[] objects = {holiday.getHolidayUser(), holiday.getHolidayType().toString(), holiday.getHolidayBz(), holiday.getStartTime() + "", holiday.getEndTime() + "", holiday.getHolidayStatus(), holiday.getHolidayNo()};
        try {
            count = JdbcTemplate.executeUpdate(sql, objects);
            logger.info("updateHoliday执行insert返回结果是：" + count);
        } catch (SQLException e) {
            logger.error(count);
        }
        return count;
    }

    @Override
    public int deleteHoliday(Holiday holiday) {
        int count = 0;
        logger.info("在HolidayDaoImpl类中，deleteHoliday");
        String sql = "delete from t_holiday  where t_holiday_no=?  ";
        Object[] objects = {holiday.getHolidayNo()};
        try {
            count = JdbcTemplate.executeUpdate(sql, objects);
            logger.info("deleteHoliday执行deletet返回结果是：" + count);
        } catch (SQLException e) {
            logger.error(count);
        }
        return count;
    }

    @Override
    public List<Holiday> getAllHolidays() {
        List<Holiday> results = null;
        logger.debug("在holidayDaoImpl类中，getAllHolidays");
        String sql = "SELECT\n" +
                "* FROM\n" +
                "t_holiday";
        Object[] objects = {};
        results = JdbcTemplate.executeQuery(sql, new HolidayMapper(), objects);
        return results;
    }

    @Override
    public List<Holiday> getHolidayByHolidayNo(String holidayNo) {
        return null;
    }

    @Override
    public Holiday getHolidayByempNo(String empNo) {
        return null;
    }

    @Override
    public List<Holiday> getHolidaysPerPage(int currentPage, int size) {
        return null;
    }

    /**
     * @param empName       员工ID不然会出现erroe 因为姓名可以重复
     * @param holidayType
     * @param holidayStatus
     * @return
     */
    @Override
    public Integer queryForCount(String empName, String holidayType, String holidayStatus) {
        StringBuffer sql = new StringBuffer();
        sql.append("select count(id) from t_holiday  where 1=1 ");
        if (!(empName == null || "".equals(empName))) {
            sql.append(" and t_holiday_user like  '%" + empName + "%'");
        }
        if (!(holidayType == null || "".equals(holidayType))) {
            sql.append(" and t_holiday_type= " + "'" + holidayType + "'");
        }
        if (!(holidayStatus == null || "".equals(holidayStatus))) {
            sql.append(" and t_holiday_status= " + "'" + holidayStatus + "'");
        }

        int result = 0;
        try {
            result = JdbcTemplate.executeQuery(sql.toString(), new RowMapper<Integer>() {
                @Override
                public List<Integer> mapperList(ResultSet rs) throws SQLException {
                    List<Integer> list = new ArrayList<>();
                    if (rs.next()) {
                        list = new ArrayList<>();
                        list.add(rs.getInt(1));
                        return list;
                    }
                    return list;
                }

            }, new Object[0]).get(0);
        } catch (Exception e) {
            logger.error("获取请假记录集合总数出问题");
        }
        logger.info("queryForCount" + result);
        return result;
    }

    @Override
    public List<Holiday> queryByPage(String empName, String holidayType, String holidayStatus, Integer currentPage, Integer pageSize) {
        StringBuffer sql = new StringBuffer("SELECT\n" +
                "id,\n" +
                "t_holiday_no,\n" +
                "t_holiday_user,\n" +
                "t_holiday_type,\n" +
                "t_holiday_bz,\n" +
                "t_start_time,\n" +
                "t_end_time,\n" +
                "t_holiday_status,\n" +
                "DATE_FORMAT(t_create_time, '%Y-%m-%d %k:%i:%s') as t_create_time\n" +
                "FROM\n" +
                "t_holiday\n" +
                "where 1=1  ");
        if (!(empName == null || "".equals(empName))) {
            sql.append(" and t_holiday_user like  '%" + empName + "%'");
        }
        if (!(holidayType == null || "".equals(holidayType))) {
            sql.append(" and t_holiday_type= " + "'" + holidayType + "'");
        }
        if (!(holidayStatus == null || "".equals(holidayStatus))) {
            sql.append(" and t_holiday_status= " + "'" + holidayStatus + "'");
        }

        sql.append(" limit ?, ?");
        Object objects[] = {(currentPage - 1) * pageSize, pageSize};
        return JdbcTemplate.executeQuery(sql.toString(), new HolidayMapper(), objects);
    }

    @Override
    public Holiday getHolidayByNo(String holidayNo) {
        StringBuffer sql = new StringBuffer("SELECT\n" +
                "id,\n" +
                "t_holiday_no,\n" +
                "t_holiday_user,\n" +
                "t_holiday_type,\n" +
                "t_holiday_bz,\n" +
                "t_start_time,\n" +
                "t_end_time,\n" +
                "t_holiday_status,\n" +
                "DATE_FORMAT(t_create_time, '%Y-%m-%d %k:%i:%s') as t_create_time\n" +
                "FROM\n" +
                "t_holiday where t_holiday_no=?\n");

        Object objects[] = {holidayNo};
        List<Holiday> lists = JdbcTemplate.executeQuery(sql.toString(), new HolidayMapper(), objects);
        if (null != lists && lists.size() == 1) {
            Holiday HolidayResult = lists.get(0);
            return HolidayResult;
        }
        logger.info("该编号未查到对应请假记录");
        return null;
    }
}
