package com.lib.ho;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class FindController {
	
	@GetMapping("/find/id")
	public String findId() {
		return "/ho_find/findid";
	}
	
	@PostMapping("/find/pw")
	public String findPw() {
		return "/ho_find/findpw";
	}
	

}
