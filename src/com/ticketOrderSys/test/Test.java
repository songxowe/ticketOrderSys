package com.ticketOrderSys.test;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import org.junit.Before;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.ticketOrderSys.pojo.Flight;
import com.ticketOrderSys.pojo.FlightOrder;
import com.ticketOrderSys.pojo.User;
import com.ticketOrderSys.service.FlightOrderService;
import com.ticketOrderSys.service.FlightService;
import com.ticketOrderSys.service.UserService;
import com.ticketOrderSys.utils.Pager;
import com.ticketOrderSys.utils.UUID;

public class Test {
	private UserService userService;
	private FlightService flightService;
	private FlightOrderService flightOrderService;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	@SuppressWarnings("resource")
	@Before
	public void init() {
		ApplicationContext ctx = new ClassPathXmlApplicationContext("applicationContext.xml");
		userService = ctx.getBean("userService", UserService.class);
		flightService = ctx.getBean("flightService", FlightService.class);
		flightOrderService = ctx.getBean("flightOrderService", FlightOrderService.class);
	}

	@org.junit.Test
	public void addUser() {
		User u = new User();
		u.setUsername("mark");
		u.setIdcard("430181199912251122");
		u.setPassword("admin");
		u.setPhone("13888888888");
		u.setSex(1);
		u.setTruename("马克");
		userService.add(u);
	}

	@org.junit.Test
	public void addFlight() {
		Flight f = new Flight();

		f.setFlighttype(1);
		f.setFromcity("天津");
		f.setTocity("巴黎");
		f.setName("大西洋航空");
		f.setPrice(688d);
		f.setRemainingseats(80);
		try {
			f.setFromtime(sdf.parse("2016-08-26 13:20:22"));
			f.setTotime(sdf.parse("2016-08-26 15:20:22"));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		for (int i = 0; i < 5; i++) {
			flightService.add(f);
		}
	}

	@org.junit.Test
	public void addFlightOrder() {

		FlightOrder fo = new FlightOrder();
		fo.setNum(1);
		fo.setOrderno(UUID.getUUID());
		try {
			fo.setOrdertime(sdf.parse("2016-08-19 16:20:22"));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		fo.setTotalprice(888d);
		fo.setUnitprice(888d);
		User u = userService.find(1);
		Flight f = flightService.find(6);
		fo.setUser(u);
		fo.setFlight(f);
		flightOrderService.add(fo);

	}

	@org.junit.Test
	public void find() {
		List<User> users = userService.find();
		for (User u : users) {
			System.out.println(u.getUsername());
		}
	}

	@org.junit.Test
	public void findOrder() {
		List<FlightOrder> orders = flightOrderService.find();
		for (FlightOrder fo : orders) {
			System.out.println(sdf.format(fo.getOrdertime()));
		}
	}

	@org.junit.Test
	public void findOrderAt() {
		Pager p = flightOrderService.find(1, 3, "oid", "asc", null, "m");
		System.out.println(p.getTotal());
		for (int i = 0; i < p.getRows().size(); i++) {
			System.out.println(p.getRows().get(i));
		}
	}

	@org.junit.Test
	public void findFlightAt() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Pager<Flight> p = flightService.find(1, 2, "name", "asc", null, null, null, "2016-08-19", 0);
		for (int i = 0; i < p.getRows().size(); i++) {
			System.out.println(p.getRows().get(i));
		}
	}

	@org.junit.Test
	public void findUserByUsername() {
		User u = userService.find("zhangsan");
		System.out.println(u.getUsername());
		System.out.println(u.getPassword());
	}

	/*
	 * final Integer page, final Integer rows, String sort, String order, final
	 * String orderNo, final Integer userid
	 */
}
