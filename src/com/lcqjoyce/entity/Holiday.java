package com.lcqjoyce.entity;

import com.lcqjoyce.dao.HolidayDao;
import com.lcqjoyce.dao.impl.HolidayDaoImpl;
import lombok.Data;

import java.text.DecimalFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

/**
 * <p>
 * 
 * </p>
 *
 * @author mybatis-plus
 * @since 2020-03-13
 */
@Data
public class Holiday {


    private Integer id;

    private String holidayNo;

    private String holidayUser;

    private String holidayType;

    private String holidayBz;

    private LocalDate startTime;

    private LocalDate endTime;

    private String holidayStatus;

    private LocalDateTime createTime;

    public LocalDateTime getCreateTime() {
        return createTime;
    }

    public static String getNumber() {

        String id = null;
        HolidayDao dao = new HolidayDaoImpl();
        List<Holiday> lists = new ArrayList<>();
        lists = dao.getAllHolidays();
        Collections.sort(lists, new Comparator<Holiday>() {
            public int compare(Holiday o1, Holiday o2) {
                // 升序
                //return o1.getAge()-o2.getAge();
                // return o1.getAge().compareTo(o2.getAge());
                // 降序
                // return o2.getAge()-o1.getAge();
                // return o2.getAge().compareTo(o1.getAge());
                return o2.getId().compareTo(o1.getId());
            }
        });
        String a = lists.get(0).holidayNo;
        int idnum = 0;
        try {
            idnum = Integer.parseInt(a.substring(a.length() - 4)) + 1;
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        DecimalFormat df = new DecimalFormat("0000");
        String aa = df.format(idnum);
        id = "QJ" + aa;
        return id;
    }

}
