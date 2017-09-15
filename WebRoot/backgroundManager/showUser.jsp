<%@ page language="java" pageEncoding="UTF-8"%>

<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title></title>
<link rel="stylesheet" type="text/css"
	href="../easyui/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="../easyui/themes/icon.css" />
<script src="../easyui/jquery.min.js"></script>
<script src="../easyui/jquery.easyui.min.js"></script>
<script src="../easyui/locale/easyui-lang-zh_CN.js"></script>
</head>

<body>
	<div style="margin: 0px 0px">
	  <div id="searchUserForm" style="padding: 0px">
	    <div style="margin-bottom: 10px">
        <a href="#" class="easyui-linkbutton"
           iconCls="icon-edit" plain="true"
           onclick="user_obj.edit();">修改</a>
        <a href="#" class="easyui-linkbutton"
           iconCls="icon-save" plain="true"
           style="display: none" id="save"
           onclick="user_obj.save();">保存</a>
        <a href="#" class="easyui-linkbutton"
           iconCls="icon-redo" plain="true"
           style="display: none" id="redo"
           onclick="user_obj.redo();">取消编辑</a>
        <a href="#" class="easyui-linkbutton"
           iconCls="icon-remove" plain="true"
           onclick="user_obj.remove();">删除</a>
      </div>
	  
	    <div style="padding: 0 0 0 6px">
        &nbsp;
        <input placeholder="用户名" type="text" id="name"/>
        
        <a href="#" class="easyui-linkbutton"
           iconCls="icon-search"
           onclick="user_obj.search();">查询</a>
      </div>
	  </div>
	  
		<div style="margin-top: 10px">
			<table id="userDataGrid">

			</table>
		</div>
	</div>
	<script type="text/javascript">
	  $(function(){
		  user_obj = {
			  editRow : undefined,
			  search : function(){
			  	var name=$('#name').val();
			  	
				  $("#userDataGrid").datagrid('load',{
					username : name,
					// name :$("#name").value,
          });
			  },
			  add : function(){ 
	        $("#save,#redo").show();
	        if(this.editRow == undefined){
	          // 在第一行的位置插入一个新行
	          $("#userDataGrid").datagrid("insertRow",{
	            index : 0, // 数据行索引
	            row : {}
	          });
	          
	          //将第一行设为可编辑状态
	          $("#userDataGrid").datagrid("beginEdit",0);
	          this.editRow = 0;
	        }
	      },
	      save : function(){ 
          //将指定行设为结束编辑状态
          $("#userDataGrid").datagrid("endEdit",this.editRow);
        },
        redo : function(){  
          this.editRow = undefined;
          $("#save,#redo").hide();
          // 回滚所有从创建或者上一次调用acceptChanges函数后更改的数据
          $("#userDataGrid").datagrid("rejectChanges");
        },
        edit : function(){ 
          // 返回所有被选中的行，当没有记录被选中的时候将返回一个空数组
          var rows = $("#userDataGrid").datagrid("getSelections");
          if(rows.length == 1){
           if(this.editRow != undefined){ // add-edit
             $("#userDataGrid").datagrid("endEdit",this.editRow);
           }
           
            if(this.editRow == undefined){ // edit
             var rowIndex = $("#userDataGrid").datagrid(
                    "getRowIndex", rows[0]);
              $("#userDataGrid").datagrid("beginEdit", rowIndex);
              $("#save,#redo").show();
              this.editRow = rowIndex; // 设置当前选中行为编辑行
              // 取消选中 (原因:已知此行是编辑行)
              $("#userDataGrid").datagrid("unselectRow", rowIndex);
            }
          }else if(rows.length > 1){
             $.messager.alert("警告", "只能选中一行","warning");
          }else{
            $.messager.alert("警告", "必须选中一行","warning");
          }
        },
        remove : function() { 
          // 返回所有被选中的行，当没有记录被选中的时候将返回一个空数组
          var rows = $("#userDataGrid").datagrid("getSelections");
          if(rows.length > 0) {
            $.messager.confirm("消息","确认真的要删除所选的数据吗",function(flag){
            if(flag){
	          var ids = [];
	          for(var i=0;i<rows.length;i++){
	            ids.push(rows[i].userid);
	          }
	          $.ajax({
	            type : "post",
	            url : "../userAction_remove",
	            data : {
	              ids : ids.join(","),
	            },
	            beforeSend : function(){
	            // 显示载入状态
	              $("#userDataGrid").datagrid("loading");
	            },
	            success : function(data){
	              if(data) {
	              // 隐藏载入状态
	              $("#userDataGrid").datagrid("loaded");
	              // 加载和显示第一页的所有行
	              $("#userDataGrid").datagrid("load");
	              // 取消选择所有当前页中所有的行
	              $("#userDataGrid").datagrid("unselectAll");
	              $.messager.show({
	              title : "提示",
	              msg : data + "个用户被删除"
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
		  
		  // -----------------------------------------
		  $("#userDataGrid").datagrid({
	      url:'../userAction_list',   // 一个URL从远程站点请求数据
	      title : '用户列表',
	      fitColumns : true, // 自动展开/收缩列
	      striped : true,    // 显示斑马线效果
	      rownumbers : true, // 行号
	      columns:[[{ // -- 列开始 ---------
	        field : 'userid',
	        title : '序号',
	        width : 50,
	        checkbox : true,
	        sortable : true
	      },{
	        field : 'username',
	        title : '用户名',
	        width : 100,
	        sortable : true,
	        editor : {
	          type : "validatebox",
	          options : {
	            required : true
	         }
	         }
	      },{
	        field : 'password',
	        title : '密码',
	        width : 100,
	        sortable : true,
	        editor : {  // 编辑器 (新增/修改时编辑字段)
	          type : "validatebox",
	          options : {
	            required : true,
	            min : 1,
	            precision : 2
	          }
	          }
	        
	      },{
	        field : 'truename',
	        title : '真实姓名',
	        width : 100,
	        sortable : true,
	        editor : {
	          type : "validatebox",
	          options : {
	            required : true
	          }
	          }
	          
	           },{
	        field : 'sex',
	        title : '性别',
	        width : 100,
	        sortable : true,
	        editor : {
	          type : "numberbox",
	          options : {
	            required : true
	          }
	          },
			formatter:function(value,row,index){
				if(row.sex=="1"){
					return "男";
				};
				if(row.sex=="0"){
					return "女";
				}
			} ,	        
	         },{
	        field : 'idcard',
	        title : '身份证',
	        width : 100,
	        sortable : true,
	        editor : {
	          type : "validatebox",
	          options : {
	            required : true
	          }
	          }
	          },{
	        field : 'phone',
	        title : '电话',
	        width : 100,
	        sortable : true,
	        editor : {
	          type : "validatebox",
	          options : {
	            required : true
	          }
	          }
	          
	        
	      }]], // -- 列结束 ---------
	      toolbar : "#searchUserForm",
	      pagination : true, // -- 分页设置 ----
	      pageSize : 5,// rows:每页显示的记录条数 (page 控件自动计算)
	      pageList : [ 5, 10, 15, 20, 50 ],// 设置每页条数的列表
	      sortName : "userid", // sort:排序列 (默认)
	      sortOrder : "ASC", 
	      
	      
	      
	      onAfterEdit : function(rowIndex, rowData, changes){
          $("#save,#redo").hide();
          
          // 从上一次的提交获取改变的所有行
          var inserted = $("#userDataGrid").datagrid("getChanges","inserted");
          var updated = $("#userDataGrid").datagrid("getChanges","updated");
          
          var url = "../userAction_save";
          var state = "";
          if(inserted.length > 0){ // 新增
            state = "新增";
          }
          if(updated.length > 0){ // 修改
            state = "修改";
          }
       
          
          $.ajax({
            url : url,
            type : "post",
            data : { user : rowData },
            beforeSend : function(){
              // 显示载入状态
              $("#userDataGrid").datagrid("loading");
            },
            success : function(data){
              if(data){
                // 隐藏载入状态
                $("#userDataGrid").datagrid("loaded");
                // 加载和显示第一页的所有行
                $("#userDataGrid").datagrid("reload");
                // 取消选择所有当前页中所有的行
                $("#userDataGrid").datagrid("unselectAll");
                $.messager.show({
                  title : "提示",
                  msg : data + "个用户被" + state
                });
              }
              user_obj.editRow = undefined;
            }
          });
        },
	        
        onDblClickRow : function(rowIndex, rowData){
          if (user_obj.editRow != undefined) {
            $("#userDataGrid").datagrid("endEdit", user_obj.editRow);
          }
          if (user_obj.editRow == undefined) {
            $("#userDataGrid").datagrid("beginEdit", rowIndex);
            $("#save,#redo").show();
            user_obj.editRow = rowIndex;
          }
        }
		  });
	  });
	</script>
</body>
</html>




