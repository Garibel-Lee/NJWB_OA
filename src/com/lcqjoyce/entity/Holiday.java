package com.lcqjoyce.entity;

import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;

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

    private Integer holidayNo;

    private String holidayUser;

    private Integer holidayType;

    private String holidayBz;

    private LocalDate startTime;

    private LocalDate endTime;

    private String holidayStatus;

    private LocalDateTime createTime;



}
