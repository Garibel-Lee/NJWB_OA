package com.lcqjoyce.My_MVC.Controller.Filter;

import org.apache.log4j.Logger;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class AuthorityFilter implements Filter {
	private static Logger logger = Logger.getLogger(AuthorityFilter.class);
	private List<String> list = null; 
	public void destroy() {
		// TODO Auto-generated method stub

	}

	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest)req;
		HttpServletResponse response = (HttpServletResponse)res;
		String uri = request.getRequestURI();
		//  /web001/   /web001/ImageJsp.jsp
		//从最后一个斜杠截取，如果截取后字符串在集合中，直接放行，否则要进行是否登录的验证
		//System.out.println(uri);
		uri = uri.substring(uri.lastIndexOf("/"));
		boolean isValidate = true;//假设需要验证
		if(list.contains(uri)){
			isValidate = false;
		}
		if(isValidate){
			//就要验证(1)获得session中的变量，如果不是null，就可以请求下一个过滤器，如果是null，返回登录或注册页面
			HttpSession session = request.getSession();
			if(null == session.getAttribute("user")){
				response.sendRedirect("/jsp_day20/login.jsp");
			}else{
				//就可以请求下一个过滤器
				chain.doFilter(request, response);
			}
			
		}else{
			//不要验证， 调用下一个过滤器
			chain.doFilter(request, response);
		}
		

	}

	public void init(FilterConfig arg0) throws ServletException {
		//初始化时，获得解析成功过权限集合
		logger.debug("获取权限解析后的集合");
		list = AuthorityParse.getAuthorityList();

	}

}
