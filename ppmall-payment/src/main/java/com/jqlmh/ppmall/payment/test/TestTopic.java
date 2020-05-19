package com.jqlmh.ppmall.payment.test;

import org.apache.activemq.ActiveMQConnectionFactory;
import org.apache.activemq.command.ActiveMQTextMessage;

import javax.jms.*;
import java.util.Objects;

/**
 * @author LMH
 * @create 2020-04-28 14:14
 */
public class TestTopic {

	public static void main(String[] args) {
		ConnectionFactory connectionFactory = new ActiveMQConnectionFactory("tcp://localhost:61616"); //创建acmq连接工厂

		Connection connection = null;
		Session session = null;
		try {
			connection = connectionFactory.createConnection();

			connection.start();  //连接开启

			//创建一个会话,第一个参数表示是否开启事务,第二个值是确认模式:事务模式
			session = connection.createSession(true, Session.SESSION_TRANSACTED);

			//会话创建一个消息队列
			Topic topic = session.createTopic("speaking");

			//创建一条消息内容
			TextMessage message = new ActiveMQTextMessage();
			message.setText("我要发布一个演讲,你们谁要来");

			//创建一个生产者:参数是生产的消息要发送给的消息队列名字
			MessageProducer producer = session.createProducer(topic);
			producer.setDeliveryMode(DeliveryMode.PERSISTENT);  //话题模式的消息默认在服务器上不持久化
			producer.send(message);  //发送消息

			session.commit();

		} catch (JMSException e) {
			try {
				Objects.requireNonNull(session).rollback();
			} catch (JMSException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				Objects.requireNonNull(connection).close();
			} catch (JMSException e) {
				e.printStackTrace();
			}
		}
	}
}
