# API 接口设计
## 一. Controller 设计规范

### 1. @RequestBody、@RequestParam、@PathVariable区别与使用场景
接口设计风格为restful的风格，在get请求下，后台接收参数的注解为RequestBody时会报错；在post请求下，后台接收参数的注解为RequestParam时也会报错。

如果为get请求时，后台接收参数的注解应该为RequestParam，如果为post请求时，则后台接收参数的注解就是为RequestBody。
## 二. Service 设计规范

## 三. Mapper 设计规范
