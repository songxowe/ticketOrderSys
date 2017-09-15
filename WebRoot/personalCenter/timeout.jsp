<%@ page language="java" pageEncoding="utf-8"%>


<!DOCTYPE HTML >
<html>
<head>

<title>正在跳转</title> 
<script type="text/javascript">
	//window.setInterval("location='index.html'", 3000);
	
	onload = function() {
		//setInterval(go, 1000);
		location.href = '../personalCenterAction_showOrder';
	};
	var x = 5; //利用了全局变量来执行 
	function go() {
		x--;
		if (x > 0) {
			document.getElementById("sp").innerHTML = x; //每次设置的x的值都不一样了。 
		}
		else {
			location.href = '../personalCenterAction_showOrder';
		}
	}
</script>


</head>
<body>
	系统正在处理...<span id="sp">5</span>秒后跳转到
	<sapn style="color:red">个人中心->预定管理 </sapn>
	进行查看
</body>
</html>
