package com.csh.pojo;

import java.sql.Timestamp;

public class ChatHistory {

    private int logId;
    private String content; //内容
    private User sendUser; //发送消息用户
    private Timestamp sendTime; //发送消息时间
    private User recipient; //接收消息用户
    private int chatId; //会话id
    private boolean read_status; //接收消息用户的阅读状态

    public ChatHistory() {
    }

    public ChatHistory(String content, User sendUser, User recipient, int chatId) {
        this.content = content;
        this.sendUser = sendUser;
        this.recipient = recipient;
        this.chatId = chatId;
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

    public User getSendUser() {
        return sendUser;
    }

    public void setSendUser(User sendUser) {
        this.sendUser = sendUser;
    }

    public Timestamp getSendTime() {
        return sendTime;
    }

    public void setSendTime(Timestamp sendTime) {
        this.sendTime = sendTime;
    }

    public User getRecipient() {
        return recipient;
    }

    public void setRecipient(User recipient) {
        this.recipient = recipient;
    }

    public int getChatId() {
        return chatId;
    }

    public void setChatId(int chatId) {
        this.chatId = chatId;
    }

    public boolean isRead_status() {
        return read_status;
    }

    public void setRead_status(boolean read_status) {
        this.read_status = read_status;
    }

    @Override
    public String toString() {
        return "ChatHistory{" +
                "logId=" + logId +
                ", content='" + content + '\'' +
                ", sendUser=" + sendUser +
                ", sendTime=" + sendTime +
                ", recipient=" + recipient +
                ", chatId=" + chatId +
                ", read_status=" + read_status +
                '}';
    }
}
