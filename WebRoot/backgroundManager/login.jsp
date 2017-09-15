<%@ page language="java" pageEncoding="utf-8"%>

<!DOCTYPE html >
<html>
<head>
<title>管理员登录</title>
</head>
<style>
.span {
	color: red;
	font-size: 10px;
}
</style>
<script src="../easyui/jquery.min.js"></script>
<script type="text/javascript">


	function doPost() {
		var username = document.getElementById("username").value;
		var password = document.getElementById("password").value;

		$.ajax({
			type : "POST",
			url : "../adminAction_login",
			data : "username=" + username + "&password=" + password,
			success : function(msg) {
				var text = String($.trim(msg));
				if (text == "ok") {

						window.location.href="index.jsp";
				}
				else if (text == "usernameError") {

					document.getElementById("nametips").style.display = "block";

				}
				else {

					document.getElementById("passwordtips").style.display = "block";
					document.getElementById("nametips").style.display = "none";
				}
			}
		});
	}

	function none() {
		document.getElementById("nametips").style.display = "none";
		document.getElementById("passwordtips").style.display = "none";
	}
</script>
<body style="margin:0; padding:0; ">

	<div id="head"
		style="height:30px;background-color: #17577B;color:white;line-height: 30px;">
		&nbsp;&nbsp;&nbsp;&nbsp;欢迎登录机票订购系统后台管理平台</div>

	<div id="middle"
		style="height:700px;background-image: url(../img/back.jpg);background-size:100% 100%;">
		<div id="login" name="login"
			style="background-color:white;height:30%;width:30%;
   				border:1px solid #79BEE7;position:relative;left:35%;top:30%;">
			<div style="margin-left:20%;margin-top: 10%">
				<form>
					<p style="color:#FF4300">管理员登录
					<p />
					<input type="text" id="username" name="username" placeholder="name"
						style="float: left;" onclick="none()" /> <span id="nametips"
						class="span"
						style="display:none;float: left;height:15px;line-height: 15px;">用户名错误</span>
					<br />
					<br /> <input type="password" id="password" name="password"
						placeholder="password" style="float: left; " onclick="none()" /> <span
						id="passwordtips" class="span"
						style="display: none;float: left;height:15px;line-height: 15px;">密码错误</span>
					<br />
					<br /> <input type="button" onclick="doPost()" value="登录"
						style="background-color:#79BEE7;color: white;border:0px;height: 30px;width:100px; " />
				</form>

			</div>
		</div>

	</div>
	<div id="bottom"
		style="height:30px;text-align: center;color:black; opacity: 0.5;background-color:gray">版权所有</div>
</body>
</html>
