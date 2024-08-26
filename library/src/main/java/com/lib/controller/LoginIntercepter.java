package com.lib.controller;

import java.util.Arrays;
import java.util.List;

import org.springframework.web.servlet.HandlerInterceptor;

import com.lib.dto.UserDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class LoginIntercepter implements HandlerInterceptor {

	public List<String> loginEssential = Arrays.asList("/recomm/**", "/book/**","/user/**",
														"/admin/**","/send/code2",
														"/board/**","/comm/**","/mypage"); // board의 모든 하위 파일 (,찍고 다른 파일도 추가할 수 있음) 로그인이 필요한 항목
	
	public List<String> loginInessential = Arrays.asList("/home/**","/join","/checkUserID","/send",
												"/user/register/**","/board/search/**","/board/no/**",
												"/search/**","/login/**","/find/**","/findpwform","pwcode"); // **은 글 번호가 바뀌어도 받을 수 있게 로그인이 필요 없는 항목

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		UserDto dto = (UserDto) request.getSession().getAttribute("user"); // user라는 이름의 세션 어트리뷰트 - 로그인 정보
	
		String url = request.getRequestURI(); // 해당 url 권한 확인
//		if (dto != null && dto.getUserID() != null) { // 요청 처리 순서 묻기 - 일반적인 코드
//			return true;
//		} else {
//			response.sendRedirect("/login");
//			return false;
//		}
		System.out.println(url);
		if(dto != null && dto.getUserID() != null) {// 일단 로그인 되어있는지.
			if(dto.getState() !=null && dto.getState().equals("탈퇴")) {
				response.sendRedirect("/join"); // join 페이지에 alert 로 탈퇴한 계정입니다 한 번 띄우기
				return false;
			}else if(dto.getAdmin().equals("1")) { // admin
				// admin
//				System.out.println("admin");
//				System.out.println(url);
				return true;
			}else { // user
				// url이 user로 시작하는지 -> 맞다면 true 아니면 잘못된 접근 페이지, false
//				System.out.println("normal");
//				System.out.println(url);
				if(url.startsWith("/book/")||url.startsWith("/admin/")) {
					response.sendRedirect("/restrict");
					return false;
				}
				return true;
			}
		}else {
			response.sendRedirect("/loginfirst"); // alert 추가하면 좋겠다
			return false;
		}
	}
}
