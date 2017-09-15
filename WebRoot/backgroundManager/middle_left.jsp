<%@ page language="java" pageEncoding="utf-8"%>

<!DOCTYPE HTML >
<html>
<head>
<link rel="stylesheet" type="text/css" href="../easyui/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="../easyui/themes/icon.css" />
<script src="../easyui/jquery.min.js"></script>
<script src="../easyui/jquery.easyui.min.js"></script>
<script src="../easyui/locale/easyui-lang-zh_CN.js"></script>

<title>middle_left</title>
<style type="text/css">
html, body, #content {
	width: 100%;
	height: 100%;
	margin: 0px;
	padding: 0px;
}

a {
	text-decoration: none;
}

alink {
	text-decoration: none;
}
tr a:HOVER {
	color: red;
}

</style>

<script type="text/javascript">
	function logout() { 
			var msg = "您确定要退出吗？"; 
			if (confirm(msg)){ 
				window.parent.parent.location = "../adminAction_exit";
			}
		} 
	$(function(){
		$('tr a').click(function(){
			$('a').css({color: "black"});
			$(this).css({color: "red"});
		});
	
	});
</script>
</head>

<body
	style="background-color: #F5F6F7;height: 300px;text-align: center;">

	<table id="content" cellspacing="0" style="width:100%;height: 300px;">
		<tr style="background-color:#449AD5;color: white;height:30px">
			<td>管理员</td>
		</tr>
		<tr style="background-color:#D4E6F0;height:30px">
			<td>${sessionScope.admin.username}</td>
		</tr>
		<tr style="background-color:#D4E6F0;height:20px">
			<td>
			您有3条消息
			
			</td>
		</tr>
		<tr style="background-color:#D4E6F0;height:20px">
			<td><a href="javascript: logout();">退出</a></td>
		</tr>
		<tr style="background-color:#449AD5;color: white;height:30px">
			<td>管理菜单</td>
		</tr>
		<tr style="background-color:#D4E6F0;height:35px;">
			<td><a href="SystemSetting.jsp" target="lower_right">&nbsp;&nbsp;系统设置&nbsp;&nbsp;</a></td>
		</tr>
		<tr style="background-color:#D4E6F0;height:35px">
			<td><a href="showUser.jsp" target="lower_right">&nbsp;&nbsp;用户管理&nbsp;&nbsp;</a></td>
		</tr>
		<tr style="background-color:#D4E6F0;height:35px">
			<td><a href="planeManager.jsp" target="lower_right">&nbsp;&nbsp;航班管理&nbsp;&nbsp;</a></td>
		</tr>
		<tr style="background-color:#D4E6F0;height:35px">
			<td><a href="../flightOrderAction_list" target="lower_right">&nbsp;&nbsp;机票管理&nbsp;&nbsp;</a></td>
		</tr>
		<tr></tr>
		<tr></tr>
	</table>



</body>

</html>
