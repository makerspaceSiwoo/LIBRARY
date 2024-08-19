package com.lib.ho;


import java.security.SecureRandom;
import java.util.Base64;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.lib.dto.UserDto;
import com.lib.ho.service.EmailService;
import com.lib.ho.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
@SessionAttributes("user")
public class AdminModController {

	 @Autowired
	 private UserService userService;
	 
	 @Autowired
	 private EmailService emailService;
	 
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
	 
	 @PostMapping("/admin/mod/info")
	    public String editUser(@SessionAttribute("user") UserDto sessionUser,
	                           @RequestParam("userID") String userID,
	                           @RequestParam("userPW") String userPW,
	                           @RequestParam("name") String name,
	                           @RequestParam("birth") @DateTimeFormat(pattern = "yyyy-MM-dd") Date birth,
	                           @RequestParam("phone") String phone,
	                           @RequestParam("email") String email,
	                           @RequestParam("address") String address,
	                           @RequestParam("verificationCode") String verificationCode,
	                           HttpSession session,
	                           Model model) {
		 
		 	// RedirectAttributes redirectAttributes
		 
	        if (!sessionUser.getUserID().equals(userID) && userService.existsByUserID(userID)) {
	            model.addAttribute("error", "이미 사용 중인 ID입니다.");
	            return "/ho_mod/adminmodinfo";
	        }

	        String sessionVerificationCode = (String) session.getAttribute("verificationCode");
	        if (sessionVerificationCode == null || !sessionVerificationCode.equals(verificationCode)) {
	            model.addAttribute("error", "인증 코드가 일치하지 않습니다.");
	            return "/ho_mod/adminmodinfo";
	        }

	        sessionUser.setUserID(userID);
	        sessionUser.setUserPW(userPW);
	        sessionUser.setName(name);
	        sessionUser.setBirth(birth);
	        sessionUser.setPhone(phone);
	        sessionUser.setEmail(email);
	        sessionUser.setAddress(address);

	        userService.updateUser(sessionUser);
	        session.setAttribute("user", sessionUser);
	        
	        // redirectAttributes.addFlashAttribute("successMessage", "수정이 완료되었습니다.");

	        return "redirect:/home";  // 수정 완료 후 리다이렉트
	    }

	    @PostMapping("/send/code2")
	    @ResponseBody
	    public String sendVerificationCode(@RequestParam("email") String email, HttpSession session) {
	        String verificationCode = generateVerificationCode();
	        
	        String subject = "인증 코드";
	        String text = "인증 코드는 " + verificationCode + "입니다.";
	        emailService.sendSimpleMessage(email, subject, text);

	        session.setAttribute("verificationCode", verificationCode);
	        
	        return verificationCode;
	    }

	    private String generateVerificationCode() {
	        SecureRandom random = new SecureRandom();
	        byte[] randomBytes = new byte[6];
	        random.nextBytes(randomBytes);
	        return Base64.getUrlEncoder().withoutPadding().encodeToString(randomBytes);
	    }
	    
	    @PostMapping("/checkUserID")
	    @ResponseBody
	    public String checkUserID(@RequestParam("userID") String userID) {
	        if (userService.existsByUserID(userID)) {
	            return "이미 사용 중";
	        } else {
	            return "사용 가능";
	        }
	    }
	}