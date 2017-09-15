package com.ticketOrderSys.pojo;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Flight entity. @author MyEclipse Persistence Tools
 */

public class Flight implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	private Integer fid;
	private String name;
	private Integer flighttype;
	private String fromcity;
	private String tocity;
	private Date fromtime;
	private Date totime;
	private Double price;
	private Integer remainingseats;
	private Set<FlightOrder> orders = new HashSet<FlightOrder>(0);

	// Constructors

	public Flight() {
	}

	public Integer getFid() {
		return this.fid;
	}

	public void setFid(Integer fid) {
		this.fid = fid;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getFlighttype() {
		return this.flighttype;
	}

	public void setFlighttype(Integer flighttype) {
		this.flighttype = flighttype;
	}

	public String getFromcity() {
		return this.fromcity;
	}

	public void setFromcity(String fromcity) {
		this.fromcity = fromcity;
	}

	public String getTocity() {
		return this.tocity;
	}

	public void setTocity(String tocity) {
		this.tocity = tocity;
	}

	public Date getFromtime() {
		return this.fromtime;
	}

	public void setFromtime(Date fromtime) {
		this.fromtime = fromtime;
	}

	public Date getTotime() {
		return this.totime;
	}

	public void setTotime(Date totime) {
		this.totime = totime;
	}

	public Double getPrice() {
		return this.price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public Integer getRemainingseats() {
		return this.remainingseats;
	}

	public void setRemainingseats(Integer remainingseats) {
		this.remainingseats = remainingseats;
	}

	public Set<FlightOrder> getOrders() {
		return orders;
	}

	public void setOrders(Set<FlightOrder> orders) {
		this.orders = orders;
	}

}