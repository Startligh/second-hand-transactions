package com.csh.mapper;

import com.csh.pojo.Dynamic;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface DynamicMapper {

    //查询uno的商品下新的未读新动态的数量
    public int selectCountOfNewDynamicByUno(@Param("uno") String uno);

    //查询uno下的所有商品的动态
    public List<Dynamic> selectDynamicsByUno(@Param("uno") String uno);

    //插入一条新动态
    public int insertDynamic(@Param("dynamic") Dynamic dynamic);

    //更新uno下的所有阅读状态
    public int updateDynamicReaded(@Param("uno") String uno);

}
