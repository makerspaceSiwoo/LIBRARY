package com.lib.ho;


import java.security.SecureRandom;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.lib.dto.UserDto;
import com.lib.ho.dao.UserDao;
import com.lib.ho.service.EmailService;
import com.lib.ho.service.UserService;

@SessionAttributes("user")
@Controller
public class LoginController {
	
	@Autowired
    UserDao userDao;
	
	@Autowired
    EmailService emailService;
	
	@Autowired
    UserService userService;
	
	@GetMapping("/admin/new/form")
		public String adminnewform(){
			return "/ho_find/adminnew";
	}
	
	// 변경하거나 삭제해야함, 테스트용 매핑
	@GetMapping("/testmod12")
	public String testmod() {
		return "test12345/testmod12";
	}
	
//	// 세션
//	@ModelAttribute("user")
//	    public UserDto getDto() {
//	     return new UserDto();
//	      
//	}
	
	@GetMapping("/login")
    public String loginPage() {
        return "login";
    }
	
	//로그인 , admin 1일시 사서 홈, 0일시 유저 홈으로.
	
	@PostMapping("/login")
	public ModelAndView login(@RequestParam("userID") String userID, 
	                          @RequestParam("userPW") String userPW, 
	                          RedirectAttributes redirectAttributes, 
	                          Model m) {


	    List<UserDto> users = userService.getAllUsers();
	    for (UserDto user : users) {
	        if (user.getUserID().equals(userID) && user.getUserPW().equals(userPW)) {
	            
	            // 계정 상태 확인
	            String state = user.getState();
	            if ("탈퇴".equals(state)) {
	                redirectAttributes.addFlashAttribute("errorMessage", "탈퇴된 계정입니다.");
	                return new ModelAndView("redirect:/login");
	            }

	            // 로그인 성공: 세션에 사용자 정보 저장
	            m.addAttribute("user", user);
	            
//	            boolean admin = user.getAdmin().equals("1");
	            return new ModelAndView("redirect:/home");

	        }
	        
	    }
	    
	    // 아이디 또는 비밀번호가 일치하지 않을 경우
	    redirectAttributes.addFlashAttribute("errorMessage", "아이디 또는 비밀번호가 잘못되었습니다.");
	    return new ModelAndView("redirect:/login");

	}
	
	// 로그아웃
	@PostMapping("/logout")
	public String logout(SessionStatus sessionStatus) {
	    sessionStatus.setComplete();
	    return "redirect:/home";
	}
	// 랜덤 문자 생성
    private String Random(int length) {
        SecureRandom random = new SecureRandom();
        byte[] randomBytes = new byte[length];
        random.nextBytes(randomBytes); 
        return Base64.getUrlEncoder().withoutPadding().encodeToString(randomBytes).substring(0, length);
    }
    
    // 랜덤값 만들어서 사서 아이디 비밀번호 발송
    
    @PostMapping("/admin/new")
    public String generateCredentials(@RequestParam("email") String email, RedirectAttributes redirectAttributes) {
        String userID = Random(12);
        String userPW = Random(12);

        UserDto user = new UserDto();
        user.setUserID(userID);
        user.setUserPW(userPW);
        user.setEmail(email);
        user.setName("");
        user.setGender("");
        
        // 문자열을 Date로 변환
        String birthStr = "1970-01-01"; // 기본값
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Date birthDate = null;
        try {
            birthDate = formatter.parse(birthStr);
        } catch (ParseException e) {
            e.printStackTrace();
            // 오류 처리
        }
        user.setBirth(birthDate); // 변환된 Date 객체 설정
        
        user.setPhone("");
        user.setAddress("");
        user.setBan(null);
        user.setPenalty(0);
        user.setState("");
        user.setAdmin("1");

        userDao.insertUser(user);

        // 사서 아이디 이메일 발송
        String subject = "새로운 아이디";
        String text = "당신의 아이디 " + userID + "\n당신의 비밀번호 " + userPW;
        emailService.sendSimpleMessage(email, subject, text);
        
        redirectAttributes.addFlashAttribute("message", "이메일이 성공적으로 발송되었습니다.");

        return "redirect:/admin/mypage";
    }
    
 // 인증 코드 생성
    private String generateVerificationCode() {
        SecureRandom random = new SecureRandom();
        byte[] randomBytes = new byte[6];
        random.nextBytes(randomBytes);
        return Base64.getUrlEncoder().withoutPadding().encodeToString(randomBytes);
    }

    @PostMapping("/send/code")
    @ResponseBody
    public String sendVerificationCode(@RequestParam("email") String email) {
        String verificationCode = generateVerificationCode();
        
        // 이메일 발송
        String subject = "인증 코드";
        String text = "인증 코드는 " + verificationCode + "입니다.";
        emailService.sendSimpleMessage(email, subject, text);

        // 인증 코드를 클라이언트 측에서 사용할 수 있도록 반환
        return verificationCode;
    }
    
    @PostMapping("/user/del")
    public ModelAndView withdrawUser(@ModelAttribute("user") UserDto user, 
                                     RedirectAttributes redirectAttributes, 
                                     SessionStatus sessionStatus) {
    	
    	System.out.println(user);

        if (user.getUserID() != null) {
            // 사용자 상태를 "탈퇴"로 변경
            userService.withdrawUser(user.getUserID());
            
            // 세션 상태를 완료(무효화)하여 로그아웃 처리
            sessionStatus.setComplete();
            
            redirectAttributes.addFlashAttribute("successMessage", "회원 탈퇴가 완료되었습니다.");
            return new ModelAndView("redirect:/login");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "로그인이 필요합니다.");
            return new ModelAndView("redirect:/login");
        }
    }
    
}
