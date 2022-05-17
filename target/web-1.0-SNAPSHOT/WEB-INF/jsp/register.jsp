<%@ page language="java" contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
    <style type="text/css">
        .container{
            width: 420px;
            height: 320px;
            min-height: 320px;
            max-height: 320px;
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
            margin-top: 20px;
            margin-left: -20px;
        }
        .layui-btn1{
            margin-left: -50px;
            border-radius: 5px;
            width: 350px;
            height: 40px;
            font-size: 15px;
        }
        .font1{
            font-size: 13px;
            margin-left: 150px;
        }
        .verity{
            width: 120px;
        }
        a:hover{
            text-decoration: underline;
        }
        .background{
            background-image: url(img/showPic/6.jpg);
            background-size: cover;
            background-repeat:no-repeat ;
            background-attachment: fixed;

            position: fixed;
            height: 100%;
            width: 100%;
        }

    </style>
</head>
<body class="background">
<form class="layui-form" action="${pageContext.request.contextPath}/register" method="post">
    <div class="container">

        <div class="layui-form-item" >
            <h1 align="center">用户注册</h1>
        </div>
        <c:if test="${msg!=null}">
            <div class="layui-form-item" >
                <h4 style="color: red" align="center"><c:out value="${msg}"></c:out></h4>
            </div>
        </c:if>
        <div class="layui-form-item" >
            <label class="layui-form-label layui-icon layui-icon-username" >用户帐号</label>
            <div class="layui-input-block">
                <input type="text" id="uno" name="uno" required  lay-verify="required" placeholder="用户自定义帐号" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label layui-icon layui-icon-password">密 &nbsp;&nbsp;码</label>
            <div class="layui-input-inline">
                <input type="password" id="upassword" name="upassword" required lay-verify="required" placeholder="密码" onblur="message()" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label layui-icon layui-icon-password">确认密码</label>
            <div class="layui-input-inline">
                <input type="password" id="surepwd" name="surepwd" required lay-verify="required" placeholder="确认密码" onblur="check()" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button type="button" class="layui-btn1 layui-bg-cyan" lay-submit lay-filter="formDemo" id="sec">注册</button>
            </div>
        </div>
    </div>
</form>

<script type="text/javascript" src="layui/layui.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-1.8.3.min.js"></script>
<script>
    layui.use(['form','jquery','layer'], function(){
        var form = layui.form;
        var layer = layui.layer;
        var $=layui.jquery;
        var btnele=document.getElementById("sec");
        btnele.onclick=function(){
            var no = $("#uno").val();
            var p = $("#upassword").val();
            var np = $("#surepwd").val();
            if(np != '' && p != '' && no != '') {
                $.ajax({
                    url:'${pageContext.request.contextPath}/register', //上传接口register
                    data:{uno:no,upassword:p,surepwd:np},
                    method:'post',
                    contentType:'application/json',
                    dataType:"json",
                    success:function(result) {
                        if(result.msg == true){
                            layer.msg("注册成功，请前往登录", {icon:1});
                            //延迟2s后跳转
                            window.setTimeout(function () {
                                window.location.href="${pageContext.request.contextPath}/toLogin";
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
                layer.msg("所有信息都需要填上", {icon:5});
            }
        }
    });
</script>
<script type="text/javascript">
    layui.use(['form','layer'],function(){
        var form = layui.form;
        var layer = layui.layer;

        $("#uno").blur(function(){
            var no = $("#uno").val();
            if(no == "") {
                layer.msg("帐号不可空", {icon:5});
            } else{
                $.ajax({
                    url:'${pageContext.request.contextPath}/checkUno', //上传接口checkUno?uno=
                    data:{uno:no},
                    method:'get',
                    contentType:'application/json',
                    dataType:"json",
                    success:function(result) {
                        if(result.msg != true){
                            layer.msg(result.msg, {icon:5});
                            document.getElementById("uno").value="";
                        }else if(result.msg == true){
                            layer.msg("帐号可使用",{icon:1});
                        }else{
                            layer.msg("已存在帐号",{icon:5});
                            document.getElementById("uno").value="";
                        }
                    }
                });
            }
        });
    });
</script>

<script>
    function message() {
        var p = $("#upassword").val();
        if(p == "") {
            layer.msg("请输入密码",{icon:5});
        }
    }
</script>
<script>
    function check() {
        var p = $("#upassword").val();
        var np = $("#surepwd").val();
        if(p != np) {
            layer.msg("前后输入的密码不一致",{icon:5});
        }
    }
</script>
</body>
</html>

