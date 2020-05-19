package com.jqlmh.ppmall.redissontest.controller;

import com.jqlmh.ppmall.util.RedisUtil;
import org.apache.commons.lang3.StringUtils;
import org.redisson.api.RLock;
import org.redisson.api.RedissonClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import redis.clients.jedis.Jedis;

import java.util.concurrent.TimeUnit;

/**
 * redisson提供了分布式可重入锁
 * 可重入锁（Reentrant Lock）
 * 		基于Redis的Redisson分布式可重入锁RLock Java对象实现了java.util.concurrent.locks.Lock接口。
 *
 *
 * 可重入锁的含义是:当前获取锁的线程再次获取锁不会被阻塞
 * @author LMH
 * @create 2020-04-19 12:05
 */
@RestController
public class RedissonTestController {

	@Autowired
	private RedisUtil redisUtil;

	@Autowired
	private RedissonClient redissonClient;


	@RequestMapping("/redisson")
	public String redisson() {

		Jedis jedis = redisUtil.getJedis(); //连接redis
		RLock lock = redissonClient.getLock("lock"); //声明锁

		//加锁
		//方式一:
		//lock.lock();  没有设置锁过期时间、没有设置尝试加锁等待时间

		//方式二:
		// 加锁以后10秒钟自动解锁
		// 无需调用unlock方法手动解锁
		//lock.lock(10, TimeUnit.SECONDS);

		//方式三:设置了加锁的等待时间,等待时间后不再尝试加锁
		boolean res = false;  // 尝试加锁，最多等待100秒，上锁以后10秒自动解锁
		try {
			res = lock.tryLock(100, 10, TimeUnit.SECONDS); //尝试上锁
		} catch (InterruptedException e) {
			e.printStackTrace();
		}

		if (res) {
			try {
				String v = jedis.get("k");
				if (StringUtils.isBlank(v)) {
					v = "1";
				}
				System.out.println("--->" + v);
				jedis.set("k", Integer.parseInt(v) + 1 + "");

			} finally {
				jedis.close();
				lock.unlock(); //手动解锁
			}
		}
		return "success";
	}
}
