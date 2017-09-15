package com.ticketOrderSys.dao;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate4.HibernateCallback;
import org.springframework.orm.hibernate4.support.HibernateDaoSupport;

import com.ticketOrderSys.pojo.User;
import com.ticketOrderSys.utils.Pager;

public class UserDaoImpl extends HibernateDaoSupport implements UserDao {

	@Override
	public void add(User user) {
		this.getHibernateTemplate().save(user);
	}

	@Override
	public void modify(User user) {
		this.getHibernateTemplate().update(user);
	}

	@Override
	public void remove(User user) {
		this.getHibernateTemplate().delete(user);
	}

	@Override
	public User find(Integer userid) {
		return this.getHibernateTemplate().get(User.class, userid);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<User> find() {
		return (List<User>) this.getHibernateTemplate().find("from User", new Object[] {});
	}

	@Override
	public Pager<User> find(final Integer page, final Integer rows, String sort, String order, final String username) {
		String temphql = "from User where 1=1 ";
		if (StringUtils.isNotBlank(username)) {
			temphql += " and username like :username ";
		}
		// 排序
		temphql += " order by " + sort + " " + order;
		final String hql = temphql;

		return this.getHibernateTemplate().execute(new HibernateCallback<Pager<User>>() {
			@SuppressWarnings("unchecked")
			@Override
			public Pager<User> doInHibernate(Session session) throws HibernateException {
				Query query = session.createQuery(hql);
				if (StringUtils.isNotBlank(username)) {
					query.setString("username", "%" + username + "%");
				}
				Pager<User> pager = new Pager<User>();
				pager.setTotal(query.list().size());
				// 用于分页
				query.setFirstResult((page - 1) * rows);
				query.setMaxResults(rows);
				pager.setRows(query.list());
				return pager;

			}
		});
	}

	@Override
	public User find(final String username) {
		String hqltemp = "from User where 1=1 ";
		if (StringUtils.isNotBlank(username)) {
			hqltemp += " and username = :username ";
		}
		final String hql = hqltemp;
		return this.getHibernateTemplate().execute(new HibernateCallback<User>() {
			@Override
			public User doInHibernate(Session session) throws HibernateException {
				Query query = session.createQuery(hql);
				if (StringUtils.isNotBlank(username)) {
					query.setString("username", username);
				} else {
					return null;
				}
				System.out.println(query.list().size());
				return query.list().size() == 0 ? null : (User) query.list().get(0);
			}
		});
	}

}
