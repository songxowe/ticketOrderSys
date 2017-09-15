package com.ticketOrderSys.pojo;

import java.util.Date;

public class FlightOrder implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	private Integer oid;
	private String orderno;
	private Date ordertime;
	private Integer num;
	private Double totalprice;
	private Double unitprice;
	private User user;
	private Flight flight;

	/** default constructor */
	public FlightOrder() {
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public Integer getOid() {
		return this.oid;
	}

	public void setOid(Integer oid) {
		this.oid = oid;
	}

	public String getOrderno() {
		return this.orderno;
	}

	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}

	public Date getOrdertime() {
		return this.ordertime;
	}

	public void setOrdertime(Date ordertime) {
		this.ordertime = ordertime;
	}

	public Double getTotalprice() {
		return this.totalprice;
	}

	public void setTotalprice(Double totalprice) {
		this.totalprice = totalprice;
	}

	public Double getUnitprice() {
		return this.unitprice;
	}

	public void setUnitprice(Double unitprice) {
		this.unitprice = unitprice;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Flight getFlight() {
		return flight;
	}

	public void setFlight(Flight flight) {
		this.flight = flight;
	}

}