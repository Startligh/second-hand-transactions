package com.csh.service;

import com.csh.pojo.Orders;

import java.util.List;

public interface OrdersService {

    //根据商品Pno查询购物车
    public List<Orders> selectOrdersByPno(String pno);

    //查询最大的订单号
    public int selectMaxOno();

    //根据ono查询订单
    public Orders selectOrderByOnoWithSave(int ono, String uno);

    //根据uno查询所有相关订单
    public List<Orders> selectOrdersByUno(String uno);

    //根据bno查询所有订单
    public List<Orders> selectOrdersByBno(String bno);

    //根据sno查询所有订单
    public List<Orders> selectOrdersBySno(String sno);

    //插入新的订单
    public boolean insertOrder(Orders orders);

    //更新订单状态
    public boolean updateOrdersStats(int stats, String ono);

    //根据订单编号查询订单信息
    public Orders selectOrderByOno(String ono);

}
