package com.jqlmh.ppmall.payment.test;

import org.apache.activemq.ActiveMQConnection;
import org.apache.activemq.ActiveMQConnectionFactory;

import javax.jms.*;

/**
 * @author LMH
 * @create 2020-04-28 14:16
 */
public class Xiaolu {

	public static void main(String[] args) {
		ConnectionFactory connectionFactory = new ActiveMQConnectionFactory(
				ActiveMQConnection.DEFAULT_USER,
				ActiveMQConnection.DEFAULT_PASSWORD,
				"tcp://localhost:61616"); //创建acmq连接工厂

		Connection connection = null;
		Session session = null;
		try {
			connection = connectionFactory.createConnection();

			connection.start();  //连接开启

			//创建一个会话,第一个参数表示是否开启事务,第二个值是确认模式:只要调用comsumer.receive方法 ，自动确认
			session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);

			//会话创建一个消息队列
			Queue queue = session.createQueue("drink");

			//创建一个消费者:参数是消费哪个消息队列名字
			MessageConsumer consumer = session.createConsumer(queue);
			//设置一个消息监听器
			consumer.setMessageListener(new MessageListener() {
				@Override
				public void onMessage(Message message) {
					if (message instanceof TextMessage) {
						try {
							String text = ((TextMessage) message).getText();
							System.out.println(text + "小卢:我来了,我来执行");
						} catch (JMSException e) {
							e.printStackTrace();
						}
					}
				}
			});

		} catch (JMSException e) {
			e.printStackTrace();
		}
	}
}
