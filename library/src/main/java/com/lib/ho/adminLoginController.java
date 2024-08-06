package com.lib.ho;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

import com.lib.ho.service.UserService;

@Controller
public class adminLoginController {
	
	@Autowired
    private UserService userService;
	
	@PostMapping("/login")
	public String login() {
		return "/login/login";
	}
	
}
