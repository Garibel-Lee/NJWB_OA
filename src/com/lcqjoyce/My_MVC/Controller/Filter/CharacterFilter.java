package com.lcqjoyce.My_MVC.Controller.Filter;

import org.apache.log4j.Logger;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

//过滤器就是一个servlet，只不过，它会被服务器在执行相应的请求前调用
public class CharacterFilter implements Filter {
	private static Logger logger = Logger.getLogger(CharacterFilter.class);
	
	public void destroy() {
		// 销毁方法
		logger.debug("CharacterFilter.class调用销毁方法");
		//System.out.println("CharacterFilter.class调用销毁方法");
	}	
	/**
	 * req request对象
	 * res response对象
	 * chain 过滤器链的对象，（调用其他过滤器）
	 */
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
			throws IOException, ServletException {
		// 执行多次的过滤方法
		logger.debug("CharacterFilter.class调用过滤方法");
		//System.out.println("CharacterFilter.class调用过滤方法");
		//为什么要强转，方法更多，功能更多
		HttpServletRequest request = (HttpServletRequest)req;
		HttpServletResponse response = (HttpServletResponse)res;
		//判断是get请求还是Post请求
		if("get".equalsIgnoreCase(request.getMethod())){
			//request.getMethod() //获得请求方式
			request = new MyRequest(request);//创建自己的对象
		}if("post".equalsIgnoreCase(request.getMethod())){
			//设置字符集
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			response.setContentType("text/html;charset=utf8");
		}
		//如何通过过滤器
		chain.doFilter(request, response);
	}
	private String from = null;// 原始字符集
	private String to = null; //新的字符集
	public void init(FilterConfig config) throws ServletException {
		// 初始化方法
		logger.debug("CharacterFilter.class调用初始化方法");
		//System.out.println("CharacterFilter.class调用初始化方法");
		from = config.getInitParameter("oldCharacter");
		to = config.getInitParameter("newCharacter");
	}

	class MyRequest extends HttpServletRequestWrapper{
		private Logger logger2 = Logger.getLogger(MyRequest.class);
		HttpServletRequest request = null;
		public MyRequest(HttpServletRequest request) {
			super(request);
			this.request = request;
		}
		//获得一个值
		@Override
		public String getParameter(String name) {
			logger2.debug("MyRequest.class的getParameter方法");
			String result=null ;
			String other = request.getParameter(name);
			if(null != other){
				try {
					//实现的转码
					result = new String(other.getBytes(from),to);
				} catch (UnsupportedEncodingException e) {
					logger2.warn("MyRequest.class的getParameter方法的字符转换异常");
					e.printStackTrace();
				}
			}
			return result;
		}
		@Override
		public String[] getParameterValues(String name) {
			logger2.debug("MyRequest.class的getParameterValues方法");
			String[] values = request.getParameterValues(name);
			//循环集合中的所有内容
			if(null!=values){
				for (int i = 0; i < values.length; i++) {
					try {
						values[i]=new String(values[i].getBytes(from),to);
					} catch (UnsupportedEncodingException e) {
						logger2.warn("MyRequest.class的getParameterValues方法的字符转换异常");
						e.printStackTrace();
					}
				}
			}
			return values ;
		}
		
	}
	
}
