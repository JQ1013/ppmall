package com.jqlmh.ppmall.conf;

import com.jqlmh.ppmall.util.RedisUtil;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * redis 配置类
 *
 * @author LMH
 * @create 2020-04-14 19:54
 */
@Configuration
public class RedisConfig {

	/**
	 * 读取配置文件中的redis的ip地址
	 */
	@Value("${spring.redis.host:disabled}")
	private String host;

	/**
	 * redis端口
	 */
	@Value("${spring.redis.port:0}")
	private int port;

	/**
	 * redis默认库
	 */
	@Value("${spring.redis.database:0}")
	private int database;

	@Bean
	public RedisUtil redisUtil() {
		String disabled = "disabled";
		if (disabled.equals(host)) {
			return null;
		}
		RedisUtil redisUtil = new RedisUtil();
		redisUtil.initPool(host, port, database);
		return redisUtil;
	}
}