package com.test;

import com.lcqjoyce.entity.Menu;
import com.lcqjoyce.service.PermissionsService;
import com.lcqjoyce.service.impl.PermissionsServiceImpl;

import java.util.List;
import java.util.Map;

/**
 * @author ：LCQJOYCE
 * @date ：Created in 2020/3/12 14:55
 * @description：
 * @version: $
 */
public class Test001 {


    public static void main(String[] args) {
       /* User  user=new User();
        user.setUserAccount("admin");
        user.setUserPwd("admin");
        UserService service= (UserService) BeanFactory.getObject("userService");
        user=service.login(user);
        System.out.println(user.getEmpNo()+"第一次");


        *//**//*
        user=null;
        user=service.getUserByEmpNo("E1002");
        PermissionsDao PermissionsDao=new PermissionsDaoImpl();

        System.out.println(PermissionsDao.ListAll(1).toString());*/
        /**/
        PermissionsService PermissionsService=new PermissionsServiceImpl();
        Map<Menu, List<Menu>>  re= PermissionsService.listAll(3);
        System.out.println(re.toString());

    }

}
