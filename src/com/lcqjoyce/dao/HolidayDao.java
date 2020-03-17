package com.lcqjoyce.dao;

import com.lcqjoyce.entity.Holiday;

import java.util.List;

/**
 * @author ：LCQJOYCE
 * @date ：Created in 2020/3/15 14:24
 * @description：
 * @version: $
 */
public interface HolidayDao {

    /**
     * 查询所有的假期
     *
     * @return
     */
    int addHoliday(Holiday emp);

    int updateHoliday(Holiday holiday);

    int deleteHoliday(Holiday holiday);

    List<Holiday> getAllHolidays();

    List<Holiday> getHolidayByHolidayNo(String holidayNo);

    Holiday getHolidayByempNo(String empNo);

    List<Holiday> getHolidaysPerPage(int currentPage, int size);

    Integer queryForCount(String empName, String holidayType, String holidayStatus);

    //现在是锁定了参数  但是最好不写死 后期做一个 queryObject 现在这样的代码量减少  复用性得不到提升后期升级起来遇到麻烦，做高级拼接不更方便
    List<Holiday> queryByPage(String empName, String holidayType, String holidayStatus, Integer currentPage, Integer pageSize);

    Holiday getHolidayByNo(String holidayNo);

}
