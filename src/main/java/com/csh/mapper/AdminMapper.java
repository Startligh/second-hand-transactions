package com.csh.mapper;

import com.csh.pojo.Admin;
import com.csh.pojo.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AdminMapper {
    public List<Admin> selectAllAdmins(); //查询所有的管理员
    public Admin selectAdminByAno(String ano);
    public List<User> selectallUser();//查询用户列表
    public List<User> selectWhiteUser();//查询非黑名单用户
    public List<User> selectBlackUser();//查询小黑屋用户
    public List<User> selectBlackUserByMsg(@Param("user") User user);//根据信息查询目的黑名单用户
    public void updateblacklist(User user);//设置用户类型
    public void updateAdmin(Admin admin);//修改管理员信息
    public void addAdmin(Admin admin);//增加管理员
    public void deleteProductByPno(String pno);//删除商品
    public boolean deleteAdminByAno(String ano);//删除管理员

}
