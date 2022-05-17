package com.csh.pojo;

public class ShowPic {

    private int picId;
    private String picName;
    private String picShow;
    private String picTop;
    private String picLink;

    @Override
    public String toString() {
        return "ShowPic{" +
                "picId=" + picId +
                ", picName='" + picName + '\'' +
                ", picShow='" + picShow + '\'' +
                ", picTop='" + picTop + '\'' +
                ", picLink='" + picLink + '\'' +
                '}';
    }

    public int getPicId() {
        return picId;
    }

    public void setPicId(int picId) {
        this.picId = picId;
    }

    public String getPicName() {
        return picName;
    }

    public void setPicName(String picName) {
        this.picName = picName;
    }

    public String getPicShow() {
        return picShow;
    }

    public void setPicShow(String picShow) {
        this.picShow = picShow;
    }

    public String getPicTop() {
        return picTop;
    }

    public void setPicTop(String picTop) {
        this.picTop = picTop;
    }

    public String getPicLink() {
        return picLink;
    }

    public void setPicLink(String picLink) {
        this.picLink = picLink;
    }
}
