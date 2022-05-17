<%@ page language="java" contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
    <style type="text/css">
        .background{
            background-size: cover;
            background-image: url(${pageContext.request.contextPath}/img/showPic/1.png);
            height: 100%;
            width: 100%;
        }
    </style>
    <script type="text/javascript" src="${pageContext.request.contextPath}/layui/layui.js"></script>
</head>
<body class="background">
<div class="layui-container " style="padding: 50px; text-align: center">

    <div style="padding: 50px 0 50px 0">
        <button type="button" class="layui-btn" style="background-color: #FFB800; width: 100%; height: 50px">
            <i class="layui-icon layui-icon-face-smile" style="font-size: 30px; color: #FFFFFF; margin: 0 auto;">
                添加管理员
            </i>
        </button>
    </div>

    <form class="layui-form layui-form-pane" action="${pageContext.request.contextPath}/admin/addManager" method="post" enctype="multipart/form-data" style="background-color: #FFFFFF; padding: 50px">
        <div class="layui-form-item">
            <label class="layui-form-label">帐号</label>
            <div class="layui-input-block">
                <%--<h4 style="color: red">#{msg}</h4>--%>
                <input type="text" name="ano" id="ano" required  lay-verify="required" placeholder="请输入帐号" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">姓名</label>
            <div class="layui-input-block">
                <input type="text" name="aname" required  lay-verify="required" placeholder="请输入名称" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">性别</label>
            <div class="layui-input-block">
                <select required name="asex" lay-verify="required">
                    <option value=""></option>
                    <option value="男">男</option>
                    <option value="女">女</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">密码框</label>
            <div class="layui-input-inline">
                <input type="password" name="apassword" required lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"><i class="layui-icon">&#xe67c;</i>上传头像</label>
            <div class="layui-input-block">
                <input class="layui-inline" type="file" name="file" style="background-color: #FFFFFF"/>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block" style="margin-left: 0px;">
                <input class="layui-btn" type="submit" value="立即提交">
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>
<script type="text/javascript">
    layui.use('form',function(){
        const form = layui.form;
        form.render();
        form.render('select'); //刷新select选择框渲染
    });
</script>

<script src="${pageContext.request.contextPath}/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript">
    layui.use(['form','layer'],function(){
        var form = layui.form;
        var layer = layui.layer;

        $("#ano").blur(function(){
            var num = $("#ano").val();
            $.ajax({
                url:'${pageContext.request.contextPath}/admin/checkAno', //上传接口/admin/checkAno?ano=
                data:{ano:num},
                method:'get',
                contentType:'application/json',
                dataType:"json",
                success:function(result) {
                    if(result.msg != true){
                        layer.msg(result.msg, {icon:5});
                        document.getElementById("ano").value="";
                    }else if(result.msg == true){
                        layer.msg("帐号可使用",{icon:1});
                    }else{
                        layer.msg("已存在帐号",{icon:5});
                        document.getElementById("ano").value="";
                    }
                }
            });
        });
    });
</script>

</body>
</html>