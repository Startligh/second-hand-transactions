package com.csh.service;

import com.csh.ws.WebSocketPoint;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class WSMessageService {

    /**
     * 发送消息service
     * @param userId
     * @param message
     * @return
     */
    public boolean sendToAllTerminal(String userId, String message) {
        return WebSocketPoint.sendMessage(userId, message);
    }

}
