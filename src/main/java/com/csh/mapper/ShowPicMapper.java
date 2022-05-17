package com.csh.mapper;

import com.csh.pojo.ShowPic;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ShowPicMapper {

    /**
     *得到关于key的图片列表：(key=show, top, null)
     */
    public List<ShowPic> selectShowPic(@Param("key") String key);

    /**
     * 插入新的展示图，只能添加图片名称
     */
    public int insertShowPic(@Param("showPic") ShowPic showPic);

    /**
     * 改变图片的三个状态：show、top、link
     */
    public int updatePicShow(@Param("showPic") ShowPic showPic);

    /**
     * 根据轮播图编号删除该轮播图
     * */
    public int deleteShowPic(@Param("picId") String pidId);

}
