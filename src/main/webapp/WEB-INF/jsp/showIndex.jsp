<%@ page language="java" contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8"%>
<%--导入头部--%>
<%@include file="/WEB-INF/jsp/head.jsp"%>

<!-- 首页内容主体区域 -->
<div>
    <div style="padding: 100px;">

        <div class="layui-carousel" id="test1">
            <div carousel-item>
                <c:if test="${picList!=null}">
                    <c:forEach items="${picList}" var="showPic">
                        <div style="text-align:center;"><img style="object-fit:cover;" width="100%" height="100%" src="${pageContext.request.contextPath}/img/showPic/${showPic.picName}"></div>
                    </c:forEach>
                </c:if>
                <c:if test="${picList==null}">
                    <div style="text-align:center;"><img width="70%" height="100%" src="${pageContext.request.contextPath}/img/showPic/1.png"></div>
                    <div style="text-align:center;"><img width="70%" height="200%" src="${pageContext.request.contextPath}/img/showPic/2.jpg"></div>
                    <div style="text-align:center;"><img width="1300px" height="300px" src="${pageContext.request.contextPath}/img/showPic/3.png"></div>
                </c:if>
                </div>
        </div>
        <!-- 条目中可以是任意内容，如：<img src=""> -->

        <div class="layui-main" style="padding-top: 50px; margin-bottom: -100px;">
            <i class="layui-icon layui-icon-face-smile" style="font-size: 30px; color: #1E9FFF; margin: 0 auto;">
                <a href="${pageContext.request.contextPath}/toSearch?keyWord=最新发布" class="layui-btn layui-btn-radius layui-btn-primary" style="color: #18cde8">最新发布</a>
            </i>
        </div>

        <%--导入产品列表--%>
        <%@include file="/WEB-INF/jsp/productList.jsp" %>
    </div>
</div>

<%--导入脚部--%>
<%@include file="/WEB-INF/jsp/foot.jsp" %>
