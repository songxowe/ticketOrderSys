package com.ticketOrderSys.service;

import java.util.List;

import com.ticketOrderSys.dao.FlightDao;
import com.ticketOrderSys.pojo.Flight;
import com.ticketOrderSys.utils.Pager;

public class FlightServiceImpl implements FlightService {

	private FlightDao flightDao;

	public void setFlightDao(FlightDao flightDao) {
		this.flightDao = flightDao;
	}

	@Override
	public void add(Flight flight) {
		this.flightDao.add(flight);
	}

	@Override
	public void modify(Flight flight) {
		this.flightDao.modify(flight);
	}

	@Override
	public void remove(Flight flight) {
		this.flightDao.remove(flight);
	}

	@Override
	public Flight find(Integer fid) {
		return this.flightDao.find(fid);
	}

	@Override
	public List<Flight> find() {
		return this.flightDao.find();
	}

	@Override
	public Pager<Flight> find(Integer page, Integer rows, String sort, String order, String fromCity, String toCity,
			String name, String fromTime, Integer flightType) {
		return this.flightDao.find(page, rows, sort, order, fromCity, toCity, name, fromTime, flightType);
	}

}
