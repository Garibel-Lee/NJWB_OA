package com.lcqjoyce.web.action;

import com.lcqjoyce.entity.Menu;
import com.lcqjoyce.entity.User;
import com.lcqjoyce.service.PermissionsService;
import com.lcqjoyce.service.RoleService;
import com.lcqjoyce.service.UserService;
import com.lcqjoyce.util.MD5;
import com.lcqjoyce.util.page.PageIndex;
import com.lcqjoyce.util.page.PageResult;
import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * @author ：LCQJOYCE
 * @date ：Created in 2020/3/13 17:03
 * @description：
 * @version: $
 */
public class UserAction {

    private static Logger logger = Logger.getLogger(UserAction.class);
    UserService userService;
    RoleService roleService;
    PermissionsService permissionsService;

    public void setPermissionsService(PermissionsService permissionsService) {
        this.permissionsService = permissionsService;
    }

    public void setRoleService(RoleService roleService) {
        this.roleService = roleService;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }


    public String ajaxloginName(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String resultString = "success";
        String name = request.getParameter("name");
        logger.info("验证用户名是否   存在");
        System.out.println(name);
        User user = userService.getUserByName(name);
        if (null == user) {
            resultString = "fail";
            logger.info("验证用户名不存在");
        } else logger.info("验证用户名存在");
        return resultString;
    }


    //登录代码&权限控制
    public String login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String resultString = "";
        logger.debug("执行UserAction类的login方法");
        //通过名称获得提交的数据
        String name = request.getParameter("userName");
        String pwd = request.getParameter("userPwd");
        User user = new User();
        user.setUserAccount(name);
        user.setUserPwd(MD5.encode(pwd));
        User result = userService.login(user);
        logger.info(result.toString());
        // 请求转发
        if (null != result) { //成功
            Map<Menu, List<Menu>> re = permissionsService.listAll(result.getRoleId());
            request.setAttribute("roleMap", re);
            request.getSession().setAttribute("user", result);//放置session
            resultString = "success";
        } else {
            resultString = "fail";
        }
        System.out.println("自定义mvc解析并处理成功");
        return resultString;
    }

    //注册
    public String regist(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("自定义mvc的注册功能");
        String resultString = "";
        String name = request.getParameter("userName");
        String pwd = request.getParameter("userPwd");
        //获得一组爱好
        User user = new User();

        user.setUserAccount(name);
        user.setUserPwd(MD5.encode(pwd));

        int count = userService.insert(user);
        if (count == 1) {
            resultString = "success";
        } else {
            resultString = "fail";
        }
        return resultString;
    }

    /*权限控制*/
    public String roleController(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       /* User user=(User)request.getSession().getAttribute("user");
        PermissionsService PermissionsService=new PermissionsServiceImpl();
        Map<Menu, List<Menu>> re= PermissionsService.listAll(user.getRoleId());
        request.setAttribute("roleMap",re);*/
        return "";
    }

    public String loginOut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getSession().removeAttribute("user");
        return "success";
    }


    public String queryUsers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userAccount = request.getParameter("userAccount");
        String residueTimes = request.getParameter("residueTimes");
        String roleId = request.getParameter("roleId");


        Integer currentPage = 1;
        if (null != request.getParameter("currentPage") && !"".equals(request.getParameter("currentPage"))) {
            currentPage = Integer.valueOf(request.getParameter("currentPage").toString());
        }
        //holidayResult  获取成功
        PageResult usersResult = userService.getUsersWithConditionByPage(userAccount, residueTimes, roleId,currentPage);
        //3 页面索引数量
        PageIndex usersIndex = PageIndex.getPageIndex(3, currentPage, usersResult.getTotalPage());
        logger.info(usersResult.getListData());
        //分页参数
        request.setAttribute("usersResult", usersResult);
        request.setAttribute("usersIndex", usersIndex);
        //查询参数
        request.setAttribute("userAccount", userAccount);
        request.setAttribute("residueTimes", residueTimes);
        request.setAttribute("roleId", roleId);
        return "success";
    }


    //修改密码
    public String resetPwd(HttpServletRequest request, HttpServletResponse resp){
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        logger.info(oldPassword+"&&&"+newPassword);
        //获取登录的用户信息
        HttpSession session = request.getSession();
        User loginUser = (User) session.getAttribute("user");
        //通过登录的用户ID和旧密码查找用户
        User user = userService.selectUserByIdAndPwd(loginUser.getId(),MD5.encode(oldPassword));
        //找到旧密码
        if(user.getId() != null){
            userService.updateUserByPwd(loginUser.getId(),MD5.encode(newPassword));
            session.removeAttribute("user");
            return "success";
        }else{

            return "fail";
        }
    }

   public String addUser(HttpServletRequest request, HttpServletResponse resp){
        String userAccount = request.getParameter("userAccount");
        //生成账号密码一致
        String userPwd = request.getParameter("userAccount");
        String empNo = request.getParameter("empNo");
        String userStatus = request.getParameter("userStatus");
        String roleId = request.getParameter("roleId");

        //获取登录的用户信息
        User user=new User();
       user.setUserAccount(userAccount);
       user.setUserPwd(MD5.encode(userPwd));
       user.setEmpNo(empNo);
       user.setResidueTimes(Integer.valueOf(userStatus));
       user.setRoleId(Integer.valueOf(roleId));

       int count=userService.addUser(user);
        if(count==1)
            return "success";
        return "faill";
    }


    public String deleteUserById(HttpServletRequest request, HttpServletResponse resp){
        Integer userId = Integer.parseInt(request.getParameter("userId"));

        User user = userService.getUserById(userId);
        int count=userService.delete(user);
        if(count==1)
            return "success";
        return "fail";
    }



}
