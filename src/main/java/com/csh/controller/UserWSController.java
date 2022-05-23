package com.csh.controller;

import com.csh.service.WSMessageService;
import com.csh.util.Constants;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@Controller
public class UserWSController {

    @Autowired
    private WSMessageService wsMessageService;

    /**
     * 发送消息测试
     * @param userNo
     * @param message
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "testMs", produces = { "text/html;charset=utf-8" })
    public String testMS(String userNo, String message) {
        System.out.println("收到消息：" + message + "发送给：" + userNo);
        if(wsMessageService.sendToAllTerminal(userNo, message)) {
            return "发送成功";
        } else {
            return "发送失败";
        }
    }

    /**
     * 前往消息中心点击请求
     * @param session
     * @return
     */
    @RequestMapping(value = "messageCenter")
    public String toMessageCenter(HttpSession session) {
        String userNo = (String) session.getAttribute(Constants.USER_NO);
        return "messageCenter";
    }

    /**
     * 添加会话记录
     * @param chatTo 将与会话的用户
     * @param session 请求添加会话的用户
     * @return status：添加状态（200添加成功，500添加失败）
     */
    @ResponseBody
    @RequestMapping(value = "addChatToUser", produces = { "text/html;charset=utf-8" })
    public String addChatToUser(String chatTo, HttpSession session) {
        String userNo = (String) session.getAttribute(Constants.USER_NO);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("status", 500);
        if(userNo != null && chatTo != null) {
            if(wsMessageService.addChat(userNo, chatTo)) {
                jsonObject.put("status", 200);
            }
        }
        return jsonObject.toString();
    }

    /**
     * 获得登陆用户的会话列表
     * @param session
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getChatList", produces = { "text/html;charset=utf-8" })
    public String getChatList(HttpSession session) {
        String userNo = (String) session.getAttribute(Constants.USER_NO);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("chatList", wsMessageService.getChatList(userNo));
        return jsonObject.toString();
    }

    /**
     * 登录用户请求修改与某个用户的聊天记录为已读
     * @param chatTo
     * @param session
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "readChatLog", produces = { "text/html;charset=utf-8" })
    public String readChatLog(String chatTo, HttpSession session) {
        String userNo = (String) session.getAttribute(Constants.USER_NO);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("status", 500);
        if(userNo != null && chatTo != null) {
            if(wsMessageService.updateReadStatus(userNo, chatTo)) {
                jsonObject.put("status", 200);
            }
        }
        return jsonObject.toString();
    }

    /**
     * 获得登录用户与该聊天用户的所有聊天记录
     * @param session
     * @param chatTo
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getChatLog", produces = { "text/html;charset=utf-8" })
    public String getChatLog(HttpSession session, String chatTo) {
        String userNo = (String) session.getAttribute(Constants.USER_NO);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("status", 500);
        int chatId = -1;
        if(userNo != null && chatTo != null && !userNo.equals(chatTo)) {
            wsMessageService.getChatId(chatTo, userNo);
        }
        if(chatId > 0) {
            jsonObject.put("chatLog", wsMessageService.getChatHistory(userNo, chatTo));
            jsonObject.put("status", 200);
        }
        return jsonObject.toString();
    }

    /**
     * 获得登录用户与该聊天用户的聊天记录的分页
     * @param session
     * @param chatTo
     * @param start 查询分页的开始位置
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getChatLogPage", produces = { "text/html;charset=utf-8" })
    public String getChatLogPage(HttpSession session, String chatTo, int start) {
        String userNo = (String) session.getAttribute(Constants.USER_NO);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("status", 500);
        int chatId = -1;
        if(userNo != null && chatTo != null && !userNo.equals(chatTo)) {
            chatId = wsMessageService.getChatId(chatTo, userNo);
        }
        if(chatId > 0) {
            jsonObject.put("chatLog", wsMessageService.getChatHistoryByChatIdInPaging(chatId, start));
            jsonObject.put("status", 200);
        }
        return jsonObject.toString();
    }

}
