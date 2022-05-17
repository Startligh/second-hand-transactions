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
<form class="layui-form" action="${pageContext.request.contextPath}/login" method="post">
    <div class="container">

        <div class="layui-form-item" >
            <h1 align="center">登录</h1>
            <c:if test="${msg!=null}">
                <h4 align="center" style="color: orangered">${msg}</h4>
            </c:if>
        </div>
        <div class="layui-form-item" >
            <label class="layui-form-label layui-icon layui-icon-username" >账号</label>
            <div class="layui-input-block">
                <input type="text" name="lno" required  lay-verify="required" placeholder="账号" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label layui-icon layui-icon-password">密 &nbsp;&nbsp;码</label>
            <div class="layui-input-inline">
                <input type="password" name="lpassword" required lay-verify="required" placeholder="密码" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button type="submit" class="layui-btn1 layui-bg-cyan" lay-submit lay-filter="formDemo">登录</button>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button type="button" class="layui-btn1 layui-bg-cyan" id="register">立即注册</button>
            </div>
        </div>
    </div>
</form>
<script type="text/javascript" src="layui/layui.js"></script>
<script>
    layui.use(['form', 'layedit', 'laydate','jquery','layer'], function(){
        var form = layui.form;
        var layer = layui.layer;
        var layedit = layui.layedit;
        var laydate = layui.laydate;
        var $=layui.jquery;

        $("#register").click(function(){
            //点击注册时弹出一个弹出层
            layer.open(
                {
                    type:2,
                    title:'用户注册',
                    area:['600px','600px'],
                    content:"${pageContext.request.contextPath}/toRegister"
                });
        });

    });
</script>
</body>
</html>
