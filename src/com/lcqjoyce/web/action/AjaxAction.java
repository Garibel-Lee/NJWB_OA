/*
package com.lcqjoyce.web.action;

import com.lcqjoyce.entity.User;
import com.lcqjoyce.service.UserService;
import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


public class Aja4xAction {
	private static Logger logger = Logger.getLogger(AjaxAction.class);
	private UserService userService;
	
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	//验证用户名是否存在
	public String ajaxloginName(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException{
		String resultString="success";
		String name = request.getParameter("name");
		logger.info("验证用户名是否存在");
		System.out.println(name);
		User user = userService.getUserByName(name);
		if(null==user){
			resultString = "fail";
			logger.info("验证用户名不存在");
		}else 	logger.info("验证用户名存在");
		return resultString;
	}
	
}
*/
