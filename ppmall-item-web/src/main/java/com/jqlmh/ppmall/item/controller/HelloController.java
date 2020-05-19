package com.jqlmh.ppmall.item.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author LMH
 * @create 2020-04-12 17:56
 */
@Controller
public class HelloController {

	/**
	 * 测试方法
	 * @param model
	 * @return
	 */
	@RequestMapping("/index")
	public String hello(Model model){
		model.addAttribute("hello","参数");
		return "index";
	}
}
