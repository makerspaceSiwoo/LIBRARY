package com.lib.pjh.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.lib.dto.UserDto;
import com.lib.pjh.service.JoinService;
import java.util.HashMap;
import java.util.Map;

@RestController
public class JoinController {

    private final JoinService joinService;

    @Autowired
    public JoinController(JoinService joinService) {
        this.joinService = joinService;
    }

    @PostMapping("/checkId")
    @ResponseBody
    public Map<String, String> checkId(@RequestParam("userID") String userID) {
        boolean isDuplicate = joinService.checkUserIdDuplicate(userID);

        Map<String, String> response = new HashMap<>();
        if (isDuplicate) {
            response.put("status", "duplicate");
        } else {
            response.put("status", "available");
        }
        return response;
    }
    @PostMapping("/register")
    @ResponseBody
    public Map<String, String> registerUser(
        @RequestParam("userID") String userID,
        @RequestParam("userPW") String userPW,
        @RequestParam("name") String name,
        @RequestParam("gender") String gender,
        @RequestParam("year") String year,
        @RequestParam("month") String month,
        @RequestParam("day") String day,
        @RequestParam("phone") String phone,
        @RequestParam("email_user") String emailUser,
        @RequestParam("email_domain") String emailDomain,
        @RequestParam("address") String address) {

        // 생년월일을 YYYY-MM-DD 형식으로 조합
        String birthDateString = year + "-" + month + "-" + day;

        // 이메일 조합
        String email = emailUser + "@" + emailDomain;

        // UserDto 객체 생성 및 값 설정
        UserDto user = new UserDto();
        user.setUserID(userID);
        user.setUserPW(userPW);
        user.setName(name);
        user.setGender(gender);
        user.setBirth(java.sql.Date.valueOf(birthDateString)); // String을 Date로 변환
        user.setPhone(Integer.parseInt(phone)); // 문자열을 정수로 변환
        user.setEmail(email);
        user.setAddress(address);
        
        // 추가 정보 설정 (예: admin, ban, penalty, state)
        user.setAdmin("N"); // 기본값
        user.setBan(0);
        user.setPenalty(0);
        user.setState("active"); // 기본 상태

        // 사용자 정보 저장
        joinService.registerUser(user);

        Map<String, String> response = new HashMap<>();
        response.put("status", "success");
        response.put("message", "회원가입이 완료되었습니다.");
        return response;
    }
}