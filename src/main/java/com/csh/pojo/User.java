package com.csh.pojo;

public class User {
    //账号、密码、姓名、性别、电话、地址、余额、用户头像、类型（黑名单）
    private String uno;
    private String upassword;
    private String uname;
    private String usex;
    private String utel;
    private String uaddress;
    private float ubalance;
    private String upricture;
    private String utype;

    public String getUtype() {
        return utype;
    }

    public void setUtype(String utype) {
        this.utype = utype;
    }

    public String getUno() {
        return uno;
    }

    public void setUno(String uno) {
        this.uno = uno;
    }

    public String getUpassword() {
        return upassword;
    }

    public void setUpassword(String upassword) {
        this.upassword = upassword;
    }

    public String getUname() {
        return uname;
    }

    public void setUname(String uname) {
        this.uname = uname;
    }

    public String getUsex() {
        return usex;
    }

    public void setUsex(String usex) {
        this.usex = usex;
    }

    public String getUtel() {
        return utel;
    }

    public void setUtel(String utel) {
        this.utel = utel;
    }

    public String getUaddress() {
        return uaddress;
    }

    public void setUaddress(String uaddress) {
        this.uaddress = uaddress;
    }

    public float getUbalance() {
        return ubalance;
    }

    public void setUbalance(float ubalance) {
        this.ubalance = ubalance;
    }

    public String getUpricture() {
        return upricture;
    }

    public void setUpricture(String upricture) {
        this.upricture = upricture;
    }

    @Override
    public String toString() {
        return "User{" +
                "uno='" + uno + '\'' +
                ", upassword='" + upassword + '\'' +
                ", uname='" + uname + '\'' +
                ", usex='" + usex + '\'' +
                ", utel='" + utel + '\'' +
                ", uaddress='" + uaddress + '\'' +
                ", ubalance=" + ubalance +
                ", upricture='" + upricture + '\'' +
                ", utype='" + utype + '\'' +
                '}';
    }
}
