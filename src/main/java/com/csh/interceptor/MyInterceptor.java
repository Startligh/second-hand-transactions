package com.csh.interceptor;

import com.csh.pojo.Admin;
import com.csh.pojo.User;
import com.csh.util.Constants;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class MyInterceptor implements HandlerInterceptor {

    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws ServletException, IOException {
        // 如果是登陆页面则放行或者是查询页或者是首页都放行
        System.out.println("uri: " + request.getRequestURI());
        if (request.getRequestURI().contains("ogin")
                || request.getRequestURI().contains("earch")
                || request.getRequestURI().contains("toShowIndex")
                || request.getRequestURI().contains("layui")
                || request.getRequestURI().contains("egister")
                || request.getRequestURI().contains("checkUno")) {
            return true;
        }

        HttpSession session = request.getSession();
        // 如果已登陆
        if(session.getAttribute(Constants.USER_SESSION) != null) {
            String contextPath = request.getContextPath();//获取项目名称
//            System.out.println("session内容：" + session.getAttribute(Constants.USER_SESSION));
            //如果是admin
            if (session.getAttribute(Constants.USER_SESSION).getClass().equals(Admin.class) ) {//处理admin下的请求
                if(request.getRequestURI().contains("admin")) {
                    return true;
                } else {//回到admin首页
                    response.sendRedirect(contextPath + "/adminIndex.jsp");
                    return false;
                }
            }
            //如果是用户
            else if (session.getAttribute(Constants.USER_SESSION).getClass().equals(User.class)) {//处理非admin下的请求
                if(!request.getRequestURI().contains("admin")) {
                    return true;
                } else {//回到商城首页
                    response.sendRedirect(contextPath + "/index.jsp");
                    return false;
                }
            }
        }

        // 用户没有登陆跳转到登陆页面
        request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
        return false;
    }

    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
