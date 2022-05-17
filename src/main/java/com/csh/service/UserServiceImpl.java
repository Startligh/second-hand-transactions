package com.csh.service;

import com.csh.mapper.UserMapper;
import com.csh.pojo.*;
import com.csh.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
@Service
@Transactional

public class UserServiceImpl implements UserService {
    @Autowired
    UserMapper usermapper;

    @Override
    public User selectUserByUno(String uno) {
        return usermapper.selectUserByUno(uno);
    }

    public boolean addUser(String uno, String upassword, String utype) {
        return usermapper.insertUser(uno,upassword,utype) > 0;
    }

    @Override
    public void updateUserbyuno(User user) {
        usermapper.updateUserbyuno(user);
    }

    @Override
    public boolean updateUpassword(User user) {
        return usermapper.updateUpassword(user) > 0;
    }

    @Override
    public List<Product> selectProduct() {

        return usermapper.selectProduct();
    }

    @Override
    public Product selectProductbypno(String pno) {
        return usermapper.selectProductbypno(pno);
    }

    @Override
    public List<Product> selectProductbypname(String pname) {
        return usermapper.selectProductbypname(pname);
    }

    @Override
    public List<Product> selectProductByUno(String uno) {
        return usermapper.selectProductByUno(uno);
    }

    @Override
    public void updatemyPoduct(Product product) {
        usermapper.updatemyPoduct(product);

    }

    @Override
    public void deletemyProduct(String pno) {
        usermapper.deletemyProduct(pno);

    }

    @Override
    public void addProduct(Product product) {
        usermapper.addProduct(product);

    }

    @Override
    public List<Shopcar> selectShopcar(String uno) {
        return usermapper.selectShopcar(uno);
    }

    @Override
    public void deleteProductfromshopcar(String pno) {
        usermapper.deleteProductfromshopcar(pno);

    }

    @Override
    public void addProducttoshopcar(Shopcar shopcar) {
        usermapper.addProducttoshopcar(shopcar);

    }

    @Override
    public List<Orders> selectOrders(String uno) {
        return usermapper.selectOrders(uno);
    }

    @Override
    public List<Orders> selectBuyOrders(String uno) {
        return usermapper.selectBuyOrders(uno);
    }

    @Override
    public List<Orders> selectSaleOrders(String uno) {
        return usermapper.selectSaleOrders(uno);
    }

    @Override
    public void addOrders(Orders orders) {
        usermapper.addOrders(orders);

    }

    @Override
    public List<Dynamic> selectDynamic(String uno) {
        return usermapper.selectDynamic(uno);
    }

    @Override
    public void addDynamic(Dynamic dynamic) {
        usermapper.addDynamic(dynamic);

    }

    @Override
    public void deleteDynamic(String pno) {
        usermapper.deleteDynamic(pno);

    }
}
