package com.csh.controller;

import com.csh.pojo.*;
import com.csh.util.Constants;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class TestController {

    @RequestMapping("toTest")
    public String toTest() {
        return "test";
    }

    /**
     * 时间的处理
     * */
    @InitBinder
    public void initBinder(HttpServletRequest request,
                           ServletRequestDataBinder binder) throws Exception {
        binder.registerCustomEditor(Date.class, new CustomDateEditor(new
                SimpleDateFormat("yyyy-MM-dd"),true));
    }


    @RequestMapping("test")
    public String test(TeUser user, Model model, @RequestParam("file") CommonsMultipartFile file , HttpServletRequest request) throws IOException {
        //获取文件名 : file.getOriginalFilename();
        String uploadFileName = file.getOriginalFilename();

        //如果文件名为空，直接回到首页！
        if (!"".equals(uploadFileName)){
            user.setFileName(uploadFileName);
            System.out.println("上传文件名 : " + uploadFileName);

            //上传路径保存设置
            String path = request.getServletContext().getRealPath("/img/headPhoto");
            System.out.println("path : " + path);
            //如果路径不存在，创建一个
            File realPath = new File(path);
            if (!realPath.exists()){
                realPath.mkdir();
            }
            System.out.println("上传文件保存地址：" + realPath);

            InputStream is = file.getInputStream(); //文件输入流
            OutputStream os = new FileOutputStream(new File(realPath,uploadFileName)); //文件输出流

            //读取写出
            int len=0;
            byte[] buffer = new byte[1024];
            while ((len=is.read(buffer))!=-1){
                os.write(buffer,0,len);
                os.flush();
            }
            os.close();
            is.close();
        }

/*        System.out.println(user.getSex());
        System.out.println(user.getRole());
        System.out.println(user.getCreateDate());*/
        System.out.println(user.getLikes());
        if(user != null) {
            model.addAttribute("user", user);
            return "test";
        }
        model.addAttribute("msg", "信息上传失败");
        return "redirect:/index.jsp";
    }

    /*文件下载步骤：

        1、设置 response 响应头

        2、读取文件 -- InputStream

        3、写出文件 -- OutputStream

        4、执行操作

        5、关闭流 （先开后关）
        */
    @RequestMapping(value="/download")
    public String downloads(String fileName, HttpServletResponse response , HttpServletRequest request) throws Exception{
        System.out.println("filename : " + fileName);
        //要下载的图片地址
        String path = request.getServletContext().getRealPath("/img/headPhoto");
        //1、设置response 响应头
        response.reset(); //设置页面不缓存,清空buffer
        response.setCharacterEncoding("UTF-8"); //字符编码
        response.setContentType("multipart/form-data"); //二进制传输数据
        //设置响应头
        response.setHeader("Content-Disposition",
                "attachment;fileName=" + URLEncoder.encode(fileName, "UTF-8"));

        File file = new File(path,fileName);
        //2、 读取文件--输入流
        InputStream input = new FileInputStream(file);
        //3、 写出文件--输出流
        OutputStream out = response.getOutputStream();

        byte[] buff = new byte[1024];
        int index = 0;
        //4、执行 写出操作
        while((index= input.read(buff))!= -1){
            out.write(buff, 0, index);
            out.flush();
        }
        out.close();
        input.close();
        return null;
    }

}