package com.lcqjoyce.service;

import com.lcqjoyce.My_JDBC.Init.BeanFactory;
import com.lcqjoyce.entity.Menu;
import org.junit.Test;

import java.util.List;
import java.util.Map;

/**
 * @author ：LCQJOYCE
 * @date ：Created in 2020/3/14 20:49
 * @description：
 * @version: $
 */
public class PermissionsServiceTest {
    @Test
    public void TestMap_Menu_ListMenu() {
        PermissionsService PermissionsService = (PermissionsService) BeanFactory.getObject("permissionsService");
        Map<Menu, List<Menu>> re = PermissionsService.listAll(3);
        System.out.println(re.toString());
    }

}
