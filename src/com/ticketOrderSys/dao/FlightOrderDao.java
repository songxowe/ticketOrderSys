package com.ticketOrderSys.dao;

import java.util.List;

import com.ticketOrderSys.pojo.FlightOrder;
import com.ticketOrderSys.utils.Pager;

public interface FlightOrderDao {

	void add(FlightOrder flightOrder);

	void modify(FlightOrder flightOrder);

	void remove(FlightOrder flightOrder);

	List<FlightOrder> find(Integer userid);

	List<FlightOrder> find();

	List<FlightOrder> find(String orderNo);

	@SuppressWarnings("rawtypes")
	Pager find(Integer page, Integer rows, String sort, String order, String orderNo, String username);

}
