package com.csh.service;

import com.csh.mapper.AdminMapper;
import com.csh.pojo.Admin;
import com.csh.pojo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
@Service
@Transactional
public class AdminServiceImpl implements AdminService {
    @Autowired
    AdminMapper adminmapper;

    public void setAdminmapper(AdminMapper adminmapper) {
        this.adminmapper = adminmapper;
    }

    //查询得到管理员列表
    public List<Admin> selectAllAdmins() {
        return adminmapper.selectAllAdmins();
    }


    @Override
    public Admin selectAdminByAno(String ano) {
        return adminmapper.selectAdminByAno(ano);
    }


    @Override
    public List<User> selectallUser() {
        return adminmapper.selectallUser();
    }

    @Override
    public void updateblacklist(User user) {
        adminmapper.updateblacklist(user);

    }

    @Override
    public void updateAdmin(Admin admin) {
        adminmapper.updateAdmin(admin);

    }

    @Override
    public void addAdmin(Admin admin) {
        adminmapper.addAdmin(admin);

    }

    @Override
    public void deleteProductByPno(String pno) {
        adminmapper.deleteProductByPno(pno);
    }

    //删除管理员
    public boolean deleteAdminByAno(String ano) {
        return adminmapper.deleteAdminByAno(ano);
    }

    //查询非黑名单用户
    public List<User> selectWhiteUser() {
        return adminmapper.selectWhiteUser();
    }

    //查询小黑屋用户
    public List<User> selectBlackUser() {
        return adminmapper.selectBlackUser();
    }

    //根据信息查询目的黑名单用户
    public List<User> selectBlackUserByMsg(String keyword) {
        User user = new User();
        user.setUname(keyword);
        user.setUno(keyword);
        return adminmapper.selectBlackUserByMsg(user);
    }

}
