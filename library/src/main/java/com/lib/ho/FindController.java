package com.lib.ho;

import java.security.SecureRandom;
import java.util.Base64;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lib.dto.UserDto;
import com.lib.ho.service.EmailService;
import com.lib.ho.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
public class FindController {

	@Autowired
	UserService userservice;

	@Autowired
	private EmailService emailService;

	@GetMapping("/find/search/id")
	public String findId() {
		return "/ho_find/findid";
	}

	@GetMapping("/find/id")
	public String findUserId(@RequestParam("email") String email, Model model) {
		try {
			String userId = userservice.findUserIdByEmail(email);
			model.addAttribute("message", "입력하신 이메일의 아이디는\n" + userId + " 입니다");
		} catch (IllegalArgumentException e) {
			model.addAttribute("message", "오류: " + e.getMessage());
		}
		return "/ho_find/findid";
	}
	
	@GetMapping("/find/search/pw")
	public String findPw() {
		return "/ho_find/findpw";
	}

	@PostMapping("/findpwform")
    public String sendVerificationCode(@RequestParam("userID") String userID,
                                       @RequestParam("email") String email,
                                       HttpSession session,
                                       Model model) {
        // userID와 email이 일치하는지 확인
        UserDto user = userservice.findUserByIdAndEmail(userID, email);
        if (user == null) {
            model.addAttribute("message", "해당 정보로 사용자를 찾을 수 없습니다.");
            return "ho_find/findpw";
        }

        // 인증 코드 생성 및 이메일 발송
        String verificationCode = generateVerificationCode();
        emailService.sendSimpleMessage(email, "인증 코드", "인증 코드는 " + verificationCode + "입니다.");

        // 세션에 인증 코드 및 사용자 ID 저장
        session.setAttribute("verificationCode", verificationCode);
        session.setAttribute("userID", userID);
        session.setAttribute("email", email);

        model.addAttribute("message", "인증 코드가 발송되었습니다. 이메일을 확인하세요.");
        return "ho_find/pwcode";  // 인증 코드 확인 페이지로 이동
    }

    // 인증 코드 생성 메서드
    private String generateVerificationCode() {
        SecureRandom random = new SecureRandom();
        byte[] randomBytes = new byte[6];
        random.nextBytes(randomBytes);
        return Base64.getUrlEncoder().withoutPadding().encodeToString(randomBytes);
    }
    
    @PostMapping("/pwcode")
    public String verifyCode(@RequestParam("verificationCode") String verificationCode,
                             HttpSession session,
                             Model model) {

        // 세션에 저장된 인증 코드 확인
        String sessionVerificationCode = (String) session.getAttribute("verificationCode");
        if (sessionVerificationCode == null || !sessionVerificationCode.equals(verificationCode)) {
            model.addAttribute("message", "인증 코드가 올바르지 않습니다.");
            return "ho_find/pwcode";
        }

        // 인증 성공 -> 비밀번호 변경 페이지로 이동
        return "redirect:/find/pw";
    }
    
    @GetMapping("/find/pw")
    public String showPasswordResetPage() {
        return "ho_find/resetPassword";  // 비밀번호 변경 폼을 보여주는 JSP 또는 HTML 페이지
    }
	    
 // 비밀번호 변경 처리 메서드
    @PostMapping("/find/pw")
    public String resetPassword(@RequestParam("newPassword") String newPassword,
                                HttpSession session,
                                Model model) {

    	String userID = (String) session.getAttribute("userID");
        String email = (String) session.getAttribute("email");

        if (userID == null || email == null) {
            model.addAttribute("message", "잘못된 접근입니다. 다시 시도하세요.");
            return "ho_find/findpw";  // 비밀번호 찾기 페이지로 이동
        }

        // 사용자 정보 가져오기
        UserDto user = userservice.findUserByIdAndEmail(userID, email);
        if (user == null) {
            model.addAttribute("message", "사용자를 찾을 수 없습니다.");
            return "ho_find/resetPassword";  // 비밀번호 변경 폼으로 돌아가기
        }

        // 비밀번호 업데이트
        userservice.updateUserPassword(user.getUserno(), newPassword);
        model.addAttribute("message", "비밀번호가 성공적으로 변경되었습니다.");
        
        session.removeAttribute("userID");
        session.removeAttribute("email");
        session.removeAttribute("verificationCode");

        // 비밀번호 변경 후 로그인 페이지로 리다이렉트
        return "redirect:/login";  // 로그인 페이지로 리다이렉트
    }

}
