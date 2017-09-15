package com.ticketOrderSys.service;

import java.util.List;

import com.ticketOrderSys.pojo.User;
import com.ticketOrderSys.utils.Pager;

public interface UserService {

	void add(User user);

	void modify(User user);

	void remove(User user);

	User find(Integer userid);

	User find(String username);

	List<User> find();

	Pager<User> find(Integer page, Integer rows, String sort, String order, String username);
}
