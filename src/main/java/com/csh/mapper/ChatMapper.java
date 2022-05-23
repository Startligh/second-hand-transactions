package com.csh.mapper;

import com.csh.pojo.ChatHistory;
import com.csh.pojo.ChatItem;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ChatMapper {

    /**
     * 以下为操作表 chat
     */

    /**
     * 通过用户id得到与其聊天的用户列表（列表信息包括{用户id、用户昵称、用户头像、未读信息数量}）
     * @param userId
     * @return 联系人列表
     */
    public List<ChatItem> getChatListByUserId(@Param("userId") String userId);

    /**
     * 通过会话双方id查询出会话id
     * @param userAId
     * @param userBId
     * @return 会话id
     */
    public Integer getChatIdByBothUser(@Param("userAId") String userAId, @Param("userBId") String userBId);

    /**
     * 增加一条会话双方的联系人记录
     * @param userAId
     * @param userBId
     * @return 插入条数
     */
    public int insertChatting(@Param("userAId") String userAId, @Param("userBId") String userBId);

    /**
     * 修改该会话的最晚聊天时间
     * @param chatId
     * @return
     */
    public int updateLastChatTime(@Param("chatId") int chatId, @Param("logId") int logId);

    /**
     * 以下为操作表 chatLog
     */

    /**
     * 通过会话id查询得出历史会话记录列表
     * @param chatId
     * @return 该会话的历史记录列表
     */
    public List<ChatHistory> getChatHistoryListByChatId(@Param("chatId") int chatId);

    /**
     * 通过会话id查询出历史会话记录列表，同时使用分页查询，从start行开始，读取连续的10条记录
     * @param chatId
     * @param start
     * @return 该会话的在数据库的start位置 的 10条历史记录
     */
    public List<ChatHistory> getChatHistoryListByChatIdAndPaging(@Param("chatId") int chatId, @Param("start") int start);

    /**
     * 通过会话id，将未读信息状态修改为已读
     * @param chatId
     * @return 返回修改条数
     */
    public int readChatHistory(@Param("chatId") int chatId);

    /**
     * 插入一条会话记录
     * @param chatLog
     * @return 返回插入条数
     */
    public int insertChatLog(ChatHistory chatLog);

}
