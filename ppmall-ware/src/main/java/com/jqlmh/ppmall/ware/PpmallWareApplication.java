package com.jqlmh.ppmall.ware;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import tk.mybatis.spring.annotation.MapperScan;

@MapperScan(basePackages = "com.jqlmh.ppmall.ware.mapper")
@SpringBootApplication
public class PpmallWareApplication {

	public static void main(String[] args) {
		SpringApplication.run(PpmallWareApplication.class, args);
	}

}
