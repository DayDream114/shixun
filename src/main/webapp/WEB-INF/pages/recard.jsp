
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>业务管理</title>
    <link rel="stylesheet" href="../layui/css/layui.css">
</head>
<style>
    #layui-layer1 {
        top:50px !important;
    }
</style>
<body>
<!-- 数据表格开始 -->
<table class="layui-hide" id="recardTable" lay-filter="recardTable"></table>
<div id="userBar" style="display: none;">
    <a class="layui-btn layui-btn-xs" lay-event="edit">开房</a>
</div>
<!-- 数据表格结束 -->
<!-- 添加和修改的弹出层开始 -->
<div style="display: none;padding: 20px" id="saveOrUpdateDiv" >
    <form class="layui-form " action="" lay-filter="dataFrm" id="dataFrm">
        <div class="layui-form-item">
            <%--编号在数据库中通过索引自动生成--%>
            <div class="layui-inline">
                <label class="layui-form-label">姓名:</label>
                <div class="layui-input-inline">
                    <input type="text" name="name"  lay-verify="required" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">身份证号:</label>
                <div class="layui-input-inline">
                    <input type="text" name="idcard" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">房间号:</label>
                <div class="layui-input-inline">
                    <input type="text" name="roomid" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
                <div class="layui-inline">
                    <label class="layui-form-label">房间类型:</label>
                    <div class="layui-input-inline">
                        <input type="text" name="roomtype" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">请选择日期</label>
                        <div class="layui-input-inline">
                            <input type="date" class="layui-input" name="Stime" id="ID-laydate-demo" placeholder="yyyy-mm-dd">
                        </div>
                    </div>
        </div>
                <div class="layui-form-item" style="text-align: center;">
                    <div class="layui-input-block">
                        <button type="button" class="layui-btn layui-btn-normal layui-btn-sm layui-icon layui-icon-release" lay-filter="doSubmit" lay-submit="">提交</button>
                        <button type="reset" class="layui-btn layui-btn-warm layui-btn-sm layui-icon layui-icon-refresh" >重置</button>
                    </div>
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
            elem: '#startTime'
        });
        laydate.render({
            elem: '#endTime'
        });

        //渲染数据表格
        var tableIns = table.render({
            elem: "#recardTable",//渲染的table元素
            url: "/getFreeRoom",//获取用户的请求路径
            title: "空闲房间表",
            toolbar: "#userToolBar",//表格上面的添加和批量删除工具条
            height: 450,//表格的高度
            cellMinWidth: 100,//设置列的最小宽度
            //分页的设置,点击分页插件的按钮时会发送携带参数的请求
            page: {
                curr: 1,//当前页
                limit: 10,//每页的数据
                groups: 3,//显示的页码数
                prev: "上一页",//上一页按钮显示的内容
                next: "下一页",
                first: "首页",
                last: "尾页"
            },
            cols: [[  //表格的列
                {type: "checkbox", fixed: "left"},//可以选中每个元素的复选框
                {field: "roomid", title: "房间号", sort: true, align: "center"},//设置字段
                {field: "roomtype", title: "房间类型", align: "center"},
                {field: "price",title: "价格",align: "center"},
                {field: "state",title: "房间状态",align: "center"},
                {title: "操作", fixed: "right", toolbar: "#userBar", width: 200, align: "center"}
            ]]
        });
        //监听头部工具栏事件
//监听行工具事件
        table.on('tool(recardTable)', function(obj){
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
                openOpenRoom(data);
            }
        });

        var url;
        var mainIndex;
        function openOpenRoom(data){
            mainIndex=layer.open({
                type:1,
                title:'开房信息',
                content:$("#saveOrUpdateDiv"),
                area:['800px','400px'],
                success:function(index){
                    //使用数据渲染表单 form.val("渲染哪个表单",使用什么数据)
                    form.val("dataFrm",data);
                    url="/openRoom";
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
        layui.use(function(){
            var laydate = layui.laydate;
            // 自定义格式
            laydate.render({
                elem: '#ID-laydate-demo',
                format: 'yyyy年MM月dd日'
            });
        });
    });
</script>
</body>
</html>
