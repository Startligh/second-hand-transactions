package com.csh.service;

import com.csh.pojo.ShowPic;
import java.util.List;

public interface ShowPicService {

    /**
     *得到关于key的图片列表：(key=show, top, null)
     *     public List<ShowPic> selectShowPic(String key);
     */
    public List<ShowPic> getAllShowPic();
    public List<ShowPic> getShowPicWithShow();
    public List<ShowPic> getShowPicWithTop();

    /**
     * 插入新的展示图，只能添加图片名称
     */
    public boolean insertShowPic(ShowPic showPic);

    /**
     * 改变图片的三个状态：show、top、link
     */
    public boolean updatePicShow(ShowPic showPic);

    /**
     * 根据轮播图编号删除该轮播图
     * */
    public boolean deleteShowPic(String pidId);

}
