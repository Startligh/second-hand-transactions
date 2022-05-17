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
                <i class="layui-icon layui-icon-home" style="font-size: 30px; color: #FFFFFF; margin: 0 auto;">用户列表</i>
            </button>
        </div>

        <div name="userMsgList" style="text-align:center; background-color: #FFFFFF;">
            <fieldset class="table-search-fieldset">
                <legend>搜索信息</legend>
                <div style="margin: 10px" id="btn">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">用户名称</label>
                            <div class="layui-input-inline">
                                <!--注意此处input标签里的id-->
                                <input class="layui-input" name="demoReload" id="demoReload" autocomplete="off">
                            </div>
                        </div>

                        <div class="layui-inline">
                            <!--注意此处button标签里的type属性-->
                            <button id="searchUser" type="button" class="layui-btn layui-btn-primary"  lay-submit data-type="reload" lay-filter="data-search-btn"><i class="layui-icon"></i> 搜 索</button>
                        </div>
                    </div>
                </div>
            </fieldset>

            <%--表格--%>
            <table id="userTable" lay-filter="userTable"></table><%--layui初始化需要的table--%>
        </div>

        <script type="text/javascript" src="${pageContext.request.contextPath}/layui/layui.js"></script>
        <%--添加小黑屋：--%>
        <script type="text/html" id="changeUserTypeDemo">
            <div class="layui-btn-container">
                <form action="${pageContext.request.contextPath}/admin/makeHimBlackHome" method="post">
                    <input hidden name="uno" value="{{d.uno}}">
                    <button type="submit" class="layui-btn layui-btn-sm">
                        <input hidden name="utype" value="{{d.utype}}">
                        <i class="layui-icon">&#xe682;</i>&nbsp;小黑屋
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
                    ,url:'${pageContext.request.contextPath}/admin/getUserList'
                    ,dataType: "json"
                    ,success: function (data) {
                        if(data) {
                            var option={
                                elem: '#userTable'
                                ,cellMinWidth: 80
                                ,page: true
                                ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                                ,limit: 10
                                ,cols: [[ //表头
                                    {type:'checkbox', fixed: 'left'}
                                    ,{field: 'uno', title: '用户编号', width:150, sort: true, fixed: 'left'}
                                    ,{field: 'upricture', title: '用户头像', width:100, align: 'center', templet: '#headPhoto'}/*//templet参数用户定制列的数据特殊标签处理*/
                                    ,{field: 'usex', title: '性别', width:120,sort: true}
                                    ,{field: 'uname', title: '用户名字', width:250}
                                    ,{field: 'utel', title: '联系电话', width:200}
                                    ,{field: 'uaddress', title: '地址', width:'20%'}
                                    ,{field: 'ubalance', title: '余额', width:'10%', sort: true}
                                    ,{field: 'utype', title: '移入黑名单', width: '10%', sort: true, templet: '#changeUserTypeDemo', fixed: 'right'}
                                ]]
                            };
                            option.data = data.data
                            table.render(option);
                        } else {
                            layer.msg("未获取到信息")
                        }
                    }
                })

                <%--搜索框监测--%>
                //以下是搜索框进行监测
                var active = {
                    reload: function(){
                        var demoReload = $('#demoReload');	//得到搜索框里已输入的数据
                        layer.msg(demoReload)
                        //执行重载
                        table.reload('userTable', {
                            page: {
                                curr: 1 //重新从第 1 页开始
                            }
                            ,where: {
                                uname:  demoReload.val()		//在表格中进行搜索
                                //,uno: demoReload.val()
                            }
                        });
                    }
                };
                /*绑定搜索点击事件*/
                $('#searchUser').on('click', function(){
                    var type = $(this).data('type');
                    active[type] ? active[type].call(this) : '';
                });
            });
        </script>
        <%--下面方法分页失效了--%>
        <%--<script>
            /*使用layui的表格功能*/
            layui.use('table', function(){
                var table = layui.table;
                /*layui渲染表格*/
                table.render({
                    title: "用户列表"
                    ,elem: '#userTable'//实例化需要的table的id
                    ,height: 360//容器高度
                    ,url: '${pageContext.request.contextPath}/admin/getUserList'//请求参数URL
                    ,method:"get"//GET方法
                    ,where:{}//用户自定义请求参数(直接跟在url?后面)
                    ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                    ,request: {//请求参数名称映射配置
                        pageName: 'pageNum' //页码的参数名称，默认：page
                        ,limitName: 'limit' //每页数据量的参数名，默认：limit
                    }
                    ,limit:5
                    ,limits:[5,25,50]
                    ,page: true//开启分页
                    ,parseData: function(res){ //将原始数据解析成 table 组件所规定的数据，res为从url中get到的数据
                        var result;
                        console.log(this);
                        console.log(JSON.stringify(res));
                        if(this.page.curr){
                            result = res.data.slice(this.limit*(this.page.curr-1),this.limit*this.page.curr);
                        }
                        else{
                            result=res.data.slice(0,this.limit);
                        }
                        return {
                            "code": res.code, //解析接口状态
                            "msg": res.msg, //解析提示文本
                            "count": res.count, //解析数据长度
                            "data": result //解析数据列表
                        };
                    },cols: [[ //表头
                        {type:'checkbox', fixed: 'left'}
                        ,{field: 'uno', title: '用户编号', width:150, sort: true, fixed: 'left'}
                        ,{field: 'upricture', title: '用户头像', width:100, align: 'center', templet: '#headPhoto'}/*//templet参数用户定制列的数据特殊标签处理*/
                        ,{field: 'usex', title: '性别', width:120,sort: true}
                        ,{field: 'uname', title: '用户名字', width:250}
                        ,{field: 'utel', title: '联系电话', width:200}
                        ,{field: 'uaddress', title: '地址', width:'20%'}
                        ,{field: 'ubalance', title: '余额', width:'10%', sort: true}
                        ,{field: 'utype', title: '移入黑名单', width: '10%', sort: true, templet: '#changeUserTypeDemo', fixed: 'right'}
                    ]]
                });
                /*表格重载(搜索的点击时间调用的是方法)*/
                /*var $ = layui.$, active = {
                    reload: function(){
                        var exhibitionInput = $('#exhibitionInput');
                        //执行重载
                        table.reload('userTable', {
                            page: {
                                curr: 1 //重新从第 1 页开始
                            }
                            ,where: {
                                name: exhibitionInput.val()
                            }
                        });
                    }
                };
                */
            });
        </script>--%>

        <%--定制列样式，展示图片--%>
        <script type="text/html" id="headPhoto">
            <img class="layui-nav-img" src="${pageContext.request.contextPath}/img/headPhoto/{{d.upricture}}" onclick="showimg(this)">
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