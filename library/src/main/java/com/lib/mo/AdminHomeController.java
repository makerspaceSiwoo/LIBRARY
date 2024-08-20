package com.lib.mo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.lib.mo.service.HomeService;

@Controller
public class AdminHomeController {

	@Autowired
	HomeService service;
	
	@GetMapping("/admin/home")
	public String adhome(Model m) {
		m.addAttribute("allbook", service.allbook());
		m.addAttribute("chongbook", service.chongbook());
		m.addAttribute("chulbook", service.chulbook());
		m.addAttribute("jongbook", service.jongbook());
		m.addAttribute("sabook", service.sabook());
		m.addAttribute("zabook", service.zabook());
		m.addAttribute("gibook", service.gibook());
		m.addAttribute("yeabook", service.yeabook());
		m.addAttribute("unbook", service.unbook());
		m.addAttribute("munbook", service.munbook());
		m.addAttribute("yeokbook", service.yeokbook());
		return "/admin/home";
	}
}
