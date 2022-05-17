<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--导入头部--%>
<%@include file="/WEB-INF/jsp/head.jsp"%>

<!-- 商品详情展示内容主体区域 -->
<div>
    <div class="layui-container" style="padding: 100px; text-align: center">

        <div style="margin-bottom: 50px">
            <i class="layui-icon layui-icon-face-smile" style="font-size: 30px; color: #1E9FFF; margin: 0 auto;">
                商品详情
            </i>
        </div>

        <div class="layui-row layui-col-space10">
            <div class="layui-col-md7">
                <img width="500px" height="350px" onclick="showimg(this)" src="${pageContext.request.contextPath}/img/productPhoto/${product.ppricture}">
            </div>
            <div class="layui-col-md5">
                <table style="background-color: #fff; color: #666; margin: 0 15px; " class="layui-inline" lay-even lay-skin="nob" width="250">
                    <tbody>
                    <tr>
                        <td style="position: relative; padding: 9px 15px; line-height: 20px; max-width: 200px">
                            商品名称：<c:out value="${product.pname}"></c:out>
                        </td>
                    </tr>
                    <tr>
                        <td style="position: relative; padding: 9px 15px; line-height: 20px;">
                            商品价格：<i class="layui-icon">&#xe65e;</i><c:out value="${product.price}"></c:out>
                        </td>
                    </tr>
                    <tr>
                        <td style="position: relative; padding: 9px 15px; line-height: 20px;">
                            <c:out value="${product.plevel}"></c:out>成新
                        </td>
                    </tr>
                    <tr>
                        <td style="position: relative; padding: 9px 15px; line-height: 20px;">
                            商品类型：<c:out value="${product.ptype}"></c:out>
                        </td>
                    </tr>
                    <tr>
                        <td style="position: relative; padding: 9px 15px; line-height: 20px;">
                            <input id="sno" value="${product.uno}" hidden />
                            <a href="${pageContext.request.contextPath}/toUserMsg?uno=${product.uno}" class="layui-btn layui-btn-radius layui-btn-primary" style="color: #ff4c62;">发布用户：<c:out value="${product.uno}"></c:out></a>
                        </td>
                    </tr>
                    <tr>
                        <td style="position: relative; padding: 9px 15px; line-height: 20px;">
                            <div class="layui-btn-group">
                                <input hidden id="pno" name="pno" value="${product.pno}" />
                                <c:if test="${product.uno == userNo}">
                                    <form action="${pageContext.request.contextPath}/toUpdateProduct" method="post">
                                        <input hidden name="pno" value="${product.pno}">
                                        <button type="submit" class="layui-btn layui-btn-radius layui-btn-primary">
                                            <i class="layui-icon">&#xe642;</i>&nbsp;&nbsp;修改商品&nbsp;&nbsp;
                                        </button>
                                    </form>
                                </c:if>
                                <c:if test="${product.uno != userNo}">
                                    <div id="controlShopcar" name="controlShopcar" style="margin: 10px">
                                        <%--控制加入移出购物车的按钮显示，利用ajax判断--%>
                                    </div>
                                    <div id="buyButton" name="buyButton" style="margin: 10px">
                                        <%--控制下订单的按钮显示，利用Ajax判断--%>
                                    </div>
                                </c:if>
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

    </div>
</div>

<script src="${pageContext.request.contextPath}/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="layui/layui.js"></script>
<script type="text/javascript">
    window.onload = function()//用window的onload事件，窗体加载完毕的时候
    {
        checkShopCarByPno();
        checkOrderByPno();
    }
</script>
<script>
    /*检查该商品是否加入购物车*/
    function checkShopCarByPno() {
        var pno = $("#pno").val();//获得商品编号
        $.ajax({
            url:'${pageContext.request.contextPath}/checkShopCarByPno', //对应controller的URL，获得数据
            data:{pno:pno},
            method:'post',
            contentType:'application/json',
            dataType:"json",
            success: function (result) {
                var html = '';
                if(result.msg == true) {//已加入购物车
                    html += '<button type="button" id="delPno" onclick="delFromShopcar(this)" class="layui-btn layui-btn-sm" value="' + pno + '">';
                    html += '   <i class="layui-icon">&#xe67e;</i>&nbsp;&nbsp;移出购物车&nbsp;&nbsp;';
                    html += '</button>';
                } else if(result.msg == false) {//未添加到购物车
                    html += '<button type="button" id="addPno" onclick="addToShopcar(this)" class="layui-btn layui-btn-sm" value="' + pno + '">';
                    html += '   <i class="layui-icon">&#xe654;</i>&nbsp;&nbsp;添加到购物车&nbsp;&nbsp;';
                    html += '</button>';
                }
                $("#controlShopcar").html(html);
            }
        });
    }
</script>

<script>
    /*监听移出购物车点击按钮事件，t代表标签本身*/
    function delFromShopcar(t) {
        //获得商品id
        var pno = t.value;
        layer.confirm('确定将该商品从购物车中移出吗?',{
                btn : [ '是的', '取消'], //按钮
                shade : false
                //不显示遮罩
            },
            function(index) {
                $.ajax({
                    url : "${pageContext.request.contextPath}/delFromShopcar",
                    data: {"pno":pno},
                    method:'post',
                    contentType:'application/json',
                    dataType:"json",
                    success : function(result) {
                        if(result.msg == true){
                            layer.msg("移出成功",{icon:1});
                        } else {
                            layer.msg("移出失败",{icon:5});
                        }
                        checkShopCarByPno();
                    }
                });
                layer.close(index);
                return;
            }, function(index) {
                layer.close(index);
                return;
            });
    }
</script>

<script>
    /*监听加入购物车点击按钮事件，t代表标签本身*/
    function addToShopcar(t) {
        //获得商品id
        var pno = t.value;
        var sno = $("#sno").val();//获得商品卖家编号
        layer.confirm('确定将该商品加入到购物车中吗?',{
                btn : [ '是的', '取消'], //按钮
                shade : false
                //不显示遮罩
            },
            function(index) {
                $.ajax({
                    url : "${pageContext.request.contextPath}/addToShopcar",
                    data: {"pno":pno,"sno":sno},
                    method:'post',
                    contentType:'application/json',
                    dataType:"json",
                    success : function(result) {
                        if(result.msg == true){
                            layer.msg("加入成功",{icon:1});
                        } else {
                            layer.msg("加入失败",{icon:5});
                        }
                        checkShopCarByPno();
                    }
                });
                layer.close(index);
                return;
            }, function(index) {
                layer.close(index);
                return;
            });
    }
</script>

<script>
    /*检查商品有无被购买*/
    function checkOrderByPno() {
        var pno = $("#pno").val();//获得商品编号
        $.ajax({
            url:'${pageContext.request.contextPath}/checkOrderByPno', //对应controller的URL，获得数据
            data:{pno:pno},
            method:'post',
            contentType:'application/json',
            dataType:"json",
            success: function (result) {
                var html = '';
                if(result.msg == true) {//未加入订单，立即下单购买
                    html += '<button type="button" id="buyPno" onclick="buyPno(this)" class="layui-btn layui-btn-sm" value="' + pno + '">';
                    html += '   <i class="layui-icon">&#xe62b;</i>&nbsp;&nbsp;立即下单购买&nbsp;&nbsp;';
                    html += '</button>';
                } else if(result.msg == false) {//已被下单购买
                    html += '<button type="button" class="layui-btn layui-btn-sm layui-btn-disabled">';
                    html += '   <i class="layui-icon">&#xe702;</i>&nbsp;&nbsp;已被下单购买&nbsp;&nbsp;';
                    html += '</button>';
                }
                $("#buyButton").html(html);
            }
        });
    }
</script>

<script>
    /*监听下单购买的点击请求，t是标签本身*/
    function buyPno(t) {
        //获得商品id
        var pno = t.value;
        layer.confirm('确定下订单购买该商品吗?',{
                btn : [ '是的', '取消'], //按钮
                shade : false
                //不显示遮罩
            },
            function(index) {
                window.location.href = '${pageContext.request.contextPath}/buy?pno=' + pno;
                layer.close(index);
                return;
            }, function(index) {
                layer.close(index);
                return;
            });
    }
</script>

<%--导入脚部--%>
<%@include file="/WEB-INF/jsp/foot.jsp" %>