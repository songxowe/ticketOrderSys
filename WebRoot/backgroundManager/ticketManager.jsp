<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title>航班订单管理系统</title>
</head>
<body style="background-color: #F5F6F7">
	<br />
	<br />
	<br />
	<form action="flightOrderAction_list" method="post" name="f"
		align="left">
		<input name="flightOrder.orderno" placeholder="订单编号" type="text" /> <input
			name="flightOrder.user.username" placeholder="用户名" type="text" /> <input
			value="查询" type="submit" />
	</form>
	<br />
	<div class="div1">
		<table border="1" align="center"
			style="border-color:#c0c0c0;width:100%;hight:800px;border-spacing:0;">
			<tr style="background-color: #D4E6F0;">
				<th>序号</th>
				<th>订单编号</th>
				<th>订单时间</th>
				<th>航班名称</th>
				<th>用户名</th>
				<th>订购数量</th>
				<th>票价</th>
				<th>总价</th>
				<th>操作</th>
			</tr>
			<s:iterator var="flightOrder" value="flightOrders" status="rows">
				<tr style="border:0.5px">
					<th><s:property value="#rows.index+1" /></th>
					<th><s:property value="#flightOrder.orderno" /></th>
					<th><s:date name="#flightOrder.ordertime"
							format="yyyy-MM-dd HH:mm:ss" /></th>
					<th><s:property value="#flightOrder.flight.name" /></th>
					<th><s:property value="#flightOrder.user.username" /></th>
					<th><s:property value="#flightOrder.num" /></th>
					<th><s:property value="#flightOrder.totalprice" /></th>
					<th><s:property
							value="(#flightOrder.totalprice)*(#flightOrder.num)" /></th>
					<th><s:url var="removeUrl" action="flightOrderAction_remove">
							<s:param name="flightOrder.oid" value="#flightOrder.oid" />
						</s:url> <s:a href="%{removeUrl}" onclick="return confirm('是否确认删除?')">删除</s:a>
					</th>
					</th>
				</tr>
			</s:iterator>
		</table>
	</div>
</body>
</html>
