package com.lib.ho;


import java.security.SecureRandom;
import java.util.Base64;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.lib.dto.UserDto;
import com.lib.ho.dao.UserDao;
import com.lib.ho.service.EmailService;
import com.lib.ho.service.UserService;

@Controller
public class LoginController {
	
	@Autowired
    UserDao userDao;
	
	@Autowired
    EmailService emailService;
	
	@Autowired
    UserService userService;
	
	@GetMapping("/login")
    public String loginPage() {
        return "login"; // 로그인 페이지의 뷰 이름
    }
	
	//로그인 , admin 1일시 사서 홈, 0일시 유저 홈으로.
	
	@PostMapping("/login")
    public ModelAndView login(@RequestParam("userID") String userID, @RequestParam("userPW") String userPW) {

        List<UserDto> users = userService.getAllUsers();

        for (UserDto user : users) {
            if (user.getUserID().equals(userID) && user.getUserPW().equals(userPW)) {
                boolean admin = user.getAdmin().equals("1");
                if (admin) {
                    return new ModelAndView("/admin/home");
                } else {
                    return new ModelAndView("/user/home");
                }
            }
        }
        return new ModelAndView("login"); 
    }
	
	// 랜덤 문자 생성
    private String generateRandomString(int length) {
        SecureRandom random = new SecureRandom();
        byte[] randomBytes = new byte[length];
        random.nextBytes(randomBytes);
        return Base64.getUrlEncoder().withoutPadding().encodeToString(randomBytes).substring(0, length);
    }
    
    // 랜덤값 만들어서 DB에 저장
    
    @PostMapping("/admin/new")
    public ModelAndView generateCredentials(@RequestParam("email") String email) {
        String userID = generateRandomString(12);
        String userPW = generateRandomString(12);

        UserDto user = new UserDto();
        user.setUserID(userID);
        user.setUserPW(userPW);
        user.setEmail(email);
        user.setName("");
        user.setGender("");
        user.setBirth(new Date());
        user.setPhone("");
        user.setAddress("");
        user.setBan(0);
        user.setPenalty(0);
        user.setState("");
        user.setAdmin("1");

        userDao.insertUser(user);

        // 이메일 발송
        String subject = "새로운 아이디";
        String text = "당신의 아이디 " + userID + "\n당신의 비밀번호 " + userPW;
        emailService.sendSimpleMessage(email, subject, text); 

        return new ModelAndView("/admin/home");
    }
    
}
