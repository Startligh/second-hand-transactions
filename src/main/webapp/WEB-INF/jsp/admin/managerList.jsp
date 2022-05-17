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
</head>
<body class="background">

<div>
    <div class="layui-container" style="padding: 50px; text-align: center">
        <div style="margin-bottom: 50px">
            <button type="button" class="layui-btn" style="background-color: #FFB800; width: 100%; height: 50px">
                <i class="layui-icon layui-icon-home" style="font-size: 30px; color: #FFFFFF; margin: 0 auto;">管理员列表</i>
            </button>
        </div>

        <div name="adminMsgList" style="text-align:center; background-color: #FFFFFF;">
            <fieldset class="table-search-fieldset">
                <div style="margin: 10px" id="btn">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <a href="${pageContext.request.contextPath}/admin/toAddManager"><button type="button" class="layui-btn layui-btn-fluid">添加管理员</button></a>
                        </div>
                    </div>
                </div>
            </fieldset>

            <%--表格--%>
            <table id="adminTable" lay-filter="adminTable"></table><%--layui初始化需要的table--%>
        </div>

        <script type="text/javascript" src="${pageContext.request.contextPath}/layui/layui.js"></script>
        <%--删除管理员--%>
        <script type="text/html" id="deleteAdmin">
            <div class="layui-btn-container">
                <form action="${pageContext.request.contextPath}/admin/deleteAdmin" method="post">
                    <input hidden name="ano" value="{{d.ano}}">
                    <button type="submit" class="layui-btn layui-btn-sm">
                        <i class="layui-icon">&#xe682;</i>&nbsp;删除管理员
                    </button>
                </form>
            </div>
        </script>

        <script src="${pageContext.request.contextPath}/js/jquery-1.8.3.min.js"></script>
        <script type="text/javascript">
            /*使用layui的表格功能*/
            layui.use('table', function(){
                var table = layui.table;
                $.ajax({
                    type: "GET"
                    ,url:'${pageContext.request.contextPath}/admin/getAdminList'
                    ,dataType: "json"
                    ,success: function (data) {
                        if(data) {
                            var option={
                                elem: '#adminTable'
                                ,cellMinWidth: 80
                                ,page: true
                                ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                                ,limit: 10
                                ,cols: [[ //表头
                                    {field: 'ano', title: '管理员编号', width:150, sort: true}
                                    ,{field: 'apricture', title: '管理员头像', width:100, align: 'center', templet: '#headPhoto'}/*//templet参数用户定制列的数据特殊标签处理*/
                                    ,{field: 'asex', title: '性别', width:120, sort: true}
                                    ,{field: 'aname', title: '管理员名字', width:250}
                                    ,{field: 'ano', title: '删除管理员', width: '20%', templet: '#deleteAdmin'}
                                ]]
                            };
                            option.data = data.data
                            table.render(option);
                        } else {
                            layer.msg("未获取到信息")
                        }
                    }
                })
            });
        </script>
        <%--定制列样式，展示图片--%>
        <script type="text/html" id="headPhoto">
            <img class="layui-nav-img" src="${pageContext.request.contextPath}/img/headPhoto/{{d.apricture}}" onclick="showimg(this)">
        </script>

        <%--点击图片放大--%>
        <script>
            function showimg(t) {
                layer.open({
                    type: 1,
                    title: false,
                    closeBtn: 0,
                    area: '1000px',
                    skin: 'layui-layer-nobg', //没有背景色
                    shadeClose: true,
                    content: '<img style="display: inline-block; width: 100%; height: 100%;" src="'+t.src+'">'
                });
            }
        </script>

        <script type="text/javascript">
            layui.use('form',function(){
                const form = layui.form;
                form.render();
            });
        </script>

</body>
</html>