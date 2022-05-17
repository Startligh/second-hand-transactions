package com.csh.pojo;

public class Shopcar {
    //购物车：主键、、商品编号、，前4个shopcar库中有，其他需联表查询
    private String scno;
    private String uno;//购物车的用户编号
    private String pno;
    private String sno;//所属用户即卖家账号
    private String uname;//所属用户的名字
    private String pname;
    private float price;
    private String ppricture;

    @Override
    public String toString() {
        return "Shopcar{" +
                "scno='" + scno + '\'' +
                ", uno='" + uno + '\'' +
                ", pno='" + pno + '\'' +
                ", sno='" + sno + '\'' +
                ", pname='" + pname + '\'' +
                ", price=" + price +
                ", uname='" + uname + '\'' +
                ", ppricture='" + ppricture + '\'' +
                '}';
    }

    public String getScno() {
        return scno;
    }

    public void setScno(String scno) {
        this.scno = scno;
    }

    public String getUno() {
        return uno;
    }

    public void setUno(String uno) {
        this.uno = uno;
    }

    public String getPno() {
        return pno;
    }

    public void setPno(String pno) {
        this.pno = pno;
    }

    public String getSno() {
        return sno;
    }

    public void setSno(String sno) {
        this.sno = sno;
    }

    public String getPname() {
        return pname;
    }

    public void setPname(String pname) {
        this.pname = pname;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getUname() {
        return uname;
    }

    public void setUname(String uname) {
        this.uname = uname;
    }

    public String getPpricture() {
        return ppricture;
    }

    public void setPpricture(String ppricture) {
        this.ppricture = ppricture;
    }
}
