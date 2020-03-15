package com.lcqjoyce.My_MVC.Controller.Filter;

/**
 * @author ：LCQJOYCE
 * @date ：Created in 2020/3/15 8:57
 * @description：做一session 过滤器没有user session 跳转
 * @version: $
 */

import com.lcqjoyce.entity.User;
import org.apache.log4j.Logger;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;


public class AccessFilter implements Filter {
    private static Logger logger = Logger.getLogger(AccessFilter.class);

    @Override
    public void destroy() {
        // TODO Auto-generated method stub
        logger.debug("AccessFilter.class调用销毁方法");
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
            throws IOException, ServletException {
        logger.debug("AccessFilter.class调用过滤方法");
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;

        String urlPath = request.getServletPath();
        logger.info("urlPath:" + urlPath);

        String spath = request.getServletPath();
        System.out.println("request.getContextPath()" + request.getContextPath());
        //不需要过滤的url
        String[] urls = {"/login", "/json", ".js", ".css", ".ico", ".jpg", ".png"};

        for (String str : urls) {
            if (spath.indexOf(str) != -1) {
                chain.doFilter(req, resp);
            }
        }

        if (urlPath.indexOf("login.jsp") == -1 && urlPath.indexOf("login.do") == -1) {
            logger.info("该请求不放行进行检查！");
            HttpSession session = request.getSession();
            if (null == (User) session.getAttribute("user")) {
                response.sendRedirect("njwb/login.jsp");
                return;

            } else {
                chain.doFilter(req, resp);
            }
        }
        chain.doFilter(req, resp);

    }

    @Override
    public void init(FilterConfig arg0) throws ServletException {
        // TODO Auto-generated method stub

    }

}
