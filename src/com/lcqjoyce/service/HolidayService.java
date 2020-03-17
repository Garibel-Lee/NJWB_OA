package com.lcqjoyce.service;

import com.lcqjoyce.entity.Holiday;
import com.lcqjoyce.util.page.PageResult;

import java.util.List;

/**
 * @author ：LCQJOYCE
 * @date ：Created in 2020/3/15 18:31
 * @description：
 * @version: $
 */
public interface HolidayService {



    int addHoliday(Holiday emp);

    int deleteHoliday(Holiday emp);

    int updateHoliday(Holiday emp);

    List<Holiday> getAllHolidays();

    Holiday getHolidayByempNo(String empNo);

    PageResult getHolidaysWithConditionByPage(String empName, String holidayType,String holidayStatus,Integer currentPage);

    List<Holiday> getHolidaysPerPage(int currentPage, int size);

    Holiday getHolidayByNo(String holidayNo);
}
