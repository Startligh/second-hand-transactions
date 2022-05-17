package com.csh.mapper;

import com.csh.pojo.Orders;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface OrdersMapper {

    //根据pno查询订单
    public List<Orders> selectOrdersByPno(@Param("pno") String pno);

    //查询最大的订单号
    public int selectMaxOno();

    //根据ono查询订单
    public Orders selectOrderByOnoWithSave(@Param("ono") int ono, @Param("uno") String uno);

    //根据uno查询所有相关订单
    public List<Orders> selectOrdersByUno(@Param("uno") String uno);

    //根据bno查询所有订单
    public List<Orders> selectOrdersByBno(@Param("bno") String bno);

    //根据sno查询所有订单
    public List<Orders> selectOrdersBySno(@Param("sno") String sno);

    //插入新的订单
    public int insertOrder(@Param("orders") Orders orders);

    //更新订单状态
    public int updateOrdersStats(@Param("stats") int stats, @Param("ono") String ono);

    //根据订单编号查询订单信息
    public Orders selectOrderByOno(@Param("ono") String ono);

}
