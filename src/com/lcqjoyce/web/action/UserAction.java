package com.lcqjoyce.web.action;

import com.lcqjoyce.My_JDBC.Init.BeanFactory;
import com.lcqjoyce.entity.Menu;
import com.lcqjoyce.entity.User;
import com.lcqjoyce.service.PermissionsService;
import com.lcqjoyce.service.UserService;
import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * @author ：LCQJOYCE
 * @date ：Created in 2020/3/13 17:03
 * @description：
 * @version: $
 */
public class UserAction  {

    private static Logger logger = Logger.getLogger(UserAction.class);
    UserService userService ;

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    //登录代码&权限控制
    public String login(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        String resultString = "";
        logger.debug("执行UserAction类的login方法");
        //通过名称获得提交的数据
        String name=request.getParameter("userName");
        String pwd = request.getParameter("userPwd");
        User user = new User();
        user.setUserAccount(name);
        user.setUserPwd(pwd);
        User result = userService.login(user);
        // 请求转发

        PermissionsService PermissionsService=(PermissionsService) BeanFactory.getObject("permissionsService");
        Map<Menu, List<Menu>> re= PermissionsService.listAll(result.getRoleId());
        request.setAttribute("roleMap",re);


        if(null!=result){ //成功
            request.getSession().setAttribute("user", result);//放置session
            resultString="success";
        }else{
            resultString="fail";
        }
        System.out.println("自定义mvc解析并处理成功");
        return resultString;
    }
    //注册
    public String regist(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException{
        System.out.println("自定义mvc的注册功能");
        String resultString="";
        String name = request.getParameter("userName");
        String pwd = request.getParameter("userPwd");
        //获得一组爱好
        User user = new User();

        user.setUserAccount(name);
        user.setUserPwd(pwd);

        int count = userService.insert(user);
        if(count==1){
            resultString="success";
        }else{
            resultString="fail";
        }
        return resultString;
    }
    /*权限控制*/
    public String  roleController(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
       /* User user=(User)request.getSession().getAttribute("user");
        PermissionsService PermissionsService=new PermissionsServiceImpl();
        Map<Menu, List<Menu>> re= PermissionsService.listAll(user.getRoleId());
        request.setAttribute("roleMap",re);*/
        return "";
    }
    public String  loginOut(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        request.getSession().removeAttribute("user");
        return "success";
    }

}
