package test;

import com.csh.pojo.ShowPic;
import com.csh.pojo.User;
import org.json.JSONObject;

import java.text.SimpleDateFormat;
import java.util.*;

public class Test {
    // 获得随机UUID文件名
    public static String generateRandonFileName(String fileName) {
        // 获得扩展名
        int index = fileName.lastIndexOf(".");
        if (index != -1) {
            String ext = fileName.substring(index);//文件后缀名
            return UUID.randomUUID().toString().substring(0,6) + ext;
        }
        return UUID.randomUUID().toString();
    }

    public static void main(String[] args) {
//        System.out.println(generateRandonFileName(null));
        System.out.println(new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss").format(new Date()).replace("-", ""));

    }

    @org.junit.Test
    public void test() {
        HashMap<String, Integer> map = new HashMap<>();
        map.put("abc", 1);
        map.put("abc", 2);
        System.out.println(map.get("abc"));
        System.out.println(map.remove("abc"));
        System.out.println(map.get("abc"));
    }

}
