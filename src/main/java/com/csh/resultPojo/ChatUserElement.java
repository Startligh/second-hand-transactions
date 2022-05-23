package com.csh.resultPojo;

import com.csh.pojo.User;

public class ChatUserElement {

    private int chatId;
    //获得用户的对话人信息，包括{id、name、head_photo、unReadCount}
    private String userId;
    private String userName;
    private String userPhoto;
    private int unReadCount;

    public ChatUserElement() {
    }

    public ChatUserElement(int chatId, int unReadCount) {
        this.chatId = chatId;
        this.unReadCount = unReadCount;
    }

    public ChatUserElement(int chatId, int unReadCount, User user) {
        this(chatId, unReadCount);
        this.userId = user.getUno();
        this.userName = user.getUname();
        this.userPhoto = user.getUpricture();
    }

    public int getChatId() {
        return chatId;
    }

    public void setChatId(int chatId) {
        this.chatId = chatId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserPhoto() {
        return userPhoto;
    }

    public void setUserPhoto(String userPhoto) {
        this.userPhoto = userPhoto;
    }

    public int getUnReadCount() {
        return unReadCount;
    }

    public void setUnReadCount(int unReadCount) {
        this.unReadCount = unReadCount;
    }

    @Override
    public String toString() {
        return "ChatUserElement{" +
                "chatId=" + chatId +
                ", userId='" + userId + '\'' +
                ", userName='" + userName + '\'' +
                ", userPhoto='" + userPhoto + '\'' +
                ", unReadCount=" + unReadCount +
                '}';
    }
}
