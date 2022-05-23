package com.csh.pojo;

import java.util.List;

public class ChatItem {

    private int chatId;
    private User userA;
    private User userB;
    private int unReadCount;//未读消息统计

    public int getChatId() {
        return chatId;
    }

    public void setChatId(int chatId) {
        this.chatId = chatId;
    }

    public User getUserA() {
        return userA;
    }

    public void setUserA(User userA) {
        this.userA = userA;
    }

    public User getUserB() {
        return userB;
    }

    public void setUserB(User userB) {
        this.userB = userB;
    }

    public int getUnReadCount() {
        return unReadCount;
    }

    public void setUnReadCount(int unReadCount) {
        this.unReadCount = unReadCount;
    }

    @Override
    public String toString() {
        return "ChatItem{" +
                "chatId=" + chatId +
                ", userA=" + userA +
                ", userB=" + userB +
                ", unReadCount=" + unReadCount +
                '}';
    }
}
