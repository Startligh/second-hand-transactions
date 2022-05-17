package com.csh.service;

import com.csh.pojo.Dynamic;

import java.util.List;

public interface DynamicService {

    //查询uno下新的未读新动态的数量
    public int selectCountOfNewDynamicByUno(String uno);

    //查询uno下的所有商品的动态
    public List<Dynamic> selectDynamicsByUno(String uno);

    //插入一条新动态
    public boolean insertDynamic(Dynamic dynamic);

    //更新uno下的所有阅读状态
    public boolean updateDynamicReaded(String uno);

}
