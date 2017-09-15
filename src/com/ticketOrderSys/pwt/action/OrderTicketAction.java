package com.ticketOrderSys.pwt.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

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
import com.ticketOrderSys.utils.UUID;

public class OrderTicketAction {

	private Flight flight;
	private FlightService flightService;
	private UserService userService;
	private FlightOrderService flightOrderService;
	private HttpServletRequest request;
	private HttpServletResponse response;
	private SimpleDateFormat sdf;
	private PrintWriter out;
	private HttpSession session;

	public Flight getFlight() {
		return flight;
	}

	public void setFlight(Flight flight) {
		this.flight = flight;
	}

	public void setFlightOrderService(FlightOrderService flightOrderService) {
		this.flightOrderService = flightOrderService;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public void setFlightService(FlightService flightService) {
		this.flightService = flightService;
	}

	public void init() {
		request = ServletActionContext.getRequest();
		response = ServletActionContext.getResponse();
		session = request.getSession();
		sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 生成订单
	 * 
	 * @return
	 * @throws ParseException
	 */
	public String createOrder() throws ParseException {
		init();
		response.setContentType("text/html; charset=UTF-8");
		String orderno = UUID.getUUID();
		Date ordertime = sdf.parse(sdf.format(new Date()));
		Integer num = NumberUtils.createInteger(request.getParameter("num"));
		Double unitprice = NumberUtils.createDouble(request.getParameter("unitprice"));
		Double totalprice = NumberUtils.createDouble(request.getParameter("totalprice"));
		User user = (User) session.getAttribute("user");
		Flight flight = flightService.find(NumberUtils.createInteger(request.getParameter("fid")));
		flight.setRemainingseats(flight.getRemainingseats() - num);
		System.out.println("剩余座位" + flight.getRemainingseats());
		FlightOrder flightOrder = new FlightOrder();
		flightOrder.setOrderno(orderno);
		flightOrder.setOrdertime(ordertime);
		flightOrder.setNum(num);
		flightOrder.setUnitprice(unitprice);
		flightOrder.setTotalprice(totalprice);
		flightOrder.setUser(user);
		flightOrder.setFlight(flight);
		flightOrderService.add(flightOrder);
		out.println(num);
		out.close();
		return null;
	}

	/**
	 * 购买机票
	 * 
	 * @return
	 */
	public String buyOrders() {
		init();
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		Integer fid = NumberUtils.createInteger(request.getParameter("fid"));

		if (fid != null) {
			flight = flightService.find(fid);
			System.out.println(fid);
		}
		return "order";
	}

}
