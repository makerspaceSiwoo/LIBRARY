package com.lib.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
public class testcontroller {

	@GetMapping("/test")
	public String A() {
		return "home";
	}
	
	@GetMapping("/test2")
	public String B() {
		return "hello";
	}
	
}
