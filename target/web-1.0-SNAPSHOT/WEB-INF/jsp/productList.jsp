<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--导入头部--%>
<%@include file="/WEB-INF/jsp/head.jsp"%>

<!-- 产品搜索结果展示内容主体区域 -->
<input hidden id="productCount" name="productCount" value="${count}">
<input hidden id="keyWord" name="keyWord" value="${keyWord}">
<div>
    <div style="padding: 100px;">

        <%--商品查询结果显示，MAX:?个，MIN:0个--%>
        <div id="productList" name="productList" class="layui-main, layui-container" style="text-align:center;">

        </div>

        <div class="layui-main, layui-container" style="margin-top: 50px;text-align:center;">
            <button type="button" onclick="searchProduct()" class="layui-btn layui-btn-lg layui-btn-radius layui-btn-normal">搜索更多</button>
        </div>

    </div>
</div>

<script src="${pageContext.request.contextPath}/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="layui/layui.js"></script>
<script type="text/javascript">
    window.onload = function()//用window的onload事件，窗体加载完毕的时候
    {
        searchProduct();
    }
</script>

<script>
    $(document).scroll(function() {
        //以下三个值的来源、意义都不同
        var scrollTop = $(document).scrollTop();//页面卷上去的高度，滚动到的当前位置
        var height = document.body.clientHeight;//浏览器高度，即使可以给页面展示的高度
        var contentHeight = $(document).height();  //内容高度
        if (contentHeight <= (height + scrollTop)){  //滚动条滑到底部啦
            searchProduct();
        }
    });
</script>

<script>
    function searchProduct() {
        var count = $("#productCount").val();
        var keyWord = $("#keyWord").val();
        $.ajax({
            url:'${pageContext.request.contextPath}/searchProduct', //对应controller的URL，获得数据
            data:{count:count,keyWord:keyWord},
            method:'post',
            contentType:'application/json',
            dataType:"json",
            success: function (res) {
                var datas = res.data;
                var html = '';
                if(datas) {
                    for (let i = 0; i < datas.length; i++) {
                        if(i % 4 === 0) {
                            html += '<br/>';
                        }
                        html += '<table style="background-color: #fff; color: #666; margin: 0 15px; " class="layui-inline" lay-even lay-skin="nob" width="250">';
                        html += '   <tbody>';
                        html += '       <tr>';
                        html += '           <td style="position: relative; padding: 9px 15px; line-height: 20px;">';
                        html += '               <img style="margin: 0 auto; width: 200px; height: 200px" onclick="showimg(this)" src="img/productPhoto/' + datas[i].ppricture + '">';
                        html += '           </td>';
                        html += '       </tr>';
                        html += '       <tr>';
                        html += '           <td style="position: relative; padding: 9px 15px; line-height: 20px; max-width: 200px">' + datas[i].pname + '</td>';
                        html += '       </tr>';
                        html += '           <td style="position: relative; padding: 9px 15px; line-height: 20px;">￥' + datas[i].price + '</td>';
                        html += '       </tr>';
                        html += '       <tr>';
                        html += '           <td style="position: relative; padding: 9px 15px; line-height: 20px;">' + datas[i].plevel + '成新</td>';
                        html += '       </tr>';
                        html += '       <tr>';
                        html += '           <td style="position: relative; padding: 9px 15px; line-height: 20px;">';
                        html += '               <a href="toUserMsg?uno=' + datas[i].uno + '" class="layui-btn layui-btn-radius layui-btn-primary" style="color: aqua;">发布用户</a>';
                        html += '           </td>';
                        html += '       </tr>';
                        html += '       <tr>';
                        html += '           <td style="position: relative; padding: 9px 15px; line-height: 20px;">';
                        html += '               <a href="toProductMsg?pno=' + datas[i].pno + '" class="layui-btn layui-btn-radius layui-btn-primary" style="color: deeppink">查看详情</a>';
                        html += '           </td>';
                        html += '       </tr>';
                        html += '<tr>';
                        html += '           <td style="position: relative; padding: 9px 15px; line-height: 20px;">';
                        html += '               <a href="buy?pno=' + datas[i].pno + '" class="layui-btn layui-btn-radius layui-btn-primary" style="color: deeppink">立即购买</a>';
                        html += '           </td>';
                        html += '</tr>';
                        html += '   </tbody>';
                        html += '</table>';
                    }
                } else {
                    console.log("刷到底了，去搜索看看吧");
                }
                $("#productList").append(html);
                document.getElementById('productCount').value = res.newCount;
            }
        });
    }
</script>

<%--导入脚部--%>
<%@include file="/WEB-INF/jsp/foot.jsp" %>