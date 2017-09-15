<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>用户修改信息</title>
<style>
	.body{
	text-align: center;
	}
</style>
</head>
<body>
  <c:if test="${empty user == false }">
    <h3 style="text-align: center">修改用户信息</h3>
    <div style="text-align: center">
    	<form method="post" id="form">
	      用户编号<input name="user.userid" type="number" width="10"
	        readonly="readonly" value="${user.userid }"/><br/><br/>
	      用户名&nbsp;<input name="user.username" type="text" width="10"
	        value="${user.username}"/><br/><br/>
	      密码&nbsp;&nbsp;<input name="user.password" type="text" width="10"
	        value="${user.password }"/><br/><br/>
	      真实姓名<input name="user.truename" type="text" width="10"
	        value="${user.truename }"/><br/><br/>
	     	性别&nbsp;&nbsp;<select name="user.sex"  style="width: 174px;text-align: center;">
		      <option value="1" ${user.sex==1?'selected':'' }>男</option>
		      <option value="0" ${user.sex==1?'':'selected' }>女</option>
		    </select><br/><br/>
	        联系方式<input name="user.phone" type="text" width="10"
	        value="${user.phone }"/><br/><br/>
	      <input value="修改" type="submit" width="10"/>
    	</form>
    </div>
  </c:if>
  <script type="text/javascript">
    $("#form").form({
    	url : "../personalCenterAction_modify",
    	success : function(data){
    		if (data) {
 	        $.messager.show( {
 	          title : "提示",
 	          msg : "用户" + data + "成功!"
 	        });
 	        $("#editUser").window("close",true);
 	      }
    	}
    });
  </script>
</body>
</html>