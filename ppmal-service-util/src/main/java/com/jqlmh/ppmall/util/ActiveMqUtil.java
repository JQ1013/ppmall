package com.jqlmh.ppmall.util;


import org.apache.activemq.ActiveMQConnectionFactory;
import org.apache.activemq.pool.PooledConnectionFactory;

import javax.jms.ConnectionFactory;

/**
 * ActiveMq工具类
 *
 * @author LMH
 * @create 2020-04-26 10:53
 */
public class ActiveMqUtil {
    private PooledConnectionFactory pooledConnectionFactory=null;

    public void init(String brokerUrl) {

        ActiveMQConnectionFactory factory = new ActiveMQConnectionFactory(brokerUrl);
         //加入连接池
        pooledConnectionFactory=new PooledConnectionFactory(factory);
        //出现异常时重新连接
        pooledConnectionFactory.setReconnectOnException(true);
        //
        pooledConnectionFactory.setMaxConnections(5);
        pooledConnectionFactory.setExpiryTimeout(10000);
    }

    public ConnectionFactory getConnectionFactory(){
        return pooledConnectionFactory;
    }
}