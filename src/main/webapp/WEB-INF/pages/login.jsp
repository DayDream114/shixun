<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html class="loginHtml">
<head>
    <meta charset="utf-8">
    <title>登录--酒店后台管理系统</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="icon" href="../images/favicon.ico">
    <link rel="stylesheet" href="../layui/css/layui.css" media="all" />
    <link rel="stylesheet" href="../css/main.css" media="all" />
</head>
<body class="loginBody">
<form class="layui-form" id="loginFrm" method="post" action="/toLogin">
    <div class="login_face"><img src="../images/face.jpg" class="userAvatar"></div>
    <div class="layui-form-item input-item">
        <label for="username">用户名</label>
        <input type="text" placeholder="请输入用户名" autocomplete="off" id="username" name="username" class="layui-input" lay-verify="required">
    </div>
    <!--显示登录错误的信息-->
    <div style="color:red;font-size: 20px;">${error}</div>
    <br/>
    <br/>
    <div class="layui-form-item input-item">
        <label for="password">密码</label>
        <input type="password" placeholder="请输入密码" autocomplete="off" id="password" name="password" class="layui-input" lay-verify="required">
    </div>
    <%--<div class="layui-form-item input-item" id="imgCode">
        <label for="code">验证码</label>
        <input type="text" placeholder="请输入验证码" autocomplete="off" id="code" class="layui-input">
        <img src="resources/images/code.jpg">
    </div>--%>
    <br/>
    <br/>
    <br/>
    <div class="layui-form-item">
        <button class="layui-btn layui-block" lay-filter="login" lay-submit>登录</button>
    </div>

</form>
<script type="text/javascript" src="../layui/layui.js"></script>
<script type="text/javascript" src="../js/cache.js"></script>
<script type="text/javascript">
    layui.use(['form','layer','jquery'],function(){
        var form = layui.form,
            //layer = parent.layer === undefined ? layui.layer : top.layer,
            $ = layui.jquery;

        //登录按钮
        form.on("submit(login)",function(data){
            $(this).text("登录中...").attr("disabled","disabled").addClass("layui-disabled");
            form.val("login",data);
            setTimeout(function(){
                $("#loginFrm").submit();
            },1000);
            return false;
        });

        //表单输入效果
        $(".loginBody .input-item").click(function(e){
            e.stopPropagation();
            $(this).addClass("layui-input-focus").find(".layui-input").focus();
        });
        $(".loginBody .layui-form-item .layui-input").focus(function(){
            $(this).parent().addClass("layui-input-focus");
        });
        $(".loginBody .layui-form-item .layui-input").blur(function(){
            $(this).parent().removeClass("layui-input-focus");
            if($(this).val() != ''){
                $(this).parent().addClass("layui-input-active");
            }else{
                $(this).parent().removeClass("layui-input-active");
            }
        });
    })
</script>
</body>
</html>
