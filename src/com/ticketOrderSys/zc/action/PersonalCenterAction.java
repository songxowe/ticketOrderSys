package com.ticketOrderSys.zc.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.math.NumberUtils;
import org.apache.struts2.ServletActionContext;

import com.ticketOrderSys.pojo.Flight;
import com.ticketOrderSys.pojo.FlightOrder;
import com.ticketOrderSys.pojo.User;
import com.ticketOrderSys.service.FlightOrderService;
import com.ticketOrderSys.service.FlightService;
import com.ticketOrderSys.service.UserService;
import com.ticketOrderSys.utils.JsonDateValueProcessor;
import com.ticketOrderSys.utils.Pager;
import com.ticketOrderSys.utils.UUID;

import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;
import net.sf.json.JsonConfig;
import net.sf.json.util.PropertyFilter;

public class PersonalCenterAction {
	private User user;// set() jsp->action get() action->jsp
	private FlightOrder flightOrder; // set() jsp->action get() action->jsp
	private List<FlightOrder> flightOrders; // get() action->jsp
	private Flight flight;

	private UserService userService;// set() 注入
	private FlightOrderService flightOrderService;
	private FlightService flightService;

	private HttpServletRequest request;
	private HttpServletResponse response;
	private PrintWriter out;
	public static HttpSession session;

	/**
	 * 初始化 request response out
	 */
	public void init() {
		// 1.获得request response 对象
		request = ServletActionContext.getRequest();
		response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
		session = request.getSession();
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 显示个人信息
	 */
	@SuppressWarnings({ "unchecked", "unused", "rawtypes" })
	public void find() {
		// 1.初始化
		init();

		// 2.接受参数
		User user = (User) session.getAttribute("user");
		String username = ((User) session.getAttribute("user")).getUsername();

		Pager<User> pager = new Pager();
		List<User> rows = new ArrayList<User>(0);
		rows.add(user);
		pager.setRows(rows);
		// 3.2 转换 json
		JsonConfig jsonConfig = new JsonConfig();
		// Json 日期格式化转换
		jsonConfig.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor());

		jsonConfig.setJsonPropertyFilter(new PropertyFilter() {

			@Override
			public boolean apply(Object source, String name, Object value) {
				// 过滤不在页面显示的列
				// if (name.equals("hiredate")) {
				// return true;
				// }
				return false;
			}
		});
		jsonConfig.setExcludes(new String[] { "orders" });// 除去orders属性
		JSONObject json = (JSONObject) JSONSerializer.toJSON(pager, jsonConfig);

		// 4.输出数据
		out.println(json);
		out.flush();
		out.close();
		// System.out.println(json);

	}

	/**
	 * 显示航班
	 * 
	 * @throws ParseException
	 */
	public void showPlane() throws ParseException {
		// 1.初始化
		init();

		// 2.接受参数

		Integer page = NumberUtils.createInteger(request.getParameter("page"));
		Integer rows = NumberUtils.createInteger(request.getParameter("rows"));
		String sort = request.getParameter("sort");
		String order = request.getParameter("order");

		String fromCity = request.getParameter("fromcity");
		String toCity = request.getParameter("tocity");
		Integer flightType = NumberUtils.createInteger(request.getParameter("flightType"));

		String fromTime = request.getParameter("fromtime");

		Pager<Flight> pager = flightService.find(page, rows, sort, order, fromCity, toCity, null, fromTime, flightType);
		System.out.println(" size:" + pager.getRows().size());

		// 3.2 转换 json
		JsonConfig jsonConfig = new JsonConfig();
		// Json 日期格式化转换
		jsonConfig.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor());

		jsonConfig.setJsonPropertyFilter(new PropertyFilter() {

			@Override
			public boolean apply(Object source, String name, Object value) {

				return false;
			}
		});
		jsonConfig.setExcludes(new String[] { "orders" });// 除去orders属性
		JSONObject json = (JSONObject) JSONSerializer.toJSON(pager, jsonConfig);

		// 4.输出数据
		out.println(json);
		System.out.println(json);

		out.flush();
		out.close();

	}

	/**
	 * 显示 用户订单
	 * 
	 * @return
	 */
	public String showOrder() {

		Integer userid = ((User) session.getAttribute("user")).getUserid();

		flightOrders = flightOrderService.find(userid);

		// System.out.println(flightOrders.size());

		return "showOrder";
	}

	/**
	 * 获得用户对象
	 * 
	 * @return
	 */
	public String findById() {
		init();
		// 2.接受参数
		Integer userid = ((User) session.getAttribute("user")).getUserid();
		// String userid = request.getParameter("userid");

		// System.out.println("userid:" + userid);
		user = userService.find(userid);

		return "findById";

	}

	/**
	 * 修改 个人信息
	 */
	public void modify() {
		init();
		userService.modify(user);
		session.setAttribute("user", user);
		out.println("修改");
		out.flush();
		out.close();
	}

	/**
	 * 退票 操作
	 * 
	 * @return
	 */
	public String remove() {
		init();
		Integer oid = NumberUtils.createInteger(request.getParameter("oid"));
		Integer num = NumberUtils.createInteger(request.getParameter("num"));
		Integer fid = NumberUtils.createInteger(request.getParameter("fid"));
		flightOrder = new FlightOrder();
		flightOrder.setOid(oid);
		flight = flightService.find(fid);
		Integer remainingSeats = flight.getRemainingseats() + num;
		flightOrderService.remove(flightOrder);
		flight.setRemainingseats(remainingSeats);
		flightService.modify(flight);
		out.println("ok");
		out.flush();
		out.close();
		return null;
	}

	/**
	 * 改签
	 */
	public void alteration() {
		// 1.初始化
		init();

		// 2.获得参数
		Integer oid = NumberUtils.createInteger(request.getParameter("oid"));
		Integer newfid = NumberUtils.createInteger(request.getParameter("newfid"));
		Integer oldfid = NumberUtils.createInteger(request.getParameter("oldfid"));
		Integer num = NumberUtils.createInteger(request.getParameter("num"));

		// 3.删除 已有订单 原航班机票数增加
		flightOrder = new FlightOrder();
		flightOrder.setOid(oid);
		flightOrderService.remove(flightOrder);
		flightOrder = null;

		Flight flight = flightService.find(oldfid);
		flight.setRemainingseats(flight.getRemainingseats() + num);
		flightService.modify(flight);

		// 4.生成新的定单 并且 新航班机票数减少
		flightOrder = new FlightOrder();
		User user = ((User) session.getAttribute("user"));
		flight = flightService.find(newfid);

		flightOrder.setNum(num);
		flightOrder.setOrderno(UUID.getUUID());
		flightOrder.setOrdertime(new Date());
		flightOrder.setTotalprice(flight.getPrice() * num);
		flightOrder.setUnitprice(flight.getPrice());
		flightOrder.setUser(user);
		flightOrder.setFlight(flight);

		flightOrderService.add(flightOrder);

		flight.setRemainingseats(flight.getRemainingseats() - num);
		flightService.modify(flight);

		// 5.返回值
		out.println("ok");
		out.flush();
		out.close();

	}

	/**
	 * 修改订单
	 * 
	 * @return
	 */
	public String modifyOrder() {
		flightOrderService.modify(flightOrder);

		return "modifyOrder";
	}

	public Flight getFlight() {
		return flight;
	}

	public void setFlight(Flight flight) {
		this.flight = flight;
	}

	/**
	 * spring 注入
	 * 
	 * @param userService
	 */
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	/**
	 * spring 注入
	 * 
	 * @param flightOrderService
	 */
	public void setFlightOrderService(FlightOrderService flightOrderService) {
		this.flightOrderService = flightOrderService;
	}

	/**
	 * spring 注入
	 * 
	 * @param flightService
	 */
	public void setFlightService(FlightService flightService) {
		this.flightService = flightService;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public FlightOrder getFlightOrder() {
		return flightOrder;
	}

	public void setFlightOrder(FlightOrder flightOrder) {
		this.flightOrder = flightOrder;
	}

	public List<FlightOrder> getFlightOrders() {
		return flightOrders;
	}

}
