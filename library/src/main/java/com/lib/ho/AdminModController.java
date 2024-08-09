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
	 
	 @GetMapping("/rerere44")
	 public String reda() {
		 return "/test12345/test2930194";
	 }
	 
	 // 수정 페이지로 이동
	 @GetMapping("/admin/mod/info")
	    public String editProfile(@ModelAttribute("user") UserDto user, Model model) {
		 
	        model.addAttribute("user", user);
	        return "/ho_mod/adminmodinfo";
	    } 
	 
	 // 정보 변경한걸 ID체크해서 업데이트
	 @PostMapping("/admin/id_check")
	 public String updateProfile(@ModelAttribute("user") UserDto user, Model model) {
	     // ID가 중복되는 경우
	     UserDto existingUser = userService.findByUserID(user.getUserID());

	     // ID가 중복되는 경우
	     if (existingUser != null && existingUser.getUserno() != user.getUserno()) {
	         model.addAttribute("errorMessage", "User ID가 이미 존재합니다. 다른 User ID를 선택해 주세요.");
	         model.addAttribute("user", user);
	         return "forward:/admin/mod/info"; // 수정 페이지로 포워드하여 다시 입력받도록 합니다.
	     }
	     
	     // 중복되지 않으면 업데이트
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