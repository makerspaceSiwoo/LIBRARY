package com.lib.mo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.lib.mo.service.HomeService;

@Controller
public class HomeController {
	
	@Autowired
	HomeService service;
	
	@GetMapping("/home")
	public String homepage(Model m) {
		m.addAttribute("allbook", service.allbook());
		return "/user/home";
	}
	
	@GetMapping("/search/title")
	public String search() {
		return "/search/title";
	}
	
	@GetMapping("/recomm/filter")
	public String recomm() {
		return "/recomm/main";
	}
	
	@GetMapping("/my/borrow")
	public String mypage() {
		return "/mypage";
	}
	
	@GetMapping("/board/list")
	public String nanum() {
		return "/board/list";
	}
	
	@GetMapping("/login")
	public String login() {
		return "/login";
	}
	
	@GetMapping("/join")
	public String join() {
		return "/join";
	}
	@GetMapping("/allbook")
	public String allbook(Model m) {
		m.addAttribute("allbook", service.allbook());
		
		return "/user/home";
	}
}
