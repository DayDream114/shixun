<%@ page import="com.ecjtu.pojo.Role" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>用户管理</title>
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
<%--        <div class="layui-inline">--%>
<%--            <label class="layui-form-label">id:</label>--%>
<%--            <div class="layui-input-inline">--%>
<%--                <input type="text" name="id"  autocomplete="off" class="layui-input">--%>
<%--            </div>--%>
<%--        </div>--%>
        <div class="layui-inline">
            <label class="layui-form-label">用户名:</label>
            <div class="layui-input-inline">
                <input type="text" name="username"  autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">手机号:</label>
            <div class="layui-input-inline">
                <input type="tel" name="tel"  autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">角色权限:</label>
            <div class="layui-input-inline">
                 <!--使用下拉框显示所有的角色权限-->
                 <select name="role">
                     <option value="">请选择</option>
                     <!--使用jstl核心标签库+el表达式来循环数据-->
                     <c:forEach items="${roleList}" var="role">
                         <option value="${role.id}">${role.name}</option>
                     </c:forEach>
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
<!--工具条元素,提供添加和批量删除功能-->
<c:if test="${user.role=='酒店经理'}">
    <div style="display: none;" id="userToolBar">
        <button type="button" class="layui-btn layui-btn-sm" lay-event="add">增加</button>
        <button type="button" class="layui-btn layui-btn-sm" lay-event="batchDelete">批量删除</button>
    </div>
    <div id="userBar" style="display: none;">
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
                <label class="layui-form-label">编号:</label>
                <div class="layui-input-inline">
                    <input type="text" name="id"  lay-verify="required" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">用户名:</label>
                <div class="layui-input-inline">
                    <input type="text" name="username" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
                <div class="layui-inline">
                    <label class="layui-form-label">密码:</label>
                    <div class="layui-input-inline">
                        <input type="text" name="password" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
            <div class="layui-inline">
                <label class="layui-form-label">电话:</label>
                <div class="layui-input-inline">
                    <input type="text" name="tel"  lay-verify="required|tel" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">角色:</label>
                <div class="layui-input-inline" style=" width: 350px;">
                    <!--可以通过后端获取角色表的所有字段，将对应的字符串循环打印出来-->
                    大堂职员<input type="radio" name="role" value="1" lay-verify="required" autocomplete="off" class="layui-input">
                    酒店经理<input type="radio" name="role" value="2" lay-verify="required" autocomplete="off" class="layui-input">
                    酒店后勤<input type="radio" name="role" value="3" lay-verify="required" autocomplete="off" class="layui-input">
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
            url:"/getAllUsers",//获取用户的请求路径
            title:"用户数据表",
            toolbar:"#userToolBar",//表格上面的添加和批量删除工具条
            height:450,//表格的高度
            cellMinWidth:100,//设置列的最小宽度
            //分页的设置,点击分页插件的按钮时会发送携带参数的请求
            page:{
                curr:1,//当前页
                limit:8,//每页的数据
                groups:3,//显示的页码数
                prev:"上一页",//上一页按钮显示的内容
                next:"下一页",
                first:"首页",
                last:"尾页"
            },
            cols:[[  //表格的列
                {type:"checkbox",fixed:"left"},//可以选中每个元素的复选框
                {field:"id",title:"ID",sort:true},//设置字段
                {field:"username",title:"用户名"},
                {field:"tel",title:"电话"},
                {
                    field:"role",title:"角色"
                    //如果是int类型,通过templet函数根据字段返回对应数据
                    // templet:function (data) {
                    //     //data就是数据
                    //     if(data.role=='1'){
                    //         return "超级管理员";
                    //     }else if(data.role='2'){
                    //         return "普通用户";
                    //     }else{
                    //         return "黄金VIP";
                    //     }
                    // }
                },
                {title: "操作",fixed: "right",toolbar:"#userBar",width:200,align:"center"}
            ]]
        });

        //监听头部工具栏事件
        table.on("toolbar(userTable)",function(obj){
            switch(obj.event){
                case 'add':
                    //打开添加用户的方法
                    openAddUser();
                    break;
                case 'batchDelete':
                    //打开删除用户的方法
                    deleteBatch();
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
                    deleteUser(data.id);
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
            url = "/getAllUsers";
            var params = $("#searchFrm").serialize();
            //使用查询的参数再次更新表格数据
            tableIns.reload({
                url:url+"?"+params
            })
        });
        //打开添加页面
        function openAddUser(){
            mainIndex=layer.open({
                type:1,
                title:'添加用户',
                content:$("#saveOrUpdateDiv"),
                area:['800px','400px'],
                //成功打开这个区域后执行的操作
                success:function(index){
                    //清空表单数据
                    $("#dataFrm")[0].reset();
                    //点击区域中的确认按钮发送的请求路径
                    url="/addUser";
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
                    url="/updateUser";
                }
            });
        }
        //删除
        function deleteUser(id){
            url="/deleteUser";
            var res = $.post(url,{"ids":id},function(obj){
                layer.msg(res.responseText);
                //刷新数据 表格
                tableIns.reload();
            })
        }
        //批量删除
        function deleteBatch(){
            //得到选中的数据行
            var checkStatus = table.checkStatus('userTable');
            var data = checkStatus.data;
            var params = "";
            url = "/deleteUser";
            $.each(data,function (index, elem) {
                if (index == 0){
                    params += "ids="+elem.id;
                } else {
                    params += "&ids=" +elem.id;
                }
            });
            layer.confirm('真的要删除这些用户吗？',function (index) {
                var res = $.post(url,params,function (res) {
                    layer.msg(res);
                    //刷新数据 表格
                    tableIns.reload();
                })
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
