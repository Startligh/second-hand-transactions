<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--导入头部--%>
<%@include file="/WEB-INF/jsp/head.jsp"%>

<!-- 消息中心内容主体区域 -->
<div  class="layui-container" style="padding: 75px">
    <div class="Main">
        <div id="Mainchat">
            <!-- 联系人界面 -->
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
                    <div class="slide_one"><div id="topOfSlide"></div></div>
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
                        <div class="checkchat" onclick="getMoreChatLog()"><span>点击获得更多聊天记录</span></div>
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
            <%--消息中心初始化--%>
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
    /**************创建websocket对象************************/
    var websocket;
    var connFlag = false;
    window.onload = myOnload();
    function myOnload() {
        getSocket();
        //加载聊天对象
        $(".slide-online").show();//打开联系人列表
        var chatToAhead = sessionStorage.getItem("chatWith");
        if(chatToAhead != null) {
            //进入消息中心前，预选定了聊天对象则：在联系人列表中添加该用户，选中该聊天，打开聊天框
            // （因为函数同一时间执行故元素在函数执行完才实际添加到页面，此时无法通过函数操作不存在的元素）
            chatToAheadUser(sessionStorage.getItem("chatWith"));
            sessionStorage.removeItem("chatWith");
        }
        showChatUserList(chatToAhead);//加载联系人列表
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
            console.log(evnt.data);//evnt.data: "{\"sendFrom\":\"xx\",\"content\":\"xx\"}"
            var data = JSON.parse(evnt.data);
            if(data.sendFrom == ${userNo}) {
                //自己发送回传
                if(data.status == 200) {
                    console.log("发送成功");
                }
                setChatLogStart(sessionStorage.getItem("chatting-userNo"), 1);
            } else if(data.sendFrom == sessionStorage.getItem("chatting-userNo")) {
                //当前对话框的用户发来消息
                addOtherSayToBox(data.content, data.sendFrom, data.sendTime, false);//将消息添加至聊天框
            } else  {//不是当前对话框的用户发来的消息
                if(document.getElementById(data.sendFrom) == null) {//联系人列表中还没有该用户
                    addToChatListByUserNo(data.sendFrom);//添加至联系人列表
                }
                if(document.getElementById(data.sendFrom + "_content") == null) {//该会话的会话框还没创建
                    addChatBox(data.sendFrom);//创建会话框填充消息
                    $("#" + data.sendFrom + "_content").hide();//隐藏聊天框
                }
                if(data.sendFrom != sessionStorage.getItem("chatting-userNo")) {//当前会话没被选择
                    $("#newMsg_" + data.sendFrom).show();//消息提示红点的打开
                }
                addOtherSayToBox(data.content, data.sendFrom, data.sendTime, false);//将消息添加至聊天框
                setChatLogStart(data.sendFrom, 1);
                //聊天内容区滑到最下面
                var chatting_content_box = '#'+ data.sendFrom + "_content_box";
                $(chatting_content_box).scrollTop( $(chatting_content_box)[0].scrollHeight );
            }
            topChatUser(data.sendFrom);//置顶新发送消息的用户
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
    /**************发送消息给服务端************************/
    function send(content) {
        if(websocket != null) {
            console.log("内容：" + content);
            //置顶该联系人
            topChatUser(sessionStorage.getItem("chatting-userNo"));
            //从JS对象转换为JSON字符串
            var message = JSON.stringify({chatToUserNo: sessionStorage.getItem("chatting-userNo"), content: content});
            websocket.send(message);
            return true;
        } else {
            alert('未与服务器链接.');
            return false;
        }
    }

    document.getElementById("outLogin").onclick = outLogin();
    function outLogin() {//退出登录前检查是否有socket连接
        if(!connFlag && websocket != null) {
            connFlag = false;
            websocket.close();
            websocket = null;
        }
    }

    window.onbeforeunload = function () {
        console.log("页面关闭");
        setChatLogHadRead(sessionStorage.getItem("chatting-userNo"));//发送将消息修改为已读的请求
        sessionStorage.removeItem("chatting-userNo");
        if(!connFlag && websocket != null) {
            connFlag = false;
            websocket.close();
            websocket = null;
        }
    };

    /**************展示当前用户的聊天列表************************/
    function showChatUserList(chatToAhead) {
        $.ajax({
            url : "${pageContext.request.contextPath}/getChatList",
            method:'post',
            contentType:'application/json',
            dataType:"json",
            success : function(result) {
                var chatList = result.chatList;
                for(var i = 0; i < chatList.length; i++){
                    var chat = chatList[i];
                    if(chat.userId != chatToAhead) {
                        addToChatList(chat.userId, chat.userName, chat.userPhoto);
                        if(chat.unReadCount > 0) {
                            $("#newMsg_" + chat.userId).show();//消息提示红点的打开
                        }
                    }
                }
            }
        });
    }
    /**************给定具体对话人数据，添加至联系人列表************************/
    function addToChatList(userNo, userName, userHP) {
        var friendDiv  = "<div class='menber' id="+ userNo +" onclick=chooseToChat(this)>"+"<div class='men-pirture'>" + "<span id='photo_" + userName + "' class='m-pirture'>"+'</span>'+ "<span class='icon wechat_reddot' id = newMsg_" + userNo +">" + "</div>"+"<div class='chat-item'>"+"<h3 class='s-nickname'>"+"<span class='s-nick-text' id='" + userNo + "_userName'>"+ userName +"</span>"+"</h3>"+"</div>"+"</div>";
        $(".slide_one").append(friendDiv);
        var friendHP = "<img id=\"photo_" + userNo + "\" src=\"${pageContext.request.contextPath}/img/headPhoto/" + userHP + "\" class=\"chat-user-photo\" alt=\"" + userHP + "\">";
        $("#photo_" + userName).append(friendHP);
    }
    /**************给定具体对话人id，添加至联系人列表************************/
    function addToChatListByUserNo(userNo) {
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
                    addToChatList(userNo, result.userName, result.userHP);
                }
            }
        })
    }

    /**************和提前选定的联系人聊天************************/
    function chatToAheadUser(userNo) {
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
                    var friendDiv  = "<div class='menber' id="+ userNo +" onclick=chooseToChat(this)>"+"<div class='men-pirture'>"+"<span id='photo_" + result.userName + "' class='m-pirture'>"+'</span>' + "<span class='icon wechat_reddot' id = newMsg_" + userNo +">" + "</div>"+"<div class='chat-item'>"+"<h3 class='s-nickname'>"+"<span class='s-nick-text' id='" + userNo + "_userName'>"+ result.userName +"</span>"+"</h3>"+"</div>"+"</div>";
                    $(".slide_one").append(friendDiv);
                    var friendHP = "<img id=\"photo_" + userNo + "\" src=\"${pageContext.request.contextPath}/img/headPhoto/" + result.userHP + "\" class=\"chat-user-photo\" alt=\"" + result.userHP + "\">";
                    $("#photo_"+result.userName).append(friendHP);
                    chooseChat(userNo);
                    document.getElementById(userNo).style.background = "#3A3F45";
                }
            }
        })
    }

    /**************从联系人列表中选择聊天************************/
    function chooseToChat(e) {
        chooseChat(e.id);
        $("#send-frame").val('');
        document.getElementById(e.id).style.background = "#3A3F45";
    }

    /**************选择聊天用户************************/
    function chooseChat(userNo) {
        if(document.getElementById("newMsg_" + userNo).style.display == 'inline') {
            $("#newMsg_" + userNo).hide();//消息提示红点的关闭
            setChatLogHadRead(userNo);//发送将消息修改为已读的请求
        }
        console.log("chooseChat:" + userNo);
        $("#chatArea").show();
        var chattingUser = sessionStorage.getItem("chatting-userNo");
        if(chattingUser != null) {
            //早已选择了聊天对象
            if(chattingUser != userNo) {
                //更改聊天对象，当前聊天内容区隐藏，同时将会话记录改为已读
                setChatLogHadRead(chattingUser);//发送将消息修改为已读的请求
                if($("#" + chattingUser) != null) {
                    document.getElementById(chattingUser).style.background = "#2e3238";
                    $("#" + chattingUser + "_content").hide();
                }
                //选择新的聊天对象
                sessionStorage.setItem("chatting-userNo", userNo);
                //加入新聊天内容区
                $("#chatWithName").text($("#" + userNo + "_userName").text());
                if(document.getElementById(userNo + "_content") != null) {
                    //所选聊天区已存在
                    $("#" + userNo + "_content").show();
                } else {
                    //不然，追加聊天内容区
                    addChatBox(userNo, true);
                }
            }
        } else {
            //第一次选择聊天对象
            sessionStorage.setItem("chatting-userNo", userNo);
            $("#chatWithName").text($("#" + userNo + "_userName").text());
            //追加聊天内容区
            addChatBox(userNo, true);
        }
        $("#send-frame").focus();
    }

    /*****************添加聊天框*********************/
    function addChatBox(userNo, chatLogFlag) {
        var chat_content = "<div class='box_mainwrap'"+"id="+userNo+'_content'+">"+"<div class='box_main'"+ "id=" + userNo + '_content_box'+">" + "<div id=" + userNo + '_content_box_top' + " style=\"display: none;\">0</div>" + "</div>"+"</div>";
        $(".chat_content").append(chat_content);
        if(chatLogFlag == true) {
            getChatLog(userNo);//加载聊天历史记录
            var chatting_content_box = '#'+ userNo + "_content_box";
            setTimeout(function() {
                $(chatting_content_box).scrollTop( $(chatting_content_box)[0].scrollHeight );
            }, 100);
        }
    }

    /****************置顶某联系人**********************/
    function topChatUser(chatToUserNo) {
        var topOfSlide = $("#topOfSlide");
        var userSlide = $("#" + chatToUserNo);
        topOfSlide.after(userSlide);
    }

    /**************将登录用户与会话用户的聊天记录设为已读************************/
    function setChatLogHadRead(userNo) {
        $.ajax({
            url : "${pageContext.request.contextPath}/readChatLog",
            data:{chatTo:userNo},
            method:'post',
            contentType:'application/json',
            dataType:"json",
            success : function(result) {
                if(result.status == 200) {
                    console.log("已读用户：" + userNo + "发送的消息");
                    return true;
                } else {
                    return false;
                }
            }
        });
    }

    /**************设置历史记录的查询起始位置************************/
    function setChatLogStart(userNo, addValue) {
        console.log(typeof (addValue));
        var boxTop = "#" + userNo + "_content_box_top";
        var start = ($(boxTop).text());
        console.log((Number($(boxTop).text()) + Number(addValue)));
        $(boxTop).text((Number($(boxTop).text()) + Number(addValue)));
    }

    /**************点击加载历史记录************************/
    function getMoreChatLog() {
        getChatLog(sessionStorage.getItem("chatting-userNo"));
    }
    function getChatLog(chattingUser) {
        var start = $("#" + chattingUser + "_content_box_top").text();
        $.ajax({
            url : "${pageContext.request.contextPath}/getChatLogPage",
            data:{chatTo:chattingUser,start:start},
            method:'post',
            contentType:'application/json',
            dataType:"json",
            success : function(result) {
                console.log(result.chatLog);
                if(result.status == 200) {
                    console.log("得到与用户：" + chattingUser + "的聊天记录" + result.chatLog.length + "条");
                    var list = result.chatLog;
                    for(var i = 0; i < list.length; i++) {
                        var data = list[i];
                        if(data.sendUserId == chattingUser) {//发送用户是聊天对方
                            addOtherSayToBox(data.content, data.sendUserId, data.sendTime, true);
                        } else {//发送方是自己
                            addMySayToBox(data.content, true, data.sendTime);
                        }
                    }
                    setChatLogStart(chattingUser, list.length);
                    return true;
                } else if(result.status == 500) {
                    return false;
                }
            }
        });
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
                addMySayToBox($content.val(), false);
            }
        }
        else{
            // alert("发送内容不能为空!");
            $content.focus();
            return false;
        }
    });

    /**************将自己发送内容填充至聊天区************************/
    function addMySayToBox(content, logFlag, sendTime) {
        if(logFlag == false) {
            sendTime = currentTime();
        }
        var Message = '<div class="other">'+
            '<div class="clearfix">'+
            '<div class="m-one">'+
            '<div class="other-body">'+
            '<p class="m-time">'+'<span>' + sendTime + '</span>'+'</p>'+
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
        if(logFlag) {
            var chatting_content_box_top = '#' + sessionStorage.getItem("chatting-userNo") + '_content_box_top';
            $(chatting_content_box_top).after(Message);
        } else {
            var chatting_content_box = '#'+ sessionStorage.getItem("chatting-userNo") + "_content_box";
            $(chatting_content_box).append(Message);
            $(chatting_content_box).scrollTop( $(chatting_content_box)[0].scrollHeight );
        }
        $("#send-frame").val('');
    }

    /**************将接受到他人的消息填充至聊天区************************/
    function addOtherSayToBox(content, userNo, sendTime, logFlag) {
        var userPic = document.getElementById("photo_" + userNo).alt;
        var Message = '<div class="other">'+
            '<div class="clearfix">'+
            '<div class="m-one">'+
            '<div class="msg-from-box">'+
            '<p class="m-time">'+'<span>' + sendTime + '</span>'+'</p>'+
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
        if(logFlag) {
            var chatting_content_box_top = '#' + sessionStorage.getItem("chatting-userNo") + '_content_box_top';
            $(chatting_content_box_top).after(Message);
        } else {
            var chatting_content_box = '#' + userNo + "_content_box";
            $(chatting_content_box).append(Message);
            $(chatting_content_box).scrollTop($(chatting_content_box)[0].scrollHeight);
        }
        $("#send-frame").val('');
    }

    /************************过滤消息******************/
    function strFilter(str){
        // str = str.replace(/<\/?(?!img\b)[a-z]+[^>]*>/ig,'');
        str = str.replace(/<\/?(?!img\b)[a-z\d]+[^>]*>/ig, function ($0) { return $0.replace(/</g, '&lt;').replace(/>/g, '&gt;') });
        return str;
    }
    /**************获取当前时间************************/
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