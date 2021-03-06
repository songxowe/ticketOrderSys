package com.ticketOrderSys.service;

import java.util.List;

import com.ticketOrderSys.dao.UserDao;
import com.ticketOrderSys.pojo.User;
import com.ticketOrderSys.utils.Pager;

public class UserServiceImpl implements UserService {

	UserDao userDao;

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	@Override
	public void add(User user) {
		this.userDao.add(user);
	}

	@Override
	public void modify(User user) {
		this.userDao.modify(user);
	}

	@Override
	public void remove(User user) {
		this.userDao.remove(user);
	}

	@Override
	public User find(Integer userid) {
		return this.userDao.find(userid);
	}

	@Override
	public List<User> find() {
		return this.userDao.find();
	}

	@Override
	public Pager<User> find(Integer page, Integer rows, String sort, String order, String username) {
		return this.userDao.find(page, rows, sort, order, username);
	}

	@Override
	public User find(String username) {
		return userDao.find(username);
	}

}
