package com.csh.service;

import com.csh.mapper.DynamicMapper;
import com.csh.pojo.Dynamic;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class DynamicServiceImpl implements DynamicService {

    @Autowired
    DynamicMapper dynamicMapper;

    /**
     * 查询uno下新的未读新动态的数量
     * */
    public int selectCountOfNewDynamicByUno(String uno) {
        return dynamicMapper.selectCountOfNewDynamicByUno(uno);
    }

    /**
     * 查询uno下的所有商品的动态
     */
    public List<Dynamic> selectDynamicsByUno(String uno) {
        return dynamicMapper.selectDynamicsByUno(uno);
    }

    /**
     * 插入一条新动态
     */
    public boolean insertDynamic(Dynamic dynamic) {
        return dynamicMapper.insertDynamic(dynamic) > 0;
    }

    //更新uno下的所有阅读状态
    public boolean updateDynamicReaded(String uno) {
        return dynamicMapper.updateDynamicReaded(uno) > 0;
    }

}
