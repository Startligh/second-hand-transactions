package com.csh.service;

import com.csh.pojo.*;

import java.util.List;

public interface UserService {

    public User selectUserByUno(String uno);
    public boolean addUser(String uno, String upassword, String utype);//添加新用户
    public void updateUserbyuno(User user);//修改除密码外的信息
    public boolean updateUpassword(User user);//修改密码
    public List<Product> selectProduct();//查询所有商品
    public Product selectProductbypno(String pno);//根据商品编号查询
    public List<Product> selectProductbypname(String pname);//根据商品名称模糊查询
    public List<Product> selectProductByUno(String uno);//显示我的商品
    public void updatemyPoduct(Product product);//修改我发布的商品，只能在“我的商品”页面操作
    public void deletemyProduct(String pno);//删除我发布的商品，只能在“我的商品”页面操作
    public void addProduct(Product product);//发布商品
    public List<Shopcar> selectShopcar(String uno);//显示购物车的内容
    public void deleteProductfromshopcar(String pno);//根据商品编号从购物车中删除
    public void addProducttoshopcar(Shopcar shopcar);//增加商品到购物车
    public List<Orders> selectOrders(String uno);//查看我的订单（根据我的id到订单表查找）
    public List<Orders> selectBuyOrders(String uno);//用where bno=uno子句查询我的购买订单
    public List<Orders> selectSaleOrders(String uno);//用where sno=uno子句查询我的销售订单
    public void addOrders(Orders orders);//增加订单
    public List<Dynamic> selectDynamic(String uno);//根据id查看动态
    public void addDynamic(Dynamic dynamic);//增加动态
    public void deleteDynamic(String pno);//删除动态（例如退货时）
}
