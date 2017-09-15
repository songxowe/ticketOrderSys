package com.ticketOrderSys.dao;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate4.HibernateCallback;
import org.springframework.orm.hibernate4.support.HibernateDaoSupport;

import com.ticketOrderSys.pojo.FlightOrder;
import com.ticketOrderSys.utils.Pager;

public class FlightOrderDaoImpl extends HibernateDaoSupport implements FlightOrderDao {

	@Override
	public void add(FlightOrder flightOrder) {
		this.getHibernateTemplate().save(flightOrder);
	}

	@Override
	public void modify(FlightOrder flightOrder) {
		this.getHibernateTemplate().update(flightOrder);
	}

	@Override
	public void remove(FlightOrder flightOrder) {
		this.getHibernateTemplate().delete(flightOrder);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<FlightOrder> find() {
		return (List<FlightOrder>) this.getHibernateTemplate().find("from FlightOrder", new Object[] {});
	}

	@SuppressWarnings("rawtypes")
	@Override
	public Pager find(final Integer page, final Integer rows, String sort, String order, final String orderNo,
			final String username) {
		String temphql = "select fo.oid,fu.username,ff.name from FlightOrder fo left join fo.user fu left join fo.flight ff where 1=1 ";

		if (StringUtils.isNotBlank(orderNo)) {
			temphql += " and fo.orderNo = :orderNo ";
		}

		if (StringUtils.isNotBlank(username)) {
			temphql += " and fu.username like :username ";
		}

		// 排序
		temphql += " order by fo." + sort + " " + order;
		final String hql = temphql;
		return this.getHibernateTemplate().execute(new HibernateCallback<Pager<FlightOrder>>() {
			@SuppressWarnings("unchecked")
			@Override
			public Pager doInHibernate(Session session) throws HibernateException {
				Query query = session.createQuery(hql);
				if (StringUtils.isNotBlank(orderNo)) {
					query.setString("orderNo", orderNo);
				}

				if (StringUtils.isNotBlank(username)) {
					query.setString("username", "%" + username + "%");
				}
				Pager pager = new Pager();
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
	public List<FlightOrder> find(final String orderNo) {
		String temphql = " from FlightOrder where 1=1 ";
		if (StringUtils.isNotBlank(orderNo)) {
			temphql += " and orderno like :orderno ";
		}
		final String hql = temphql;
		return this.getHibernateTemplate().execute(new HibernateCallback<List<FlightOrder>>() {

			@SuppressWarnings("unchecked")
			@Override
			public List<FlightOrder> doInHibernate(Session session) throws HibernateException {
				Query query = session.createQuery(hql);
				if (StringUtils.isNotBlank(orderNo)) {
					query.setString("orderno", "%" + orderNo + "%");
				}
				return query.list();
			}
		});
	}

	@Override
	public List<FlightOrder> find(final Integer userid) {
		final String temphql = " from FlightOrder where userid = :userid";
		return this.getHibernateTemplate().execute(new HibernateCallback<List<FlightOrder>>() {
			@SuppressWarnings("unchecked")
			@Override
			public List<FlightOrder> doInHibernate(Session session) throws HibernateException {
				Query query = session.createQuery(temphql);
				query.setInteger("userid", userid);
				return query.list();
			}

		});
	}
}
