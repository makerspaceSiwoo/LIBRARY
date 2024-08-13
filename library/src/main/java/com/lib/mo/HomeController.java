package com.lib.mo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.lib.dto.BoardDto;
import com.lib.mo.service.HomeService;

@Controller
public class HomeController {
	
	@Autowired
	HomeService service;
	
	@GetMapping("/home")
	public String homepage(Model m) {
		m.addAttribute("allbook", service.allbook());
		List<BoardDto> notice = service.notice();
		m.addAttribute("notice",notice);
		
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
		return "/user/home";
	}

}
