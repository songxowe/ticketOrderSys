package com.ticketOrderSys.pwt.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.math.NumberUtils;
import org.apache.struts2.ServletActionContext;

import com.ticketOrderSys.pojo.Flight;
import com.ticketOrderSys.service.FlightService;
import com.ticketOrderSys.utils.JsonDateValueProcessor;
import com.ticketOrderSys.utils.Pager;

import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;
import net.sf.json.JsonConfig;
import net.sf.json.util.PropertyFilter;

public class FlightAction {

	private FlightService flightService;

	private Flight flight;
	private HttpServletRequest request;
	private HttpServletResponse response;
	private PrintWriter out;
	@SuppressWarnings("unused")
	private HttpSession session;

	public Flight getFlight() {
		return flight;
	}

	public void setFlight(Flight flight) {
		this.flight = flight;
	}

	public void setFlightService(FlightService flightService) {
		this.flightService = flightService;
	}

	/**
	 * 初始化
	 */
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
	 * 显示航班
	 * 
	 * @return
	 * @throws ParseException
	 */
	public String list() throws ParseException {
		init();
		// 获得easyui的参数和条件查询的参数
		Integer page = NumberUtils.createInteger(request.getParameter("page"));
		Integer rows = NumberUtils.createInteger(request.getParameter("rows"));
		String sort = request.getParameter("sort");
		String order = request.getParameter("order");
		String name = request.getParameter("name");
		String fromCity = request.getParameter("fromCity");
		String toCity = request.getParameter("toCity");
		String fromTime = request.getParameter("fromTime");
		Integer flightType = NumberUtils.createInteger(request.getParameter("flightType"));
		System.out.println("adkjslkdjsjdklsa");
		System.out.println("fromTime" + fromTime);
		// 获得查询结果集
		Pager<Flight> pager = flightService.find(page, rows, sort, order, fromCity, toCity, name, fromTime, flightType);
		// 把结果集转换为json
		JsonConfig jsonConfig = new JsonConfig();
		// Json 日期格式化转换
		jsonConfig.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor("yyyy-MM-dd HH:mm:ss"));

		jsonConfig.setJsonPropertyFilter(new PropertyFilter() {

			@Override
			public boolean apply(Object source, String name, Object value) { // 过滤不在页面显示的列
				return false;
			}
		});
		// 设置不包含的字段
		jsonConfig.setExcludes(new String[] { "orders" });// 关闭关联
		JSONObject json = (JSONObject) JSONSerializer.toJSON(pager, jsonConfig);
		// 5.把 json数据写入至客户端
		out.println(json.toString());
		out.close();
		return null;
	}
}
