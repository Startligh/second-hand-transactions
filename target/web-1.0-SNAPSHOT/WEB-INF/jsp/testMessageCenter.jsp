<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--导入头部--%>
<%@include file="/WEB-INF/jsp/head.jsp"%>

<!-- 消息中心内容主体区域 -->
<div style="padding: 20px; margin: 20px">
    <strong>location:</strong> <br />
    <input type="text" id="serverUrl" size="35" value="" /> <br />
    <button onclick="connect()">Connect</button>
    <button onclick="wsclose()">disConnect</button>
    <br /> <strong>message:</strong> <br /> <input id="txtMsg" type="text" size="50" />
    <br />
    <button onclick="sendEvent()">send</button>
</div>

<div style="margin-left: 20px; padding-left: 20px; width: 350px; border-left: solid 1px #cccccc;"> <strong>Log:</strong>
    <div style="border: solid 1px #999999;border-top-color: #CCCCCC;border-left-color: #CCCCCC; padding: 5px;width: 100%;height: 172px;overflow-y: scroll;" id="echo-log"></div>
    <button onclick="clearLog()" style="position: relative; top: 3px;">Clear log</button>
</div>

<%--导入脚部--%>
<%@include file="/WEB-INF/jsp/foot.jsp" %>