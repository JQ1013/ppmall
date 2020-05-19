package com.jqlmh.ppmall;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import tk.mybatis.spring.annotation.MapperScan;

@MapperScan(basePackages = "com.jqlmh.ppmall.order.mapper")
@SpringBootApplication
public class PpmallOrderServiceApplication {

	public static void main(String[] args) {
		SpringApplication.run(PpmallOrderServiceApplication.class, args);
	}

}
