package com.jqlmh.ppmall;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import tk.mybatis.spring.annotation.MapperScan;

@MapperScan(basePackages = "com.jqlmh.ppmall.cart.mapper")
@SpringBootApplication
public class PpmallCartServiceApplication {

	public static void main(String[] args) {
		SpringApplication.run(PpmallCartServiceApplication.class, args);
	}

}
