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