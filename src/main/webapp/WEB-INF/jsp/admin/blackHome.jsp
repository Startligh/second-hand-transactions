<%@ page language="java" contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css">
    <style type="text/css">
        .background{
            background-size: cover;
            background-image: url(${pageContext.request.contextPath}/img/showPic/1.png);
            height: 100%;
            width: 100%;
        }
    </style>
</head>
<body class="background">

<div>
    <div style="padding: 100px; text-align: center">

        <div style="margin-bottom: 50px">
            <button type="button" class="layui-btn" style="background-color: #FFB800; width: 100%; height: 50px">
                <i class="layui-icon layui-icon-home" style="font-size: 30px; color: #FFFFFF; margin: 0 auto;">用户列表</i>
            </button>>
        </div>

        <div name="userMsgList" style="text-align:center; background-color:#FFFFFF;">
            <fieldset style="background-color: #FFFFFF" class="table-search-fieldset">
                <legend>搜索信息</legend>
                <div style="margin: 10px;" id="btn">
                    <div class="layui-form-item">
                        <form action="${pageContext.request.contextPath}/admin/searchBlackUser">
                            <div class="layui-inline">
                                <label class="layui-form-label">名称或编号</label>
                                <div class="layui-input-inline">
                                    <!--注意此处input标签里的id-->
                                    <input class="layui-input" name="keyword" id="keyword" autocomplete="off">
                                </div>
                            </div>

                            <div class="layui-inline">
                                <input type="submit" class="layui-btn layui-btn-primary">
                                <!--注意此处button标签里的type属性-->
                                <%--<button id="searchUser" type="button" class=""  lay-submit data-type="reload" lay-filter="data-search-btn"><i class="layui-icon"></i> 搜 索</button>--%>
                            </div>
                        </form>
                    </div>
                </div>
            </fieldset>
            <c:if test="${userList==null}">
                <c:out value="暂无用户"></c:out>
            </c:if>
            <c:if test="${userList!=null}">
                <table class="layui-table" lay-even lay-skin="line" lay-size="lg">
                    <colgroup>
                        <col width="200">
                        <col width="200">
                        <col width="200">
                        <col width="200">
                        <col width="200">
                        <col width="800">
                        <col width="200">
                        <col width="200">
                        <col width="200">
                    </colgroup>
                    <thead>
                    <tr>
                        <th>用户头像</th>
                        <th>用户编号</th>
                        <th>用户名</th>
                        <th>性别</th>
                        <th>电话</th>
                        <th>地址</th>
                        <th>余额</th>
                        <th>类型</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <c:forEach items="${userList}" var="user">
                        <tbody>
                        <tr<c:if test="${user.utype!='white'}"> bgcolor="#dda0dd" </c:if>>
                            <td>
                                <img src="${pageContext.request.contextPath}/img/headPhoto/${user.upricture}" class="layui-nav-img">
                            </td>
                            <td><c:out value="${user.uno}"></c:out></td>
                            <td><c:out value="${user.uname}"></c:out></td>
                            <td>
                                <button type="button" class="layui-btn layui-btn-sm">
                                    <c:if test="${user.usex=='男'}">
                                        <i class="layui-icon" style="color: #141d6b">&#xe662;</i>
                                    </c:if>
                                    <c:if test="${user.usex=='女'}">
                                        <i class="layui-icon" style="color: #6b0058">&#xe661;</i>
                                    </c:if>
                                </button>
                            </td>
                            <td><c:out value="${user.utel}"></c:out></td>
                            <td><c:out value="${user.uaddress}"></c:out></td>
                            <td><c:out value="${user.ubalance}"></c:out></td>
                            <td>
                                <c:if test="${user.utype=='white'}">
                                    <button type="button" class="layui-btn layui-btn-sm">
                                        <i class="layui-icon">&#xe6af;</i>
                                    </button>
                                </c:if>
                                <c:if test="${user.utype!='white'}">
                                    <i class="layui-icon" style="color: black">&#xe69c;</i>
                                </c:if>
                            </td>
                            <td>
                                <form action="${pageContext.request.contextPath}/admin/changeUserType" method="post">
                                    <input hidden name="uno" value="${user.uno}">
                                    <button type="submit" class="layui-btn layui-btn-sm">
                                        <c:if test="${user.utype=='white'}">
                                            <input hidden name="utype" value="black">
                                            <i class="layui-icon">&#xe682;</i>&nbsp;加入黑名单
                                        </c:if>
                                        <c:if test="${user.utype!='white'}">
                                            <input hidden name="utype" value="white">
                                            <i class="layui-icon">&#xe682;</i>&nbsp;移出黑名单
                                        </c:if>
                                    </button>
                                </form>
                            </td>
                        </tr>
                        </tbody>
                    </c:forEach>
                </table>
            </c:if>
        </div>
        <script type="text/javascript">
            layui.use('form',function(){
                const form = layui.form;
                form.render();
            });
        </script>
</body>
</html>