package com.csh.controller;

import com.csh.pojo.Admin;
import com.csh.pojo.Login;
import com.csh.pojo.ShowPic;
import com.csh.pojo.User;
import com.csh.service.AdminService;
import com.csh.service.LoginService;
import com.csh.service.ShowPicService;
import com.csh.util.Constants;
import com.csh.util.UploadPic;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("admin")
public class AdminController {

    @Autowired
    private AdminService adminService;

    @Autowired
    private LoginService loginService;

    @Autowired
    private ShowPicService showPicService;

    /**
    * 前往管理员页面
    * */
    @RequestMapping("toAdminIndex")
    public String toAdminIndex() {
        return "admin/admin";
    }

    /**
    * 退出管理员系统，回到商城首页
    * */
    @RequestMapping("outLogin")
    public String outLogin(HttpSession session) {
        session.removeAttribute(Constants.USER_SESSION);
        session.removeAttribute(Constants.USER_NO);
        session.removeAttribute(Constants.USER_PHOTO);
        session.removeAttribute(Constants.USER_NAME);
        return "redirect:/toShowIndex";
    }

    /**
    * 前往添加管理员页面
    * */
    @RequestMapping("toAddManager")
    public String toAddManager() {
        return "admin/addManager";
    }

    /**
     * 检查需要注册的帐号是否已存在
     * */
    @ResponseBody
    @RequestMapping(value = "checkAno", produces = { "text/html;charset=utf-8" })
    public String cheakAno(String ano) {
        System.out.println("ano" + ano);
        JSONObject json = new JSONObject();
        if(ano != null && !"".equals(ano)) {
            Admin admin = adminService.selectAdminByAno(ano);
            if(admin == null) {
                json.put("msg", true);
            } else {
                json.put("msg", "已存在帐号");
            }
        } else {
            json.put("msg", "帐号不可为空");
        }
        return json.toString();
    }

    /**
    * 添加管理员
    * */
    @RequestMapping("addManager")
    public String addManager(Admin admin, @RequestParam(value = "file") CommonsMultipartFile file ,HttpServletRequest request) throws IOException {
        //获取文件名 : file.getOriginalFilename();
        if (!"".equals(file.getOriginalFilename())){
            String fileName = null;
            if((fileName = UploadPic.uploadPic(file, "headPhoto", request)) != null) {
                admin.setApricture(fileName);
            }
        } else {//没有上传图片
            admin.setApricture("noPhoto.jpg");
        }
        adminService.addAdmin(admin);
        Login login = new Login();
        login.setLno(admin.getAno());
        login.setRolecode("1");
        login.setLpassword(admin.getApassword());
        loginService.addLogin(login);
        return "redirect:/admin/toManagerList";
    }

    /**
     * 管理员头像更换
     * */
    @ResponseBody
    @RequestMapping(value = "uploadAdminPic", produces = { "text/html;charset=utf-8" })
    public String uploadAdminPic(HttpServletRequest request) throws IOException {
        JSONObject json = new JSONObject();
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        // 获取上传的文件
        CommonsMultipartFile multiFile = (CommonsMultipartFile)multipartRequest.getFile("file");
        String fileName = null;
        if((fileName = UploadPic.uploadPic(multiFile, "headPhoto", request)) != null) {
            //成功上传，修改管理员的数据库、session存储的信息
            json.put("msg", true);
            HttpSession session = request.getSession();
            Admin admin = (Admin)session.getAttribute(Constants.USER_SESSION);
            admin.setApricture(fileName);
            adminService.updateAdmin(admin);
            session.setAttribute(Constants.USER_SESSION, admin);
            return json.toString();
        }
        json.put("msg", "上传失败");
        return json.toString();
    }

    /**
    * 前往管理员列表
    * */
    @RequestMapping("toManagerList")
    public String toManagerList() {
        return "admin/managerList";
    }

    /**
     * 获得管理员列表
     * */
    @ResponseBody
    @RequestMapping(value = "getAdminList", produces = { "text/html;charset=utf-8" })
    public String getAdminList() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code", 200);
        jsonObject.put("msg", "success");
        List<Admin> adminList = adminService.selectAllAdmins();
        jsonObject.put("count", adminList.size());
        jsonObject.put("data", adminList);
        System.out.println(jsonObject);
        return jsonObject.toString();
    }

    /**
    * 删除管理员
    * */
    @RequestMapping("deleteAdmin")
    public String deleteAdmin(String ano, HttpSession session) {
        System.out.println("被删除的管理员账号为：" + ano);
        adminService.deleteAdminByAno(ano);
        loginService.deleteByLno(ano);
        if(((Admin)session.getAttribute(Constants.USER_SESSION)).getAno().equals(ano)) {
            return "redirect:/admin/outLogin";//自删，退出回到首页
        }
        return "redirect:/admin/toManagerList";
    }

    /**
     * 前往用户列表
     * */
    @RequestMapping("toUserList")
    public String toUserList() {
        return "admin/userList";
    }

    /**
    * 更改用户的状态，是否在小黑屋
    * */
    @RequestMapping("changeUserType")
    public String changeUserType(User user) {
        adminService.updateblacklist(user);
        return "redirect:/admin/toBlackHome";
    }

    /**
     * 获得用户列表的json数据，返回给userList页面，不做页面跳转
     * */
    @ResponseBody
    @GetMapping(value = "getUserList", produces = { "text/html;charset=utf-8" })
    public String getUserList() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code", 200);
        jsonObject.put("msg", "success");
        //查询所有的白名单用户
        List<User> userList = adminService.selectWhiteUser();
        jsonObject.put("count", userList.size());
        jsonObject.put("data", userList);
        System.out.println(jsonObject);
        return jsonObject.toString();
    }

    /**
     * 将用户移至小黑屋
     * */
    @RequestMapping("makeHimBlackHome")
    public String makeHimBlackHome(User user) {
        if("white".equals(user.getUtype())) {
            user.setUtype("black");
        } else {
            user.setUtype("white");
        }
        adminService.updateblacklist(user);
        return "redirect:/admin/toUserList";
    }

    /**
     * 前往小黑屋页面
     * */
    @RequestMapping("toBlackHome")
    public String toBlackHome(Model model) {
        //查询所有的黑名单用户
        model.addAttribute("userList", adminService.selectBlackUser());
        return "admin/blackHome";
    }

    /**
     * 搜索请求
     * */
    @RequestMapping("searchBlackUser")
    public String searchBlackUser(String keyword, Model model) {
        model.addAttribute("userList", adminService.selectBlackUserByMsg(keyword));
        return "admin/blackHome";
    }

    /**
     * 前往管理轮播图页面
     * */
    @RequestMapping("toManageSlideshow")
    public String toManageSlideshow() {
        return "admin/manageShowPic";
    }

    /**
     * 得到轮播图列表展示
     * */
    @ResponseBody
    @RequestMapping(value = "getShowPicList", produces = { "text/html;charset=utf-8" })
    public String getShowPicList() {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code", 200);
        jsonObject.put("msg", "success");
        //查询轮播图列表
        List<ShowPic> allShowPic = showPicService.getAllShowPic();
        jsonObject.put("count", allShowPic.size());
        jsonObject.put("data", allShowPic);
        System.out.println(jsonObject);
        return jsonObject.toString();
    }

    /**
     * 添加轮播图
     * */
    @ResponseBody
    @RequestMapping(value = "uploadShowPic", produces = { "text/html;charset=utf-8" })
    public String uploadShowPic(HttpServletRequest request) throws IOException {
        JSONObject json = new JSONObject();
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        // 获取上传的文件
        CommonsMultipartFile multiFile = (CommonsMultipartFile)multipartRequest.getFile("file");
        String fileName = null;
        if((fileName = UploadPic.uploadPic(multiFile, "showPic", request)) != null) {
            //成功上传，修改showPic的数据库
            json.put("msg", true);
            ShowPic showPic = new ShowPic();
            showPic.setPicName(fileName);
            showPicService.insertShowPic(showPic);
            return json.toString();
        }
        json.put("msg", "上传失败");
        return json.toString();
    }

    /**
     * 改变轮播图的置顶状态
     * */
    @ResponseBody
    @RequestMapping(value = "changeTop", produces = { "text/html;charset=utf-8" })
    public String changeTop(String picId, String status) {
        ShowPic showPic = new ShowPic();
        showPic.setPicId(new Integer(picId));
        if("不置顶".equals(status)) {
            status = "置顶中";
            showPic.setPicTop("Top");
        } else if("置顶中".equals(status)) {
            status = "不置顶";
            showPic.setPicTop("noTop");
        }
        System.out.println("轮播图Id：" + picId + "，     状态：" + status);
        JSONObject jsonObject = new JSONObject();
        //更改置顶状态
        if(showPicService.updatePicShow(showPic)) {
            jsonObject.put("code", 200);
            jsonObject.put("msg", true);
            jsonObject.put("topStatus", status);
        } else {
            jsonObject.put("code", 500);
            jsonObject.put("msg", "置顶失败");
        }
        System.out.println(jsonObject);
        return jsonObject.toString();
    }

    /**
     * 删除图片的Ajax请求
     */
    @ResponseBody
    @RequestMapping(value = "delShowPic", produces = { "text/html;charset=utf-8" })
    public String delShowPic(String picId) {
        JSONObject jsonObject = new JSONObject();
        System.out.println("被删除的轮播图编号为：" + picId);
        if(picId != null && !"".equals(picId)) {
            showPicService.deleteShowPic(picId);
            jsonObject.put("code", 200);
            jsonObject.put("msg", true);
        } else {
            jsonObject.put("code", 500);
            jsonObject.put("msg", "置顶失败");
        }
        System.out.println(jsonObject);
        return jsonObject.toString();
    }

    /**
     * 更改轮播图的展示状态
     * */
    @ResponseBody
    @RequestMapping(value = "changeShow", produces = { "text/html;charset=utf-8" })
    public String changeShow(String picId, String status) {
        System.out.println("picId:" + picId + "   status:" + status);
        ShowPic showPic = new ShowPic();
        showPic.setPicId(new Integer(picId));
        if("展示中".equals(status)) {
            status = "不展示";
            showPic.setPicShow("noshow");
        } else if("不展示".equals(status)) {
            status = "展示中";
            showPic.setPicShow("show");
        }
        //更改展示状态
        JSONObject jsonObject = new JSONObject();
        if(showPicService.updatePicShow(showPic)) {
            jsonObject.put("code", 200);
            jsonObject.put("msg", true);
            jsonObject.put("topStatus", status);
        } else {
            jsonObject.put("code", 500);
            jsonObject.put("msg", "展示失败");
        }
        System.out.println(jsonObject);
        return jsonObject.toString();
    }

}
