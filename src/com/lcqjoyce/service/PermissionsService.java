package com.lcqjoyce.service;

import com.lcqjoyce.entity.Menu;

import java.util.List;
import java.util.Map;

public interface PermissionsService {
    public Map<Menu, List<Menu>> listAll(Integer roleId);
}
