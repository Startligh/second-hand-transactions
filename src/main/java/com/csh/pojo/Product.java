package com.csh.pojo;

public class Product {
    //编号、商品名称、价格、类型、几成新等级、、商品图片
    private String pno;
    private String pname;
    private float price;
    private String ptype;
    private int plevel;
    private String uno;//所属用户即卖家账号
    private String ppricture;
    private String bno;//买家编号
    private String uname;//买家姓名

    public void setPno(String pno) {
        this.pno = pno;
    }

    public void setPname(String pname) {
        this.pname = pname;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public void setPtype(String ptype) {
        this.ptype = ptype;
    }

    public void setPlevel(int plevel) {
        this.plevel = plevel;
    }

    public void setUno(String uno) {
        this.uno = uno;
    }

    public void setPpricture(String ppricture) {
        this.ppricture = ppricture;
    }

    public void setBno(String bno) {
        this.bno = bno;
    }

    public void setUname(String uname) {
        this.uname = uname;
    }

    public String getPno() {
        return pno;
    }

    public String getPname() {
        return pname;
    }

    public float getPrice() {
        return price;
    }

    public String getPtype() {
        return ptype;
    }

    public int getPlevel() {
        return plevel;
    }

    public String getUno() {
        return uno;
    }

    public String getPpricture() {
        return ppricture;
    }

    public String getBno() {
        return bno;
    }

    public String getUname() {
        return uname;
    }

    @Override
    public String toString() {
        return "Product{" +
                "pno='" + pno + '\'' +
                ", pname='" + pname + '\'' +
                ", price=" + price +
                ", ptype='" + ptype + '\'' +
                ", plevel=" + plevel +
                ", uno='" + uno + '\'' +
                ", ppricture='" + ppricture + '\'' +
                ", bno='" + bno + '\'' +
                ", uname='" + uname + '\'' +
                '}';
    }

}
