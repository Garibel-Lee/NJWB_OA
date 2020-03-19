package com.lcqjoyce.web.action;

import com.lcqjoyce.entity.User;
import com.lcqjoyce.service.RoleService;
import com.lcqjoyce.service.UserService;
import com.lcqjoyce.util.page.PageIndex;
import com.lcqjoyce.util.page.PageResult;
import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 * @author ：LCQJOYCE
 * @date ：Created in 2020/3/15 14:13
 * @description：
 * @version: $
 */
public class RoleAction {
    private static Logger logger = Logger.getLogger(RoleAction.class);

    public void setRoleService(RoleService roleService) {
        this.roleService = roleService;
    }

    private RoleService roleService;

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    private UserService  userService;

    public String getAllRoles(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer currentPage = 1;
        if (null != request.getParameter("currentPage") && !"".equals(request.getParameter("currentPage"))) {
            currentPage = Integer.valueOf(request.getParameter("currentPage").toString());
        }
        //holidayResult  获取成功
        PageResult rolesResult = roleService.getRolesWithConditionByPage(currentPage);
        //3 页面索引数量
        PageIndex rolesIndex = PageIndex.getPageIndex(3, currentPage, rolesResult.getTotalPage());
        logger.info(rolesResult.getListData());
        //分页参数
        request.setAttribute("rolesResult", rolesResult);
        request.setAttribute("rolesIndex", rolesIndex);
        //查询参数无
        return "success";



    }


     //删除
    public String deleteRoleById(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer roleId = Integer.parseInt(request.getParameter("roleId"));
        List<User> users = userService.getUsersByRoleId(roleId);
        logger.info("userService.getUsersByRoleId(roleId)"+users.toString());
            if(users.size() != 0){
            PrintWriter out;
            try {
                out = response.getWriter();
                String errorMessage = "该角色下还有用户关联，不允许删除！";
                out.write(errorMessage);
                out.flush();
                out.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
            return "success";
        }else{
            roleService.deleteRoleById(roleId);
            return "success";
        }
    }



/*    public String addRole(HttpServletRequest request,HttpServletResponse response){
        String roleName = request.getParameter("roleName");
        List<Role> roles = roleService.getRoleByRoleName(roleName);
        if(roles.size() == 0){
            roleService.addRole(roleName);
            return "success";
        }else{
            request.setAttribute("isError", true);
            request.setAttribute("errorMessage", "添加角色失败：角色名已存在！");
            return "fail";
        }
    }*/

}
