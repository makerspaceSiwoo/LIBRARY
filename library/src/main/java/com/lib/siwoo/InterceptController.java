package com.lib.siwoo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class InterceptController {
	
	@GetMapping("/")
	public String defaultPage() {
		return "redirect:/home";
	}
	
	@GetMapping("/restrict")
	public String restrict() {
		return "restrict";
	}
	
	@GetMapping("/loginfirst")
	public String loginFirst() {
		return "loginFirst";
	}
	
}
