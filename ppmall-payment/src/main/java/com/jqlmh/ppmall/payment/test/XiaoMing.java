package com.jqlmh.ppmall.payment.test;

import org.apache.activemq.ActiveMQConnection;
import org.apache.activemq.ActiveMQConnectionFactory;

import javax.jms.*;

/**
 * @author LMH
 * @create 2020-04-28 14:16
 */
public class XiaoMing {

	public static void main(String[] args) {
		ConnectionFactory connectionFactory = new ActiveMQConnectionFactory(
				ActiveMQConnection.DEFAULT_USER,
				ActiveMQConnection.DEFAULT_PASSWORD,
				"tcp://localhost:61616"); //创建acmq连接工厂

		Connection connection = null;
		Session session = null;
		try {
			connection = connectionFactory.createConnection();

			//设置消息消费客户端的id,便于持久化[相当于设置了这个id,你就在服务器那里有了一个id记录,你消费了消息就会有记录]
			connection.setClientID("小明");

			connection.start();  //连接开启

			//创建一个会话,第一个参数表示是否开启事务,第二个值是确认模式:只要调用comsumer.receive方法 ，自动确认
			session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);

			//会话创建一个消息主题
			Topic topic = session.createTopic("speaking");

			//创建一个持久化的话题消息的消费者,在topic模式下,可以记录你的id和名字,在消费者上进行持久化
			MessageConsumer consumer = session.createDurableSubscriber(topic, "小明");
			//创建一个消费者:参数是消费哪个消息主题名字
			//MessageConsumer consumer = session.createConsumer(topic);


			//设置一个消息监听器
			consumer.setMessageListener(new MessageListener() {
				@Override
				public void onMessage(Message message) {
					if (message instanceof TextMessage) {
						try {
							String text = ((TextMessage) message).getText();
							System.out.println(text + "小明:我来了,我来执行");
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
