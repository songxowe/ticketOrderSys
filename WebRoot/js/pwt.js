

$(function(){
	
		$('#userCenterA,#userLogoutA').mouseover(function(){
			$(this).css({color: "red"})
		});
		$('#userCenterA,#userLogoutA').mouseout(function(){
			$(this).css({color: "black"})
		})
  		/*  */
		for(var i=0;i<7;i++){
			$('#ddate'+i).html(getDate(i));
			$('#idate'+i).html(getDate(i));
		}
		
  		flight_obj={
  			//验证用户是否已登录
  			validateSession:function(row){
  				$.ajax({
  					type:"POST",
  					url:"valSessionAction",
  					success: function(data){
  						var text=String($.trim(data));
  						if(text=="0"){
  							alert("您尚未登录,请先登录!");
  						}
  						if(text=="1"){
  							flight_obj.orderTicket(row);
  						}
  					}
  				});
  			},
  			//用户订票
  			orderTicket:function(row){
  				var fid=row;
				$("#showOrder").window({
		            title : "订购机票",
		            left:500,
		            top:100,
		            width : 350,
		            height : 280,
		            minimizable : false,
		            collapsible:false,
		            minimizable:false,
		            maximizable:false,
		            resizable:false,
		            style: {
		            	 borderRadius: '3px',
           		 		 boxShadow: '#666 0px 0px 10px',
		            },
		            href : "orderTicketAction_buyOrders?fid="+fid,
		            onClose : function(){
		              $('#domesticFlightGrid').datagrid("reload");
		               $('#internationalFlightGrid').datagrid("reload");
		            }
		          });
  			},
  			//国内航班根据日期查询
			dfindByDay:function(num){
				var d = new Date();
				var vYear = d.getFullYear();
				var vMon = d.getMonth() + 1;
				var vDay = d.getDate()+num;
				var s=vYear+"-"+(vMon<10 ? "0" + vMon : vMon)+"-"+(vDay<10 ? "0"+ vDay : vDay);
		 				$('#domesticFlightGrid').datagrid('load',{
		 					fromTime:s,
		 				});
					},
			//国际航班根据日期查询
			ifindByDay:function(num){
				var d = new Date();
				var vYear = d.getFullYear();
				var vMon = d.getMonth() + 1;
				var vDay = d.getDate()+num;
				var s=vYear+"-"+(vMon<10 ? "0" + vMon : vMon)+"-"+(vDay<10 ? "0"+ vDay : vDay);
		 				$('#internationalFlightGrid').datagrid('load',{
		 					fromTime:s,
		 				});
					},
			//模糊查询(根据城市)
			findByCity:function(){
				var fromCity=$('#fromCitySearch').val();
				var toCity=$('#toCitySearch').val();
				$('#domesticFlightGrid').datagrid('load',{
					fromCity:fromCity,
					toCity:toCity,
				});
				$('#internationalFlightGrid').datagrid('load',{
					fromCity:fromCity,
					toCity:toCity,
				});
			},
			//用户注册
			register:function(){
				var regUsername=$('#regUsername').val();
				var regPassword=$('#regPassword').val();
				var sex=$("input[name='sex']").val();
				var realName=$('#realName').val();
				var idCard=$('#idCard').val();
				var phone=$('#phone').val();
				$.ajax({
					type:	"POST",
					url:"userPwtAction_register",
					data:"regUsername="+regUsername+"&regPassword="+regPassword+"&sex="+sex+"&realName="+realName+"&idCard="+idCard+"&phone="+phone,
					success:function(data){
						$.messager.show( {
				 	          title : "提示",
				 	          msg : "注册成功!,请登录"
				 	        });
						flight_obj.closeDiv();
					}
				});
			},
			//关闭弹出层
			closeDiv:function(){
					$('input[type=text]').val("");
					$('input[type=password]').val("");
					$('#div_Bg').css({'display':'none'});
					$('#register').css({'display':'none'});
			},
			/* 用户登录AJAX */
			login:function(){
				var username=$('#username').val();
				var password=$('#password').val();
				$.ajax({
					type:"POST",
					url:"userPwtAction_login",
					data:"username="+username+"&password="+password,
					success: function(data){
						var text=String($.trim(data));
						if(text=="用户名不存在!"){
							$('#username').next().css({'display':'inline'});
							$('#password').next().css({'display':'none'});
						}
						if(text=="密码错误!"){
							$('#username').next().css({'display':'none'});
							$('#password').next().css({'display':'inline'});
						}
						if(text=="登录成功!"){
							/* $('#beforeLogin').css({'display':'none'});
							$('#afterLogin').css({'display':'block'}); */
							window.location.href="index.jsp";
						}
					},
				});
			},
			//用户登出
			logout:function(){
				$.ajax({
					type:"POST",
					url:"userPwtAction_logout",
					success:function(data){
						window.location.href="index.jsp";
					}
				});
			},
			//验证用户名是否存在
			validateUsername:function(){
				var regUsername=$('#regUsername').val();
				$.ajax({
					type:"POST",
					url:"userPwtAction_validateUsername",
					data:"regUsername="+regUsername,
					success: function(data){
						var text=String($.trim(data));
						if(text=="exist"){
							$('#regUsername').next().css({'display':'inline'});
							$('#regUsername').next().html("用户名已存在!");
						}if(text=="ok"){
							$('#regUsername').next().css({'display':'none'});
						}
					}
				});
			},
  		}
  	});  
  		
    	/* *********************************** */
    	//弹出层
        function show_Win(div_Win, tr_Title, event) {
            var s_Width = document.documentElement.scrollWidth; //滚动 宽度
            var s_Height = document.documentElement.scrollHeight; //滚动 高度
            var js_Title = $(document.getElementById(tr_Title)); //标题
            js_Title.css("cursor", "move");
            //创建遮罩层
            $("<div id=\"div_Bg\"></div>").css({ "position": "absolute", "z-index":"8","left": "0px", "right": "0px", "width": s_Width + "px", "height": s_Height + "px", "background-color": "#ffffff", "opacity": "0.6" }).prependTo("body");
            //获取弹出层
            var msgObj = $("#" + div_Win);
            msgObj.css('display', 'block'); //必须先弹出此行，否则msgObj[0].offsetHeight为0，因为"display":"none"时，offsetHeight无法取到数据；如果弹出框为table，则为'',如果为div，则为block，否则textbox长度无法充满td
            //y轴位置
            var js_Top = -parseInt(msgObj.height()) / 2 + "px";
            //x轴位置
            var js_Left = -parseInt(msgObj.width()) / 2 + "px";
            msgObj.css({ "margin-left": js_Left, "margin-top": js_Top });
            //使弹出层可移动
            msgObj.draggable({ handle: js_Title, scroll: false });
        }
        /* 根据参数得到日期*/
        function getDate(dates){
			var dd = new Date();
		    dd.setDate(dd.getDate()+dates);
		    var m = dd.getMonth()+1;
		    var d = dd.getDate();
			return m+"-"+d;
		}
		/* 重写判断两次密码输入是否一致 */
		$.extend($.fn.validatebox.defaults.rules, {    
   			equals: {    
	     	    validator: function(value,param){    
	            return value == $(param[0]).val();    
       		 },    
       	 	message: '两次密码输入不一致!'   
    		}    
		}); 
		/* 重写判断最小输入长度 */
		$.extend($.fn.validatebox.defaults.rules, {    
   		  	minLength: {    
        		validator: function(value, param){    
            	return value.length >= param[0];    
       	  	},    
        	message: '至少输入{0}位字符'   
    		}    
		});  
		/* 重写判断固定长度 */
		$.extend($.fn.validatebox.defaults.rules, {    
   		  	length: {    
        		validator: function(value, param){    
            	return value.length == param[0];    
       	  	},    
        	message: '应输入{0}位字符'   
    		}    
		});  
		
		