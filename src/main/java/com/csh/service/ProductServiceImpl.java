package com.csh.service;

import com.csh.mapper.ProductMapper;
import com.csh.pojo.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class ProductServiceImpl implements ProductService {

    @Autowired
    ProductMapper productMapper;

    /**
     * 得到最新的count个产品
     * */
    @Override
    public List<Product> getNewestProducts(int start, int end) {
        return productMapper.selectDescProducts(start, end);
    }

    /**
     * 选出最大的pno
     */
    public String getMaxPno() {
        return productMapper.selectMaxPno();
    }

    /**
     * 插入新的商品
     */
    public boolean addProduct(Product product) {
        return productMapper.insertProduct(product) > 0;
    }

    /**
     * 根据Pno查询商品
     */
    public Product selectProductByPno(String pno) {
        return productMapper.selectProductByPno(pno);
    }

    /**
     * 根据Pno修改指定商品信息
     */
    public boolean updateProductByPno(Product product) {
        return productMapper.updateProductByPno(product) > 0;
    }

    /**
     * 根据用户编号查询他发布的所有商品
     */
    public List<Product> selectProductsByUno(String uno) {
        return productMapper.selectProductsByUno(uno);
    }

    /**
     * 根据商品编号pno删除商品
     */
    public boolean deleteProductByPno(String pno) {
        return productMapper.deleteProductByPno(pno) > 0;
    }

    /**
     * 其他用户查看某uno下的所有未卖出商品，每次查end-start个数据
     */
    public List<Product> selectProductsByOtherUno(String otherUno, int start, int end) {
        return productMapper.selectProductsByOtherUno(otherUno, start, end);
    }

    /**
     * 根据keyWord模糊查询商品
     */
    public List<Product> selectProductsByKeyWord(String keyWord, int start, int end) {
        return productMapper.selectProductsByKeyWord(keyWord, start, end);
    }

    /**
     * 根据uno、pno，查询是否是该uno用户发布的商品pno
     */
    public Product selectUnoProductByPno(String uno, String pno) {
        return productMapper.selectUnoProductByPno(uno, pno);
    }

}
