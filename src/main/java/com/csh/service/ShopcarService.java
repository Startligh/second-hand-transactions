package com.csh.service;

import com.csh.pojo.Shopcar;

import java.util.List;

public interface ShopcarService {

    //根据商品pno以及uno，查询该用户购物车中有无记录pno商品
    public Shopcar selectUnoCarByPno(String pno, String uno);

    //增加一个购物车信息
    public boolean insertShopcar(String pno, String uno, String sno);

    //根据商品编号pno、用户编号uno 删除一个购物车信息
    public boolean deleteUnoShopcarByPno(String pno, String uno);

    //根据uno查询该用户的购物车中所有信息
    public List<Shopcar> selectShopcarsByUno(String uno);

}
