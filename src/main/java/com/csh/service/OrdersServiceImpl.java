package com.csh.service;

import com.csh.mapper.OrdersMapper;
import com.csh.pojo.Orders;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class OrdersServiceImpl implements OrdersService {

    @Autowired
    OrdersMapper ordersMapper;

    /**
     * 根据商品Pno查询购物车
     */
    public List<Orders> selectOrdersByPno(String pno) {
        return ordersMapper.selectOrdersByPno(pno);
    }

    /**
     * 查询最大的订单号
     */
    public int selectMaxOno() {
        return ordersMapper.selectMaxOno();
    }

    /**
     * 根据ono查询订单
     */
    public Orders selectOrderByOnoWithSave(int ono, String uno) {
        return ordersMapper.selectOrderByOnoWithSave(ono, uno);
    }

    /**
     * 根据uno查询所有相关订单
     */
    public List<Orders> selectOrdersByUno(String uno) {
        return ordersMapper.selectOrdersByUno(uno);
    }

    /**
     * 根据bno查询所有订单
     */
    public List<Orders> selectOrdersByBno(String bno) {
        return ordersMapper.selectOrdersByBno(bno);
    }

    /**
     * 根据sno查询所有订单
     */
    public List<Orders> selectOrdersBySno(String sno) {
        return ordersMapper.selectOrdersBySno(sno);
    }

    /**
     * 插入新的订单
     */
    public boolean insertOrder(Orders orders) {
        return ordersMapper.insertOrder(orders) > 0;
    }

    /**
     * 更新订单状态
     */
    public boolean updateOrdersStats(int stats, String ono) {
        return ordersMapper.updateOrdersStats(stats, ono) > 0;
    }

    /**
     * 根据订单编号查询订单信息
     */
    public Orders selectOrderByOno(String ono) {
        return ordersMapper.selectOrderByOno(ono);
    }

}
