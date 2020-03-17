package com.lcqjoyce.web.action;

import com.lcqjoyce.entity.Menu;
import com.lcqjoyce.entity.Role;
import com.lcqjoyce.service.MenuService;
import com.lcqjoyce.service.PermissionsService;
import com.lcqjoyce.service.RoleService;
import com.lcqjoyce.util.page.PageIndex;
import com.lcqjoyce.util.page.PageResult;
import net.sf.json.JSONArray;
import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * @author ：LCQJOYCE
 * @date ：Created in 2020/3/17 21:29
 * @description：
 * @version: $
 */
public class PermissionsAction {
    private static Logger logger = Logger.getLogger(PermissionsAction.class);
    private PermissionsService permissionsService;
    private RoleService roleService;
    private MenuService menuService;

    public void setMenuService(MenuService menuService) {
        this.menuService = menuService;
    }

    public void setRoleService(RoleService roleService) {
        this.roleService = roleService;
    }

    public void setPermissionsService(PermissionsService permissionsService) {
        this.permissionsService = permissionsService;
    }


    //获取role名字
    public String getAllRoleName(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String resultString = "success";
        List<Role> roles = roleService.getAllroles();
        PrintWriter out;
        try {
            out = response.getWriter();
            String json = JSONArray.fromObject(roles).toString();
            out.write(json);
            out.flush();
            out.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return resultString;
    }

    //获取role名字
    public String getAllMenu(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String resultString = "success";
        List<Menu> menus = menuService.getallMenus();
        PrintWriter out;
        try {
            out = response.getWriter();
            String json = JSONArray.fromObject(menus).toString();
            out.write(json);
            out.flush();
            out.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return resultString;
    }


    public String queryPermissions(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String roleId = request.getParameter("roleId");
        String menuId = request.getParameter("menuId");
        List<Menu> menus = menuService.getallMenus();
        List<Role> roles = roleService.getAllroles();
        Map<String, String> menuMap = new ConcurrentHashMap<>();
        Map<String, String> roleMap = new ConcurrentHashMap<>();
        for (Menu menu :
                menus) {
            menuMap.put(menu.getId().toString(),menu.getMenuName());
        }
        for (Role role :
                roles) {
            roleMap.put(role.getId().toString(),role.getRoleName());
        }

        Integer currentPage = 1;
        if (null != request.getParameter("currentPage") && !"".equals(request.getParameter("currentPage"))) {
            currentPage = Integer.valueOf(request.getParameter("currentPage").toString());
        }
        //holidayResult  获取成功
        PageResult permissionsResult = permissionsService.getPermissionsWithConditionByPage(roleId, menuId,currentPage);
        PageIndex permissionsIndex = PageIndex.getPageIndex(3,currentPage,permissionsResult.getTotalPage());
        logger.info(permissionsResult.getListData());
        request.setAttribute("permissionsResult",permissionsResult);
        request.setAttribute("permissionsIndex",permissionsIndex);
/*        request.setAttribute("empName",empName);
        request.setAttribute("holidayType",holidayType);
        request.setAttribute("holidayStatus",holidayStatus);*/
        request.setAttribute("menuMap",menuMap);
        request.setAttribute("roleMap",roleMap);
        return "success";
    }

}
