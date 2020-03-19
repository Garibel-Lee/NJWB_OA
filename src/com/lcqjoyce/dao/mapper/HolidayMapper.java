package com.lcqjoyce.dao.mapper;

import com.lcqjoyce.My_JDBC.Handle.RowMapper;
import com.lcqjoyce.entity.Holiday;
import org.apache.log4j.Logger;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

/**
 * @author ：LCQJOYCE
 * @date ：Created in 2020/3/15 14:31
 * @description：
 * @version: $
 */
public class HolidayMapper implements RowMapper {
    private static Logger logger = Logger.getLogger(HolidayMapper.class);

    public List<Holiday> mapperList(ResultSet rs) throws SQLException {
        logger.info("获得t_holiday表中数据，这是t_holiday表与HolidayMapper类的映射");
        List<Holiday> list = new ArrayList<Holiday>();
        //数据封装 rs是一个只读只进，只读--不能用于修改，只进--不能回头
        while (rs.next()) {
            System.out.println("rs不为空");
            Holiday holiday = new Holiday();
            holiday.setId(rs.getInt("id"));
            holiday.setHolidayNo(rs.getString("t_holiday_no"));
            holiday.setHolidayUser(rs.getString("t_holiday_user"));
            holiday.setHolidayType(rs.getString("t_holiday_type"));
            holiday.setHolidayBz(rs.getString("t_holiday_bz"));
            holiday.setHolidayStatus(rs.getString("t_holiday_status"));
            try {

                holiday.setStartTime(LocalDate.parse(rs.getString("t_start_time"), DateTimeFormatter.ofPattern("yyyy-MM-dd")));
                holiday.setEndTime(LocalDate.parse(rs.getString("t_end_time"), DateTimeFormatter.ofPattern("yyyy-MM-dd")));

            } catch (NullPointerException e) {
                logger.debug("开始与结束 日期转化 失败");
                e.printStackTrace();
            }
            try {

                String timeStamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(rs.getDate("t_create_time"));
                logger.info("LockTime()" + timeStamp);
                DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                LocalDateTime dateTest = LocalDateTime.parse(timeStamp, df);
                holiday.setCreateTime(dateTest);
            } catch (NullPointerException e) {

                logger.debug("tCreateTime 日期转化 失败");
                e.printStackTrace();
            }

            list.add(holiday);
        }
        logger.debug("HolidayMapperMapper数据分装成功");
        return list;
    }
}
