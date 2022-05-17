package com.csh.controller;

import com.csh.service.WSMessageService;
import com.csh.util.Constants;
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
        //加载历史聊天用户列表
        return "messageCenter";
    }

}
