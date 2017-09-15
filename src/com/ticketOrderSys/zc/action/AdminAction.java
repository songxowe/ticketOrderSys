package com.ticketOrderSys.zc.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.ticketOrderSys.pojo.Admin;
import com.ticketOrderSys.service.AdminService;

public class AdminAction {
	private AdminService adminService;

	private HttpServletRequest request;
	private HttpServletResponse response;
	public HttpSession session;
	private PrintWriter out;

	public void init() {
		// 1.获得request response 对象
		request = ServletActionContext.getRequest();
		response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
		session = request.getSession();
		try {
			out = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * 登录
	 * 
	 */
	public void login() {
		// 1.初始化
		init();
		// 2.获得参数
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		// System.out.println(username+" "+password);
		// 3.验证数据
		List<Admin> admins = adminService.find();
		Admin admin = admins.get(0);
		// System.out.println(admin.getUsername()+" "+admin.getPassword());
		if (admin.getUsername().equals(username)) {
			if (admin.getPassword().equals(password)) {
				session.setAttribute("admin", admin);
				out.println("ok");
			} else {
				out.println("passwordError");
			}
		} else {
			out.println("usernameError");
		}

		out.flush();
		out.close();
	}

	/**
	 * 修改密码
	 * 
	 * @param adminService
	 */
	public String resetPassword() {
		// 1.初始化
		init();
		// 2.获得参数
		String newpasword = request.getParameter("newpasword");
		String oldpassword = request.getParameter("oldpassword");
		// 3.验证
		List<Admin> admins = adminService.find();
		Admin admin = admins.get(0);
		// System.out.println(admin.getUsername()+" "+admin.getPassword());
		if (admin.getPassword().equals(oldpassword)) {
			admin.setPassword(newpasword);
			adminService.modify(admin);
			session.setAttribute("admin", admin);
			out.println("ok");
		} else {
			out.println("passwordError");
		}
		out.flush();
		out.close();

		return null;
	}

	/**
	 * 退出
	 * 
	 * @return
	 */
	public String exit() {
		init();
		session.removeAttribute("admin");
		return "exit";
	}

	/**
	 * set() 注入
	 * 
	 * @param adminService
	 */
	public void setAdminService(AdminService adminService) {
		this.adminService = adminService;
	}

}
