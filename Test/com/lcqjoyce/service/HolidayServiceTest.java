package com.lcqjoyce.service;

import com.lcqjoyce.My_JDBC.Init.BeanFactory;
import com.lcqjoyce.util.page.PageResult;
import org.junit.Test;

/**
 * @author ：LCQJOYCE
 * @date ：Created in 2020/3/17 9:33
 * @description：
 * @version: $
 */
public class HolidayServiceTest {
    @Test
    public void test1() {
        HolidayService holidayService = (HolidayService) BeanFactory.getObject("holidayService");
        PageResult pageResult=holidayService.getHolidaysWithConditionByPage(null,null,null,1);
        System.out.println(pageResult.getListData());
    }
}
