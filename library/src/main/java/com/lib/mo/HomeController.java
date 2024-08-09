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
	
}
