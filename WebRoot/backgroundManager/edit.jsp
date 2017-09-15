<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Flight CRUD</title>
</head>
<body>
  <s:if test="flight==null">
	  <form action="#" method="post" name="f" id="form">
	    <input type="hidden" name="action" value="add"/>
	    航班名称：<input name="flight.name" type="text" placeholder="航班名"/><br/>
	    航班类型：<input name="flight.flighttype" type="number" placeholder="航班类型"/><br/>
	    出发城市：<input name="flight.fromcity" type="text" placeholder="出发城市"/><br/>
	    到达城市：<input name="flight.tocity" type="text" placeholder="到达城市"/><br/>
	     出发时间：<input name="flight.fromtime" type="text" class="easyui-datetimebox" /><br/>
	     到达时间：<input name="flight.totime" type="text" class="easyui-datetimebox"  /><br/>
	    航班价格：<input name="flight.price" type="number" placeholder="价格"><br/>
	    航班票数：<input name="flight.remainingseats" type="number" placeholder="票数"><br/>
	      
	    <input value="新增" type="submit">
	  </form>
 </s:if>
  <s:else>
	  <form action="#" method="post" name="f" id="form">
      <input type="hidden" name="action" value="modify"/>
         <input name="flight.fid" type="hidden" placeholder="id"
        value="${flight.fid }"/><br/>
     航班名称：<input name="flight.name" type="text" placeholder="航班名"
        value="${flight.name }"/><br/>
        航班类型：<input name="flight.flighttype" type="number" placeholder="航班类型"
        value="${flight.flighttype }"/><br/>
        出发城市：<input name="flight.fromcity" type="text" placeholder="出发城市" value="${flight.fromcity }"/><br/>
	  到达城市：<input name="flight.tocity" type="text" placeholder="到达城市" value="${flight.tocity }"/><br/>
	  出发时间：<input name="flight.fromtime" type="text" placeholder="出发时间"
	      class="easyui-datetimebox" value="${flight.fromtime }"/><br/>
	  到达时间：<input name="flight.totime" type="text" placeholder="到达时间"
	      class="easyui-datetimebox"  value="${flight.totime }"/><br/>
	  航班价格：<input name="flight.price" type="number" placeholder="价格" value="${flight.price }"><br/>
	    航班票数：<input name="flight.remainingseats" type="number" placeholder="票数" value="${flight.remainingseats }"><br/>
      <input value="修改" type="submit">
    </form>
</s:else>

  <script type="text/javascript">
    $("#form").form({
    	url : "../flightActionf_save",
    	success : function(data){ 	
    		if (data) {
 	        $.messager.show( {
 	          title : "提示",
 	          msg : "航班" + data + "成功!"
 	        });
 	       $("#editFlight").window("close",true);
 	      }
    	}
    });
   	  
  </script>
</body>
</html>