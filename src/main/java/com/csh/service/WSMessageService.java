package com.csh.service;

import com.csh.mapper.ChatMapper;
import com.csh.mapper.UserMapper;
import com.csh.pojo.ChatHistory;
import com.csh.pojo.ChatItem;
import com.csh.pojo.User;
import com.csh.resultPojo.ChatUserElement;
import com.csh.resultPojo.ChatLogElement;
import com.csh.ws.WebSocketPoint;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.LinkedList;
import java.util.List;

@Service
@Transactional
public class WSMessageService {

    @Autowired
    ChatMapper chatMapper;

    @Autowired
    UserMapper userMapper;

    /**
     * 发送消息service
     * @param userId
     * @param message
     * @return
     */
    public boolean sendToAllTerminal(String userId, String message) {
        return WebSocketPoint.sendMessage(userId, message);
    }

    /**
     * 获得user的会话列表
     * @param userId
     * @return
     */
    public List<ChatUserElement> getChatList(String userId) {
        List<ChatUserElement> chatUserList = new LinkedList<>();
        if(userId != null) {
            List<ChatItem> chatListByUserId = chatMapper.getChatListByUserId(userId);
            for(ChatItem item : chatListByUserId) {
                User chatToUser;
                if(item.getUserA().getUno().equals(userId)) {
                    chatToUser = item.getUserB();
                } else {
                    chatToUser = item.getUserA();
                }
                chatUserList.add(new ChatUserElement(item.getChatId(), item.getUnReadCount(), chatToUser));
            }
        }
        return chatUserList;
    }

    /**
     * 查询两个用户的会话id
     * @param userId
     * @param otherUserId
     * @return chatId:会话id，
     *          大于 0 ，存在可用的
     *          0：这两个用户之间没有会话，可以创建
     *          -1：用户id为空
     */
    public int getChatId(String userId, String otherUserId) {
        if(userId != null && otherUserId != null) {
            Integer chatId =  chatMapper.getChatIdByBothUser(userId, otherUserId);
            if(chatId != null) {//查出不存在即为空
                return chatId;
            } else {
                return 0;
            }
        } else {
            return -1;
        }
    }

    /**
     * 用户user添加和chatToUser的会话记录
     * @param userId
     * @param chatToUserId
     * @return
     */
    public boolean addChat(String userId, String chatToUserId) {
        //id互不相同（不允许自聊）、两个用户还没有会话、两个用户在数据库真实存在
        if(userId != null && chatToUserId != null
                && !userId.equals(chatToUserId)
                && getChatId(userId, chatToUserId) == 0
                && userMapper.selectUserByUno(userId) != null
                && userMapper.selectUserByUno(chatToUserId) != null) {
            return chatMapper.insertChatting(userId, chatToUserId) > 0;
        }
        return false;
    }

    /**
     * 插入一条聊天记录
     * @param chatLogElement：帐号存在、内容不空
     * @return
     */
    public boolean insertChatLog(ChatLogElement chatLogElement) {
        String sendUserUno = chatLogElement.getSendUserId();
        String recipientUno = chatLogElement.getRecipientId();
        if(sendUserUno != null && recipientUno != null
                && userMapper.selectUserByUno(sendUserUno) != null
                && userMapper.selectUserByUno(recipientUno) != null
                && chatLogElement.getContent() != null) {
            //创建插入对象
            ChatHistory chatHistory = new ChatHistory(
                    chatLogElement.getContent(),
                    new User(sendUserUno),
                    new User(recipientUno),
                    chatMapper.getChatIdByBothUser(sendUserUno, recipientUno));
            chatMapper.insertChatLog(chatHistory);
            if(chatHistory.getLogId() > 0) {
                return chatMapper.updateLastChatTime(chatHistory.getChatId(), chatHistory.getLogId()) > 0;
            }
        }
        return false;
    }

    /**
     * 修改某会话下的聊天记录为已读
     * @param chatId
     * @return
     */
    public boolean updateReadStatus(int chatId) {
        return chatMapper.readChatHistory(chatId) > 0;
    }

    /**
     * 修改用户会话的聊天记录为已读状态
     * @param userNo
     * @param chatToUserNo
     * @return
     */
    public boolean updateReadStatus(String userNo, String chatToUserNo) {
        int chatId = this.getChatId(userNo, chatToUserNo);
        if(chatId > 0) {
            return this.updateReadStatus(chatId);
        }
        return false;
    }

    /**
     * 获得对话记录
     * @param userNo
     * @param chatToUserNo
     * @return
     */
    public List<ChatLogElement> getChatHistory(String userNo, String chatToUserNo) {
        return this.getChatHistoryByChatId(this.getChatId(userNo, chatToUserNo));
    }

    /**
     * 从chatHistory列表中得到ChatLogElement的列表
     * @param chatHistories
     * @return
     */
    private List<ChatLogElement> getChatHistoryList(List<ChatHistory> chatHistories) {
        List<ChatLogElement> chatLogList = new LinkedList<>();
        for(ChatHistory chatHistory : chatHistories) {
            chatLogList.add(
                    new ChatLogElement(
                            chatHistory.getLogId(),
                            chatHistory.getContent(),
                            chatHistory.getSendUser().getUno(),
                            chatHistory.getSendTime().toString(),
                            chatHistory.getRecipient().getUno(),
                            chatHistory.getChatId())
            );
        }
        return chatLogList;
    }

    /**
     * 获得某会话的聊天历史记录列表
     * @param chatId
     * @return
     */
    public List<ChatLogElement> getChatHistoryByChatId(int chatId) {
        List<ChatHistory> chatHistoryListByChatId = chatMapper.getChatHistoryListByChatId(chatId);
        return getChatHistoryList(chatHistoryListByChatId);
    }

    /**
     * 获得某会话的聊天历史记录的分页列表
     * @param chatId
     * @param start 分页开始位置
     * @return
     */
    public List<ChatLogElement> getChatHistoryByChatIdInPaging(int chatId, int start) {
        List<ChatHistory> chatHistories = chatMapper.getChatHistoryListByChatIdAndPaging(chatId, start);
        return getChatHistoryList(chatHistories);
    }

}
