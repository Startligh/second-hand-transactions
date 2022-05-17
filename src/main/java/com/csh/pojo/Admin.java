package com.csh.pojo;

public class Admin {
    //账号、密码、姓名、性别、管理员头像
    private String ano;
    private String apassword;
    private String aname;
    private String asex;
    private String apricture;

    @Override
    public String toString() {
        return "Admin{" +
                "ano='" + ano + '\'' +
                ", apassword='" + apassword + '\'' +
                ", aname='" + aname + '\'' +
                ", asex='" + asex + '\'' +
                ", apricture='" + apricture + '\'' +
                '}';
    }

    public String getAno() {
        return ano;
    }

    public void setAno(String ano) {
        this.ano = ano;
    }

    public String getApassword() {
        return apassword;
    }

    public void setApassword(String apassword) {
        this.apassword = apassword;
    }

    public String getAname() {
        return aname;
    }

    public void setAname(String aname) {
        this.aname = aname;
    }

    public String getAsex() {
        return asex;
    }

    public void setAsex(String asex) {
        this.asex = asex;
    }

    public String getApricture() {
        return apricture;
    }

    public void setApricture(String apricture) {
        this.apricture = apricture;
    }
}
