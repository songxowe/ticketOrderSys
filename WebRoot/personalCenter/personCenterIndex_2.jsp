<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib  prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML >
<html>
 	<head>
	<meta charset="utf-8">
    
<title>用户个人中心</title>
<link rel="stylesheet" type="text/css" href="easyui/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="easyui/themes/icon.css" />
<script src="easyui/jquery.min.js"></script>
<script src="easyui/jquery.easyui.min.js"></script>
<script src="easyui/locale/easyui-lang-zh_CN.js"></script>
   	<style type="text/css">
   		body{
            height: 100%;
            overflow: auto;
            margin: 0;
        }
        * html {
            overflow: hidden;
            position: absolute;
        }
         #editer{
            position: fixed;
            _position: absolute;
            top: 50%;
            left:50%;
            border: 2px solid #C0C0C0;/*弹出框边框样式*/
            background-color: #FFFFFF;/*弹出框背景色*/
            
  	     display:none;
  	               
            height:500px;
            width:800px;
            z-index: 12;
        }
    	#main{
    		width:960px;
    		margin:0 auto;
    		
    		height: 700px;
    	}
    	#head{
    		width: 80%;
    		height: 150px;
    	}
    	.titleleft{
    		background-color: #1979ca;
    		height: 35px;
    
    		width: 95%;
    	}
    	
    	#personalCenter{
    		float: left;
    		
    		width: 25%;
    		
    		height: 150px;
    	}
    	#showContent{
    		float: right;
    		
    		width: 75%;
    		
    		height: 250px;
    	}
    	#pc{
    	
    	background-color: #white;
    	height:150px;
    	width: 95%;
    	}
    	#ui,#tm,#xq{
    	border: 1px solid #A4CEF9;
    	padding: 15px;
    	
    	}
    	a{
		text-decoration:none;
		}
		button {
		height:10px;
		width:25px;
	}
	
   </style>
  </head>
  
  <body>
  		<div id="editer">	            
	            	<div id="searchForm" style="padding: 10px">   					
	            		出发地点<input type="text" id="fromcity" style="width:50px">
	            		到达地点<input type="text" id="tocity" style="width:50px">
	            		出发时间<input type="date" id="fromtime" style="width:200px">
	            		航班类型<input type="text" id="flightType" style="width:50px">
	            		&nbsp;&nbsp;
	            		<input type="button" onclick="queryPlane()" value="搜索" style="height:25px;width:60px;">
					</div>
            	            	
            	<div style="margin-left: 5%;margin-right: 5%;margin-top: 30px;">
          			<table id="content" style=""></table>
          			
   				</div>	
   					<div style="float: right;margin-left: 5%;margin-right: 5%;margin-top: 15px;"> 
   						<input id="oid" type="hidden" />
   						<input id="num" type="hidden"/>
   						<input id="oldfid" type="hidden"/>
   						<input type="button" value="确定" onclick="sure()" 
   							style="background-color: #1979CA;color:white;border: 1px solid #DFDFDF;height:25px;width:60px;">&nbsp;&nbsp;
   						<input type="button" value="取消" onclick="closePlane()" style="height:25px;width:60px;border: 1px solid #DFDFDF;">
   					</div>   						
  		</div>
  		
  		
	  <div id="main">
			  	<div id="head">
			  		<img src="img/indexHead.png" style="width: 960px;height: 150px;"/>
			  	</div>
	  	<div id="personalCenter" >
			  		<div class="titleleft" style="line-height:35px;color:white;">
			  			&nbsp;&nbsp;用户个人中心
			  		</div>
			  	<div id="pc">
			  		<div id="ui">
			  			
			  			&nbsp;&nbsp;<a href="personalCenter/personCenterIndex_1.jsp" class="a">用户信息</a>
			  		</div>
			  		<div id="tm">
			  			&nbsp;&nbsp;预定管理
			  		</div>
			  		<div id="xq">
			  			&nbsp;&nbsp;<a href="index.jsp" class="a" >返回首页</a>
			  		</div>
			  	</div>
	  	</div>
	  	<div id="showContent">
			  		<div class="titleright" style="height:35px;line-height:35px; background-color: #C0C0C0">
			  			&nbsp;&nbsp;预定管理
			  		</div>
			  		<div id="alteration"></div>			  		
			  		<div style="margin-top: 10px;">
			  			<table style="border: 2px solid #DFDFDF;width: 100%;text-align: center;">
							<tr style="background-color: skyblue;height:30px;">
								<th>序号</th>
								<th>订单</th>
								<th>航班</th>
								<th>始发地</th>
								<th>目的地</th>
								<th>订购日期</th>
								<th>订购数量</th>
								<th>票价</th>
								<th>总价</th>
								<th>操作</th>
							</tr>
							
						<s:iterator var="flightOrder" value="flightOrders" status="rows">
						  <tr style="height:30px;">  <!-- bgcolor="${rows.index%2==0?'white':'skyblue' }" -->
						    <td><s:property value="#rows.index+1"/></td>
						    <td><s:property value="#flightOrder.orderno"/></td>
						    <td><s:property value="#flightOrder.flight.name"/></td>
						      <td><s:property value="#flightOrder.flight.fromcity"/></td>
						        <td><s:property value="#flightOrder.flight.tocity"/></td>
						    <td><s:date name="#flightOrder.ordertime" format="yyyy-MM-dd HH:mm:ss"/></td>
						    <td><s:property value="#flightOrder.num"/></td>
						    <td><s:property value="#flightOrder.unitprice"/></td>
						      <td><s:property value="#flightOrder.totalprice"/></td>
						    <td>
						     <a href="javascript:modify(<s:property value='#flightOrder.oid'/>,<s:property value='#flightOrder.num'/>,<s:property value='#flightOrder.flight.fid'/>,<s:property value='#flightOrder.flight.flighttype'/>)">改签</a>
						      &nbsp;						  	
						  	<a href="javascript:remove(<s:property value='#flightOrder.oid'/>,<s:property value='#flightOrder.num'/>,<s:property value='#flightOrder.flight.fid'/>)" >退票</a>
						    </td>
						  </tr>
						</s:iterator>
						</table>			  			
			  		</div>
			  		<div id="editUser"></div>
			  		
	  	</div>
	  	<div id="bottom">
	  	</div>
	  	
	  </div>
  </body>
  <script type="text/javascript">
  
  		//改签
    	 function modify(oid,num,oldfid,flightType){
    			document.getElementById("oid").value=oid;
    			document.getElementById("num").value=num;
    			document.getElementById("oldfid").value=oldfid;
    			document.getElementById("flightType").value=flightType;
    			
    			 //弹出窗口
    			 show_Win('editer', 'title','');
    			//显示数据
    			
    			showPlane();   			 
    		  }
    	
    	//条件查询
    	function queryPlane(){
    		var fromcity=$.trim($("#fromcity").val());
    		var tocity=$.trim($("#tocity").val());
    		var fromtime=$.trim($("#fromtime").val());
    		var flightType=$.trim($("#flightType").val());
    	 // 5.条件查询
    		$("#content").datagrid('load',{
            	fromcity :fromcity ,
            	tocity   :tocity,
            	fromtime :fromtime,
            	flightType:flightType,
            // sal : $("#sal").val(),
            // 可设置更多查询条件
          		});
    		
    	}
    	//自动加载 plane
		function showPlane(){
			
    		$("#content").datagrid({
		   		url:'personalCenterAction_showPlane',   // 一个URL从远程站点请求数据
		        fitColumns : false, // 自动展开/收缩列
		        /* rownumbers : true, // 行号 */
		        title:"机票改签(请选择要改签的航班)",
		        columns:[[{// -- 列开始 ---------
		          field : 'pid',
		          title : '序号',
		          width : 120,
		          checkbox : true,
		          sortable : true
		          
		        },{ 
		          field : 'name',
		          title : '航班',
		          width : 120,
		          align:"center",
		          sortable : true,
		        },{
		          field : 'fromcity',
		          title : '始发地',
		          width : 120,
		          align:"center",
		          sortable : true,
		        },{
		          field : 'tocity',
		          title : '目的地',
		          width : 120,
		          align:"center",
		          sortable : true,
		        },{
		          field : 'fromtime',
		          title : '出发时间',
		          width : 200,
		          align:"center",
		          sortable : true,
		        },{
		          field : 'price',
		          title : '票价',
		          width : 100,
		          align:"center",
		          sortable : true,
		        } /**,{
		          field : 'ui',
		          title : '操作',
		          width : 70,
		          align:"center",
		          sortable : true,
		          formatter:function(value,row,index){
		          	return "<a href='#' class='buy' onclick='flight_obj.orderTicket("+row.fid+")'>订票</a>"
		          }
		        }**/ ]], // -- 列结束 ---------
		        toolbar : "#searchForm",
		        pagination : true, // -- 分页设置 ----
		        pageSize : 5,// rows:每页显示的记录条数 (page 控件自动计算)
		        pageList : [ 5, 10, 15, 20, 50 ],// 设置每页条数的列表
		        sortName : "fromTime", // sort:排序列 (默认)
		        sortOrder : "ASC",  // order:升序/降序 (默认)
		        });
    	
    	} 
		//确定改签
		function sure(){						
				var url="personalCenterAction_alteration";	//personalCenterAction_alteration
				var newfid=0;
				var oid=0;
				var num=0;
				var oldfid=0;		
				var rows = $('#content').datagrid("getSelections");//选中的行数
				if (rows.length == 1) {
					newfid = rows[0].fid;
					oid = $.trim($("#oid").val()),
					num = $.trim($("#num").val()),
					oldfid = $.trim($("#oldfid").val())					
				}else if(rows.length > 1){
					//$.messager.alert("提醒", "只能选中一行", "");
					alert("只能选中一行");
					return;
				} else {
					//$.messager.alert("提醒", "必须选中一行", "");
					alert("必须选中一行");
					return;
				}
				//Ajax提交数据
				$.ajax({
					type : 'post',
					url : url,					
					data : {
						newfid:newfid,
						oid:oid,
						oldfid:oldfid,
						num :num,
					},	
						beforeSend : function() {
							//显示正在载入状态
							$("#content").datagrid(
									"loading");
						},
						success : function(data){
							if (data) {																
								closePlane();
								window.location.href="personalCenter/timeout.jsp";
							}
						}

				});
			}

		//退票
		function remove(oid,num,fid){
			if (!confirm("确定退票吗？")){
    			 	return false;
    			 }
			$.ajax({
					type : 'post',
					url : "personalCenterAction_remove",//personalCenterAction_alteration					
					data : "oid="+oid+"&num="+num+"&fid="+fid,				
					/* beforeSend : function() {
							//显示正在载入状态
							$("#content").datagrid(
									"loading");
					}, */
					success : function(data){
							if (data) {																
								window.location.href="personalCenter/timeout.jsp";
							}
					}
				});
		
		}		
		
        //弹出层
        function show_Win(div_Win, tr_Title, event) {
            var s_Width = document.documentElement.scrollWidth; //滚动 宽度
            var s_Height = document.documentElement.scrollHeight; //滚动 高度
            var js_Title = $(document.getElementById(tr_Title)); //标题
            js_Title.css("cursor", "move");
            //创建遮罩层
            $("<div id=\"div_Bg\"></div>").css({ "position": "absolute","z-index":"8","left": "0px", "right": "0px", "width": s_Width + "px", "height": s_Height + "px", "background-color": "#ffffff", "opacity": "0.6" }).prependTo("body");
            //获取弹出层
            var msgObj = $("#" + div_Win);
            //document.getElementById(div_Win).style.display="block";
            msgObj.css('display', 'block'); //必须先弹出此行，否则msgObj[0].offsetHeight为0，因为"display":"none"时，offsetHeight无法取到数据；如果弹出框为table，则为'',如果为div，则为block，否则textbox长度无法充满td
            //y轴位置
            var js_Top = -parseInt(msgObj.height()) / 2 + "px";
            //x轴位置
            var js_Left = -parseInt(msgObj.width()) / 2 + "px";
            msgObj.css({ "margin-left": js_Left, "margin-top": js_Top });
            //使弹出层可移动
            msgObj.draggable({ handle: js_Title, scroll: false });
        }
        
        //关层
 		function closePlane(){
 			  document.getElementById("editer").style.display="none";
 			  document.getElementById("div_Bg").style.display="none";
 			 
 			}

  	
  </script>
</html>
