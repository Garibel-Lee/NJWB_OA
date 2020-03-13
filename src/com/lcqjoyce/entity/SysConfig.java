package com.lcqjoyce.entity;

import lombok.Data;

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
public class SysConfig {


    private Integer id;

    private String configType;

    private String configKey;

    private String configPageValue;

    private LocalDateTime createTime;

}
