package com.ticketOrderSys.pwt.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.math.NumberUtils;
import org.apache.struts2.ServletActionContext;

import com.ticketOrderSys.pojo.User;
import com.ticketOrderSys.service.UserService;

/**
 * 用户action
 * 
 * @author Administrator
 *
 */
public class UserPwtAction {

	private UserService userService;
	private HttpServletRequest request;
	private HttpServletResponse response;
	private PrintWriter out;
	private HttpSession session;

	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public void init() {
		request = ServletActionContext.getRequest();
		response = ServletActionContext.getResponse();
		session = ServletActionContext.getRequest().getSession();
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 用户登录
	 * 
	 * @return
	 */
	public String login() {
		init();
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		System.out.println("username=" + username);
		User user = userService.find(username);
		if (user == null) {
			out.println("用户名不存在!");
		} else if (!(password.equals(user.getPassword()))) {
			out.println("密码错误!");
		} else {
			session.setAttribute("user", user);
			out.println("登录成功!");
		}
		out.close();
		return null;
	}

	/**
	 * 用户注销
	 * 
	 * @return
	 */
	public String logout() {
		init();
		session.removeAttribute("user");
		out.println(1);
		return null;

	}

	/**
	 * 用户注册
	 * 
	 * @return
	 */
	public String register() {
		init();
		String username = request.getParameter("regUsername");
		String password = request.getParameter("regPassword");
		Integer sex = NumberUtils.createInteger(request.getParameter("sex"));
		String realName = request.getParameter("realName");
		String idCard = request.getParameter("idCard");
		String phone = request.getParameter("phone");
		System.out.println(username);
		System.out.println(password);
		System.out.println(sex);
		System.out.println(realName);
		System.out.println(idCard);
		System.out.println(phone);
		User user = new User();
		user.setUsername(username);
		user.setPassword(password);
		user.setSex(sex);
		user.setTruename(realName);
		user.setIdcard(idCard);
		user.setPhone(phone);
		userService.add(user);
		out.println("注册成功!");
		out.flush();
		out.close();
		return null;
	}

	/**
	 * 注册时验证用户名是否存在
	 * 
	 * @return
	 */
	public String validateUsername() {
		init();
		String regUsername = request.getParameter("regUsername");
		User u = userService.find(regUsername);
		if (u == null) {
			out.println("ok");
		} else {
			out.println("exist");
		}
		out.close();
		return null;
	}
}
