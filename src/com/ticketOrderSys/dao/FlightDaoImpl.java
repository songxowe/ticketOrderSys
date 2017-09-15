package com.ticketOrderSys.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate4.HibernateCallback;
import org.springframework.orm.hibernate4.support.HibernateDaoSupport;

import com.ticketOrderSys.pojo.Flight;
import com.ticketOrderSys.utils.Pager;

public class FlightDaoImpl extends HibernateDaoSupport implements FlightDao {

	@Override
	public void add(Flight flight) {
		this.getHibernateTemplate().save(flight);
	}

	@Override
	public void modify(Flight flight) {
		this.getHibernateTemplate().update(flight);
	}

	@Override
	public void remove(Flight flight) {
		this.getHibernateTemplate().delete(flight);
	}

	@Override
	public Flight find(Integer fid) {
		return this.getHibernateTemplate().get(Flight.class, fid);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Flight> find() {
		return (List<Flight>) this.getHibernateTemplate().find("from Flight", new Object[] {});
	}

	@Override
	public Pager<Flight> find(final Integer page, final Integer rows, String sort, String order, final String fromCity,
			final String toCity, final String name, final String fromTime, final Integer flightType) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Calendar cal = Calendar.getInstance();
		String temphql = "from Flight where 1=1 and fromTime>sysdate ";
		if (flightType != null) {
			temphql += " and flighttype= :flightType ";
		}
		if (StringUtils.isNotBlank(name)) {
			temphql += " and name like :name ";
		}
		Date fromtimetemp = null;
		Date toTime = null;
		if (StringUtils.isNotBlank(fromTime)) {
			temphql += " and fromTime between :from_Time and :to_Time ";
			try {
				fromtimetemp = sdf.parse(fromTime + " 00:00:00");
				cal.setTime(fromtimetemp);
				cal.add(Calendar.DATE, 1);
				toTime = cal.getTime();
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		final Date to_Time = toTime;
		final Date from_Time = fromtimetemp;
		/*
		 * System.out.println("toTime= " + to_Time); System.out.println(
		 * "fromTime= " + from_Time);
		 */
		if (StringUtils.isNotBlank(fromCity)) {
			temphql += " and fromCity like :fromCity ";

		}

		if (StringUtils.isNotBlank(toCity)) {
			temphql += " and toCity like :toCity ";
		}
		// 排序
		temphql += " order by " + sort + " " + order;
		final String hql = temphql;
		return this.getHibernateTemplate().execute(new HibernateCallback<Pager<Flight>>() {
			@SuppressWarnings("unchecked")
			@Override
			public Pager<Flight> doInHibernate(Session session) throws HibernateException {
				Query query = session.createQuery(hql);
				if (flightType != null) {
					query.setInteger("flightType", flightType);
				}
				if (StringUtils.isNotBlank(name)) {
					query.setString("name", "%" + name + "%");
				}

				if (StringUtils.isNotBlank(fromTime)) {
					query.setDate("from_Time", from_Time);
					query.setDate("to_Time", to_Time);
				}

				if (StringUtils.isNotBlank(fromCity)) {
					query.setString("fromCity", "%" + fromCity + "%");
				}

				if (StringUtils.isNotBlank(toCity)) {
					query.setString("toCity", "%" + toCity + "%");
				}
				Pager<Flight> pager = new Pager<Flight>();
				pager.setTotal(query.list().size());
				// 用于分页
				query.setFirstResult((page - 1) * rows);
				query.setMaxResults(rows);
				pager.setRows(query.list());

				// for (Flight f : (List<Flight>) query.list()) {
				// System.out.println(
				// "name" + f.getName() + " " + "fromCity" + f.getFromcity() +
				// "toCity" + f.getTocity());
				// System.out.println(hql);
				// }
				return pager;

			}
		});
	}

}
