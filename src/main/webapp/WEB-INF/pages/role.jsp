<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>角色管理</title>
    <link rel="stylesheet" href="../layui/css/layui.css">
</head>
<style>
    #layui-layer1 {
        top:50px !important;
    }
</style>
<body>
<!-- 数据表格开始 -->
<table class="layui-hide" id="userTable" lay-filter="userTable"></table>
<div style="display: none;" id="userToolBar">
    <button type="button" class="layui-btn layui-btn-sm" lay-event="add">增加</button>
</div>
<div  id="userBar" style="display: none;">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
</div>
<!-- 数据表格结束 -->

<!-- 添加和修改的弹出层开始 -->
<div style="display: none;padding: 20px" id="saveOrUpdateDiv" >
    <form class="layui-form " action="" lay-filter="dataFrm" id="dataFrm">
        <div class="layui-form-item">
            <%--编号在数据库中通过索引自动生成--%>
            <div class="layui-inline">
                <label class="layui-form-label">编号:</label>
                <div class="layui-input-inline">
                    <input type="text" name="id"  lay-verify="required" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">角色名:</label>
                <div class="layui-input-inline">
                    <input type="text" name="name" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-form-item" style="text-align: center;">
            <div class="layui-input-block">
                <button type="button" class="layui-btn layui-btn-normal layui-btn-sm layui-icon layui-icon-release" lay-filter="doSubmit" lay-submit="">提交</button>
                <button type="reset" class="layui-btn layui-btn-warm layui-btn-sm layui-icon layui-icon-refresh" >重置</button>
            </div>
        </div>
    </form>

</div>
<!-- 添加和修改的弹出层结束 -->

<script src="../layui/layui.js"></script>
<script type="text/javascript">
    layui.use([ 'jquery', 'layer', 'form', 'table','laydate','laypage'], function() {
        var $ = layui.jquery;
        var layer = layui.layer;
        var form = layui.form;
        var table = layui.table;
        var laydate = layui.laydate;
        var laypage = layui.laypage;
        var url;
        var mainIndex;
        //绑定时间选择器
        laydate.render({
            elem:'#startTime'
        });
        laydate.render({
            elem:'#endTime'
        });

        //渲染数据表格
        var tableIns = table.render({
            elem:"#userTable",//渲染的table元素
            url:"/getAllRole",//获取用户的请求路径
            title:"角色数据表",
            toolbar:"#userToolBar",//表格上面的添加和批量删除工具条
            height:450,//表格的高度
            cellMinWidth:100,//设置列的最小宽度
            //分页的设置,点击分页插件的按钮时会发送携带参数的请求
            page:{
                curr:1,//当前页
                limit:10,//每页的数据
                groups:3,//显示的页码数
                prev:"上一页",//上一页按钮显示的内容
                next:"下一页",
                first:"首页",
                last:"尾页"
            },
            cols:[[  //表格的列
                {type:"checkbox",fixed:"left"},//可以选中每个元素的复选框
                {field:"id",title:"ID",sort:true,align: "center"},//设置字段
                {field:"name",title:"角色名",align: "center"},
                {title: "操作",fixed: "right",toolbar:"#userBar",width:200,align:"center"}
            ]]
        });

        //监听头部工具栏事件
        table.on("toolbar(userTable)",function(obj){
            switch(obj.event){
                case 'add':
                    //打开添加用户的方法
                    openAddRole();
                    break;
            };
        })
        //打开添加页面
        function openAddRole(){
            mainIndex=layer.open({
                type:1,
                title:'添加角色',
                content:$("#saveOrUpdateDiv"),
                area:['800px','400px'],
                //成功打开这个区域后执行的操作
                success:function(index){
                    //清空表单数据
                    $("#dataFrm")[0].reset();
                    //点击区域中的确认按钮发送的请求路径
                    url="/addRole";
                }
            });
        }
        //监听行工具事件
        table.on('tool(userTable)', function(obj){
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
            if(layEvent === 'edit'){ //编辑
                //打开编辑的窗口
                openUpdateRole(data);
            }
        });
        //打开修改页面
        function openUpdateRole(data){
            mainIndex=layer.open({
                type:1,
                title:'修改角色',
                content:$("#saveOrUpdateDiv"),
                area:['800px','400px'],
                success:function(index){
                    //使用数据渲染表单 form.val("渲染哪个表单",使用什么数据)
                    form.val("dataFrm",data);
                    url="/updateRole";
                }
            });
        }
        //保存
        form.on("submit(doSubmit)",function(obj){
            //序列化表单数据
            var params=$("#dataFrm").serialize();
            var res = $.post(url,params,function(obj){
                layer.msg(res.responseText);
                //关闭弹出层
                layer.close(mainIndex);
                //刷新数据 表格
                tableIns.reload();
            })
        });
    });
</script>
</body>
</html>
