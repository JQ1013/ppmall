package com.jqlmh.ppmall;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import tk.mybatis.spring.annotation.MapperScan;

@MapperScan(basePackages = "com.jqlmh.ppmall.member.mapper")
@SpringBootApplication
public class PpmallMemberServiceApplication {

	public static void main(String[] args) {
		SpringApplication.run(PpmallMemberServiceApplication.class, args);
	}

}
