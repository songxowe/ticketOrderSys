package com.ticketOrderSys.lyt.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.math.NumberUtils;
import org.apache.struts2.ServletActionContext;

import com.ticketOrderSys.pojo.User;
import com.ticketOrderSys.service.UserService;
import com.ticketOrderSys.utils.Pager;

import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;
import net.sf.json.JsonConfig;

public class UserAction {
	private UserService userService;
	private User user;

	// 查询用户的方法
	public String list() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");

		try {
			PrintWriter out = response.getWriter();

			Integer page = NumberUtils.createInteger(request.getParameter("page"));
			Integer rows = NumberUtils.createInteger(request.getParameter("rows"));
			String sort = request.getParameter("sort");
			String order = request.getParameter("order");

			String username = request.getParameter("username");

			Pager<User> pager = userService.find(page, rows, sort, order, username);
			JsonConfig jsonConfig = new JsonConfig();

			jsonConfig.setExcludes(new String[] { "orders" });
			JSONObject json = (JSONObject) JSONSerializer.toJSON(pager, jsonConfig);
			out.println(json.toString());
			out.flush();
			out.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	// 保存用户的方法
	public String save() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");

		try {
			PrintWriter out = response.getWriter();

			Integer userid = NumberUtils.createInteger(request.getParameter("user[userid]"));
			String username = request.getParameter("user[username]");
			String password = request.getParameter("user[password]");
			String truename = request.getParameter("user[truename]");
			Integer sex = NumberUtils.createInteger(request.getParameter("user[sex]"));
			String idcard = request.getParameter("user[idcard]");
			String phone = request.getParameter("user[phone]");

			user = new User();
			user.setUserid(userid);
			user.setUsername(username);
			user.setPassword(password);
			user.setTruename(truename);
			user.setSex(sex);
			user.setIdcard(idcard);
			user.setPhone(phone);

			userService.modify(user);

			out.println(1);
			out.flush();
			out.close();

		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	// 删除用户的方法
	public String remove() {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");

		try {
			PrintWriter out = response.getWriter();
			String ids[] = request.getParameter("ids").split(",");
			for (int i = 0; i < ids.length; i++) {
				Integer userid = NumberUtils.createInteger(ids[i]);
				user = new User();
				System.out.println(ids.length);
				System.out.println("userid=:" + userid);
				user.setUserid(userid);
				userService.remove(user);
			}
			out.println(ids.length);
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

}
