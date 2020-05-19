package com.jqlmh.ppmall;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import tk.mybatis.spring.annotation.MapperScan;

@MapperScan(basePackages = "com.jqlmh.ppmall.payment.mapper")
@SpringBootApplication
public class PpmallPaymentApplication {

	public static void main(String[] args) {
		SpringApplication.run(PpmallPaymentApplication.class, args);
	}

}
