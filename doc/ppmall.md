## ppmall-parent:父模块

>把所有依赖的版本通用管理起来,用到了maven的parent概念。可以让所有的模块都继承这个parent模块，由这个parent模块来管理版本。

## ppmall-api:接口和bean模块

>实体类和service接口模块

## ppmall-common-util:通用工具模块
> spring-boot-starter-test、spring-boot-starter-web;  
> 通用型的第三方包，比如fastjson、httpclient、apache工具包;   
> dubbo、spring和dubbo整合包、zkclient、热部署工具devtools; 

## ppmall-service-util:通用service层模块
> 引入父工程依赖:ppmall-parent;  
> 引入通用工具模块:ppmall-common-util;  
> 数据库相关依赖:jdbc、mysql、druid、mybatis整合包、jedis;

##  ppmall-web-util:通用web层模块
> 引入父工程依赖:ppmall-parent;  
> 引入通用工具模块:ppmall-common-util;  
> 引入前端页面渲染框架thymeleaf

##  ppmall-member:会员服务模块  
> 拆分为member-service和member-web模块

### ppmall-member-service/ppmall-member-web
> 用户服务的service层  
>
> 端口号:8070  

>用户服务的web层
>端口:8080

## ppmall-manage-service/ppmall-manage-web
> 后台管理服务的service层
> 端口:8071

> 后台管理服务的web层
> 端口:8081

## ppmall-item-web
> 前台的商品详情展示     
>
>  端口:8082
>     

##  ppmall-search-web/ppmall-search-service
> 前台的搜索服务
> 端口:8083

>后台搜索服务的service层
>端口:8073

## ppmall-cart-web/ppmall-cart-service
>    前台的购物车服务
>    端口:8084

>后台购物车服务的service层
>端口:8074

## ppmall-passport-web
 >   认证中心:颁发token+验证真伪
 >   端口:8085
 >   服务层调用的是ppmall-member-service 8070

 ## ppmall-order-web/ppmall-order-service
>     订单控制层
>     端口:8086

> 订单服务
>  端口:8076

## ppmall-order-payment
> 支付服务
> 端口:8001    

## ppmall-flashsale
> 秒杀服务
> 端口:8002

未修改:
在购物车的用户登录还未做.memberId使用 "1" 和"" 代替[已改]  
购物车cookie过期时间:设置的60*3   
购物车中已经提交订单的sku方便测试,还没有删除 --->saveOmsOrder  
延迟队列设置的时间是10秒
购物车合并  
支付完成删除购物车信息