package com.csh.pojo;

import java.util.Date;

public class Orders {
    //订单：订单编号、商品编号、买方账号、卖方账号、时间、状态（1确认或0取消）
    private int ono;
    private String pno;
    private String bno;
    private String sno;
    private Date odate;
    private int stats;
    //买卖双方的姓名
    private String bname;
    private String sname;

    @Override
    public String toString() {
        return "Orders{" +
                "ono=" + ono +
                ", pno='" + pno + '\'' +
                ", bno='" + bno + '\'' +
                ", sno='" + sno + '\'' +
                ", odate=" + odate +
                ", stats=" + stats +
                ", bname='" + bname + '\'' +
                ", sname='" + sname + '\'' +
                '}';
    }

    public int getOno() {
        return ono;
    }

    public void setOno(int ono) {
        this.ono = ono;
    }

    public String getPno() {
        return pno;
    }

    public void setPno(String pno) {
        this.pno = pno;
    }

    public String getBno() {
        return bno;
    }

    public void setBno(String bno) {
        this.bno = bno;
    }

    public String getSno() {
        return sno;
    }

    public void setSno(String sno) {
        this.sno = sno;
    }

    public Date getOdate() {
        return odate;
    }

    public void setOdate(Date odate) {
        this.odate = odate;
    }

    public int getStats() {
        return stats;
    }

    public void setStats(int stats) {
        this.stats = stats;
    }

    public String getBname() {
        return bname;
    }

    public void setBname(String bname) {
        this.bname = bname;
    }

    public String getSname() {
        return sname;
    }

    public void setSname(String sname) {
        this.sname = sname;
    }
}
