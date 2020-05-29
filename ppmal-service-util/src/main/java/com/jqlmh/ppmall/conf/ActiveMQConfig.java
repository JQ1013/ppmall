package com.jqlmh.ppmall.conf;

import com.jqlmh.ppmall.util.ActiveMqUtil;
import org.apache.activemq.ActiveMQConnectionFactory;
import org.apache.activemq.RedeliveryPolicy;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jms.config.DefaultJmsListenerContainerFactory;

import javax.jms.Session;

/**
 * ActiveMq 配置类
 *
 * @author LMH
 * @create 2020-04-26 10:53
 */
@Configuration
public class ActiveMqConfig {

    /**
     * mq的连接地址
     */
    @Value("${spring.activemq.broker-url:novalue}")
    private String brokerUrl;

    /**
     * 是否自动监听
     */
    @Value("${activemq.listener.enable:novalue}")
    private String listenerEnable;


    @Bean
    public ActiveMqUtil activeMqUtil() {
        String noValue = "noValue";
        if (noValue.equals(brokerUrl)) {
            return null;
        }
        ActiveMqUtil activeMqUtil = new ActiveMqUtil();
        activeMqUtil.init(brokerUrl);
        return activeMqUtil;
    }

    /**
     * 定义一个消息监听器连接工厂，这里定义的是点对点模式的监听器连接工厂
     *
     * @param activeMQConnectionFactory 连接工厂
     * @return DefaultJmsListenerContainerFactory
     */
    @SuppressWarnings("AlibabaLowerCamelCaseVariableNaming")
    @Bean(name = "jmsQueueListener1")
    public DefaultJmsListenerContainerFactory jmsQueueListenerContainerFactory(ActiveMQConnectionFactory activeMQConnectionFactory) {
        DefaultJmsListenerContainerFactory factory = new DefaultJmsListenerContainerFactory();

        String flag = "true";
        if (!flag.equals(listenerEnable)) {
            return null;
        }

        factory.setConnectionFactory(activeMQConnectionFactory);
        // 设置连接数
        factory.setConcurrency("5");

        // 重连间隔时间
        factory.setSessionTransacted(false);
        factory.setSessionAcknowledgeMode(Session.CLIENT_ACKNOWLEDGE);

        return factory;
    }


    @Bean
    public RedeliveryPolicy redeliveryPolicy() {
        RedeliveryPolicy redeliveryPolicy = new RedeliveryPolicy();
        //是否在每次尝试重新发送失败后,增长这个等待时间
        redeliveryPolicy.setUseExponentialBackOff(true);
        //重发次数,默认为6次   这里设置为10次
        redeliveryPolicy.setMaximumRedeliveries(0);
        //重发时间间隔,默认为1秒
        redeliveryPolicy.setInitialRedeliveryDelay(1);
        //第一次失败后重新发送之前等待500毫秒,第二次失败再等待500 * 2毫秒,这里的2就是value
        redeliveryPolicy.setBackOffMultiplier(2);
        //是否避免消息碰撞
        redeliveryPolicy.setUseCollisionAvoidance(false);
        //设置重发最大拖延时间-1 表示没有拖延只有UseExponentialBackOff(true)为true时生效
        redeliveryPolicy.setMaximumRedeliveryDelay(-1);
        return redeliveryPolicy;
    }


    @Bean
    public ActiveMQConnectionFactory activeMqConnectionFactory(@Value("${spring.activemq.broker-url:noValue}") String url) {
        return new ActiveMQConnectionFactory(
                "admin",
                "admin",
                url);
    }

}
