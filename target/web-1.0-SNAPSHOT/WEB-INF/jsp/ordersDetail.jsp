<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--导入头部--%>
<%@include file="/WEB-INF/jsp/head.jsp"%>

<!-- 订单展示内容主体区域 -->
<div class="layui-container" style="padding: 100px; text-align: center">

    <div class="layui-row">
        <form action="${pageContext.request.contextPath}/sureOrder" method="post">
            <table class="layui-table">
                <colgroup>
                    <col width="200">
                    <col width="200">
                    <col width="200">
                    <col width="200">
                    <col width="200">
                </colgroup>
                <tr align="center">
                    <th><button type="button" class="layui-btn layui-btn-primary">订单账号</button></th>
                    <th><button type="button" class="layui-btn layui-btn-primary">商品账号</button></th>
                    <th><button type="button" class="layui-btn layui-btn-primary">买方账号</button></th>
                    <th><button type="button" class="layui-btn layui-btn-primary">卖方账户</button></th>
                    <th><button type="button" class="layui-btn layui-btn-primary">时间</button></th>
                </tr>
                <tr>
                    <td>
                        <input id="ono" hidden name="ono" value="${order.ono}"><c:out value="${order.ono}"></c:out>
                    </td>
                    <td>
                        <input hidden id="pno" name="pno" value="${order.pno}">
                        <button type="button" class="layui-btn layui-btn-primary layui-border-black" id="showProductMsg"><c:out value="${order.pno}"></c:out></button>
                    </td>
                    <td>
                        <input hidden name="bno" value="${order.bno}"><c:out value="${order.bno}"></c:out>
                    </td>
                    <td>
                        <input hidden name="sno" value="${order.sno}"><c:out value="${order.sno}"></c:out>
                    </td>
                    <td>
                        <input name="date" type="date" readonly value="<fmt:formatDate value="${order.odate}" type="both" pattern="yyyy-MM-dd"/>">
                    </td>
                </tr>
            </table>
            <div style="margin-top: 50px;text-align:center;">
                <c:if test="${order.sno != userNo}">
                    <%--访问的帐号不能是卖方--%>
                    <c:if test="${order.stats == 500}">
                        <button type="submit" class="layui-btn layui-btn-lg layui-btn-radius layui-btn-normal">提交订单</button>
                    </c:if>
                    <c:if test="${order.stats == 0}">
                        <button type="button" id="makeSureOrder" onclick="makeSureOrder()" class="layui-btn layui-btn-lg layui-btn-radius layui-btn-normal">确定订单</button>
                    </c:if>
                    <c:if test="${order.stats == 1}">
                        <button type="button" id="cancelOrder" onclick="cancelOrder()" class="layui-btn layui-btn-lg layui-btn-radius layui-btn-normal">取消订单</button>
                    </c:if>
                </c:if>
            </div>
            <c:if test="${product != null}">
                <div style="margin-top: 50px;text-align:center;">
                    <button type="button" class="layui-btn layui-btn-lg layui-btn-radius layui-btn-normal">商<br>品<br>详<br>情</button>
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
                        </tbody>
                    </table>
                </div>
            </c:if>
        </form>
    </div>
</div>

<script>
    function makeSureOrder() {
        //获得订单号
        var ono = $("#ono").val();
        var pno = $("#pno").val();
        layer.confirm('需要确定订单?',{
                btn : [ '是的', '取消'], //按钮
                shade : false
                //不显示遮罩
            },
            function(index) {
                $.ajax({
                    url : "${pageContext.request.contextPath}/sureTheOrder",
                    data: {"ono":ono},
                    method:'post',
                    contentType:'application/json',
                    dataType:"json",
                    success : function(result) {
                        if(result.msg == true){
                            layer.msg("确认成功",{icon:1});
                            //延迟2s后刷新
                            window.setTimeout(function () {
                                window.location.href = "${pageContext.request.contextPath}/toProductMsg?pno=" + pno;
                            },2000)
                        } else {
                            layer.msg("确认失败",{icon:5});
                        }
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
    function cancelOrder() {
        //获得订单号
        var ono = $("#ono").val();
        var pno = $("#pno").val();
        layer.confirm('需要取消订单?',{
                btn : [ '是的', '取消'], //按钮
                shade : false
                //不显示遮罩
            },
            function(index) {
                $.ajax({
                    url : "${pageContext.request.contextPath}/delTheOrder",
                    data: {"ono":ono},
                    method:'post',
                    contentType:'application/json',
                    dataType:"json",
                    success : function(result) {
                        if(result.msg == true){
                            layer.msg("取消成功",{icon:1});
                            //延迟2s后刷新
                            window.setTimeout(function () {
                                window.location.href = "${pageContext.request.contextPath}/toProductMsg?pno=" + pno;
                            },2000)
                        } else {
                            layer.msg("取消失败",{icon:5});
                        }
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

<%--导入脚部--%>
<%@include file="/WEB-INF/jsp/foot.jsp" %>
