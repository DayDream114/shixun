<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>客房管理</title>
    <link rel="stylesheet" href="../layui/css/layui.css">
</head>
<style>
    #layui-layer1 {
        top:50px !important;
    }
</style>
<body>
<!-- 搜索条件开始 -->
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
    <legend>查询条件</legend>
</fieldset>
<form id="searchFrm" class="layui-form" method="post">
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">房间号:</label>
            <div class="layui-input-inline">
                <input type="text" name="roomid"  autocomplete="off" class="layui-input">
        </div>
        </div>
    <div class="layui-inline">
            <label class="layui-form-label">房间类型:</label>
            <div class="layui-input-inline">
                <!--使用下拉框显示所有的角色权限-->
                <select name="roomtype">
                    <option value="">请选择</option>
                    <!--使用jstl核心标签库+el表达式来循环数据-->
                    <option value="标准间">标准间</option>
                    <option value="单人间">单人间</option>
                    <option value="豪华间">豪华间</option>

                </select>
            </div>
    </div>
    <div class="layui-inline">
        <label class="layui-form-label">房间状态:</label>
        <div class="layui-input-inline">
            <!--使用下拉框显示所有的角色权限-->
            <select name="state">
                <option value="">请选择</option>
                <!--使用jstl核心标签库+el表达式来循环数据-->
                <option value="空闲">空闲</option>
                <option value="居住">居住</option>
                <option value="打扫">打扫</option>

            </select>
        </div>
    </div>
        <div class="layui-inline" style="margin-left: 400px;">
            <button type="button" class="layui-btn layui-btn-normal layui-btn-sm layui-icon layui-icon-search" id="doSearch">查询</button>
            <button type="reset" class="layui-btn layui-btn-warm layui-btn-sm layui-icon layui-icon-refresh">重置</button>
        </div>
    </div>
</form>

<!-- 搜索条件结束 -->


<!-- 数据表格开始 -->
<table class="layui-hide" id="userTable" lay-filter="userTable"></table>
<div style="display: none;" id="userToolBar">
    <button type="button" class="layui-btn layui-btn-sm" lay-event="add">增加</button>
</div>
<c:if test="${room.state=='空闲'}">
<div  id="userBar" style="display: none;">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</div>
</c:if>
<!-- 数据表格结束 -->

<!-- 添加和修改的弹出层开始 -->
<div style="display: none;padding: 20px" id="saveOrUpdateDiv" >
    <form class="layui-form " action="" lay-filter="dataFrm" id="dataFrm">
        <div class="layui-form-item">
            <%--编号在数据库中通过索引自动生成--%>
            <div class="layui-inline">
                <label class="layui-form-label">房间号:</label>
                <div class="layui-input-inline">
                    <input type="text" name="roomid"  lay-verify="required" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">种类:</label>
                <div class="layui-input-inline">
                    标准间<input type="radio" name="roomtype" value="标准间" autocomplete="off" class="layui-input">
                    单人间<input type="radio" name="roomtype" value="单人间" autocomplete="off" class="layui-input">
                    豪华间<input type="radio" name="roomtype" value="豪华间" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">价格:</label>
                <div class="layui-input-inline">
                    <input type="text" name="price"  lay-verify="required" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">房间状态:</label>
                <div class="layui-input-inline" style="width: 250px;">
                    空闲<input type="radio" value="空闲" name="state" autocomplete="off" class="layui-input" checked>
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
        url:"/getAllRoom",//获取用户的请求路径
        title:"房间数据表",
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
            {field:"roomid",title:"房间号",sort:true},//设置字段
            {field:"roomtype",title:"房间类型"},
            {field:"price",title:"价格"},
            {field:"state",title:"状态"},
            {title: "操作",fixed: "right",toolbar:"#userBar",width:200,align:"center"}
        ]]
    });

    //监听头部工具栏事件
    table.on("toolbar(userTable)",function(obj){
        switch(obj.event){
            case 'add':
                //打开添加用户的方法
                openAddRoom();
                break;

        };
    })

    //监听行工具事件
    table.on('tool(userTable)', function(obj){
        var data = obj.data; //获得当前行数据
        var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
        if(layEvent === 'del'){ //删除
            layer.msg("删除");
            layer.confirm('真的删除行么', function(index){
                //向服务端发送删除指令
                deleteUser(data.roomid);
            });
        } else if(layEvent === 'edit'){ //编辑
            //打开编辑的窗口
            openUpdateUser(data);
        }
    });

    var url;
    var mainIndex;

    //模糊查询
    $("#doSearch").click(function () {
        url = "/getAllRoom";
        var params = $("#searchFrm").serialize();
        //使用查询的参数再次更新表格数据
        tableIns.reload({
            url:url+"?"+params
        })
    });
    //打开添加页面
    function openAddRoom(){
        mainIndex=layer.open({
            type:1,
            title:'添加房间',
            content:$("#saveOrUpdateDiv"),
            area:['800px','400px'],
            //成功打开这个区域后执行的操作
            success:function(index){
                //清空表单数据
                $("#dataFrm")[0].reset();
                //点击区域中的确认按钮发送的请求路径
                url="/addRoom";
            }
        });
    }
    //打开修改页面
    function openUpdateUser(data){
        mainIndex=layer.open({
            type:1,
            title:'修改用户',
            content:$("#saveOrUpdateDiv"),
            area:['800px','400px'],
            success:function(index){
                //使用数据渲染表单 form.val("渲染哪个表单",使用什么数据)
                form.val("dataFrm",data);
                url="/updateRoom";
            }
        });
    }
    //删除
    function deleteUser(roomid){
        url="/deleteRoom";
        var res = $.post(url,{"roomid":roomid},function(obj){
            layer.msg(res.responseText);
            //刷新数据 表格
            tableIns.reload();
        })
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
