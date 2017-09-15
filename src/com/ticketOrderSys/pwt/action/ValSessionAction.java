package com.ticketOrderSys.pwt.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.ticketOrderSys.pojo.User;

/**
 * 判断用户是否登录
 * 
 * @author Administrator
 *
 */
public class ValSessionAction {
	@SuppressWarnings("unused")
	private HttpServletRequest request;
	private HttpServletResponse response;
	private PrintWriter out;
	private HttpSession session;

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

	public String execute() {
		init();
		User u = (User) session.getAttribute("user");
		if (u == null) {
			out.println("0");
		} else {
			out.println("1");
		}
		System.out.println(u);
		out.close();
		return null;
	}
}
