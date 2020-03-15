package com.lcqjoyce.service;

import com.lcqjoyce.My_JDBC.Init.BeanFactory;
import com.lcqjoyce.entity.User;
import org.junit.Test;

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
}
