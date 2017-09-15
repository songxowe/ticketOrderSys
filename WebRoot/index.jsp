<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<html>
  <head>
    <meta charset="utf-8">
    <title>航班网上订票系统</title>
    <link rel="stylesheet" type="text/css" href="easyui/themes/metro/easyui.css" />
	<link rel="stylesheet" type="text/css" href="easyui/themes/icon.css" />
	<script src="easyui/jquery.min.js"></script>
	<script src="easyui/jquery.easyui.min.js"></script>
	<script src="easyui/locale/easyui-lang-zh_CN.js"></script>
	<link rel="stylesheet" type="text/css" href="css/pwt.css">
	<script src="js/pwt.js"></script>
  </head>
  <body>
	  <div id="main">
	  	<div id="head">
	  		<img src="img/indexHead.png" style="width: 960px;height: 100%"/>
	  	</div>
	  	<div id="register">
	  		<br>
            <div id="title"  style="position: relative;left: 15px;">用户注册</div>
            <hr>
            <div style="position: relative;left: 0px;" id="reg">
	           	<span class="sqeSpan">用户名</span><div class="sqeDiv"></div>
	           	<input type="text" id="regUsername" onblur="flight_obj.validateUsername()"
	           	class="easyui-validatebox" data-options="validType:'minLength[6]'">
	           	<span style="color: red;font-size: x-small;display: none;"></span><br><br>
	           <span class="sqeSpan">密码</span><div class="sqeDiv"></div>
	           <input type="password" id="regPassword"
	            class="easyui-validatebox" data-options="validType:'minLength[6]'" ><br><br>
	            <span class="sqeSpan">确认密码</span><div class="sqeDiv"></div>
	            <input type="password" id="rePassword" 
	            class="easyui-validatebox" validType="equals['#regPassword']" ><br><br>
	            <span class="sqeSpan">性别</span><div class="sqeDiv"></div>
	            <input type="radio" name="sex" checked="checked" value="1">男
	            		<input type="radio" name="sex" value="0">女<br><br>
	            <span class="sqeSpan">真实姓名</span><div class="sqeDiv"></div>
	            <input type="text" id="realName"><br><br>
	            <span class="sqeSpan">身份证</span><div class="sqeDiv"></div>
	            <input type="number" id="idCard" 
	            data-options="validType:'length[18]'"class="easyui-validatebox"><br><br>
	            <span class="sqeSpan">手机</span><div class="sqeDiv"></div>
	            <input type="number" id="phone" 
	            data-options="validType:'length[11]'"class="easyui-validatebox"><br><br>
            </div>
	            <hr>
	            <div style="position:relative;top: 5px;left:295px; ">
	            	<input type="button" value="注册" onclick="flight_obj.register()" class="btn">
	            	<input type="button" value="关闭" onclick="flight_obj.closeDiv()"class="btn">
	            </div>
        </div>
	  	<div id="userInfo">
	  		<div class="titleleft" >
	  			<p style="position: relative;top: -9px;">用户信息</p>
	  		</div>
	  		<c:if test="${ empty sessionScope.user }">
	  		<div style="margin: 5px;">
	  			<div id="beforeLogin" style="position: relative;top: 12px;left: 40px;"><br><br>
	  			用户名:&nbsp; <input type="text" id="username" style="width: 120px;"><span class="warning">&nbsp;用户名不存在!</span><br><br>
	  			<div style="position: relative;left: 1px;" >
	  				密码: &nbsp;&nbsp;&nbsp;&nbsp;<input type="password" id="password" style="width: 120px;"><span class="warning">&nbsp;密码错误!</span><br><br>
	  			</div>
	  			<div style="margin:-10px;position: relative;left: 165px;">
	  				<div style="float: left;margin-right: 20px;">
	  					<input type="button" value="注册" onclick="show_Win('register', 'title', event)"class="btn">
	  				</div>
	  				<div style="float: left;">
  						<input type="button" value="登录" onclick="flight_obj.login()"class="btn">&nbsp;
  					</div>
	  			</div>
	  		</div>
	  		</div>
	  			
	  		</c:if>
	  		<c:if test="${empty sessionScope.user==false }">
	  			<div id="afterLogin"  style="height: 150px;">
	  			<div style="margin-top: 20px;height: 100%;">
  					<center>
	  					<div style="border-bottom: 1px solid #ddd;height: 58px;">
	  						<span style="position: relative;top: 8px;">
		  					欢迎旅客:<font style="color: red">${sessionScope.user.truename }</font>
		  					</span>
	  					</div>
  					</center>
	  				<center>
		  				<div style="height: 58px;position: relative;top:-2px;">
		  					<a href="personalCenter/personCenterIndex_1.jsp" style="position: relative;top: 12px;text-decoration: none;"id="userCenterA">进入个人中心</a>
		  				</div><br>
		  				<div style="border-top: 1px solid #ddd;height: 52px;position: relative;top: -34px;">
		  					<a href="#" onclick="flight_obj.logout()" style="position: relative;top: 11px;text-decoration: none;"id="userLogoutA">[安全退出]</a>
		  				</div>
	  				</center>
	  			</div>
	  			
	  		</div>
	  		</c:if>
	  		
	  	</div>
	  	<div id="domesticFlight">
	  	<div>
	  		<div class="titleright" style="">
	  			<span style="position: relative;top: 6px;left: 7px;width: 250px;float: left;">国内航班</span>
	  			 <div style="width: 50px;float: left;"></div>
	  			 <div style="position: relative;top: 6px;">
	  			 	<a href="#" onclick="flight_obj.dfindByDay(0)" id="ddate0"></a>&nbsp;&nbsp;&nbsp;
		  			<a href="#" onclick="flight_obj.dfindByDay(1)"id="ddate1"></a>&nbsp;&nbsp;&nbsp;
		  			<a href="#" onclick="flight_obj.dfindByDay(2)"id="ddate2"></a>&nbsp;&nbsp;&nbsp;
		  			<a href="#" onclick="flight_obj.dfindByDay(3)"id="ddate3"></a>&nbsp;&nbsp;&nbsp;
		  			<a href="#" onclick="flight_obj.dfindByDay(4)"id="ddate4"></a>&nbsp;&nbsp;&nbsp;
		  			<a href="#" onclick="flight_obj.dfindByDay(5)"id="ddate5"></a>&nbsp;&nbsp;&nbsp;
		  			<a href="#" onclick="flight_obj.dfindByDay(6)"id="ddate6"></a>&nbsp;&nbsp;&nbsp;
	  			 </div>
	  		</div>
	  	</div>
	  	<div style="float: left;width: 629px;">
	  		<table id="domesticFlightGrid" style="z-index: 4; "  >
  			</table>
	  	</div>
	  			
	  	</div>
	  	<div id="search">
	  		<div class="titleleft">
	  			<p style="position: relative;top: -9px;">航班查询</p>
	  		</div>
	  		<div style="position:relative;top: 24px;left: 40px; ">
	  			出发地点&nbsp;&nbsp;<input type="text" id="fromCitySearch" style="width: 120px;"><br><br>
  				到达地点&nbsp;&nbsp;<input type="text" id="toCitySearch" style="width: 120px;"><br><br>
  			<div style="position: relative;left: 195px;top: -4px;">
  				<input type="button" value="搜索航班" onclick="flight_obj.findByCity()"class="btn">
  			</div>
	  		</div>
	  		
	  	</div>
	  	<div id="internationalFlight">
	  		<div class="titleright">
	  			<span style="position: relative;top: 6px;left: 7px;width: 250px;float: left;">国际航班</span>
	  			 <div style="width: 50px;float: left;"></div>
	  			 <div style="position: relative;top: 6px;">
	  			 	<a href="#" onclick="flight_obj.ifindByDay(0)" id="idate0"></a>&nbsp;&nbsp;&nbsp;
		  			<a href="#" onclick="flight_obj.ifindByDay(1)"id="idate1"></a>&nbsp;&nbsp;&nbsp;
		  			<a href="#" onclick="flight_obj.ifindByDay(2)"id="idate2"></a>&nbsp;&nbsp;&nbsp;
		  			<a href="#" onclick="flight_obj.ifindByDay(3)"id="idate3"></a>&nbsp;&nbsp;&nbsp;
		  			<a href="#" onclick="flight_obj.ifindByDay(4)"id="idate4"></a>&nbsp;&nbsp;&nbsp;
		  			<a href="#" onclick="flight_obj.ifindByDay(5)"id="idate5"></a>&nbsp;&nbsp;&nbsp;
		  			<a href="#" onclick="flight_obj.ifindByDay(6)"id="idate6"></a>&nbsp;&nbsp;&nbsp;
	  			 </div>
	  		</div>
	  			<div style="float: left;width: 629px;">
	  			<table id="internationalFlightGrid" style="z-index: 4; "  >
	  			</table>
	  			</div>
	  	</div>
	  	<div id="showOrder"></div>
	  	<div id="bottom"></div>
	  </div>
  </body>
  <script type="text/javascript">
  		// 国内航班加载数据
  		$("#domesticFlightGrid").datagrid({
   		url:'flightAction_list?flightType=0',   // 一个URL从远程站点请求数据
        fitColumns : false, // 自动展开/收缩列
        columns:[[{ // -- 列开始 ---------
          field : 'name',
          title : '航班',
          width : 100,
          align:"center",
          sortable : true,
        },{
          field : 'fromcity',
          title : '始发地',
          width : 80,
          align:"center",
          sortable : true,
        },{
          field : 'tocity',
          title : '目的地',
          width : 80,
          align:"center",
          sortable : true,
        },{
          field : 'fromtime',
          title : '出发时间',
          width : 150,
          align:"center",
          sortable : true,
        },{
          field : 'price',
          title : '票价',
          width : 50,
          align:"center",
          sortable : true,
        },{
          field : 'remainingseats',
          title : '剩余座位',
          width : 50,
          align:"center",
          sortable : true,
        } ,{
          field : 'ui',
          title : '操作',
          width : 63,
          align:"center",
          sortable : true,
          formatter:function(value,row,index){
          	return "<a href='#' class='buy' onclick='flight_obj.validateSession("+row.fid+")'>订票</a>";
          }
        } ]], // -- 列结束 ---------
        pagination : true, // -- 分页设置 ----
        pageSize : 5,// rows:每页显示的记录条数 (page 控件自动计算)
     	pageList : [ 5 ],// 设置每页条数的列表
        sortName : "fromtime", // sort:排序列 (默认)
        sortOrder : "ASC",  // order:升序/降序 (默认)
        });
        
        // 国际航班加载数据
  		$("#internationalFlightGrid").datagrid({
   		url:'flightAction_list?flightType=1',   // 一个URL从远程站点请求数据
        fitColumns : false, // 自动展开/收缩列
        /* rownumbers : true, // 行号 */
        columns:[[{ // -- 列开始 ---------
          field : 'name',
          title : '航班',
          width : 100,
          align:"center",
          sortable : true,
        },{
          field : 'fromcity',
          title : '始发地',
          width : 80,
          align:"center",
          sortable : true,
        },{
          field : 'tocity',
          title : '目的地',
          width : 80,
          align:"center",
          sortable : true,
        },{
          field : 'fromtime',
          title : '出发时间',
          width : 150,
          align:"center",
          sortable : true,
        },{
          field : 'price',
          title : '票价',
          width : 50,
          align:"center",
          sortable : true,
        },{
          field : 'remainingseats',
          title : '剩余座位',
          width : 50,
          align:"center",
          sortable : true,
        },{
          field : 'ui',
          title : '操作',
          width : 63,
          align:"center",
          sortable : true,
          formatter:function(value,row,index){
          	return "<a href='#' class='buy' onclick='flight_obj.validateSession("+row.fid+")'>订票</a>";
          }
        } ]], // -- 列结束 ---------
        pagination : true, // -- 分页设置 ----
        pageSize : 5,// rows:每页显示的记录条数 (page 控件自动计算)
        pageList : [ 5 ],// 设置每页条数的列表
        sortName : "fromtime", // sort:排序列 (默认)
        sortOrder : "ASC",  // order:升序/降序 (默认)
        });
		
  		
  	
  </script>
</html>
