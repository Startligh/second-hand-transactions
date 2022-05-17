<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--导入头部--%>
<%@include file="/WEB-INF/jsp/head.jsp"%>

<!-- 动态信息展示内容主体区域 -->
<div>
    <div class="layui-container" style="padding: 100px; text-align: center">
        <div style="padding: 50px 0">
            <i class="layui-icon layui-icon-find-fill" style="font-size: 30px; color: #1E9FFF; margin: 0 auto;">
                动态信息
            </i>
            <div id="msg">

            </div>
        </div>
        <input hidden id="uno" value="${userNo}">
        <%--动态信息表格--%>
        <div id="dynamicMsg" name="dynamicMsg" style="text-align:center;">

        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="layui/layui.js"></script>
<%--制作购物车管理表格--%>
<script type="text/javascript">
    /*使用layui的表格功能*/
    layui.use('table', function(){
        var table = layui.table;
        var uno = $("#uno").val();
        $.ajax({
            type: "GET"
            ,url:'${pageContext.request.contextPath}/getMyDynamic'
            ,data:{uno:uno}
            ,dataType: "json"
            ,success: function (data) {
                if(data) {
                    var option={
                        elem: '#dynamicMsg'
                        ,cellMinWidth: 80
                        ,page: true
                        ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                        ,limit: 10
                        ,cols: [[ //表头
                            {field: 'dno', title: '消息', width:700, align: 'center', templet: function (data) {
                                    return '<div>' +
                                        ' 您的 <a href="${pageContext.request.contextPath}/toProductMsg?pno=' + data.pno + '" class="layui-btn layui-btn-primary layui-border-black" title="点击前往">商品</a>' +
                                        ' 已被 <a href="${pageContext.request.contextPath}/toUserMsg?uno=' + data.uno + '" class="layui-btn layui-btn-radius layui-btn-normal" type="button">' + data.uname + '</a>' +
                                        data.dtype +
                                        '</div>';
                                }
                            }
                            ,{field: 'readed', title: '', width:50, align: 'center', templet: function (data) {
                                    if(data.readed == 0) {
                                        return '<div><button type="button" class="layui-btn layui-btn-lg layui-btn-danger"></button></div>';
                                    } else {
                                        return '<div></div>';
                                    }
                                }
                            }
                        ]]
                    };
                    $("#msg").html("<button class='layui-btn layui-btn-warm'>如果买家未联系您，请您主动前往ta的用户空间，及时获取联系方式</button>");
                    option.data = data.data;
                    table.render(option);
                } else {
                    layer.msg("你无新信息");
                }
            }
        })
    });
</script>

<%--导入脚部--%>
<%@include file="/WEB-INF/jsp/foot.jsp" %>