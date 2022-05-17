package com.csh.mapper;

import com.csh.pojo.Product;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ProductMapper {

    //选择倒叙count个数据，每次查end-start个数据
    public List<Product> selectDescProducts(@Param("start") int start, @Param("end") int end);

    //选出最大的pno
    public String selectMaxPno();

    //插入新的商品
    public int insertProduct(@Param("product") Product product);

    //根据Pno查询商品
    public Product selectProductByPno(@Param("pno") String pno);

    //根据Pno修改商品
    public int updateProductByPno(@Param("product") Product product);

    //根据用户编号查询他发布的所有商品
    public List<Product> selectProductsByUno(@Param("uno") String uno);

    //根据商品编号pno删除商品
    public int deleteProductByPno(@Param("pno") String pno);

    //其他用户查看某uno下的所有未卖出商品，每次查end-start个数据
    public List<Product> selectProductsByOtherUno(@Param("otherUno") String otherUno, @Param("start") int start, @Param("end") int end);

    //根据keyWord模糊查询商品
    public List<Product> selectProductsByKeyWord(@Param("keyWord") String keyWord, @Param("start") int start, @Param("end") int end);

    //根据uno、pno，查询是否是该uno用户发布的商品pno
    public Product selectUnoProductByPno(@Param("uno") String uno, @Param("pno") String pno);

}
