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
public class User {

    private Integer id;

    private String userAccount;

    private String userPwd;

    private String empNo;

    private Employee employee;

    private Integer roleId;

    private Role role;

    private Integer residueTimes;

    private LocalDate createTime;

    private LocalDateTime lockTime;

}
