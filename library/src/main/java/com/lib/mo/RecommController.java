package com.lib.mo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.lib.dto.UserDto;
import com.lib.mo.dto.RecommDto;
import com.lib.mo.service.RecommService;

@SessionAttributes("user")
@Controller
public class RecommController {

	@Autowired
	RecommService service;

	@GetMapping("/recomm")
	public String recomm(Model m, @ModelAttribute("user") UserDto user) {
		
		List<RecommDto> allrcbook = service.allrcbook();
		m.addAttribute("allrcbook", allrcbook);
		
		List<RecommDto> catercbook = service.catercbook(user.getUserno());
		m.addAttribute("catercbook", catercbook);
		
		List<RecommDto> genrcbook = service.genrcbook(user.getGender());
		m.addAttribute("genrcbook", genrcbook);
		
		List<RecommDto> agercbook = service.agercbook(user.getBirth());
		m.addAttribute("agercbook", agercbook);
		
		return "/user/recomm";
	}
}
