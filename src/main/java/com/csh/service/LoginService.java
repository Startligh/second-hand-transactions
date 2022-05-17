package com.csh.service;

import com.csh.pojo.Login;
import com.csh.pojo.User;

public interface LoginService {
    public Login selectLogin(String lno);//登录时进行验证
    public boolean deleteByLno(String lno);//删除登陆表信息
    public boolean addLogin(Login login);//添加登陆表信息
    public boolean updateLoginByUser(User user);//更改用户的登录信息
}
