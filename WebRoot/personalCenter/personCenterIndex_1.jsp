<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib  prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML >
<html>
 	<head>
	<meta charset="utf-8">
    
    <title>用户个人中心</title>
<link rel="stylesheet" type="text/css" href="../easyui/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="../easyui/themes/icon.css" />
<script src="../easyui/jquery.min.js"></script>
<script src="../easyui/jquery.easyui.min.js"></script>
<script src="../easyui/locale/easyui-lang-zh_CN.js"></script>
   	<style type="text/css">
   		
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
    		
    		width: 30%;
    		
    		height: 150px;
    	}
    	#showContent{
    		float: right;
    		
    		width: 70%;
    		
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
	
		
		
   </style>
  </head>
  	
  <body>
  	<div id="editer">
            	
	  <div id="main">
			  	<div id="head">
			  		<img src="../img/indexHead.png" style="width: 960px;height: 150px;"/>
			  	</div>
	  	<div id="personalCenter" >
			  		<div class="titleleft" style="line-height:35px;color:white;">
			  			&nbsp;&nbsp;用户个人中心
			  		</div>
			  	<div id="pc">
			  		<div id="ui">
			  			
			  			&nbsp;&nbsp;用户信息
			  		</div>
			  		<div id="tm">
			  			&nbsp;&nbsp;<a href="../personalCenterAction_showOrder">预定管理</a>
			  		</div>
			  		<div id="xq">
			  			&nbsp;&nbsp;<a href="../index.jsp" class="a">返回首页</a>
			  		</div>
			  	</div>
	  	</div>
	  	<div id="showContent">
			  		<div class="titleright" style="height:35px;line-height:35px; background-color: #C0C0C0">
			  			&nbsp;&nbsp;用户信息
			  		</div>	
			  		
			  		 
        					  		
			  		<div >
			  			<table id="userinfo">
			  			</table>			  			
			  		</div>
			  		<div id="editUser"></div>
			  		
	  	</div>
	  	<div id="bottom">
	  	</div>
	  	
	  </div>
  </body>
  <script type="text/javascript">
  	// 2.自动加载表格数据
  	
   $(function(){    
    	$("#userinfo").datagrid({
   		url:'../personalCenterAction_find',   // 一个URL从远程站点请求数据
        title : '用户信息',
        columns:[[{ // -- 列开始 ---------
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
 	        	  	return  '女';
 	        	  }else{
 	        	 	 return '男';
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
 	        	  return "<a href='#' onclick='getUser()'>修改</a>";
 	         }
 	        }  
        
        ]], // -- 列结束 ---------
 	        	 // return "<a href='#' onclick='getUser("+userid+")'>修改</a>";
 	 	 });
 	 	 
 	 	});
 
    	//修改 user
    	 function getUser(){
    		
    	$("#editUser").window({
    	title : "修改用户信息",
        width : 450,
        height : 500,
      //  modal : true,
        minimizable : false,
    	href : "../personalCenterAction_findById",
    	onClose : function(){
              $('#userinfo').datagrid("reload");
            }
    	});
    }
    
  </script>
</html>
