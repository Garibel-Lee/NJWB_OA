package com.lcqjoyce.service;

import com.lcqjoyce.entity.Role;
import com.lcqjoyce.util.page.PageResult;

import java.util.List;

public interface RoleService {

    List<Role> getAllroles();

    PageResult getRolesWithConditionByPage(Integer currentPage);

    List<Role> getUsersPerPage(int currentPage, int size);


    int deleteRoleById(Integer roleId);

    List<Role> getRoleByRoleName(String roleName);

    int addRole(String roleName);
}
