package com.lib.pjh.controller;

import com.lib.dto.EmailVo;
import com.lib.dto.UserDto;
import com.lib.pjh.service.CodeGenerator;
import com.lib.pjh.service.JoinService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

@SessionAttributes("user")
@Controller
public class JoinController {

	@Autowired
	private JoinService joinService;
	//회원가입 서비스 호출

	@Autowired
	public JoinController(JoinService joinService) {
		this.joinService = joinService;
	}

	@GetMapping("/join")
	public String joinform() {
		return "parkjae/join";
	}
	
	@PostMapping("/checkID")
    @ResponseBody
    public String checkUserID(@RequestParam("userID") String userID) {
        boolean isAvailable = joinService.isUserIDAvailable(userID);
        return isAvailable ? "1" : "0"; // 1: 사용 가능, 0: 사용 불가
    }
	

	@PostMapping("/user/register")
	public String registerUser(@ModelAttribute UserDto user, @RequestParam("year") String year,
			@RequestParam("month") String month, @RequestParam("day") String day,
			@RequestParam("email_user") String emailUser, @RequestParam("email_domain") String emailDomain) {

		// 생년월일을 YYYY-MM-DD 형식으로 조합
		String birth = year + "-" + month + "-" + day;

		// 이메일 조합
		String email = emailUser + "@" + emailDomain;

		// UserDto 객체 생성 및 값 설정
		user.setBirth(java.sql.Date.valueOf(birth)); // String을 Date로 변환
		user.setEmail(email);

		// 추가 정보 설정 (예: admin, ban, penalty, state)
		user.setAdmin("0"); // 기본값
		user.setBan(null);
		user.setPenalty(0);
		user.setState("active"); // 기본 상태

		// 사용자 정보 저장
		joinService.registerUser(user);

		return "redirect:/login";
	}

	@RequestMapping("/send")
	@ResponseBody
	public String[] sendMail(@RequestParam("emailAddress") String emailAddress) throws Exception {
		EmailVo email = new EmailVo();
		String receiver = emailAddress;
		String subject = "Email 제목";
		String number = CodeGenerator.generateCode(6);
		String content = "인증번호는" + number + "입니다.";

		email.setReceiver(receiver);
		email.setSubject(subject);
		email.setContent(content);

		Boolean result = joinService.sendMail(email);

		return new String[] { number, result.toString() };

	}

}
