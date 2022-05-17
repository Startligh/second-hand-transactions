package com.csh.controller;

import com.csh.pojo.Admin;
import com.csh.pojo.Login;
import com.csh.pojo.User;
import com.csh.service.AdminService;
import com.csh.service.LoginService;
import com.csh.service.LoginServiceImpl;
import com.csh.service.UserService;
import com.csh.util.Constants;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
public class LoginController {

    @Autowired
    private LoginService loginService;

    @Autowired
    private AdminService adminService;

    @Autowired
    private UserService userService;

    /*前往登录页*/
    @RequestMapping("toLogin")
    public String toLogin() {
        return "login";
    }

    @RequestMapping("login")
    public String login(HttpSession session, Model model, Login login) {
        System.out.println("login.getLno():" + login.getLno() + "   login.getLpassword():" + login.getLpassword());
        Login sureLogin = loginService.selectLogin(login.getLno());
        //查出来了
        if(sureLogin != null) {
            if(sureLogin.getLpassword().equals(login.getLpassword())) {//密码正确
                if(sureLogin.getRolecode().equals("1")) {//是管理员
                    Admin admin = adminService.selectAdminByAno(sureLogin.getLno());
                    System.out.println(admin);
                    session.setAttribute(Constants.USER_SESSION, admin);
                    return "redirect:/adminIndex.jsp";
                } else {//是用户
                    User user = userService.selectUserByUno(login.getLno());
                    session.setAttribute(Constants.USER_NO, user.getUno());
                    session.setAttribute(Constants.USER_PHOTO, user.getUpricture());
                    session.setAttribute(Constants.USER_NAME, user.getUname());
                    session.setAttribute(Constants.USER_SESSION, user);
                    return "redirect:/toShowIndex";
                }
            } else {
                model.addAttribute("msg", "密码错误");
                return "login";
            }
        } else {
            model.addAttribute("msg", "账号不存在");
            return "login";
        }
    }

    @RequestMapping("outLogin")
    public String outLogin(HttpSession session) {
        session.removeAttribute(Constants.USER_SESSION);
        session.removeAttribute(Constants.USER_NO);
        session.removeAttribute(Constants.USER_PHOTO);
        session.removeAttribute(Constants.USER_NAME);
        return "redirect:/toShowIndex";
    }

}
