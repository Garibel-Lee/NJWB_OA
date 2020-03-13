package com.lcqjoyce.entity;

import lombok.Data;

import java.time.LocalDate;

/**
 * <p>
 * 
 * </p>
 *
 * @author mybatis-plus
 * @since 2020-03-13
 */
@Data
public class Permissions  {


    private Integer id;

    private Integer roleId;

    private Integer menuId;

    private LocalDate createTime;

}
