<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--导入头部--%>
<%@include file="/WEB-INF/jsp/head.jsp"%>

<!-- 消息中心内容主体区域 -->
<div  class="layui-container" style="padding: 75px">
    <div class="Main">
        <div id="Mainchat">
            <div class="slidebar">
                <div class="slide-tag">
                    <div class="chat-view">
                        <a><img id="view-photo" src="${pageContext.request.contextPath}/static/Photo/greenwe_07.png"></a>
                        <span class='reddot'></span>
                    </div>
                    <div class="contact">
                        联系人
                    </div>
                </div>
                <div class="slide-online">
                    <div class="slide_one"></div>
                </div>
                <div class="chating">
                    <div class="chating_one">
                        <!-- <div class="chat_ing"></div> -->
                    </div>
                </div>
            </div>
            <!-- 聊天窗口 -->
            <%--选择聊天对象后：style="display:block"--%>
            <div id="chatArea" class="boxchat">
                <div class="box_hd">
                    <div class="title_wrap">
                        <div class="title_body" id="chatWithName">
                            联系人名称
                        </div>
                    </div>
                </div>
                <div class="chat_content" style="position: absolute;top: 51px;right: 0;bottom: 0;left: 0;">
                    <div class="box-mainwrap"></div>
                </div>
                <div class="box_ft">
                    <div class="ft_toolbar">
                        <a href="#" class="face"></a>
                        <div class="checkchat"><span>聊天记录</span></div>
                    </div>
                    <div class="ft_content">
                        <div class="conten_area">
                            <textarea id="send-frame"></textarea>
                        </div>
                    </div>
                    <div class="action">
                        <span class="action_line">按下ctrl+Enter发送消息</span>
                        <button class="btn_send" id="send">发送</button>
                    </div>
                </div>
                <div class="faces_box">
                    <div class="faces_content">
                        <div class="faces_title">
                            <ul>
                                <li class="facesT_name">常用表情</li>
                            </ul>
                        </div>
                        <div class="faces_main">
                            <ul></ul>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 聊天记录 -->
            <div class="history">
                <div class="box_hd">
                    <div class="title_wrap">
                        <div class="title_body">
                            <a href="#" class="title_name">聊天记录</a>
                            <div style="left: 650px;top: 15px;position: absolute;"><img  class="close" src="${pageContext.request.contextPath}/static/Photo/close_02.png"></div>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="history_main">
                </div>
            </div>
            <!-- 联系人界面 -->
            <div class="menber-orign">
                <div class="orign-header">
                    <div class="title-wrap">
                        <div class="title">消息中心</div>
                    </div>
                </div>
                <div class="orign-main">
                    <div class="o-main-wrap">
                        <div>
                            <img src="${pageContext.request.contextPath}/static/Photo/lianxiren_05.png">
                            <br>点击左侧选择聊天对象
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/jquery-1.8.3.min.js"></script>
<script src="${pageContext.request.contextPath}/layui/layui.js"></script>
<script type="text/javascript">
    //创建websocket对象
    var websocket;
    var connFlag = false;
    window.onload = myOnload();
    function myOnload() {
        getSocket();
        //加载聊天对象
        $(".slide-online").show();//打开联系人列表
        if(sessionStorage.getItem("chatWith") != null) {
            addChatUserAndChat();
        }
        //加载聊天历史列表，假如历史列表存在选定聊天对象（删去）

    }
    function getSocket() {
        if('WebSocket' in window) {
            console.log("此浏览器支持websocket");
            if(!connFlag) {
                //创建连接
                websocket = new WebSocket("ws://localhost:8080${pageContext.request.contextPath}/webSocketPoint");
                connFlag = true;
            }
        } else if('MozWebSocket' in window) {
            console.log("此浏览器只支持MozWebSocket");
        } else {
            console.log("此浏览器只支持SockJS");
        }
        websocket.onopen = function(evnt) {
            console.log("连接服务器成功!")
        };
        websocket.onmessage = function(evnt) {
            console.log(evnt.data);
            //返回data格式："sendFrom:xxx;content:xxx"
            var str = evnt.data.split(';');
            var sendFrom = str[0].split(':')[1];
            var content = str[1].split(':')[1];
            if(sendFrom == sessionStorage.getItem("chatting-userNo")) {
                var userPic = document.getElementById("photo_" + sendFrom);
                //当前对话框用户发来消息
                addOtherSayToBox(content, sendFrom, userPic.alt);
            }
/*            else if() {
                //在当前的联系人列表，使用缓存的json判断（页面加载时获得数据库中的联系人列表，缓存）
            }*/
        };
        websocket.onerror = function(evnt) {
            connFlag = false;
            console.log("发生连接错误!")
        };
        websocket.onclose = function(evnt) {
            connFlag = false;
            console.log("与服务器断开了链接!")
        }
/*        $('#send').bind('click', function() {
            send();
        });*/
    }
    //发送消息给服务端
    function send(content) {
        if(websocket != null) {
            console.log("内容：" + content);
            var message = "chatToUser:" + sessionStorage.getItem("chatting-userNo") + ";content:" + content;
            websocket.send(message);
            return true;
        } else {
            alert('未与服务器链接.');
            return false;
        }
    }

    document.getElementById("outLogin").onclick = outLogin();
    function outLogin() {
        if(!connFlag && websocket != null) {
            connFlag = false;
            websocket.close();
            websocket = null;
        }
    }

    window.onbeforeunload = function () {
        console.log("页面关闭");
        if(!connFlag && websocket != null) {
            connFlag = false;
            websocket.close();
            websocket = null;
        }
    };

    //选择聊天用户进入消息中心————打开聊天区域、将其添加入联系人列表
    function addChatUserAndChat() {
        var chatWithUno = sessionStorage.getItem("chatWith");
        sessionStorage.removeItem("chatWith");
        addChatUser(chatWithUno);
        //chooseToChat(chatWithUno);
        //将该用户添加入联系人列表(数据库)

    }

    function addChatUser(userNo) {
        $.ajax({
            //得到用户头像、昵称
            url : "${pageContext.request.contextPath}/getUserHP",
            data:{uno:userNo},
            method:'post',
            contentType:'application/json',
            dataType:"json",
            success : function(result) {
                if(result.code == 200) {
                    //成功：说明存在该用户，添加进入联系人框
                    var friendDiv  = "<div class='menber' id="+ userNo +" onclick=chooseToChat(this)>"+"<div class='men-pirture'>"+"<span id='photo_" + result.userName + "' class='m-pirture'>"+'</span>'+"</div>"+"<div class='chat-item'>"+"<h3 class='s-nickname'>"+"<span class='s-nick-text' id='" + userNo + "_userName'>"+ result.userName +"</span>"+"</h3>"+"</div>"+"</div>";
                    $(".slide_one").append(friendDiv);
                    var friendHP = "<img id=\"photo_" + userNo + "\" src=\"${pageContext.request.contextPath}/img/headPhoto/" + result.userHP + "\" class=\"chat-user-photo\" alt=\"" + result.userHP + "\">";
                    $("#photo_"+result.userName).append(friendHP);
                    chooseChat(userNo);
                    document.getElementById(userNo).style.background = "#3A3F45";
                }
            }
        })
    }

    //从联系人列表选择聊天
    function chooseToChat(e) {
        chooseChat(e.id);
        document.getElementById(e.id).style.background = "#3A3F45";
    }

    //选择聊天用户
    function chooseChat(userNo) {
        console.log("chooseChat:" + userNo);
        $("#chatArea").show();
        var chattingUser = sessionStorage.getItem("chatting-userNo");
        if(chattingUser != null) {
            //早已选择了聊天对象
            if(chattingUser != userNo) {
                //更改聊天对象，当前聊天内容区隐藏
                if($(chattingUser) != null) {
                    document.getElementById(chattingUser).style.background = "#2e3238";
                }
                $("#" + chattingUser + "_content").hide();
                //选择新的聊天对象
                sessionStorage.setItem("chatting-userNo", userNo);
                //加入新聊天内容区
                $("#chatWithName").text($("#" + userNo + "_userName").val());
                if($("#" + userNo + "_content") !=  null) {
                    //所选聊天取已存在
                    $("#" + userNo + "_content").show();
                } else {
                    //追加聊天内容区
                    var chat_content = "<div class='box_mainwrap'"+"id="+userNo+'_content'+">"+"<div class='box_main'"+ "id=" + userNo + '_content_box'+">"+"</div>"+"</div>";
                    $(".chat_content").append(chat_content);
                }
            }
        } else {
            //第一次选择聊天对象
            sessionStorage.setItem("chatting-userNo", userNo);
            $("#chatWithName").text($("#" + userNo + "_userName").val());
            //追加聊天内容区
            var chat_content = "<div class='box_mainwrap'"+"id="+userNo+'_content'+">"+"<div class='box_main'"+ "id=" + userNo + '_content_box'+">"+"</div>"+"</div>";
            $(".chat_content").append(chat_content);
        }
    }

    /**************聊天内容发送************************/
    //发送按钮按enter键发送
    $(".box_ft").keydown(function(e){
        if (e.ctrlKey && e.which == 13 || e.which == 10) {
            $(".btn_send").trigger("click");
        }
    });
    $(".btn_send").click(function(){
        var $content = $("#send-frame"); //发送内容的页面元素对象
        if ($content.val() != "") {
            if(send($content.val())) {
                $(".box_main").scrollTop($(".box_main").height());
                addISayToBox($content.val());
            }
        }
        else{
            // alert("发送内容不能为空!");
            $content.focus();
            return false;
        }
    });

    //将自己发送内容填充至聊天区
    function addISayToBox(content) {
        var Message = '<div class="other">'+
            '<div class="clearfix">'+
            '<div class="m-one">'+
            '<div class="other-body">'+
            '<p class="m-time">'+'<span>' + currentTime() + '</span>'+'</p>'+
            '<span class="other-avator">'+
            '<img src=\"${pageContext.request.contextPath}/img/headPhoto/${userPicture}\" class=\"chat-user-photo\">' +
            "</span>"+
            '<div class="content">'+
            '<div class="other-bubble">'+
            '<div class="bubble_wrap">'+
            '<div class="m_meg">'+
            '<span class="meg">' + strFilter(content) + '</span>'+
            '</div>'+
            '</div>'+
            '</div>'+
            '</div>'+
            '</div>'+
            '</div>'+
            '</div>'+
            '</div>';
        var chatting_content_box = '#'+ sessionStorage.getItem("chatting-userNo") + "_content_box";
        $(chatting_content_box).append(Message);
        $("#send-frame").val('');
        $(chatting_content_box).scrollTop( $(chatting_content_box)[0].scrollHeight );
    }

    //将接受到他人的消息填充至聊天区
    function addOtherSayToBox(content, userNo, userPic) {
        var Message = '<div class="other">'+
            '<div class="clearfix">'+
            '<div class="m-one">'+
            '<div class="msg-from-box">'+
            '<p class="m-time">'+'<span>' + currentTime() + '</span>'+'</p>'+
            '<span class="msg-from-photo">'+
            '<img src=\"${pageContext.request.contextPath}/img/headPhoto/' + userPic +  '\" class=\"chat-user-photo\">' +
            "</span>"+
            '<div class="content">'+
            '<div class="other-bubble">'+
            '<div class="bubble_wrap">'+
            '<div class="m_meg">'+
            '<span class="meg">' + strFilter(content) + '</span>'+
            '</div>'+
            '</div>'+
            '</div>'+
            '</div>'+
            '</div>'+
            '</div>'+
            '</div>'+
            '</div>';
        var chatting_content_box = '#'+ sessionStorage.getItem("chatting-userNo") + "_content_box";
        $(chatting_content_box).append(Message);
        $("#send-frame").val('');
        $(chatting_content_box).scrollTop( $(chatting_content_box)[0].scrollHeight );
    }

    /************************过滤消息******************/
    function strFilter(str){
        // str = str.replace(/<\/?(?!img\b)[a-z]+[^>]*>/ig,'');
        str = str.replace(/<\/?(?!img\b)[a-z\d]+[^>]*>/ig, function ($0) { return $0.replace(/</g, '&lt;').replace(/>/g, '&gt;') });
        return str;
    }
    //获取当前时间
    function currentTime(){
        var str = '';
        var d = new Date();
        var sperator1 = "-";
        var sperator2 = ":";
        var month = d.getMonth()+1;
        var strd = d.getDate();
        var strH = d.getHours();
        var strM = d.getMinutes();
        var strS = d.getSeconds();
        if (month >= 1 && month <= 9) {
            month = '0' + month;
        }
        if (strd >=0 && strd <=9) {
            strd = '0' + strd;
        }
        if (strH >=0 && strH <=9) {
            strH = '0' + strH;
        }
        if (strM >=0 && strM <=9) {
            strM = '0' + strM;
        }
        if (strS >=0 && strS <=9) {
            strS = '0' + strS;
        }
        str = d.getFullYear() + sperator1 + month + sperator1 +strd + " " +strH
            + sperator2 + strM+sperator2+strS;
        return str;
    }
</script>

<%--导入脚部--%>
<%@include file="/WEB-INF/jsp/foot.jsp" %>