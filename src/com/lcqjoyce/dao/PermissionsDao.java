package com.lcqjoyce.dao;

import com.lcqjoyce.entity.Menu;
import com.lcqjoyce.entity.Permissions;

import java.util.List;

public interface PermissionsDao {
    //权限控制使用到的
    public List<Menu> ListAll(int role);

    int queryForCount(String roleId, String menuId);

    List<Permissions> queryByPage(String roleId, String menuId, Integer currentPage, Integer pageSize);

    List<Permissions> getPermissionsPerPage(int currentPage, int size);

    int addPermissions(Permissions permissions);
}
