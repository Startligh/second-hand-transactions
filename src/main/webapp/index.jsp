<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>index</title>
    <link rel="stylesheet" href="./layui/css/layui.css">
</head>
<body>
<h2>Hello World!</h2>
</body>
<%--<a href="toTest">前往测试页面</a><br>
<p></p>
<a href="${pageContext.request.contextPath}/toShowIndex" class="layui-btn">首页</a>--%>
<jsp:forward page="/toShowIndex"></jsp:forward>
</html>
