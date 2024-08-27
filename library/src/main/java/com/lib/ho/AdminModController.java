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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	 
	 // 수정 페이지로 이동
	 @GetMapping("/user/mod")
	    public String editProfile(@ModelAttribute("user") UserDto user, Model model) {
		 
	        model.addAttribute("user", user);
	        return "/ho_mod/adminmodinfo";
	    } 
	 
	 @PostMapping("/user/mod/info")
	 public String editUser(@SessionAttribute("user") UserDto sessionUser,
	                        @RequestParam(value = "userID", required = false) String userID,
	                        @RequestParam(value = "userPW", required = false) String userPW,
	                        @RequestParam(value = "name", required = false) String name,
	                        @RequestParam(value = "birth", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date birth,
	                        @RequestParam(value = "phone", required = false) String phone,
	                        @RequestParam(value = "email", required = false) String email,
	                        @RequestParam(value = "address", required = false) String address,
	                        @RequestParam(value = "verificationCode", required = false) String verificationCode,
	                        HttpSession session, Model model, RedirectAttributes redirectAttributes) {

	     // 아이디 변경 시 중복 체크
	     if (userID != null && !userID.equals(sessionUser.getUserID()) && userService.existsByUserID(userID)) {
	         model.addAttribute("error", "이미 사용 중인 ID입니다.");
	         return "/ho_mod/adminmodinfo";
	     }

	     // 이메일 변경 시 인증 코드 확인
	     if (email != null && !email.equals(sessionUser.getEmail())) {
	         String sessionVerificationCode = (String) session.getAttribute("verificationCode");
	         if (!verificationCode.equals(sessionVerificationCode)) {
	             model.addAttribute("error", "인증 코드가 일치하지 않습니다.");
	             return "/ho_mod/adminmodinfo";
	         }
	     }

	     // 사용자 정보 업데이트
	     updateUserInfo(sessionUser, userID, userPW, name, birth, phone, email, address);

	     userService.updateUser(sessionUser);
	     session.setAttribute("user", sessionUser);
	     
	     redirectAttributes.addFlashAttribute("message", "회원정보 수정이 완료되었습니다.");

	     return "redirect:/home";  // 수정 완료 후 리다이렉트
	 }

	 private void updateUserInfo(UserDto sessionUser, String userID, String userPW, String name, Date birth, String phone, String email, String address) {
	     if (userID != null) sessionUser.setUserID(userID);
	     if (userPW != null && !userPW.isEmpty()) sessionUser.setUserPW(userPW);
	     if (name != null) sessionUser.setName(name);
	     if (birth != null) sessionUser.setBirth(birth);
	     if (phone != null) sessionUser.setPhone(phone);
	     if (email != null) sessionUser.setEmail(email);
	     if (address != null) sessionUser.setAddress(address);
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