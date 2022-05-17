<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--导入头部--%>
<%@include file="/WEB-INF/jsp/head.jsp"%>

<!-- 订单列表展示内容主体区域 -->
<div>
    <div class="layui-container" style="padding: 100px; text-align: center">

        <div style="padding: 50px 0">
            <input hidden id="uno" value="${userNo}">
            <a href="${pageContext.request.contextPath}/mangeMyOrder"><i class="layui-icon layui-icon-heart-fill" style="font-size: 30px; color: #1E9FFF; margin: 0 auto;">
                管理我的订单
            </i></a>
        </div>

        <div style="padding: 0px 0 50px 0">
            <i class="layui-icon layui-icon-gift" style="font-size: 30px; color: #1E9FFF; margin: 0 auto;">
                <button type="button" onclick="getMyBuy()" class="layui-btn layui-btn-radius layui-btn-primary" style="color: #18cde8">我的购买</button>
            </i>
            <i class="layui-icon layui-icon-release" style="font-size: 30px; color: #1E9FFF; margin: 0 auto;">
                <button type="button" onclick="getMySale()" class="layui-btn layui-btn-radius layui-btn-primary" style="color: #18cde8">我的出售</button>
            </i>
        </div>

        <%--订单管理表格--%>
        <div id="orderList" name="orderList" style="text-align:center;">

        </div>

    </div>
</div>

<script src="${pageContext.request.contextPath}/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="layui/layui.js"></script>
<%--制作订单管理表格--%>
<script type="text/javascript">
    /*使用layui的表格功能*/
    layui.use('table', function(){
        var table = layui.table;
        var uno = $("#uno").val();
        $.ajax({
            type: "GET"
            ,url:'${pageContext.request.contextPath}/getMyOrders'
            ,data:{uno:uno}
            ,dataType: "json"
            ,success: function (data) {
                if(data) {
                    var option={
                        elem: '#orderList'
                        ,cellMinWidth: 80
                        ,page: true
                        ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                        ,limit: 10
                        ,cols: [[ //表头
                            {field: 'ono', title: '订单号', width:100, align: 'center', sort: true, templet: '#orderDetail'}/*//templet参数用户定制列的数据特殊标签处理*/
                            ,{field: 'pno', title: '商品信息', width: 200, align: 'center', templet: function (data) {
                                    return '<div><a href="${pageContext.request.contextPath}/toProductMsg?pno=' + data.pno + '" class="layui-btn layui-btn-primary layui-border-green">前往商品详情</a></div>';
                                }}
                            ,{field: 'bname', title: '买家', width:150, templet: function (data) {
                                    if(data.bno == uno) {//买家是自己
                                        return '我';
                                    } else {//买家不是用户自己
                                        return '<div><a href="${pageContext.request.contextPath}/toUserMsg?uno=' + data.bno + '" class="layui-btn layui-btn-radius layui-btn-normal">' + data.bname + '</a></div>';
                                    }
                                }
                            }
                            ,{field: 'sname', title: '卖家', width:150, templet: function (data) {
                                    if(data.sno == uno) {//卖家是自己
                                        return '我';
                                    } else {//卖家不是用户自己
                                        return '<div><a href="${pageContext.request.contextPath}/toUserMsg?uno=' + data.sno + '" class="layui-btn layui-btn-radius layui-btn-warm">' + data.sname + '</a></div>';
                                    }
                                }
                            }
                            ,{field: 'odate', title: '下单时间', width: 150, align: 'center', sort: true, templet: '#formatTime'}
                            ,{field: 'stats', title: '交易状态', width: 200, align: 'center', templet:function (data) {
                                    if(data.sno == uno) {//查看订单信息的是卖家
                                        if(data.stats == 0) {
                                            return '<div><button class="layui-btn layui-btn-radius layui-btn-disabled" type="button">订单待确定</button></div>';
                                        } else {
                                            return '<div><button class="layui-btn layui-btn-radius layui-btn-disabled" type="button">订单已确定</button></div>';
                                        }
                                    } else {//查看订单信息的买家
                                        if(data.stats == 0) {//确认订单
                                            return '<div id="order'+ data.ono +'">' +
                                                '<button class="layui-btn layui-btn-radius layui-btn-green" type="button" onclick="sureTheOrder(this)" value="' + data.ono +
                                                '" title="确认订单"><i class="layui-icon">&#x1005;</i></button>'+
                                                '</div>';
                                        } else {//取消订单
                                            return '<div id="order'+ data.ono +'">' +
                                                '<button class="layui-btn layui-btn-radius layui-btn-danger" type="button" onclick="delTheOrder(this)" value="' + data.ono +
                                                '" title="取消订单"><i class="layui-icon">&#xe639;</i></button>'+
                                                '</div>';
                                        }
                                    }
                                }
                            }
                        ]]
                    };
                    option.data = data.data;
                    table.render(option);
                } else {
                    layer.msg("暂无您的订单信息")
                }
            }
        })
    });
</script>

<%--查看我的消费订单请求--%>
<script>
    function getMyBuy() {
        $("#orderList").html("");
        /*使用layui的表格功能*/
        layui.use('table', function(){
            var table = layui.table;
            var uno = $("#uno").val();
            $.ajax({
                type: "GET"
                ,url:'${pageContext.request.contextPath}/getMyBuy'
                ,data:{uno:uno}
                ,dataType: "json"
                ,success: function (data) {
                    if(data) {
                        var option={
                            elem: '#orderList'
                            ,cellMinWidth: 80
                            ,page: true
                            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                            ,limit: 10
                            ,cols: [[ //表头
                                {field: 'ono', title: '订单号', width:100, align: 'center', sort: true, templet: '#orderDetail'}/*//templet参数用户定制列的数据特殊标签处理*/
                                ,{field: 'pno', title: '商品信息', width: 200, align: 'center', templet: function (data) {
                                        return '<div><a href="${pageContext.request.contextPath}/toProductMsg?pno=' + data.pno + '" class="layui-btn layui-btn-primary layui-border-green">前往商品详情</a></div>';
                                    }}
                                ,{field: 'bname', title: '买家', width:150, templet: function (data) {
                                        if(data.bno == uno) {//买家是自己
                                            return '我';
                                        } else {//买家不是用户自己
                                            return '<div><a href="${pageContext.request.contextPath}/toUserMsg?uno=' + data.bno + '" class="layui-btn layui-btn-radius layui-btn-normal">' + data.bname + '</a></div>';
                                        }
                                    }
                                }
                                ,{field: 'sname', title: '卖家', width:150, templet: function (data) {
                                        if(data.sno == uno) {//卖家是自己
                                            return '我';
                                        } else {//卖家不是用户自己
                                            return '<div><a href="${pageContext.request.contextPath}/toUserMsg?uno=' + data.sno + '" class="layui-btn layui-btn-radius layui-btn-warm">' + data.sname + '</a></div>';
                                        }
                                    }
                                }
                                ,{field: 'odate', title: '下单时间', width: 150, align: 'center', sort: true, templet: '#formatTime'}
                                ,{field: 'stats', title: '交易状态', width: 200, align: 'center', templet:function (data) {
                                        if(data.sno == uno) {//查看订单信息的是卖家
                                            if(data.stats == 0) {
                                                return '<div><button class="layui-btn layui-btn-radius layui-btn-disabled" type="button">订单待确定</button></div>';
                                            } else {
                                                return '<div><button class="layui-btn layui-btn-radius layui-btn-disabled" type="button">订单已确定</button></div>';
                                            }
                                        } else {//查看订单信息的买家
                                            if(data.stats == 0) {//确认订单
                                                return '<div id="order'+ data.ono +'">' +
                                                    '<button class="layui-btn layui-btn-radius layui-btn-green" type="button" onclick="sureTheOrder(this)" value="' + data.ono +
                                                    '" title="确认订单"><i class="layui-icon">&#x1005;</i></button>'+
                                                    '</div>';
                                            } else {//取消订单
                                                return '<div id="order'+ data.ono +'">' +
                                                    '<button class="layui-btn layui-btn-radius layui-btn-danger" type="button" onclick="delTheOrder(this)" value="' + data.ono +
                                                    '" title="取消订单"><i class="layui-icon">&#xe639;</i></button>'+
                                                    '</div>';
                                            }
                                        }
                                    }
                                }
                            ]]
                        };
                        option.data = data.data;
                        table.render(option);
                    } else {
                        layer.msg("你还未购买商品")
                    }
                }
            })
        });
    }
</script>

<%--查看我的售出订单按钮--%>
<script>
    function getMySale() {
        $("#orderList").html("");
        /*使用layui的表格功能*/
        layui.use('table', function(){
            var table = layui.table;
            var uno = $("#uno").val();
            $.ajax({
                type: "GET"
                ,url:'${pageContext.request.contextPath}/getMySale'
                ,data:{uno:uno}
                ,dataType: "json"
                ,success: function (data) {
                    if(data) {
                        var option={
                            elem: '#orderList'
                            ,cellMinWidth: 80
                            ,page: true
                            ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                            ,limit: 10
                            ,cols: [[ //表头
                                {field: 'ono', title: '订单号', width:100, align: 'center', sort: true, templet: '#orderDetail'}/*//templet参数用户定制列的数据特殊标签处理*/
                                ,{field: 'pno', title: '商品信息', width: 200, align: 'center', templet: function (data) {
                                        return '<div><a href="${pageContext.request.contextPath}/toProductMsg?pno=' + data.pno + '" class="layui-btn layui-btn-primary layui-border-green">前往商品详情</a></div>';
                                    }}
                                ,{field: 'bname', title: '买家', width:150, templet: function (data) {
                                        if(data.bno == uno) {//买家是自己
                                            return '我';
                                        } else {//买家不是用户自己
                                            return '<div><a href="${pageContext.request.contextPath}/toUserMsg?uno=' + data.bno + '" class="layui-btn layui-btn-radius layui-btn-normal">' + data.bname + '</a></div>';
                                        }
                                    }
                                }
                                ,{field: 'sname', title: '卖家', width:150, templet: function (data) {
                                        if(data.sno == uno) {//卖家是自己
                                            return '我';
                                        } else {//卖家不是用户自己
                                            return '<div><a href="${pageContext.request.contextPath}/toUserMsg?uno=' + data.sno + '" class="layui-btn layui-btn-radius layui-btn-warm">' + data.sname + '</a></div>';
                                        }
                                    }
                                }
                                ,{field: 'odate', title: '下单时间', width: 150, align: 'center', sort: true, templet: '#formatTime'}
                                ,{field: 'stats', title: '交易状态', width: 200, align: 'center', templet:function (data) {
                                        if(data.sno == uno) {//查看订单信息的是卖家
                                            if(data.stats == 0) {
                                                return '<div><button class="layui-btn layui-btn-radius layui-btn-disabled" type="button">订单待确定</button></div>';
                                            } else {
                                                return '<div><button class="layui-btn layui-btn-radius layui-btn-disabled" type="button">订单已确定</button></div>';
                                            }
                                        } else {//查看订单信息的买家
                                            if(data.stats == 0) {//确认订单
                                                return '<div id="order'+ data.ono +'">' +
                                                    '<button class="layui-btn layui-btn-radius layui-btn-green" type="button" onclick="sureTheOrder(this)" value="' + data.ono +
                                                    '" title="确认订单"><i class="layui-icon">&#x1005;</i></button>'+
                                                    '</div>';
                                            } else {//取消订单
                                                return '<div id="order'+ data.ono +'">' +
                                                    '<button class="layui-btn layui-btn-radius layui-btn-danger" type="button" onclick="delTheOrder(this)" value="' + data.ono +
                                                    '" title="取消订单"><i class="layui-icon">&#xe639;</i></button>'+
                                                    '</div>';
                                            }
                                        }
                                    }
                                }
                            ]]
                        };
                        option.data = data.data;
                        table.render(option);
                    } else {
                        layer.msg("你还未售出商品")
                    }
                }
            })
        });
    }
</script>

<%--定制列样式--%>
<script type="text/html" id="orderDetail">
    <div>
        <a class="layui-btn layui-btn-primary layui-border-green" href="${pageContext.request.contextPath}/toOrderDetail?ono={{d.ono}}">{{d.ono}}</a>
    </div>
</script>
<script type="text/html" id="formatTime">
    <div>
        <input id="date{{d.ono}}" value="{{d.odate}}"  onclick="changeTime(this)" readonly type="text" class="layui-btn layui-btn-radius layui-btn-normal" />
    </div>
</script>
<script>
    function changeTime(t) {
        var dealTime = t.value;
        t.value = dateFormat(dealTime, 'yyyy年MM月dd日 HH点mm分ss秒');
        t.onclick = "";
    }
    /*Fri Dec 20 09:10:28 CST 2019 格式转换为yyyy-MM-dd HH:mm:ss格式*/
    function dateFormat (date, format) {
        date = new Date(date);
        date.setHours(date.getHours()-14);
        var o = {
            'M+' : date.getMonth() + 1, //month
            'd+' : date.getDate(), //day
            'H+' : date.getHours(), //hour
            'm+' : date.getMinutes(), //minute
            's+' : date.getSeconds(), //second
            'q+' : Math.floor((date.getMonth() + 3) / 3), //quarter
            'S' : date.getMilliseconds() //millisecond
        };

        if (/(y+)/.test(format))
            format = format.replace(RegExp.$1, (date.getFullYear() + '').substr(4 - RegExp.$1.length));

        for (var k in o)
            if (new RegExp('(' + k + ')').test(format)){
                format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ('00' + o[k]).substr(('' + o[k]).length));
            }
        return format;
    }
</script>

<%--确认订单的点击--%>
<script>
    /*监听确认订单点击按钮事件，t代表标签本身*/
    function sureTheOrder(t) {
        //获得订单号
        var ono = t.value;
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
                            $("#order" + ono).html("<button class='layui-btn layui-btn-radius layui-btn-danger' type='button' onclick='delTheOrder(this)' value='" + ono + "' title='取消订单'><i class='layui-icon'>&#xe639;</i></button>");
                            layer.msg("确认成功",{icon:1});
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

<%--取消订单的按钮--%>
<script>
    /*监听取消订单点击按钮事件，t代表标签本身*/
    function delTheOrder(t) {
        //获得订单号
        var ono = t.value;
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
                            $("#order" + ono).html("<button class='layui-btn layui-btn-radius layui-btn-green' type='button' onclick='sureTheOrder(this)' value='" + ono + "' title='确认订单'><i class='layui-icon'>&#x1005;</i></button>");
                            layer.msg("取消成功",{icon:1});
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