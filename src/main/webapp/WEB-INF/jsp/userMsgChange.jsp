<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--导入头部--%>
<%@include file="/WEB-INF/jsp/head.jsp"%>

<!-- 用户信息修改页内容主体区域 -->
<div>
    <div class="layui-container" style="padding: 100px; text-align: center">

        <div style="padding: 50px 0 50px 0">
            <i class="layui-icon layui-icon-face-smile" style="font-size: 30px; color: #1E9FFF; margin: 0 auto;">
                修改完善你的个人信息
            </i>
        </div>

        <form class="layui-form layui-form-pane" action="${pageContext.request.contextPath}/userMsgSure" method="post" enctype="multipart/form-data">
            <input hidden name="uno" value="${user.uno}">
            <div class="layui-form-item">
                <label class="layui-form-label">用户名称</label>
                <div class="layui-input-block">
                    <input type="text" name="uname" required  lay-verify="required" placeholder="请输入名称" value="${user.uname}" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">性别</label>
                <div class="layui-input-block">
                    <input type="radio" name="usex" value="男" title="男" <c:if test="${user.usex == '男'}"> checked</c:if>>
                    <input type="radio" name="usex" value="女" title="女" <c:if test="${user.usex == '女'}"> checked</c:if>>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">电话</label>
                <div class="layui-input-inline">
                    <input type="text" name="utel" required lay-verify="required" placeholder="请输入电话" value="${user.utel}" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">地址</label>
                <div class="layui-input-block">
                    <input type="text" name="uaddress" required lay-verify="required" placeholder="请输入地址" value="${user.uaddress}" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label"><i class="layui-icon">&#xe67c;</i>上传头像</label>
                <div class="layui-input-block">
                    <input class="layui-inline" type="file" name="file"/>
                </div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block" style="margin-left: 0px;">
                    <input class="layui-btn" type="submit" value="立即提交">
                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                </div>
            </div>
        </form>
    </div>
</div>

<%--导入脚部--%>
<%@include file="/WEB-INF/jsp/foot.jsp" %>
