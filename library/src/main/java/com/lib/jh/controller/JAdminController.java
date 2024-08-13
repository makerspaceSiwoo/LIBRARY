package com.lib.jh.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.lib.dto.BlackListDto;
import com.lib.dto.UserDto;
import com.lib.jh.service.BlackListService;
import com.lib.jh.service.BoardService;
import com.lib.jh.service.CommService;
import com.lib.jh.service.PenaltyService;

@SessionAttributes("user")
@Controller
public class JAdminController {

	// 로그인 기능 생기면 변환하기 
		@ModelAttribute("user")
		   public UserDto getDto() {
		    //  return new userDto();
			UserDto user = new UserDto();
			user.setUserno(1);
			user.setAdmin("1");
			return user;
		   }
		
		
		//BoardService 주입
		@Autowired
		BoardService boardservice;
		
		//CommService 주입
		@Autowired
		CommService commservice;
		//BlackListService 주입
		@Autowired
	    BlackListService blacklistService;
		
		//PenaltyService 주입 ( 테스트 용도 ) 
		 @Autowired
		PenaltyService penaltyService;
		    
		    
		
		  // Admin 페이지 접근 권한 체크
	    @GetMapping("/admin/blacklist")
	    public String adminBlackList(@ModelAttribute("user") UserDto user, Model model) {
	        // 관리자 권한 체크
	        if (user.getAdmin() != "1") {
	            // 권한이 없는 경우, 접근 불가 메시지와 함께 다른 페이지로 리다이렉트
	            model.addAttribute("errorMessage", "접근 권한이 없습니다.");
	            return "ha_board/errorpage"; // 403 접근 금지 페이지로 리다이렉트
	        }
	        
	        List<BlackListDto> blacklistdto = blacklistService.BlackListAll();
	        model.addAttribute("blacklistdto",blacklistdto);
	        

	        // 권한이 있는 경우, 관리자 페이지로 이동
	        return "ha_board/adminblacklist";
	    }
	    
	    
		// Admin이 adminblacklist.jsp 에서 벤을 클릭하면 db에 board 와 comm이 sate가 blind로 바뀜
	    @PostMapping("/admin/ban")
	    public String adminBan(@RequestParam("boardno") int boardno,@RequestParam("commno") int commno) {
	    	blacklistService.boardStateReport(boardno);
	    	blacklistService.commStateReport(commno);
	    	
	    	return "redirect:/admin/blacklist";
	    }
		
	    // admin이 blind할 대상이 아니면 블랙리스트 에서 삭제
	    @PostMapping("/admin/ban/delete")
	    public String adminBanDelte(@RequestParam("blacklistno")int blacklistno) {
	    	blacklistService.deleteBlackList(blacklistno);
	    	
	    	return "redirect:/admin/blacklist";
	    }
	    
	    // admin이 블랙리스트 테이블의 forbid_end 설정 
	    @PostMapping("/admin/ban/forbid_end")
	    public String adminBanForbid_end(@RequestParam("blacklistno")int blacklistno) {
	    	blacklistService.updateBlacklistForbit_end(blacklistno);
	    	
	    	return "redirect:/admin/blacklist";
	    }
	    
	   
	   
	    @GetMapping("/admin/ban/userban")
	    public void adminBanUserban() {
	    	
	    	
	    }
		
	    
	    // 패널티 업데이트 수동 호출 (테스트 용도)
	    @GetMapping("/Penalty")
	    public String updatePenalty() {
	        penaltyService.updatePenaltyAndUserStatus();
	       
	        return "패널티 업데이트가 완료되었습니다.";
	    }
	    
		
	
}
