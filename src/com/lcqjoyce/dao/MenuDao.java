package com.lcqjoyce.dao;

import com.lcqjoyce.entity.Menu;

import java.util.List;

/**
 * @author ：LCQJOYCE
 * @date ：Created in 2020/3/14 0:37
 * @description：
 * @version: $
 */
public interface MenuDao {
    //根据ID查对象  为父节点获取实体类
    public Menu getMenuByID(Integer id);

    List<Menu> getallMenus();
}
