package com.ticketOrderSys.dao;

import java.util.List;

import org.springframework.orm.hibernate4.support.HibernateDaoSupport;

import com.ticketOrderSys.pojo.Admin;

public class AdminDaoImpl extends HibernateDaoSupport implements AdminDao {

	@Override
	public void modify(Admin admin) {
		this.getHibernateTemplate().update(admin);
	}

	@Override
	public Admin findById(Integer aid) {

		return this.getHibernateTemplate().get(Admin.class, aid);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Admin> find() {
		return (List<Admin>) this.getHibernateTemplate().find("from Admin", new Object[] {});
	}

}
