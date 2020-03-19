package com.lcqjoyce.service;

import com.lcqjoyce.My_JDBC.Init.BeanFactory;
import com.lcqjoyce.entity.User;
import com.lcqjoyce.util.page.PageIndex;
import com.lcqjoyce.util.page.PageResult;
import org.junit.Test;

import java.util.List;

/**
 * @author ：LCQJOYCE
 * @date ：Created in 2020/3/14 20:46
 * @description：
 * @version: $
 */
public class UserServiceTest {

    @Test
    public void test(){
        User user=new User();
        user.setUserAccount("admin");
        user.setUserPwd("admin");
        UserService service= (UserService) BeanFactory.getObject("userService");
        user=service.login(user);
        System.out.println(user.getEmpNo()+"第一次");
    }
    @Test
    public void testLogin(){
        User user=new User();
        user.setUserAccount("admin");
        user.setUserPwd("admin");
        UserService service= (UserService) BeanFactory.getObject("userService");
        user=service.login(user);
        System.out.println(user.getEmpNo()+"第一次");
    }

    @Test
    public void testQuery(){
        UserService service= (UserService) BeanFactory.getObject("userService");
        PageResult usersResult = service.getUsersWithConditionByPage(null, null, null,1);
        //3 页面索引数量
        PageIndex usersIndex = PageIndex.getPageIndex(3, 1, usersResult.getTotalPage());
        System.out.println(usersResult.getListData());

    }

    @Test
    public void getUsersByRoleId(){
        UserService service= (UserService) BeanFactory.getObject("userService");
        List<User> users = service.getUsersByRoleId(3);
        System.out.println(users.toString());
    }


}
