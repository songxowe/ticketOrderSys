<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Emp CRUD</title>
<style type="text/css">
	body {
		font-family: 微软雅黑;
		font-size: medium;
		margin-left: 10px;
	}
	#content{
		float:left;
		margin-left:10px;;
	}
	.btn{
        	border-radius: 3px;
            box-shadow: #666 0px 0px 2px;
        	height: 28px;
        }
</style>
</head>
<body>
 	<div id="content">
 		<center>
 		<table style="text-align:left;position: relative;left: -40px;"cellpadding="4" cellspacing="4">
		    <tr><td><span style="float: left;width: 80px;">航班:</span>${flight.name }</td></tr>
			<tr><td><span style="float: left;width: 80px;">始发地:</span>${flight.fromcity }</td></tr>
		    <tr><td><span style="float: left;width: 80px;">目的地:</span>${flight.tocity }</td></tr>
		    <tr><td><span style="float: left;width: 80px;">出发时间:</span>${flight.fromtime }</td></tr>
		    <tr><td><span style="float: left;width: 80px;">到达时间:</span>${flight.totime }</td></tr>
		    <input type="hidden" value=${flight.price } id="unitprice">
		    <input type="hidden" value=${flight.fid } id="fid">
		    <tr><td><span style="float: left;width: 80px;">票价:</span>${flight.price }</td></tr>
		    <tr><td><span style="float: left;width: 80px;">订购数量:</span><input type="number" min="1" value="1" id="num" style="width: 28px;"></td></tr>
		    <tr><td><input value="提交" type="button" onclick="obj.sub()"class="btn"></td></tr>
	    </table></center>
 	</div>
    
  <script type="text/javascript">
  	$(function(){
  		obj={
  			sub:function(){
  				var num=$('#num').val();
  				var unitprice=$('#unitprice').val();
  				var totalprice=$('#unitprice').val()*$('#num').val();
  				var fid=$('#fid').val();
  				$.ajax({
  					type:"POST",
  					url : "orderTicketAction_createOrder",
  					data:"num="+num+"&unitprice="+unitprice+"&totalprice="+totalprice+"&fid="+fid,
  					success: function(data){
  						if (data) {
				 	        $.messager.show( {
				 	          title : "提示",
				 	          msg : data + "张机票购买成功!"
				 	        });
				 	        $("#showOrder").window("close",true);
				 	      }
  					}
  				});
  			}
  		}
  	});
  	
  	
 /*    $("#form").form({
    	url : "flightAction_createOrder",
    	onSubmit:function(param){
    		param.num=$('#num').val();
    		param.unitprice=$('#unitprice').val();
    		param.totalprice=$('#unitprice').val()*$('#num').val();
    		param.fid=$('#fid').val();
    		alert("aa");
    	},
    	success : function(data){
    		alert(data);
    		if (data) {
 	        $.messager.show( {
 	          title : "提示",
 	          msg : data + "张机票购买成功!"
 	        });
 	        $("#showOrder").window("close",true);
 	      }
    	}
    }); */
  </script>
</body>
</html>