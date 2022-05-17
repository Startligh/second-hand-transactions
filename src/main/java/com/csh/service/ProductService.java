package com.csh.service;

import com.csh.pojo.Product;

import java.util.List;

public interface ProductService {

    //得到最新的count个产品
    public List<Product> getNewestProducts(int start, int end);

    //选出最大的pno
    public String getMaxPno();

    //插入新的商品
    public boolean addProduct(Product product);

    //根据Pno查询商品
    public Product selectProductByPno(String pno);

    //根据Pno修改商品
    public boolean updateProductByPno(Product product);

    //根据用户编号查询他发布的所有商品
    public List<Product> selectProductsByUno(String uno);

    //根据商品编号pno删除商品
    public boolean deleteProductByPno(String pno);

    //其他用户查看某uno下的所有未卖出商品，每次查end-start个数据
    public List<Product> selectProductsByOtherUno(String otherUno, int start, int end);

    //根据keyWord模糊查询商品
    public List<Product> selectProductsByKeyWord(String keyWord, int start, int end);

    //根据uno、pno，查询是否是该uno用户发布的商品pno
    public Product selectUnoProductByPno(String uno, String pno);

}
