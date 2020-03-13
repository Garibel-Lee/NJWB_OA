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
public class Menu {


    private Integer id;

    private String menuName;

    private String hrefUrl;

    private Integer parentId;

    private LocalDate createTime;


}
