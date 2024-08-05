package com.lib.ho;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class testHOcontroller {
	@GetMapping("/ho")
	public String ho() {
		System.out.println("ho");
		return "home";
	}
	
}
