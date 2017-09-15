package com.ticketOrderSys.service;

import java.util.List;

import com.ticketOrderSys.dao.AdminDao;
import com.ticketOrderSys.pojo.Admin;

public class AdminServiceImpl implements AdminService {
	private AdminDao adminDao;

	@Override
	public void modify(Admin admin) {
		adminDao.modify(admin);
	}

	@Override
	public Admin findById(Integer aid) {
		return adminDao.findById(aid);
	}

	@Override
	public List<Admin> find() {
		return adminDao.find();
	}

	public void setAdminDao(AdminDao adminDao) {
		this.adminDao = adminDao;
	}

}
