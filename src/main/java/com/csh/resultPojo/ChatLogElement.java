package com.csh.resultPojo;

import com.csh.pojo.User;


public class ChatLogElement {

    private int logId;
    private String content; //内容
    private String sendUserId; //发送消息用户
    private String sendTime; //发送消息时间
    private String recipientId; //接收消息用户
    private int chatId; //会话id

    public ChatLogElement() {
    }

    public ChatLogElement(String content, String sendUserId, String recipientId, int chatId) {
        this.content = content;
        this.sendUserId = sendUserId;
        this.recipientId = recipientId;
        this.chatId = chatId;
    }

    public ChatLogElement(int logId, String content, String sendUserId, String sendTime, String recipientId, int chatId) {
        this(content, sendUserId, recipientId, chatId);
        this.logId = logId;
        this.sendTime = sendTime;
    }

    public int getLogId() {
        return logId;
    }

    public void setLogId(int logId) {
        this.logId = logId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getSendUserId() {
        return sendUserId;
    }

    public void setSendUserId(String sendUserId) {
        this.sendUserId = sendUserId;
    }

    public String getSendTime() {
        return sendTime;
    }

    public void setSendTime(String sendTime) {
        this.sendTime = sendTime;
    }

    public String getRecipientId() {
        return recipientId;
    }

    public void setRecipientId(String recipientId) {
        this.recipientId = recipientId;
    }

    public int getChatId() {
        return chatId;
    }

    public void setChatId(int chatId) {
        this.chatId = chatId;
    }

    @Override
    public String toString() {
        return "ChatLogElement{" +
                "logId=" + logId +
                ", content='" + content + '\'' +
                ", sendUserId=" + sendUserId +
                ", sendTime='" + sendTime + '\'' +
                ", recipientId=" + recipientId +
                ", chatId=" + chatId +
                '}';
    }
}
