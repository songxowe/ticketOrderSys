<%@ page language="java" pageEncoding="utf-8"%>


<!DOCTYPE HTML >
<html>
  <head>
    <title>alteration</title>
	    <link rel="stylesheet" type="text/css" href="easyui/themes/default/easyui.css" />
		<link rel="stylesheet" type="text/css" href="easyui/themes/icon.css" />
		<script src="easyui/jquery.min.js"></script>
		<script src="easyui/jquery.easyui.min.js"></script>
		<script src="easyui/locale/easyui-lang-zh_CN.js"></script>
  </head>
  
  <body>
		<h3>改签</h3>
    	<div>
    	
    		<table id="alteration">
    		
    		</table>
    	</div>
  </body>
  <script type="text/javascript">
  	  $(function(){ 
  	  	alert("开始加载数据...");   
    	$("#alteration").datagrid({
    		url:'personalCenterAction_find',   // 一个URL从远程站点请求数据
        title : '用户信息',
      
        columns:[[{
        	field : 'userid',
          	width : 50,
          	checked: true,
        },{ // -- 列开始 ---------
          field : 'userid',
          title : '序号',
          width : 50
        },{
          field : 'username',
          title : '用户名',
          width : 100,
        
        },{
          field : 'password',
          title : '密码',
          width : 100,
        },{
          field : 'truename',
          title : '真实姓名',
          width : 100,
        
        },{
          field : 'sex',
          title : '性别',
          width : 100,
           formatter : function(value, rowData, rowIndex){
 	        	  var sex = rowData["sex"];
 	        	  if(sex%2==0){
 	        	  	return  '男';
 	        	  }else{
 	        	 	 return '女';
 	        	  }	        	  
 	         }        
        },{
          field : 'phone',
          title : '联系电话',
          width : 100,
        },{ // 新增一列
 	        field : 'op1',
 	          title : '操作',
 	          width : 100,
 	          formatter : function(value, rowData, rowIndex){
 	        	  var userid = rowData["userid"];
 	        	  //alert(empno); // 字符串参数需单引号
 	        	  return "<a href='#' onclick='getUser("+userid+")'>修改</a>";
 	         }
 	        }  
        
        ]], // -- 列结束 ---------
 	        	 // return "<a href='#' onclick='getUser("+userid+")'>修改</a>";
 	 	 });
 	 	 
 	 	});
  </script>
</html>
