package com.lcqjoyce.entity;

import lombok.Data;

import java.time.LocalDateTime;


@Data
public class Employee {

    private Integer id;

    private String empNo;

    private String empName;

    private String empDept;

    private String sex;

    private String education;

    private String email;

    private String phone;

    private LocalDateTime entryTime;

    private LocalDateTime createTime;

}
