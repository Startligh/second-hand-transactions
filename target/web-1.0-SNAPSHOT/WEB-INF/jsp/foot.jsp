<%@ page language="java" contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8"%>
<div class="layui-layout layui-layout-admin">
    <div class="layui-footer" style="left:0px">
        <!-- 底部固定区域 -->
        <div style="width: 30px; height: 30px" class="layui-anim layui-anim-rotate layui-anim-loop"><img src="${pageContext.request.contextPath}/img/showPic/5.png" class="layui-nav-img"></div>
    </div>
</div>

<ul class="layui-fixbar">
    <li class="layui-icon layui-icon-top" lay-type="top" style="background-color: rgb(0, 150, 136); display: list-item;" id="scrolltop"></li>
    <li class="layui-icon layui-icon-add-1" lay-type="top" style="background-color: rgb(0, 150, 136); display: list-item;" id="pushMyProduct" onclick="pushMyProduct()"></li>
</ul>
<script src="${pageContext.request.contextPath}/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="layui/layui.js"></script>
<%--回顶部的js--%>
<script type='text/javascript'>
    layui.use(['util','layer','element'], function(){
        var util = layui.util;
        var layer = layui.layer;
        var element = layui.element;
    });
    //右下角回到顶部功能函数实现
    $(document).ready(function(){
        $("#scrolltop").hide();
        $(function () {
            //设置高度
            var height=100;
            //scroll() 方法为滚动事件
            $(window).scroll(function(){
                if ($(window).scrollTop()>height){
                    $("#scrolltop").fadeIn(500);
                }else{
                    $("#scrolltop").fadeOut(500);
                }
            });
            $("#scrolltop").click(function(){
                $('body,html').animate({scrollTop:0},100);  //animate为动画效果，第二个参数是时间，单位ms
                return false;
            });
        });
    });
</script>

<%--首页滑窗--%>
<script>
    layui.use('carousel', function(){
        var carousel = layui.carousel;
        //建造实例
        carousel.render({
            elem: '#test1'
            ,width: '100%' //设置容器宽度
            ,height: 300
            ,arrow: 'none' //不显示箭头
            ,anim: 'fade' //切换动画方式
        });
    });
</script>

<%--图片点击的效果展示--%>
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

<script>
    $("#pushMyProduct").click(
        function () {
            window.location.href = "${pageContext.request.contextPath}/toAddMyProduct";
        }
    )
    function pushMyProduct() {
        window.location.href = "${pageContext.request.contextPath}/toAddMyProduct";
    }
</script>

</body>
</html>
