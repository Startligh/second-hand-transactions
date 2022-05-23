package com.csh.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class UserMethod {

    public static String getStringTime() {
       return new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss").format(new Date()).replace("-", "");
    }

    public static String getChattingNewTime() {
        return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
    }

}
