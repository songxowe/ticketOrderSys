package com.ticketOrderSys.dao;


import java.util.List;

import com.ticketOrderSys.pojo.Admin;




public interface AdminDao {

	
	//修改管理员
	void modify(Admin admin);

	
	//id  获得管理员
	Admin findById(Integer aid);

	//获得list
	List<Admin> find();

	
}
