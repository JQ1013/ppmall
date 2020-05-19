package com.jqlmh.ppmall.member;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import tk.mybatis.spring.annotation.MapperScan;

@MapperScan(basePackages = "com.jqlmh.ppmall.member.mapper")
@SpringBootApplication
public class PpmallMemberApplication {

	public static void main(String[] args) {
		SpringApplication.run(PpmallMemberApplication.class, args);
	}

}
