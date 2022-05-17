<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--导入头部--%>
<%@include file="/WEB-INF/jsp/head.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-1.8.3.min.js"></script>
<!-- 用户信息展示内容主体区域 -->
<div>
    <div class="layui-container" style="padding: 100px; text-align: center">

        <div style="margin-bottom: 50px">
            <i class="layui-icon layui-icon-home" style="font-size: 30px; color: #1E9FFF; margin: 0 auto;">
                <c:if test="${msg=='differentUser'}">
                    <c:out value="${user.uname}的个人空间"></c:out>
                </c:if>
                <c:if test="${msg!='differentUser'}">
                    <c:out value="我的个人空间"></c:out>
                </c:if>
            </i>
            <c:if test="${msg=='differentUser'}">
                <br>
                <button onclick="chat()" class="layui-icon-dialogue" style="font-size: 30px; color: green; margin: 0 auto;">
                    聊一聊
                </button>
            </c:if>
        </div>

        <div class="layui-row layui-col-space10">
            <div class="layui-col-md7">
                <img width="500px" height="350px" onclick="showimg(this)" src="${pageContext.request.contextPath}/img/headPhoto/${user.upricture}">
            </div>
            <div class="layui-col-md5">
                <table style="background-color: #fff; color: #666; margin: 0 15px; " class="layui-inline" lay-even lay-skin="nob" width="250">
                    <tbody>
                    <tr>
                        <tr>
                            <td style="position: relative; padding: 9px 15px; line-height: 20px;">
                                <input hidden id="userMsg_id" value="${user.uno}">
                                <i class="layui-icon">&#xe687;</i>&nbsp;&nbsp;帐号：&nbsp;&nbsp;<c:out value="${user.uno}"></c:out>
                            </td>
                        </tr>
                        <td style="position: relative; padding: 9px 15px; line-height: 20px; max-width: 200px">
                            <i class="layui-icon">&#xe66f;</i>&nbsp;&nbsp;名称：&nbsp;&nbsp;<c:out value="${user.uname}"></c:out>
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            <c:if test="${user.usex=='男'}">
                                <i class="layui-icon">&#xe662;</i><%--男的--%>
                            </c:if>
                            <c:if test="${user.usex=='女'}">
                                <i class="layui-icon">&#xe661;</i><%--女的--%>
                            </c:if>
                        </td>
                    </tr>
                    <tr>
                        <td style="position: relative; padding: 9px 15px; line-height: 20px;">
                            <i class="layui-icon">&#xe63b;</i>&nbsp;&nbsp;电话：&nbsp;&nbsp;<c:out value="${user.utel}"></c:out>
                        </td>
                    </tr>
                    <tr>
                        <td style="position: relative; padding: 9px 15px; line-height: 20px;">
                            <i class="layui-icon">&#xe715;</i>&nbsp;&nbsp;地址：&nbsp;&nbsp;<c:out value="${user.uaddress}"></c:out>
                        </td>
                    </tr>
                    <c:if test="${msg!='differentUser'}">
                        <%--本人查看信息--%>
                        <tr>
                            <td style="position: relative; padding: 9px 15px; line-height: 20px;">
                                <i class="layui-icon">&#xe65e;</i>&nbsp;&nbsp;余额&nbsp;&nbsp;<c:out value="${user.ubalance}"></c:out>
                            </td>
                        </tr>
                        <tr>
                            <td style="position: relative; padding: 9px 15px; line-height: 20px;">
                                <i class="layui-icon">&#xe642;</i>&nbsp;&nbsp;<a href="${pageContext.request.contextPath}/toUserMsgChange" class="layui-btn layui-btn-radius layui-btn-primary" style="color: #d20fff;">修改个人信息</a>
                            </td>
                        </tr>
                        <tr>
                            <td style="position: relative; padding: 9px 15px; line-height: 20px;">
                                <i class="layui-icon">&#xe683;</i>&nbsp;&nbsp;<a href="#" id="toUpdatePassword" class="layui-btn layui-btn-radius layui-btn-primary" style="color: #008000;">修&nbsp;改&nbsp;密&nbsp;码</a>
                            </td>
                        </tr>
<%--                        <tr>
                            <td style="position: relative; padding: 9px 15px; line-height: 20px;">
                                <i class="layui-icon">&#xe654;</i>&nbsp;&nbsp;<a href="${pageContext.request.contextPath}/toAddMyProduct?uno=${userNo}" class="layui-btn layui-btn-radius layui-btn-warm" style="color: #FFFFFF;">发&nbsp;布&nbsp;产&nbsp;品</a>
                            </td>
                        </tr>--%>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>

        <c:if test="${msg=='perfectInfo'}">
            <input id="perfectInfo" value="${perfectInfo}" hidden>
            <script>
                window.onload = function() {
                    var perfectInfo = document.getElementById("perfectInfo").value;
                    layer.msg('个人信息需要完善', {icon:5});
                    layer.msg(perfectInfo, {icon:5});
                    //延迟3s后跳转
                    window.setTimeout(function () {
                        window.location.href='${pageContext.request.contextPath}/toUserMsgChange';
                    },3000)
                }
            </script>
        </c:if>

        <%--展示我的出售商品并管理--%>
        <c:if test="${msg!='differentUser'}">
            <div style="margin: 50px 0 20px 0; text-align: center">
                <i class="layui-icon layui-icon-release" style="font-size: 30px; color: #1E9FFF; margin: 0 auto;">
                    我发布的商品
                </i>
            </div>

            <%--商品表格--%>
            <table id="myProductTable" lay-filter="myProductTable"></table><%--layui初始化需要的table--%>
        </c:if>
    </div>
</div>


<c:if test="${msg=='differentUser'}">
    <div style="text-align: center; margin-bottom: -100px;">
        <i class="layui-icon layui-icon-release" style="font-size: 30px; color: #1E9FFF; margin: 0 auto;">
            <c:out value="${user.uname}发布的商品"></c:out>
        </i>
    </div>
    <%--导入商品列表--%>
    <%@include file="/WEB-INF/jsp/productList.jsp" %>
</c:if>


<script src="${pageContext.request.contextPath}/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="layui/layui.js"></script>
<script>
    layui.use(['form', 'layedit', 'laydate','jquery','layer'], function(){
        var form = layui.form;
        var layer = layui.layer;
        var layedit = layui.layedit;
        var laydate = layui.laydate;
        var $=layui.jquery;

        $("#toUpdatePassword").click(function(){
            //点击修改密码时弹出一个弹出层
            layer.open(
                {
                    type:2,
                    title:'修改密码',
                    area:['50%','80%'],
                    content:"${pageContext.request.contextPath}/toUpdatePassword"
                });
        });

    });
</script>

<%--点击聊一聊事件--%>
<script type="text/javascript">
    function chat() {
        sessionStorage.setItem("chatWith", $("#userMsg_id").val());
        $(location).attr("href","${pageContext.request.contextPath}/messageCenter");
    }
</script>

<%--制作商品管理表格--%>
<script type="text/javascript">
    /*使用layui的表格功能*/
    layui.use('table', function(){
        var table = layui.table;
        var uno = $("#uno").val();
        $.ajax({
            type: "GET"
            ,url:'${pageContext.request.contextPath}/getMyProducts'
            ,data:{uno:uno}
            ,dataType: "json"
            ,success: function (data) {
                if(data) {
                    var option={
                        elem: '#myProductTable'
                        ,cellMinWidth: 80
                        ,page: true
                        ,toolbar: '#toolbarDemo' //开启头部工具栏，并为其绑定左侧模板
                        ,limit: 10
                        ,cols: [[ //表头
                            {field: 'pno', title: '商品编号', width:150, align: 'center', sort: true, templet: '#pno'}
                            ,{field: 'ppricture', title: '图片', width: 200, align: 'center', templet: '#ppricture'}/*//templet参数用户定制列的数据特殊标签处理*/
                            ,{field: 'pname', title: '商品名称', align: 'center', width:150}
                            ,{field: 'price', title: '价格', width:120, align: 'center', sort: true}
                            ,{field: 'ptype', title: '类别', width:120, align: 'center'}
                            ,{field: 'plevel', title: '成色', width:120, align: 'center', sort: true}
                            ,{field: 'uname', title: '交易状态', width:200, templet: function (data) {
                                    if (data.bno != null) {
                                        return '<div>' +
                                            '<a class="layui-btn layui-btn-radius layui-btn-warm" href="${pageContext.request.contextPath}/toUserMsg?uno=' + data.bno +
                                            '">' + data.uname + '&nbsp;已购买</a>' +
                                            '</div>';
                                    } else {
                                        return '<div><button class="layui-btn layui-btn-radius layui-btn-normal" type="button">您的商品尚未卖出</button></div>';
                                    }
                                }
                            }
                            ,{field: 'pno', title: '修改', width: 120, align: 'center', templet:function (data) {
                                    if(data.bno != null) {
                                        return '<div><button class="layui-btn layui-btn-radius layui-btn-disabled" type="button">商品卖出无法修改</button></div>';
                                    } else {
                                        return '<div>' +
                                            '<form action="${pageContext.request.contextPath}/toUpdateProduct" method="post">' +
                                                '<input hidden name="pno" value="' + data.pno + '">' +
                                                '<button type="submit" class="layui-btn layui-btn-radius layui-btn-normal">' +
                                                    '<i class="layui-icon">&#xe642;</i>' +
                                                '</button>' +
                                            '</form>' +
                                            '</div>';
                                    }
                                }
                            }
                            ,{field: 'pno', title: '删除', width: 120, align: 'center', templet:function (data) {
                                    if(data.bno != null) {
                                        return '<div><button class="layui-btn layui-btn-radius layui-btn-disabled" type="button">商品卖出无法删除</button></div>';
                                    } else {
                                        return '<div>' +
                                            '<button class="layui-btn layui-btn-radius layui-btn-danger" type="button" onclick="delProduct(this)" id="del'+ data.pno +'" value= ' + data.pno +
                                            '><i class="layui-icon">&#xe640;</i></button>'+
                                            '</div>';
                                    }
                                }
                            }
                        ]]
                    };
                    option.data = data.data
                    table.render(option);
                } else {
                    layer.msg("你还未发布商品")
                }
            }
        })
    });
</script>

<%--定制列样式，展示图片--%>
<script type="text/html" id="ppricture">
    <img style="object-fit:cover;" width="100%" height="100%" src="${pageContext.request.contextPath}/img/productPhoto/{{d.ppricture}}" onclick="showimg(this)">
</script>
<script type="text/html" id="pno">
    <div><input hidden name="pno" id="product_{{d.pno}}" value="{{d.pno}}">{{d.pno}}</div>
</script>

<%--删除的监听事件函数--%>
<script>
    /*传入this，标签本身*/
    function delProduct(t) {
        //获得商品id
        var pno = t.value;
        layer.confirm('确定要删除商品吗?',{
                btn : [ '是的', '取消'], //按钮
                shade : false
                //不显示遮罩
            },
            function(index) {
                $.ajax({
                    url : "${pageContext.request.contextPath}/delProduct",
                    data: {"pno":pno},
                    method:'post',
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