package com.lib.controller;

import java.util.Arrays;
import java.util.List;

import org.springframework.web.servlet.HandlerInterceptor;

import com.lib.dto.UserDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class LoginIntercepter implements HandlerInterceptor {

	public List<String> loginEssential = Arrays.asList("/board/**", "/comm/**"); // board의 모든 하위 파일 (,찍고 다른 파일도 추가할 수 있음)
	
	public List<String> loginInessential = Arrays.asList("/board/list/**","/board/content/**","/board/search/**"); // **은 글 번호가 바뀌어도 받을 수 있게

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		UserDto dto = (UserDto) request.getSession().getAttribute("user"); // user라는 이름의 세션 어트리뷰트 - 로그인 정보
	
		String url = request.getRequestURI(); // 해당 url 권한 확인
//		if (dto != null && dto.getUserID() != null) { // 요청 처리 순서 묻기
//			return true;
//		} else {
//			response.sendRedirect("/login");
//			return false;
//		}
		if(dto != null && dto.getUserID() != null) {// 일단 로그인 되어있는지.
			if(dto.getAdmin().equals("0")) { // user
				// url이 user로 시작하는지 -> 맞다면 true 아니면 잘못된 접근 페이지, false
			}else { // admin
				// admin
			}
		}
		return false;
	}
}
