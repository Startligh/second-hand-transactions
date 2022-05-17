<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--导入头部--%>
<%@include file="/WEB-INF/jsp/head.jsp"%>

<!-- 购物车展示内容主体区域 -->
<div>
    <div class="layui-container" style="padding: 100px; text-align: center">

        <div style="padding: 50px 0">
            <i class="layui-icon layui-icon-cart" style="font-size: 30px; color: #1E9FFF; margin: 0 auto;">
                购物车
            </i>
        </div>

        <input hidden id="uno" value="${userNo}">
        <%--购物车表格--%>
        <div id="shopcarMsg" name="shopcarMsg" style="text-align:center;">

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
            ,url:'${pageContext.request.contextPath}/getMyShopcar'
            ,data:{uno:uno}
            ,dataType: "json"
            ,success: function (data) {
                if(data) {
                    var option={
                        elem: '#shopcarMsg'
                        ,cellMinWidth: 80
                        ,page: true
                        ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                        ,limit: 10
                        ,cols: [[ //表头
                            {field: 'ppricture', title: '图片', width: 200, align: 'center', templet: '#ppricture'}/*//templet参数用户定制列的数据特殊标签处理*/
                            ,{field: 'pname', title: '名称', align: 'center', width:150}
                            ,{field: 'price', title: '价格', width:120, align: 'center', sort: true}
                            ,{field: 'uname', title: '发布用户', width:200, align: 'center', templet: function (data) {
                                    return '<div><a href="${pageContext.request.contextPath}/toUserMsg?uno=' + data.sno + '" class="layui-btn layui-btn-radius layui-btn-normal" type="button">' + data.uname + '</a></div>';
                                }
                            }
                            ,{field: 'pno', title: '立即购买', width: 120, align: 'center', templet:function (data) {
                                var flag = true;
                                    $.ajax({
                                        url:'${pageContext.request.contextPath}/checkOrderByPno', //对应controller的URL，获得数据
                                        data:{pno:data.pno},
                                        method:'post',
                                        contentType:'application/json',
                                        dataType:"json",
                                        async: false,
                                        success: function (result) {
                                            if(result.msg == true) {//未加入订单，立即下单购买
                                                flag = true;
                                            } else if(result.msg == false) {//已被下单购买
                                                flag = false;
                                            }
                                        }
                                    });
                                    if(flag == true) {//未加入订单，立即下单购买
                                        return '<div><a href="${pageContext.request.contextPath}//buy?pno=' + data.pno + '" class="layui-btn layui-btn-radius layui-btn-normal" type="button">立即购买</a></div>';
                                    } else if(flag == false) {//已被下单购买
                                        return '<div><button class="layui-btn layui-btn-radius layui-btn-disabled" type="button">您已购买</button></div>';
                                    }
                                }
                            }
                            ,{field: 'pno', title: '移出', width: 120, align: 'center', templet:function (data) {
                                return '<div>' +
                                        '<button class="layui-btn layui-btn-radius layui-btn-danger" type="button" onclick="delFromShopcar(this)" id="del'+ data.pno +'" value= ' + data.pno +
                                        '><i class="layui-icon">&#xe640;</i></button>'+
                                        '</div>';
                                }
                            }
                        ]]
                    };
                    option.data = data.data;
                    table.render(option);
                } else {
                    layer.msg("你还往购物车添加商品");
                }
            }
        })
    });
</script>

<%--定制列样式，展示图片--%>
<script type="text/html" id="ppricture">
    <img style="object-fit:cover;" width="100%" height="100%" src="${pageContext.request.contextPath}/img/productPhoto/{{d.ppricture}}" onclick="showimg(this)">
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
                        //延迟2s后刷新
                        window.setTimeout(function () {
                            window.location.reload();
                        },2000)
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