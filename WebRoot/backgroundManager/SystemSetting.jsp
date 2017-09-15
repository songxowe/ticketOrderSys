<%@ page language="java"  pageEncoding="UTF-8"%>


<!DOCTYPE HTML >
<html>
  <head>
    
    <title>系统设置</title>
<link rel="stylesheet" type="text/css" href="../easyui/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="../easyui/themes/icon.css" />
<script src="../easyui/jquery.min.js"></script>
<script src="../easyui/jquery.easyui.min.js"></script>
<script src="../easyui/locale/easyui-lang-zh_CN.js"></script>
  </head>
  
<script type="text/javascript">
  	
  	$.extend($.fn.validatebox.defaults.rules, {    
    equals: {    
        validator: function(value,param){    
            return value == $(param[0]).val();    
        },    
        message: '两次输入密码不一致！'   
    }    
});  
		<!--取消提示-->
		function cancel(){
			document.getElementById("tips").style.display="none";
		}
  		<!--验证表单-->
  		function identify(){
			
  			 var newpasword=$.trim($("#newpassword1").val());
  			 var oldpassword=$.trim($("#oldpassword").val());
  			 var url="../adminAction_resetPassword";
  			 
  			 $.ajax({
  			 		type : 'post',
					url : url,					
					data : {
						newpasword:newpasword,
						oldpassword:oldpassword,
					},				
					success : function(data){
							var text=String($.trim(data));
							if (text=='ok') {																
								window.location.href="welcome.html";
							}else if(text=='passwordError'){
							document.getElementById("tips").style.display="inline";
							}
						}
  			 
  			 });
  		}
  	</script>
  <body>
   	<div> 
   		<div style="height:30px;"> 系统设置->修改密码</div>
   		
   		<div>
   			<div style="margin-top: 10px;">
   				<form action="#" method="post" style="text-align:center; ">  					
   					原密码&nbsp;&nbsp;&nbsp;&nbsp;
   					<input type="password" id="oldpassword" class="easyui-validatebox"
   					 data-options="required:true" onclick="cancel()"/>
   					<span  id="tips" style="color: red;display: none;">原密码错误</span>
   					<br><br>
   					新密码&nbsp;&nbsp;&nbsp;&nbsp;
   					<input type="password" id="newpassword1" name="newpassword1" class="easyui-validatebox" 
   						data-options="required:true,validType:'maxLength[6]'"/>
   					<br><br>
   					再次输入新密码
   					<input type="password" id="newpassword2" name="newpassword2" class="easyui-validatebox" 
   							validType="equals['#newpassword1']"
   							data-options="
   							required:true,
   							validType:'maxLength[6]'
   							" />
   					<br><br>
   					
   					<input type="button" value="确定" 
   						style="height:30px;length:100px"
   					 	onclick="identify()" />  					
   				</form>
   			
   			</div>
   			
   		</div>
   	</div>
  </body>
</html>
