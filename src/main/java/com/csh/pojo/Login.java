package com.csh.pojo;

public class Login {
    //角色码、登录账号、登录密码
    private String rolecode;
    private String lno;
    private String lpassword;

    @Override
    public String toString() {
        return "Login{" +
                "rolecode='" + rolecode + '\'' +
                ", lno='" + lno + '\'' +
                ", lpassword='" + lpassword + '\'' +
                '}';
    }

    public String getRolecode() {
        return rolecode;
    }

    public void setRolecode(String rolecode) {
        this.rolecode = rolecode;
    }

    public String getLno() {
        return lno;
    }

    public void setLno(String lno) {
        this.lno = lno;
    }

    public String getLpassword() {
        return lpassword;
    }

    public void setLpassword(String lpassword) {
        this.lpassword = lpassword;
    }
}
