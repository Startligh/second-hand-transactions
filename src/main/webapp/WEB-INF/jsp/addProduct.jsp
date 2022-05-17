<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--导入头部--%>
<%@include file="/WEB-INF/jsp/head.jsp"%>

<!-- 产品搜索结果展示内容主体区域 -->
<div>
    <div class="layui-container" style="padding: 100px; text-align: center">

        <div style="padding: 50px 0 50px 0">
            <i class="layui-icon" style="font-size: 30px; color: #1E9FFF; margin: 0 auto;">
                &#xe642;<c:out value="${msg}"></c:out>
            </i>
        </div>

        <form class="layui-form layui-form-pane"
              <c:if test="${msg=='添加属于你的商品'}">action="${pageContext.request.contextPath}/addProduct"</c:if>
              <c:if test="${msg=='修改商品信息'}">action="${pageContext.request.contextPath}/updateProduct"</c:if>
              method="post" enctype="multipart/form-data">
            <input hidden name="uno" value="${userNo}">
            <c:if test="${product.pno!=null}">
                <input hidden name="pno" value="${product.pno}">
            </c:if>
            <div class="layui-form-item">
                <label class="layui-form-label">商品名称</label>
                <div class="layui-input-block">
                    <input type="text" name="pname" required  lay-verify="required" placeholder="请输入商品名称" autocomplete="off" class="layui-input"
                        <c:if test="${product.pname!=null}">value="${product.pname}"</c:if>
                    >
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">商品价格</label>
                <div class="layui-input-inline">
                    <input type="text" name="price" required lay-verify="required" placeholder="请输入价格" autocomplete="off" class="layui-input"
                           <c:if test="${product.price!=null}">value="${product.price}"</c:if>
                    >
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">新旧程度</label>
                <div class="layui-input-block">
                    <select id="plevel" name="plevel" required lay-verify="required">
                        <option value=""></option>
                        <option value="1">1成新</option>
                        <option value="2">2成新</option>
                        <option value="3">3成新</option>
                        <option value="4">4成新</option>
                        <option value="5">5成新</option>
                        <option value="6">6成新</option>
                        <option value="7">7成新</option>
                        <option value="8">8成新</option>
                        <option value="9">9成新</option>
                        <option value="10">10成新</option>
                    </select>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">商品类型</label>
                <div class="layui-input-block">
                    <select id="ptype" name="ptype" required lay-verify="required">
                        <option value=""></option>
                        <option value="电子商品">电子商品</option>
                        <option value="书籍">书&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;籍</option>
                        <option value="生活用品">生活用品</option>
                        <option value="个人服饰">个人服饰</option>
                    </select>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label"><i class="layui-icon">&#xe67c;</i>上传图片</label>
                <div class="layui-input-block">
                    <input class="layui-inline" name="file" type="file" <c:if test="${msg=='添加属于你的商品'}">required lay-verify="required"</c:if>/>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block" style="margin-left: 0px;">
                    <input class="layui-btn" onclick="checkProductMsg()" type="submit" value="立即提交">
                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                </div>
            </div>
        </form>

    </div>
</div>

<script type="text/javascript" src="layui/layui.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-1.8.3.min.js"></script>
<script>
    function checkProductMsg() {
        var plevel = $('#plevel option:selected').val();//选中的值
        var ptype = $('#ptype option:selected').val();//选中的值
        if(plevel == '' || ptype == '') {
            layer.msg("商品成色或商品类型未填写", {icon:5});
        }
    }
</script>

<%--导入脚部--%>
<%@include file="/WEB-INF/jsp/foot.jsp" %>