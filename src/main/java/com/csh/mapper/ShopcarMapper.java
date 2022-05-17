package com.csh.mapper;

import com.csh.pojo.Shopcar;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ShopcarMapper {

    //根据商品pno以及uno，查询该用户购物车中有无记录pno商品
    public Shopcar selectUnoCarByPno(@Param("pno") String pno, @Param("uno") String uno);

    //增加一个购物车信息
    public int insertShopcar(@Param("pno") String pno, @Param("uno") String uno, @Param("sno") String sno);

    //根据商品编号pno、用户编号uno 删除一个购物车信息
    public int deleteUnoShopcarByPno(@Param("pno") String pno, @Param("uno") String uno);

    //根据uno查询该用户的购物车中所有信息
    public List<Shopcar> selectShopcarsByUno(@Param("uno") String uno);

}
