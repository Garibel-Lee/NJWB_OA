package com.lcqjoyce.entity;

import lombok.Data;

import java.time.LocalDate;


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

    private LocalDate entryTime;

    private LocalDate createTime;

}
