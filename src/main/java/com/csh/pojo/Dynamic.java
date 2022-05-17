package com.csh.pojo;

public class Dynamic {
    // 动态：用户账号（产生该动态的用户）、商品编号、动态类型（描述商品订单变化）、状态（1已读0未读）
    private int dno;
    private String uno;
    private String pno;
    private String dtype;
    private int readed;
    //产生该动态的用户名称
    private String uname;

    public int getDno() {
        return dno;
    }

    public String getUno() {
        return uno;
    }

    public String getPno() {
        return pno;
    }

    public String getDtype() {
        return dtype;
    }

    public int getReaded() {
        return readed;
    }

    public void setDno(int dno) {
        this.dno = dno;
    }

    public void setUno(String uno) {
        this.uno = uno;
    }

    public void setPno(String pno) {
        this.pno = pno;
    }

    public void setDtype(String dtype) {
        this.dtype = dtype;
    }

    public void setReaded(int readed) {
        this.readed = readed;
    }

    public String getUname() {
        return uname;
    }

    public void setUname(String uname) {
        this.uname = uname;
    }
}
