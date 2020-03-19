package com.lcqjoyce.dao;

import com.lcqjoyce.entity.Role;

import java.util.List;

/**
 * @author ：LCQJOYCE
 * @date ：Created in 2020/3/14 0:37
 * @description：
 * @version: $
 */
public interface  RoleDao {
    List<Role> getAllroles();

    List<Role> queryByPage(Integer currentPage, int i);

    int queryForCount();

    List<Role> getRolesPerPage(int currentPage, int size);

    int deleteRoleById(Integer roleId);
}
