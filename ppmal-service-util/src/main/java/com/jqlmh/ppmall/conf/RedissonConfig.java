package com.jqlmh.ppmall.conf;

import org.redisson.Redisson;
import org.redisson.api.RedissonClient;
import org.redisson.config.Config;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Redisson配置类
 *
 * @author LMH
 * @create 2020-04-18 22:34
 */
@Configuration
public class RedissonConfig {

	@Value("${spring.redis.host:192.168.184.130}")
	private String host;

	@Value("${spring.redis.port:6379}")
	private String port;


	/**
	 * 将Redisson客户端加入到spring容器中
	 *
	 * @return redis客户端
	 */
	@Bean
	public RedissonClient redissonClient() {
		Config config = new Config();
		config.useSingleServer().setAddress("redis://" + host + ":" + port);
		return Redisson.create(config);
	}
}
