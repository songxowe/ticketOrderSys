package com.ticketOrderSys.service;

import java.util.List;

import com.ticketOrderSys.dao.FlightOrderDao;
import com.ticketOrderSys.pojo.FlightOrder;
import com.ticketOrderSys.utils.Pager;

public class FlightOrderServiceImpl implements FlightOrderService {

	private FlightOrderDao flightOrderDao;

	public void setFlightOrderDao(FlightOrderDao flightOrderDao) {
		this.flightOrderDao = flightOrderDao;
	}

	@Override
	public void add(FlightOrder flightOrder) {
		this.flightOrderDao.add(flightOrder);
	}

	@Override
	public void modify(FlightOrder flightOrder) {
		this.flightOrderDao.modify(flightOrder);
	}

	@Override
	public void remove(FlightOrder flightOrder) {
		this.flightOrderDao.remove(flightOrder);
	}

	@Override
	public List<FlightOrder> find() {
		return this.flightOrderDao.find();
	}

	@SuppressWarnings("rawtypes")
	@Override
	public Pager find(Integer page, Integer rows, String sort, String order, String orderNo, String username) {
		return this.flightOrderDao.find(page, rows, sort, order, orderNo, username);
	}

	@Override
	public List<FlightOrder> find(String orderNo) {
		return this.flightOrderDao.find(orderNo);
	}

	@Override
	public List<FlightOrder> find(Integer userid) {
		return this.flightOrderDao.find(userid);
	}

}
