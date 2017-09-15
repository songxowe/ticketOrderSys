package com.ticketOrderSys.lb.action;

import java.util.List;

import com.ticketOrderSys.pojo.FlightOrder;
import com.ticketOrderSys.service.FlightOrderService;

/**
 * 模糊查询，删除方法
 * 
 * @author Administrator
 *
 */
public class FlightOrderAction {
	private FlightOrder flightOrder;
	private List<FlightOrder> flightOrders;
	private FlightOrderService flightOrderService;

	/**
	 * 模糊查询
	 * 
	 * @return
	 */
	public String list() {
		// 判断对象是否为空
		if (flightOrder != null) {
			// System.out.println(flightOrder.getOrderno());

			flightOrders = flightOrderService.find(flightOrder.getOrderno());
		} else {
			flightOrders = flightOrderService.find();
		}
		return "list";
	}

	/**
	 * 删除方法
	 * 
	 * @return
	 */
	public String remove() {
		flightOrderService.remove(flightOrder);
		flightOrder = null;
		return "remove";
	}

	/**
	 * get,set方法
	 * 
	 * @return
	 */
	public FlightOrder getFlightOrder() {
		return flightOrder;
	}

	public void setFlightOrder(FlightOrder flightOrder) {
		this.flightOrder = flightOrder;
	}

	public List<FlightOrder> getFlightOrders() {
		return flightOrders;
	}

	public void setFlightOrderService(FlightOrderService flightOrderService) {
		this.flightOrderService = flightOrderService;
	}

}