package com.lib.ho;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.lib.dto.UserDto;
import com.lib.ho.dto.UnretDto;
import com.lib.ho.service.UserService;
import com.lib.mo.dto.RecommDto;
import com.lib.mo.service.RecommService;

@SessionAttributes("user")
@Controller
public class MypageController {
	
	@Autowired
	 private UserService userService;
	
	@Autowired
	RecommService service;
	
	// 세션
	@ModelAttribute("user")
	public UserDto getDto() {
	return new UserDto();
	}
	
	@GetMapping("/mypage")
	public String unret(@ModelAttribute("user") UserDto user, Model m) {
		
		List<UnretDto> unretbook = userService.unret(user.getUserno());
		m.addAttribute("unretbook",unretbook);
		
		List<UnretDto> recode = userService.record(user.getUserno());
		m.addAttribute("recode", recode);
		return "/ho_find/mypage";
		
	}
	
	@GetMapping("/admin/mypage")
	public String adminmy(@ModelAttribute("user") UserDto user, Model m) {
		
		List<RecommDto> allrcbook = service.allrcbook();
		m.addAttribute("allrc", allrcbook);
		
		return "ho_find/adminmypage";
	}
	
	

}
