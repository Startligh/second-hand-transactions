<%@ page language="java" contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<html>
<head>
    <title>test</title>
</head>
<body>
    <form action="test" method="post" enctype="multipart/form-data">
        <table border="1">
            <tr>
                <td>属性</td>
                <td>值</td>
            </tr>
            <tr>
                <td>用户名：</td>
                <td>
                    <input type="text" name="username" value="${user.username}">
                </td>
            </tr>
            <tr>
                <td>密码：</td>
                <td>
                    <input name="password" type="password" value="${user.password}">
                </td>
            </tr>
            <tr>
                <td>角色：</td>
                <td>
                    <input type="text" name="role" value="${user.role}">
                </td>
            </tr>
            <tr>
                <td>性别：</td>
                <td>
                    <input type="radio" name="sex" value="1" <c:if test="${user.sex == '1'}">checked="checked"</c:if>>男
                    <input type="radio" name="sex" value="0" <c:if test="${user.sex == '0'}">checked="checked"</c:if>>女
                </td>
            </tr>

            <tr>
                <td>爱好：</td>
                <td>
                    <input type="checkbox" name="likes" value="唱跳"
                        <c:forEach items="${user.likes}" var="hobby">
                            <c:if test="${'唱跳' == hobby}">
                               checked="checked"
                            </c:if>
                        </c:forEach>
                    >唱跳
                    <input type="checkbox" name="likes" value="rap"
                        <c:forEach items="${user.likes}" var="hobby">
                            <c:if test="${'rap' == hobby}">
                                   checked="checked"
                            </c:if>
                        </c:forEach>
                    >rap
                    <input type="checkbox" name="likes" value="篮球"
                        <c:forEach items="${user.likes}" var="hobby">
                            <c:if test="${'篮球' == hobby}">
                                   checked="checked"
                            </c:if>
                        </c:forEach>
                    >篮球
                </td>
            </tr>
            <tr>
                <td>创建时间：</td>
                <td>
                    <input type="date" id="createDate" name="createDate" value="<fmt:formatDate value="${user.createDate}" type="both" pattern="yyyy-MM-dd"/>">
                </td>
            </tr>
            <tr>
                <td>照片</td>
                <td>
                    <c:if test="${user.fileName!=null}">
                        <img src="${pageContext.request.contextPath}/img/headPhoto/${user.fileName}" width="100%" height="100%"><br>
                        <a href="download?fileName=${user.fileName}">点击下载图片</a>
                    </c:if>
                    <c:if test="${user.fileName==null}">
                        <input type="file" name="file"/>
                    </c:if>
                </td>
            </tr>
                <c:if test="${user==null}">
                    <td><input type="submit" value="提交"></td>
                    <td><input type="reset" value="取消"></td>
                </c:if>
                <c:if test="${user!=null}">
                    <td><a href="toTest">前往测试页面</a></td>
                </c:if>
            </tr>
        </table>
    </form>
</body>
</html>
