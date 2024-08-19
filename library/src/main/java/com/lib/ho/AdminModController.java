package com.lib.ho;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.Formatter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.lib.dto.UserDto;
import com.lib.ho.service.UserService;

@Controller
@SessionAttributes("user")
public class AdminModController {

	 @Autowired
	 private UserService userService;
	 
	 @GetMapping("/mypage")
	 public String mypage() {
		 return "/ho_find/mypage";
	 }
	 
	 // 수정 페이지로 이동
	 @GetMapping("/admin/mod")
	    public String editProfile(@ModelAttribute("user") UserDto user, Model model) {
		 
	        model.addAttribute("user", user);
	        return "/ho_mod/adminmodinfo";
	    } 
	 
	// 정보 업데이트
	 @PostMapping("/admin/mod/info")
	 public String updateProfile(@ModelAttribute("user") UserDto user, Model model) {
		 
	     userService.updateUser(user);
	     return "redirect:/login";
	 }
	 
	 @InitBinder
	    public void initBinder(WebDataBinder binder) {
	        binder.addCustomFormatter(new Formatter<Date>() {
	            private final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

	            @Override
	            public Date parse(String text, Locale locale) throws ParseException {
	                return dateFormat.parse(text);
	            }

	            @Override
	            public String print(Date object, Locale locale) {
	                return dateFormat.format(object);
	            }
	        });
	    }
	
}