<%@ page language="java"  pageEncoding="UTF-8"%>

<!DOCTYPE HTML>
<html>
  <head>
    <title>航班管理</title>   
<link rel="stylesheet" type="text/css" href="../easyui/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="../easyui/themes/icon.css" />
<script src="../easyui/jquery.min.js"></script>
<script src="../easyui/jquery.easyui.min.js"></script>
<script src="../easyui/locale/easyui-lang-zh_CN.js"></script>

</head>
  
  <body style="background-color:#F5F6F7;float: left;width:99%;text-align: center;">
  <div style="margin: 10px 30px">

    <div id="searchFlightForm" style="padding: 10px">
  	    <div style="margin-bottom: 10px">
        <a href="#" class="easyui-linkbutton"
           iconCls="icon-add" plain="true"
           onclick="flight_obj.showEdit('add');">新增</a>
        <a href="#" class="easyui-linkbutton"
           iconCls="icon-edit" plain="true"
           onclick="flight_obj.showEdit('modify');">修改</a>
        <a href="#" class="easyui-linkbutton"
           iconCls="icon-remove" plain="true"
           onclick="flight_obj.remove();">删除</a>
      </div>
      <div id="editFlight"></div>
  
  <div style="padding: 0 0 0 6px"> 
        &nbsp;
        <input style="width:100px" placeholder="航班名称" type="text" id="name"/>
        <input style="width:100px" placeholder="出发城市" type="text" id="fromCity"/>
        <input style="width:100px" placeholder="到达城市" type="text" id="toCity"/>
        <input style="width:120px" placeholder="出发时间" type="date" id="fromtime"/>
        <a href="#" class="easyui-linkbutton"
           iconCls="icon-search"
           onclick="flight_obj.search();">查询</a>  
      </div>   
      </div>
   
  <div style="margin-top: 10px">
			<table id="flightDataGrid">

			</table>
	</div>
	
	</div>
	
	<script type="text/javascript">
	 $(function(){
	   flight_obj = {
			  editRow : undefined,
			  search : function(){
			   var name=$('#name').val();
			   var fromCity=$('#fromCity').val();
			   var toCity=$('#toCity').val();
			    var fromtime=$('#fromtime').val();
			  $("#flightDataGrid").datagrid('load',{
				  name:name,
				  fromCity:fromCity,
				  toCity:toCity,
				  fromtime:fromtime,
			  });
			  },
			   showEdit : function(state){
		    	var url = "";
		    	var info = "";
		    	var fid = 0;
		    	if(state=="add"){
		    		info = "新增航班";
		    		url = "edit.jsp";
		    	}else{
		    		info = "修改航班";
		    		var rows = $('#flightDataGrid').datagrid("getSelections");
		    		if(rows.length==1){
		    			var fid = rows[0].fid;
		    		 	url = "../flightActionf_findById?flight.fid="+fid;
		    		}else{
		    			$.messager.alert("警告", "必须只选中一行", "warning");
		          return;
		    		}		    		
		    	}
		    	
		    	$("#editFlight").window({
            title : info,
            width : 300,
            height : 330,
            top:20,
            left: 200,
            minimizable : false,  
            href : url,
            onClose : function(){
              $('#flightDataGrid').datagrid("load");
            }
          });
        
		    },
     
        remove : function() { 
          // 返回所有被选中的行，当没有记录被选中的时候将返回一个空数组
          var rows = $("#flightDataGrid").datagrid("getSelections");
          if(rows.length > 0) {
            $.messager.confirm("消息","确认真的要删除所选的数据吗",function(flag){
            if(flag){
	          var ids = [];
	          for(var i=0;i<rows.length;i++){
	            ids.push(rows[i].fid);
	          }
	          $.ajax({
	            type : "post",
	            url : "../flightActionf_remove",
	            data : {
	              ids : ids.join(","),
	            },
	            beforeSend : function(){
	            // 显示载入状态
	              $("#flightDataGrid").datagrid("loading");
	            },
	            success : function(data){
	              if(data) {
	              // 隐藏载入状态
	              $("#flightDataGrid").datagrid("loaded");
	              // 加载和显示第一页的所有行
	              $("#flightDataGrid").datagrid("load");
	              // 取消选择所有当前页中所有的行
	              $("#flightDataGrid").datagrid("unselectAll");
	              $.messager.show({
	              title : "提示",
	              msg : data + "个航班被删除"
	              });
	            }
            }
          });
           }
          });
          }else {
            $.messager.alert("警告", "请选中要删除的数据","warning");
          }
        }
		  }
			  
		  $("#flightDataGrid").datagrid({
	      url:'../flightActionf_list',   // 一个URL从远程站点请求数据
	      title : '航班管理',
	      fitColumns : true, // 自动展开/收缩列
	      striped : true,    // 显示斑马线效果
	      rownumbers : true, // 行号
	      columns:[[{ // -- 列开始 ---------
	        field : 'fid',
	        title : '航班编号',
	        width : 15,
	        checkbox : true,
	        sortable : true,
	      },{
	        field : 'name',
	        title : '航班名称',
	        width : 50,
	        sortable : true,
	        editor : {
	          type : "validatebox",
	          options : {
	            required : true
	          }
	        }
	      },{ 
	        field : 'flighttype',
	        title : '航班类型',
	        width : 35,
	        sortable : true,
	        formatter : function(value,rowData,rowIndex){
	        	var flighttype=rowData["flighttype"];
	        	if(flighttype==0){
	        	return '国内航班';
	        	}else{
	        	return '国外航班';
	        	}
	        }
	      },{ 
	        field : 'fromcity',
	        title : '出发城市',
	        width : 35,
	        sortable : true,
	    	editor : {
	          type : "validatebox",
	          options : {
	            required : true
	          }
	        }
	      },{ 
	        field : 'tocity',
	        title : '到达城市',
	        width : 35,
	        sortable : true,
	    	editor : {
	          type : "validatebox",
	          options : {
	            required : true
	          }
	        }
	      },{
	        field : 'fromtime',
	        title : '出发日期',
	        width : 55,
	        sortable : true,
	        editor : {
	          type : "datetimebox",
	          options : {
	            required : false
	          }
	        }
	      },{
	        field : 'totime',
	        title : '到达日期',
	        width : 55,
	        sortable : true,
	        editor : {
	          type : "datetimebox",
	          options : {
	            required :false
	          }
	        }
	      },{
	        field : 'price',
	        title : '航班票价(元)',
	        width : 35,
	        sortable : true,
	        editor : {  // 编辑器 (新增/修改时编辑字段)
	          type : "numberbox",
	          options : {
	            required : true,
	            min : 1,
	            precision : 2
	          }
	        }
	      },{
	        field : 'remainingseats',
	        title : '余票(张)',
	        width : 30,
	        sortable : true,
	        editor : {
	          type : "numberbox",
	          options : {
	            required : true
	          }
	        }
	      }]], // -- 列结束 ---------
	      
	      toolbar : "#searchFlightForm",
	      pagination : true, // -- 分页设置 ----
	      pageSize : 5,// rows:每页显示的记录条数 (page 控件自动计算)
	      pageList : [ 5, 10, 15, 20, 50 ],// 设置每页条数的列表
	      sortName : "id", // sort:排序列 (默认)
	      sortOrder : "ASC", 
	      
	
	 
	 });
	 
	
	});
	
	
	</script>
 
</body>
</html>
