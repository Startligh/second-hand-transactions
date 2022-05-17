<%@ page language="java" contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<html>
<head>
    <title>校园二手交易平台</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/chat.css">
</head>
<body>

<div class="layui-layout layui-layout-admin">
    <div class="layui-header">
        <div class="layui-logo layui-hide-xs layui-bg-black">
            <a href="${pageContext.request.contextPath}/toShowIndex" style="color: goldenrod">校园二手交易平台</a>
        </div>
        <!-- 头部区域（可配合layui 已有的水平导航） -->
        <ul class="layui-nav layui-layout-left">
            <!-- 移动端显示 -->
            <li class="layui-nav-item layui-show-xs-inline-block layui-hide-sm" lay-header-event="menuLeft">
                <i class="layui-icon layui-icon-spread-left"></i>
            </li>
            <%--搜索表单--%>
            <li class="layui-nav-item layui-hide-xs">
                <form action="${pageContext.request.contextPath}/toSearch" method="get" class="fly-extend-banner-search">
                    <div class="layui-inline">
                        <input onmouseover="this.style.backgroundColor='plum'"
                               onmouseout="this.style.backgroundColor='#ffffff'"
                               type="text" placeholder="搜索 商品" name="keyWord" autocomplete="off" value="" class="layui-input">
                    </div>
                    <button class="layui-btn"><i class="layui-icon layui-icon-search"></i></button>
                </form>
            </li>
            <%--推荐搜索链接--%>
            <li class="layui-nav-item">
                <a href="javascript:;">商品推荐</a>
                <dl class="layui-nav-child">
                    <dd><a class="layui-btn-radius" href="${pageContext.request.contextPath}/toSearch?keyWord=电子产品">电子产品</a></dd>
                    <dd><a class="layui-btn-radius" href="${pageContext.request.contextPath}/toSearch?keyWord=书籍">书&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;籍</a></dd>
                    <dd><a class="layui-btn-radius" href="${pageContext.request.contextPath}/toSearch?keyWord=生活用品">生活用品</a></dd>
                    <dd><a class="layui-btn-radius" href="${pageContext.request.contextPath}/toSearch?keyWord=个人服饰">个人服饰</a></dd>
                    <dd><a class="layui-btn-radius" href="${pageContext.request.contextPath}/toSearch?keyWord=随便看看">随便看看</a></dd>
                </dl>
            </li>
        </ul>
        <%--导航栏右侧--%>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item layui-hide layui-show-md-inline-block">
                <script language="JavaScript">
                    tmpDate = new Date();
                    date = tmpDate.getDate();
                    month = tmpDate.getMonth() + 1;
                    year = tmpDate.getFullYear();
                    document.write(year);
                    document.write("年");
                    document.write(month);
                    document.write("月");
                    document.write(date);
                    document.write("日 ");

                    myArray = new Array(6);
                    myArray[0] = "星期日"
                    myArray[1] = "星期一"
                    myArray[2] = "星期二"
                    myArray[3] = "星期三"
                    myArray[4] = "星期四"
                    myArray[5] = "星期五"
                    myArray[6] = "星期六"
                    weekday = tmpDate.getDay();
                    if (weekday == 0 | weekday == 6) {
                        document.write(myArray[weekday])
                    } else {
                        document.write(myArray[weekday])
                    };
                </script>
            </li>
            <%--登录或者未登录都是用session判断，然后登录了就去session中取得用户信息--%>
            <%--未登录--%>
            <c:if test="${userSession == null}">
                <li class="layui-nav-item layui-hide layui-show-md-inline-block">
                    <a href="${pageContext.request.contextPath}/toLogin">
                        <img src="//tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg" class="layui-nav-img">
                        请登录
                    </a>
                </li>
            </c:if>
            <%--用户已登录--%>
            <c:if test="${userSession != null}">
                <li onfocus="getNewDynamic()" class="layui-nav-item layui-hide layui-show-md-inline-block">
                    <a href="${pageContext.request.contextPath}/home">
                        <img src="${pageContext.request.contextPath}/img/headPhoto/${userPicture}" class="layui-nav-img">
                        <c:out value="${userName}"></c:out>
                    </a>
                    <dl class="layui-nav-child">
                        <dd><a href="${pageContext.request.contextPath}/home">个人中心</a></dd>
                        <dd><a href="${pageContext.request.contextPath}/toAddMyProduct">发布中心</a></dd>
                        <dd><a href="${pageContext.request.contextPath}/mangeMyOrder">订单中心</a></dd>
                        <dd><a href="${pageContext.request.contextPath}/toShopcar">购物车</a></dd>
                        <dd><a href="${pageContext.request.contextPath}/messageCenter">消息中心</a></dd>
                        <dd><a id="outLogin" href="${pageContext.request.contextPath}/outLogin"> 退  出 </a></dd>
                    </dl>
                </li>
            </c:if>
<%--            <li class="layui-nav-item" lay-header-event="menuRight" lay-unselect>
                <a href="javascript:;">
                    <i class="layui-icon layui-icon-more-vertical"></i>
                </a>
            </li>--%>
        </ul>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/jquery-1.8.3.min.js"></script>
<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script>
/*    window.setInterval(function () { //每30秒刷新一次图表
        //需要执行的代码写在这里
        $.ajax({
            url : "${pageContext.request.contextPath}/checkNewDynamic",
            method:'post',
            contentType:'application/json',
            dataType:"json",
            success : function(result) {
                var count = $('#count').val();
                if(result.msg == true && result.count != count){
                    $("#myDynamic").append("<button id='count' type='button' class='layui-btn layui-btn-primary layui-border-warm'>" + result.count + "</button>");
                    /!*
                    layer.confirm('有新的消息，去看看吧?',{
                            btn : [ '好的', '不要'], //按钮
                            shade : false
                            //不显示遮罩
                        },
                        function(index) {
                            window.location.href = "${pageContext.request.contextPath}/mangeMyOrder";
                            layer.close(index);
                            return;
                        }, function(index) {
                            layer.close(index);
                            return;
                        });*!/
                }
            }
        });
    }, 30*1000);*/
</script>
