package test;

import com.csh.mapper.ChatMapper;
import com.csh.pojo.ChatHistory;
import com.csh.pojo.ShowPic;
import com.csh.pojo.User;
import com.csh.util.MybatisUtils;
import org.apache.ibatis.session.SqlSession;
import org.json.JSONObject;

import java.sql.Timestamp;
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
        System.out.println(new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss").format(new Date()).replace("-", ""));

    }

    @org.junit.Test
    public void testTableChat() {
        SqlSession sqlSession = MybatisUtils.getSqlSession();
        ChatMapper mapper = sqlSession.getMapper(ChatMapper.class);
        System.out.println(mapper.getChatListByUserId("1001"));

        String userAId = "10", userBId = "11";
        if(!userAId.equals(userBId)) {
            if(mapper.getChatIdByBothUser(userAId, userBId) == null) {
                System.out.println("can insert");
                System.out.println("insert_status: " + mapper.insertChatting(userAId, userBId));
            } else {
                System.out.println("can't insert, because this record having in table");
            }
        }
        sqlSession.commit();
    }

    @org.junit.Test
    public void testTableChatLog() {
        SqlSession sqlSession = MybatisUtils.getSqlSession();
        ChatMapper mapper = sqlSession.getMapper(ChatMapper.class);

        //插入测试
        User userA = new User();
        userA.setUno("1");
        User userB = new User();
        userB.setUno("3");
        ChatHistory chatHistory = new ChatHistory();
        chatHistory.setContent("test");
        chatHistory.setChatId(12);
        chatHistory.setSendUser(userA);
        chatHistory.setRecipient(userB);

        System.out.println("插入条数：" + mapper.insertChatLog(chatHistory));
        System.out.println("插入id：" + chatHistory.getLogId());
        System.out.println("修改最后通话时间：" + mapper.updateLastChatTime(chatHistory.getChatId(), chatHistory.getLogId()));
        System.out.println(mapper.getChatHistoryListByChatId(12));
        //System.out.println(mapper.readChatHistory(1));
        //Timestamp timestamp = new Timestamp();

        sqlSession.commit();
    }

    @org.junit.Test
    public void test() {
        System.out.println(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
    }

}
