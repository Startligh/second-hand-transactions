# 遇到问题

## 问题一

**import javax.websocket 爆红**

原因：没用资源包

解决：lib下添加相关jar包

```xml
    <dependency>
      <groupId>org.apache.tomcat</groupId>
      <artifactId>tomcat-websocket-api</artifactId>
      <version>7.0.55</version>
      <scope>provided</scope>
    </dependency>
```

[1] [Java EE HTML5 WebSocket 示例](https://www.oschina.net/translate/java-ee-html5-websocket-example)：评论中存在解答



## 问题二

**java.lang.IllegalStateException: Failed to find the root WebApplicationContext. Was ContextLoaderListener not used?**

来源：ServicePoint类的注解：

```java
@ServerEndpoint(value = "/webSocketPoint/{userNo}", configurator = SpringConfigurator.class)
```

原因：缺乏SpringConfigurator.class

解决：写一个


## 问题三

使用 @ServerEndpoint 后，@Autowired 就失效了

[1] [解决思路](https://blog.csdn.net/j1231230/article/details/114641956)
[2] [获得Spring上下文的三种方法](https://blog.csdn.net/fubo1990/article/details/79648766)

    <!--20220518晚上10点后完成内容：
        1. 设计数据库chat、chatLog的建表语句（各字段名以及数据类型）
        2. 完成Chat、ChatLog数据库对应的pojo类设计（类的变量）
        3. 完成ChatMapper接口的方法定义
    -->
    <!--20220519完成内容
        1. 完成sql语句，测试方法
        2. 完成service方法定义以及实现
    -->
    <!--20220520完成内容：
        1. 完成wsController方法
        2. 尝试JSON字符串的发送与接收（服务端和客户端）
        3. 完成userMsg.jsp中聊一聊的点击事件优化（将该会话插入数据库）
        4. 完成messageCenter页面的部分js逻辑修改
            - 页面加载会话列表
            - 选定会话，加载聊天区域（暂未支持加载历史记录）
            - 提前选定会话的加载————置顶该会话、加载该聊天的区域
            - 发送消息后，将当前会话在列表置顶
            - 切换会话————清空输入框、聚焦输入框
    -->
    <!--20220521完成内容：
        1. 完成messageCenter的页面JS逻辑修改
            - 列表加载时，添加新消息提醒
            - 点击会话后，将新消息提醒去掉，同时请求已读消息接口
            - 发送消息，添加消息入库，发送给目标用户（带上时间）
                接收消息分情况：接收用户在线或离线
                离线无意义，在线则再考虑接收用户所处的聊天框（正在与发送用户聊、非发送用户聊天框），
                在线考虑（页面没有目标元素情况复杂，因为页面实际没有该元素插入后只有渲染后才能操作）
                    1. 考虑是否有会话在列表中，无则加，会话置顶
                    2. 考虑是否有聊天框，无则加，聊天框添加发送来的消息
                    3. 若当前没有选择发送用户的聊天框，则要添加新消息提醒
                    4. 若当前消息来自当前聊天框的会话用户，则添加到聊天框（且发送消息已读请求/不发，当离开的时候发）
    -->
    <!--20220522完成内容：
        1. 完成messageCenter的页面JS逻辑修改
            - 打开聊天框
               没有聊天框则查询历史记录，插入聊天框中，聊天框再插入页面
               有则，直接show
        2. 尝试历史聊天记录的分页查询（上滑聊天界面————查询并加载）
    -->