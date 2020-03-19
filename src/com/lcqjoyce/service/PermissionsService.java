package com.lcqjoyce.service;

import com.lcqjoyce.entity.Menu;
import com.lcqjoyce.entity.Permissions;
import com.lcqjoyce.util.page.PageResult;

import java.util.List;
import java.util.Map;

public interface PermissionsService {
    public Map<Menu, List<Menu>> listAll(Integer roleId);

    PageResult getPermissionsWithConditionByPage(String roleId, String menuId, Integer currentPage);

    List<Permissions> getPermissionsPerPage(int currentPage, int size);

    int addPermissions(Permissions permissions);
}
