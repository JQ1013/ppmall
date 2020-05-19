package com.jqlmh.ppmall.flashsale.controller;

import com.jqlmh.ppmall.util.RedisUtil;
import org.redisson.api.RSemaphore;
import org.redisson.api.RedissonClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.Transaction;

import java.util.List;

/**
 * @author LMH
 * @create 2020-04-30 10:31
 */
@Controller
@CrossOrigin
public class FlashSaleController {


	@Autowired
	private RedisUtil redisUtil;

	@Autowired
	private RedissonClient redissonClient;

	/**
	 * jedis秒杀  :抢购成功后需要发消息给订单系统
	 *
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/flashSale")
	public String flashSale() {

		Jedis jedis = redisUtil.getJedis();

		//监控某一个商品key
		jedis.watch("106");

		int stock = Integer.parseInt(jedis.get("106"));
		if (stock > 0) {
			//开启事务
			Transaction tx = jedis.multi();
			//库存减1
			tx.decr("106");
			List<Object> exec = tx.exec();


			if (exec != null && exec.size() > 0) {
				System.out.println("库存剩余" + stock + ",--->[" + Thread.currentThread().getName() + "]抢购成功,已经抢购次数:" + (1000 - stock + 1));
			} else {
				System.err.println("库存数量" + stock + "不足,抢购失败!!!");
			}

		}
		jedis.close();

		return "1";
	}


	@ResponseBody
	@RequestMapping("/flashSaleWithRedisson")
	public String flashSaleWithRedisson() {
		Jedis jedis = redisUtil.getJedis();
		int stock = Integer.parseInt(jedis.get("106"));

		RSemaphore semaphore = redissonClient.getSemaphore("106");
		boolean buySuccess = semaphore.tryAcquire();

		if (buySuccess) {

			System.out.println("库存剩余" + stock + ",--->[" + Thread.currentThread().getName() + "]抢购成功,已经抢购次数:" + (1000 - stock + 1));
		} else {
			System.err.println("库存数量" + stock + "不足,抢购失败!!!");
		}

		jedis.close();
		return "1";

	}
}
