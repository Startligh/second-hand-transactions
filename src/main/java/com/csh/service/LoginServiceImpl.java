package com.csh.service;

import com.csh.mapper.LoginMapper;
import com.csh.pojo.Login;
import com.csh.pojo.User;
import com.csh.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class LoginServiceImpl implements LoginService {
    @Autowired
    LoginMapper loginmapper;

    @Override
    public Login selectLogin(String lno)
    {
        return loginmapper.selectLogin(lno);
    }

    //删除登陆表信息
    @Override
    public boolean deleteByLno(String lno) {
        return loginmapper.deleteByLno(lno);
    }

    //添加登陆表信息
    public boolean addLogin(Login login) {
        return loginmapper.insertLogin(login) > 0;
    }

    //更改用户的登录信息
    public boolean updateLoginByUser(User user) {
        return loginmapper.updateLoginByUser(user) > 0;
    }
}
