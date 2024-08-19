package com.lib.ho;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lib.ho.service.UserService;

@Controller
public class FindController {
	
	@Autowired
	UserService userservice;
	
	@GetMapping("/find/search/id")
	public String findId() {
		return "/ho_find/findid";
	}
	
	@GetMapping("/find/id")
    public String findUserId(@RequestParam("email") String email, Model model) {
        try {
            String userId = userservice.findUserIdByEmail(email);
            model.addAttribute("message", "해당 이메일의 사용자 ID: " + userId);
        } catch (IllegalArgumentException e) {
            model.addAttribute("message", "오류: " + e.getMessage());
        }
        return "/ho_find/findid";
    }
	
	@GetMapping("/find/search/pw")
	public String findPw() {
		return "/ho_find/findpw";
	}

}
