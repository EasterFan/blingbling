# 跨域问题
浏览器跨域问题，会出现浏览器请求接口全部失败，但是在 postman 里访问接口正常。
以前本地联调没问题，加上权限功能后，跨域问题就出现了。

解决方法：
```java
@Configuration
@AutoConfigureBefore(SpringSecurityConfig.class)
public class CorsConfig implements WebMvcConfigurer {

    @Override
    public void addCorsMappings(CorsRegistry registry){
        registry.addMapping("/**")
                .allowedOrigins("*")
                .allowedMethods("*")
                .allowedHeaders("*")
                .allowCredentials(true)
                .maxAge(3600);
    }
}
```
