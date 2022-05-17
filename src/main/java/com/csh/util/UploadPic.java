package com.csh.util;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.util.UUID;

public class UploadPic {

    // 获得随机UUID文件名
    private static String generateRandonFileName(String fileName) {
        // 获得扩展名
        int index = fileName.lastIndexOf(".");
        if (index != -1) {
            String ext = fileName.substring(index);//文件后缀名
            return UUID.randomUUID().toString().substring(0,6) + ext;
        }
        return UUID.randomUUID().toString().substring(0,6);
    }

    /**
    * 文件上传
    * 参数：文件、文件夹名字、请求
    * 返回：文件名
    * */
    public static String uploadPic(CommonsMultipartFile file , String direName, HttpServletRequest request) throws IOException {
        //获取文件名 : file.getOriginalFilename();
        String uploadFileName = generateRandonFileName(file.getOriginalFilename());
        if (!"".equals(uploadFileName)){
            System.out.println("上传文件名 : " + uploadFileName);
            //上传路径保存设置
            String path = request.getServletContext().getRealPath("/img/" + direName);
            System.out.println("path : " + path);
            //如果路径不存在，创建一个
            File realPath = new File(path);
            if (!realPath.exists()){
                realPath.mkdir();
            }
            System.out.println("上传文件保存地址：" + realPath);

            InputStream is = file.getInputStream(); //文件输入流
            OutputStream os = new FileOutputStream(new File(realPath, uploadFileName)); //文件输出流

            //读取写出
            int len=0;
            byte[] buffer = new byte[1024];
            while ((len=is.read(buffer))!=-1){
                os.write(buffer,0,len);
                os.flush();
            }
            os.close();
            is.close();
            return uploadFileName;
        }
        return null;
    }
}
