package com.csh.service;

import com.csh.mapper.ShowPicMapper;
import com.csh.pojo.ShowPic;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class ShowPicServiceImpl implements ShowPicService {

    @Autowired
    ShowPicMapper showPicMapper;

    /**
     *得到关于key的图片列表：(key=show, top, null)
     */
    public List<ShowPic> getAllShowPic() {
        return showPicMapper.selectShowPic("");
    }

    public List<ShowPic> getShowPicWithShow() {
        return showPicMapper.selectShowPic("show");
    }

    public List<ShowPic> getShowPicWithTop() {
        return showPicMapper.selectShowPic("top");
    }

    /**
     * 插入新的展示图，只能添加图片名称
     */
    public boolean insertShowPic(ShowPic showPic) {
        return showPicMapper.insertShowPic(showPic) > 0;
    }

    /**
     * 改变图片的三个状态：show、top、link
     */
    public boolean updatePicShow(ShowPic showPic) {
        return showPicMapper.updatePicShow(showPic) > 0;
    }

    /**
     * 根据轮播图编号删除该轮播图
     * */
    public boolean deleteShowPic(String pidId) {
        return showPicMapper.deleteShowPic(pidId) > 0;
    }

}
