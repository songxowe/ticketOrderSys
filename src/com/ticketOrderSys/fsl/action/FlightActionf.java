package com.ticketOrderSys.fsl.action;

import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.math.NumberUtils;
import org.apache.struts2.ServletActionContext;

import com.ticketOrderSys.pojo.Flight;
import com.ticketOrderSys.service.FlightService;
import com.ticketOrderSys.utils.JsonDateValueProcessor;
import com.ticketOrderSys.utils.Pager;

import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;
import net.sf.json.JsonConfig;

/**
 * action
 * 
 * @author Administrator
 *
 */

public class FlightActionf {
	private FlightService flightService;
	private Flight flight;

	/**
	 * 修改
	 * 
	 * @return
	 */
	public String modify() {
		if (flight != null) {
			flightService.modify(flight);
			flight = null;
		}
		return "modify";
	}

	public String findById() {
		System.out.println(flight.getFid());
		if (flight != null) {
			flight = flightService.find(flight.getFid());
		}
		return "findById";
	}

	/**
	 *
	 * 获得分页，加载数据，模糊查询
	 */

	public void list() {

		// 获得对象
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");

		try {
			PrintWriter out = response.getWriter();

			// 2.获得easyui 分页参数和条件查询参数
			Integer page = NumberUtils.createInteger(request.getParameter("page"));
			Integer rows = NumberUtils.createInteger(request.getParameter("rows"));
			String sort = request.getParameter("sort");
			String order = request.getParameter("order");

			String name = request.getParameter("name");
			String fromCity = request.getParameter("fromCity");
			String toCity = request.getParameter("toCity");
			String fromTime = request.getParameter("fromtime");
			Integer flightType = NumberUtils.createInteger(request.getParameter("flightType"));
			// 3.获得分页结果集
			Pager<Flight> pager = flightService.find(page, rows, sort, order, fromCity, toCity, name, fromTime,
					flightType);

			// 4.把分页结果集转换为 json
			JsonConfig jsonConfig = new JsonConfig();
			jsonConfig.registerJsonValueProcessor(Date.class, new JsonDateValueProcessor("yyyy-MM-dd HH:mm:ss"));

			jsonConfig.setExcludes(new String[] { "orders" });// 关闭关联
			JSONObject json = (JSONObject) JSONSerializer.toJSON(pager, jsonConfig);

			// 5.把json数据写入至客户端
			out.println(json.toString());
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	/**
	 * 用于增加与修改
	 * 
	 * @return
	 */
	public String save() {
		// 1.获得 request/response 对象
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");

		try {
			PrintWriter out = response.getWriter();

			// 2.获得表单参数
			Integer fid = NumberUtils.createInteger(request.getParameter("flight.fid"));
			String name = request.getParameter("flight.name");
			Integer flighttype = NumberUtils.createInteger(request.getParameter("flight.flighttype"));
			String fromcity = request.getParameter("flight.fromcity");
			String tocity = request.getParameter("flight.tocity");
			Double price = NumberUtils.createDouble(request.getParameter("flight.price"));

			String fromTime = request.getParameter("flight.fromtime");
			String toTime = request.getParameter("flight.totime");

			// 处理转换日期的方法
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

			Date fromtime = new Date();
			Date totime = new Date();
			try {
				fromtime = sdf.parse(fromTime);
				totime = sdf.parse(toTime);
			} catch (ParseException e) {
				e.printStackTrace();
			}

			Integer remainingseats = NumberUtils.createInteger(request.getParameter("flight.remainingseats"));

			// 3.把表单数据封装至对象
			Flight flight = new Flight();
			flight.setFid(fid);
			flight.setName(name);
			flight.setFlighttype(flighttype);
			flight.setFromcity(fromcity);
			flight.setTocity(tocity);
			flight.setFromtime(fromtime);
			flight.setTotime(totime);
			flight.setPrice(price);
			flight.setRemainingseats(remainingseats);

			// 4.保存至数据库
			if (fid == null) { // 新增
				flightService.add(flight);
				out.print("新增");
			} else { // 修改
				flightService.modify(flight);
				out.print("修改");
			}

			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}

	/**
	 * 删除的方法
	 * 
	 * @return
	 */
	public String remove() {
		// 获得对象
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");

		try {
			PrintWriter out = response.getWriter();

			String[] ids = request.getParameter("ids").split(",");
			for (int i = 0; i < ids.length; i++) {
				Integer fid = NumberUtils.createInteger(ids[i]);
				Flight flight = new Flight();
				flight.setFid(fid);
				flightService.remove(flight);
			}
			out.println(ids.length);

			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public void setFlightService(FlightService flightService) {
		this.flightService = flightService;
	}

	public void setFlight(Flight flight) {
		this.flight = flight;
	}

	public Flight getFlight() {
		return flight;
	}

}
