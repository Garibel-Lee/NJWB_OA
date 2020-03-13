package com.lcqjoyce.dao;

import com.lcqjoyce.entity.Menu;

import java.util.List;

public interface PermissionsDao {
    public List<Menu> ListAll(int role);
}
