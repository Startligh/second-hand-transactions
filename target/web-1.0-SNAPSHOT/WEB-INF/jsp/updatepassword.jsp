<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ page language="java" contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8" %>
<html>
<head>
    <title>登录</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
    <style type="text/css">
        .container{
            width: 420px;
            height: 380px;
            min-height: 380px;
            max-height: 380px;
            position: absolute;
            top: 0;
            left: 0;
            bottom: 0;
            right: 0;
            margin: auto;
            padding: 20px;
            z-index: 130;
            border-radius: 8px;
            background-color: #fff;
            box-shadow: 0 3px 18px rgba(100, 0, 0, .5);
            font-size: 16px;
        }
        .close{
            background-color: white;
            border: none;
            font-size: 18px;
            margin-left: 410px;
            margin-top: -10px;
        }

        .layui-input{
            border-radius: 5px;
            width: 300px;
            height: 40px;
            font-size: 15px;
        }
        .layui-form-item{
            margin-top: 35px;
            margin-left: -20px;
        }
        .layui-btn1{
            margin-left: -50px;
            border-radius: 5px;
            width: 350px;
            height: 40px;
            font-size: 15px;
        }
        .verity{
            width: 120px;
        }
        .layui-btn2{
            font-size: 13px;
            text-decoration: none;
            margin-left: 180px;
        }
        a:hover{
            text-decoration: underline;
        }

        .background{
            background-image: url("${pageContext.request.contextPath}/img/showPic/6.jpg");
            background-size: cover;
            background-repeat:no-repeat ;
            background-attachment: fixed;
            opacity: 0.68 ;
            position: fixed;
            height: 100%;
            width: 100%;
        }


    </style>
</head>
<body class="background">
<form class="layui-form" action="" method="post">
    <div class="container">

        <div class="layui-form-item" >
            <h1 align="center"><i class="layui-icon layui-icon-face-smile">修改密码</i>
            </h1>
        </div>
        <input hidden id="uno" name="uno" value="${userNo}">
        <div class="layui-form-item" >
            <label class="layui-form-label layui-icon layui-icon-username" >旧的密码</label>
            <div class="layui-input-block">
                <input type="password" id="oldPwd" required lay-verify="required" name="oldPwd" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label layui-icon layui-icon-password">新的密码</label>
            <div class="layui-input-inline">
                <input type="password" id="newPwd" name="newPwd" required lay-verify="required" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button type="button" onclick="toPost()" class="layui-btn1 layui-bg-cyan">提交</button>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button type="reset" class="layui-btn1 layui-bg-cyan" lay-submit lay-filter="formDemo">重置</button>
            </div>
        </div>
    </div>
</form>

<script type="text/javascript" src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-1.8.3.min.js"></script>
<script>
    layui.use(['form','layer'],function(){
        var form = layui.form;
        var layer = layui.layer;
        $("#oldPwd").blur(function(){
            var oldPwd = $("#oldPwd").val();
            var uno = $("#uno").val();
            if(oldPwd == "") {
                layer.msg("旧密码不可空", {icon:5});
            } else{
                $.ajax({
                    url:'${pageContext.request.contextPath}/checkOldPwd', //上传接口checkOldPwd
                    data:{oldPwd:oldPwd,uno:uno},
                    method:'post',
                    contentType:'application/json',
                    dataType:"json",
                    success:function(result) {
                        if(result.msg == true){
                            layer.msg("旧密码正确", {icon:1});
                        } else{
                            layer.msg("旧密码有误",{icon:5});
                            $("#oldPwd").shake(2, 10, 400);
                            document.getElementById("oldPwd").value="";
                        }
                    }
                });
            }
        });
    });
</script>
<script>
    $("#newPwd").blur(function(){
        var oldPwd = $("#oldPwd").val();
        var newPwd = $("#newPwd").val();
        if(oldPwd===newPwd) {
            layer.msg("前后输入一致，无需提交修改", {icon:5});
            $("#newPwd").shake(2, 10, 400);
            document.getElementById("newPwd").value="";
        } else{
            layer.msg("前后输入密码不对应，可提交修改", {icon:1});
        }
    });
</script>
<script>
    function toPost() {
        layui.use(['form','jquery','layer'], function(){
            var form = layui.form;
            var layer = layui.layer;
            var $=layui.jquery;
            var oldPwd = $("#oldPwd").val();
            var newPwd = $("#newPwd").val();
            var uno = $("#uno").val();
            if(oldPwd != '' && newPwd != '') {
                $.ajax({
                    url:'${pageContext.request.contextPath}/changePwd', //上传接口changePwd
                    data:{upassword:newPwd,uno:uno},
                    method:'post',
                    contentType:'application/json',
                    dataType:"json",
                    success:function(result) {
                        if(result.msg == true){
                            layer.msg("更改成功，请重新登录", {icon:1});
                            //延迟2s后跳转
                            window.setTimeout(function () {
                                window.location.href="${pageContext.request.contextPath}/outLogin?uno=" + uno;
                            },2000)
                        } else{
                            layer.msg(result.msg, {icon:5});
                            //延迟2s后刷新
                            window.setTimeout(function () {
                                window.location.reload();
                            },2000)
                        }
                    }
                });
            } else {
                layer.msg("新旧密码不可为空", {icon:5});
            }
        });
    }
</script>
<script>
    jQuery.fn.shake = function (intShakes /*Amount of shakes*/, intDistance /*Shake distance*/, intDuration /*Time duration*/) {
        this.each(function () {
            var jqNode = $(this);
            jqNode.css({ position: 'relative' });
            for (var x = 1; x <= intShakes; x++) {
                jqNode.animate({ left: (intDistance * -1) }, (((intDuration / intShakes) / 4)))
                    .animate({ left: intDistance }, ((intDuration / intShakes) / 2))
                    .animate({ left: 0 }, (((intDuration / intShakes) / 4)));
            }
        });
        return this;
    }
</script>
</body>
</html>
