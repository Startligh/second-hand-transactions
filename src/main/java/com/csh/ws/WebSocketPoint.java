package com.csh.ws;

import com.csh.util.Constants;

import javax.servlet.http.HttpSession;
import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

//多终端连接，连接url地址和配置项
@ServerEndpoint(value = "/webSocketPoint", configurator = GetHttpSessionConfigurator.class)
public class WebSocketPoint {

    //静态变量（线程安全），连接总数
    private static int onlineCount = 0;

    //已连接用户池，保存所有已连接用户对应的webSocketPoint对象
    private static Map<String, Set<WebSocketPoint>> userSocketMap = new HashMap<>();

    //本连接用于通信的对象
    private Session session;
    private String userNo;
    private HttpSession httpSession;

    public Session getSession() {
        return session;
    }

    public String getUserNo() {
        return userNo;
    }

    /**
     * 用户创建webSocket连接时的执行函数
     * @param
     * @param session websocket连接的session属性
     */
    @OnOpen
    public void onOpen(Session session, EndpointConfig endpointConfig) {
        System.out.println("执行onopen()方法");
        onlineCount++;
        this.session = session;
        //获取httpsession对象
        this.httpSession = (HttpSession) endpointConfig.getUserProperties().get(HttpSession.class.getName());
        this.userNo = (String) this.httpSession.getAttribute(Constants.USER_NO);
        if(userSocketMap.get(userNo) == null) {
            //第一次连接
            System.out.println("用户" + userNo + "第一次连接：" + session.getId());
            Set<WebSocketPoint> userConnSet = new HashSet<>();//用户终端连接保存池
            userConnSet.add(this);//添加连接实例
            userSocketMap.put(this.userNo, userConnSet);
        } else {
            Set<WebSocketPoint> userTerminals = userSocketMap.get(this.userNo);
            if(!userTerminals.contains(this)) {//新的终端
                System.out.println("用户" + userNo + "再其他终端连接：" + session.getId());
                userTerminals.add(this);//添加连接实例
            }
        }
        System.out.println("用户" + userNo + "登陆的终端数量为：" + userSocketMap.get(userNo).size());
        System.out.println("当前在线用户数为：" + userSocketMap.size() + "，当前连接终端个数为：" + onlineCount);
    }

    /**
     * 连接关闭时的调用函数
     */
    @OnClose
    public void onClose() {
        System.out.println("执行onClose()方法");
        this.onlineCount--;
        userSocketMap.get(this.userNo).remove(this);
        if(userSocketMap.get(this.userNo).size() == 0) {
            //用户的所有连接终端都下线了
            userSocketMap.remove(this.userNo);
        }
        if(userSocketMap.get(userNo) != null) {
            System.out.println("用户" + userNo + "登陆的终端数量为：" + userSocketMap.get(userNo).size());
        } else {
            System.out.println("用户已下线");
        }
        System.out.println("当前在线用户数为：" + userSocketMap.size() + "，当前连接终端个数为：" + onlineCount);
    }

    /**
     * 收到消息的调用函数
     * @param session 连接webSocket的session对象
     * @param message 收到的消息
     */
    @OnMessage
    public void onMessage(Session session, String message) {
        System.out.println("执行onMessage()方法");
        System.out.println("收到用户：" + this.userNo + "的消息：" + message);
        if(session == null) {
            System.out.println("session为null");
        } else {
            try {
                //message格式："chatToUser:xxx;content:xxx"
                String[] split = message.split(";");
                String chatToUserNo = split[0].split(":")[1];
                String content = split[1].split(":")[1];
                StringBuilder sb = new StringBuilder();
                if(chatToUserNo != null) {
                    sb.append("sendFrom:");
                    sb.append(this.getUserNo());
                    sb.append(";content:");
                    sb.append(content);
                    sendMessage(chatToUserNo, sb.toString());//发送给指定用户
                }
                this.getSession().getBasicRemote().sendText(sb.toString());//发送语句
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * 发生错误时的调用函数
     * @param session
     * @param error
     */
    @OnError
    public void onError(Session session, Throwable error) {
        System.out.println("执行onError()方法");
        System.out.println("用户：" + this.userNo + "连接发生错误");
        error.printStackTrace();
    }

    /**
     * 服务端给指定用户发送在线消息
     * @param userId
     * @param message 消息内容
     * @return
     */
    public static boolean sendMessage(String userId, String message) {
        System.out.println("执行sendMessage()方法");
        if(userSocketMap.containsKey(userId)) {
            System.out.println("给用户：" + userId + "发送消息：" + message);
            for(WebSocketPoint point : userSocketMap.get(userId)) {//userTerminals用户终端集合
                Session sendToSession = point.getSession();
                System.out.println("该终端连接的sessionId为：" + sendToSession.getId());
                try {
                    sendToSession.getBasicRemote().sendText(message);//发送语句
                } catch (IOException e) {
                    e.printStackTrace();
                    System.out.println("给用户：" + userId + "发送消息失败");
                    return false;
                }
            }
            return true;
        } else {
            System.out.println("用户：" + userId + "当前不在线");
            return false;
        }
    }

}
