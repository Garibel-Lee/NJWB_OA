package com.lcqjoyce.entity;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

/**
 * <p>
 * 
 * </p>
 *
 * @author mybatis-plus
 * @since 2020-03-13
 */
@Getter @Setter
public class Dept {

    private String deptNo;

    private String deptName;

    private String deptLoc;

    private String deptManager;

    private LocalDate createTime;

}