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
    <div style="padding: 50px; text-align: center">

        <div style="margin-bottom: 50px">
            <button type="button" class="layui-btn" style="background-color: #FFB800; width: 100%; height: 50px">
                <i class="layui-icon layui-icon-home" style="font-size: 30px; color: #FFFFFF; margin: 0 auto;">轮播图列表</i>
            </button>
        </div>

        <div name="showPicList" style="text-align:center; background-color: #FFFFFF;">
            <fieldset class="table-search-fieldset">
                <div style="margin: 10px" id="btn">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <button type="button" class="layui-btn" id="uploadShowPic">
                                <i class="layui-icon">&#xe612;</i>&nbsp;&nbsp;添加轮播图片
                            </button>
                        </div>
                    </div>
                </div>
            </fieldset>

        <%--表格--%>
            <table id="showPicTable" lay-filter="showPicTable"></table><%--layui初始化需要的table--%>
        </div>

        <script type="text/javascript" src="${pageContext.request.contextPath}/layui/layui.js"></script>

        <script src="${pageContext.request.contextPath}/js/jquery-1.8.3.min.js"></script>
        <script type="text/javascript">
            /*使用layui的表格功能*/
            layui.use('table', function(){
                var table = layui.table;
                $.ajax({
                    type: "GET"
                    ,url:'${pageContext.request.contextPath}/admin/getShowPicList'
                    ,dataType: "json"
                    ,success: function (data) {
                        if(data) {
                            var option={
                                elem: '#showPicTable'
                                ,cellMinWidth: 80
                                ,page: true
                                ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                                ,limit: 10
                                ,cols: [[ //表头
                                    {field: 'picId', title: '编号', width:150, align: 'center', sort: true, templet: '#pId'}
                                    ,{field: 'picName', title: '图片', width: 200, align: 'center', templet: '#pic'}/*//templet参数用户定制列的数据特殊标签处理*/
                                    ,{field: 'picShow', title: '是否展示', sort: true, width:150, templet: function (data) {
                                            if (data.picShow == 'noshow') {
                                                return '<div>' +
                                                            '<button class="layui-btn layui-btn-primary" type="button" onclick="changeShow(this)" id="show' + data.picId + '" value= ' + data.picId +
                                                            '>不展示</button>'+
                                                        '</div>';
                                            }
                                            if (data.picShow == 'show') {
                                                return '<div>' +
                                                            '<button class="layui-btn layui-btn-normal" type="button" onclick="changeShow(this)" id="show' + data.picId + '" value= ' + data.picId +
                                                            '>展示中</button>'+
                                                        '</div>';;
                                            }
                                        }
                                    }
                                    ,{field: 'picTop', title: '是否置顶', sort: true, width:150, templet: function (data) {
                                            if (data.picTop == 'noTop') {
                                                return '<div>' +
                                                            '<button class="layui-btn layui-btn-primary" type="button" onclick="sureTop(this)" id="top'+ data.picId +'" value= ' + data.picId +
                                                            '>不置顶</button>'+
                                                        '</div>';
                                            }
                                            if (data.picTop == 'Top') {
                                                return '<div>' +
                                                            '<button class="layui-btn layui-btn-normal" type="button" onclick="sureTop(this)" id="top'+ data.picId +'" value= ' + data.picId +
                                                            '>置顶中</button>'+
                                                        '</div>';
                                            }
                                        }
                                    }
                                    ,{field: 'picLink', title: '图片链接', width:200}
                                    ,{field: 'picId', title: '操作', width: 350, templet:function (data) {
                                        return '<div>' +
                                                    '<button class="layui-btn layui-btn-danger" type="button" onclick="delShowPic(this)" id="del'+ data.picId +'" value= ' + data.picId +
                                                    '>删除</button>'+
                                                '</div>';
                                        }
                                    }
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
        <script type="text/html" id="pic">
            <img style="object-fit:cover;" width="100%" height="100%" src="${pageContext.request.contextPath}/img/showPic/{{d.picName}}" onclick="showimg(this)">
        </script>
        <script type="text/html" id="pId">
            <div><input hidden name="picId" id="picId_{{d.picId}}" value="{{d.picId}}">{{d.picId}}</div>
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

        <%--图片上传--%>
        <script>
            layui.use('upload', function(){
                var upload = layui.upload;

                //执行实例
                var uploadInst = upload.render({
                    elem: '#uploadShowPic' //绑定元素
                    ,url: '${pageContext.request.contextPath}/admin/uploadShowPic' //上传接口
                    ,size: 1000
                    ,accept: 'images'
                    ,multiple: false//多文件上传
                    ,acceptMime: 'image/jpg, image/png'
                    ,done: function(result){
                        //上传完毕回调
                        if(result.msg != true){
                            layer.msg(result.msg, {icon:5});
                        }else if(result.msg == true){
                            layer.msg("上传成功!",{icon:1});
                        }else{
                            layer.msg("上传失败!",{icon:5});
                        }
                        //延迟2s后刷新
                        window.setTimeout(function () {
                            window.location.reload();
                        },2000)
                    }
                });
            });
        </script>

        <%--改变置顶状态--%>
        <script>
            function sureTop(t) {
                var picId = t.value;
                layer.confirm('确定要(不)置顶吗?',{
                        btn : [ '改变状态', '保持现状'], //按钮
                        shade : false
                        //不显示遮罩
                    },
                    function(index) {
                        myfunction(picId);  //确认调用的方法
                        layer.close(index);
                        return;
                    }, function(index) {
                        layer.close(index);
                        return;
                    });
            }

            function myfunction(picId) {
                //获取标签文本内容
                var status = document.getElementById('top' + picId).innerText;
                $.ajax({
                    url : "${pageContext.request.contextPath}/admin/changeTop",
                    data: {"picId":picId, "status":status},
                    method:'get',
                    contentType:'application/json',
                    dataType:"json",
                    success : function(result) {
                        if(result.msg == true){
                            document.getElementById('top' + picId).innerText = result.topStatus;
                            document.getElementById('top' + picId).className = "layui-btn layui-btn-warm";
                            layer.msg("更改成功",{icon:1});
                        }else{
                            layer.msg("更改失败",{icon:5});
                        }
                    }
                });
            }
        </script>

        <%--删除轮播图--%>
        <script>
            function delShowPic(t) {
                //获得图片id
                var picId = t.value;
                $.ajax({
                    url : "${pageContext.request.contextPath}/admin/delShowPic",
                    data: {"picId":picId},
                    method:'get',
                    contentType:'application/json',
                    dataType:"json",
                    success : function(result) {
                        if(result.msg == true){
                            layer.msg("删除成功",{icon:1});
                        }else{
                            layer.msg("删除失败",{icon:5});
                        }
                        //延迟2s后刷新
                        window.setTimeout(function () {
                            window.location.reload();
                        },2000)
                    }
                });
            }
        </script>

        <%--修改轮播图展示状态--%>
        <script>
            function changeShow(t) {
                var picId = t.value;
                layer.confirm('确定要(不)展示吗?',{
                        btn : [ '改变状态', '保持现状'], //按钮
                        shade : false
                        //不显示遮罩
                    },
                    function(index) {
                        changeShowFunction(picId);  //确认调用的方法
                        layer.close(index);
                        return;
                    }, function(index) {
                        layer.close(index);
                        return;
                    });

            }

            function changeShowFunction(picId) {
                //获取标签文本内容
                var status = document.getElementById('show' + picId).innerText;
                $.ajax({
                    url : "${pageContext.request.contextPath}/admin/changeShow",
                    data: {"picId":picId, "status":status},
                    method:'get',
                    contentType:'application/json',
                    dataType:"json",
                    success : function(result) {
                        if(result.msg == true){
                            document.getElementById('show' + picId).innerText = result.topStatus;
                            document.getElementById('show' + picId).className = "layui-btn layui-btn-warm";
                            layer.msg("更改成功",{icon:1});
                        }else{
                            layer.msg("更改失败",{icon:5});
                        }
                    }
                });
            }
        </script>

</body>
</html>