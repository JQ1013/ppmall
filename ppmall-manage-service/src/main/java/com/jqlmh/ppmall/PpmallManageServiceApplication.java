package com.jqlmh.ppmall;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import tk.mybatis.spring.annotation.MapperScan;

@MapperScan(basePackages = "com.jqlmh.ppmall.manage.mapper")
@SpringBootApplication
public class PpmallManageServiceApplication {

	public static void main(String[] args) {
		SpringApplication.run(PpmallManageServiceApplication.class, args);
	}

}
