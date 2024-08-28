package com.lib.jh.controller;

import java.util.Calendar;
import java.util.Date;
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
			return new UserDto();
			
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
	        if (!user.getAdmin().equals("1")) {
	            // 권한이 없는 경우, 접근 불가 메시지와 함께 다른 페이지로 리다이렉트
	            model.addAttribute("errorMessage", "접근 권한이 없습니다.");
	            return "ha_board/errorpage(admin)"; // 403 접근 금지 페이지로 리다이렉트
	        }
	        
	        List<BlackListDto> blacklistdto = blacklistService.BlackListAll();
	        model.addAttribute("blacklistdto",blacklistdto);
	        

	        // 권한이 있는 경우, 관리자 페이지로 이동
	        return "ha_board/adminblacklist";
	    }
	    
	    
		// Admin이 adminblacklist.jsp 에서 벤을 클릭하면 db에 board 와 comm이 sate가 blind로 바뀜, comm board의 state가 blind면 null로 null이나 그외면 blind로 바꿈
	    @PostMapping("/admin/ban")
	    public String adminBan(@RequestParam(value = "boardno", required = false) Integer boardno,@RequestParam(value = "commno", required = false) Integer commno) {
	    	if(commno == 0) {
	    		blacklistService.boardStateReport(boardno);
		    	

	    	}
	    	if(commno != 0) {
	    		blacklistService.commStateReport(commno);
	    	}
	    	
	    	return "redirect:/admin/blacklist";
	    }
		
	    // admin이 blind할 대상이 아니면 블랙리스트 에서 삭제
	    @PostMapping("/admin/ban/delete")
	    public String adminBanDelte(@RequestParam("blacklistno")int blacklistno) {
	    	blacklistService.deleteBlackList(blacklistno);
	    	
	    	return "redirect:/admin/blacklist";
	    }
	    
	    // 사서가 블랙리스트 테이블의 forbid_end 를 설정과 동시에 user.ban으로 값을 전달한다, 블랙리스트 테이블은 insert가 될때 boardno를 확인하여 이미 있으면 insert안함
	    //user.ban에 현재시간 + 3일 값을 넘긴다 //기존 벤이 있으면 user.ban시간 + 3일값을 넘긴다.
	    @PostMapping("/admin/ban/forbid_end")
	    public String adminBanForbid_end(@RequestParam("blacklistno")int blacklistno,@RequestParam("userno") int userno, 
	    		@RequestParam("boardno") int boardno,@RequestParam("deadline")String deadline,@RequestParam("forbid_end")String forbidend) {
	    	 // 현재 날짜를 Date 객체로 가져옴
	        Date currentDate = new Date();
	        // Calendar 인스턴스 생성 및 현재 날짜 설정
	        Calendar calendar = Calendar.getInstance();
	        calendar.setTime(currentDate);
	        	 	       
	        if(deadline.equals("+3")) {
	        	// 3일 더하기
		        calendar.add(Calendar.DAY_OF_MONTH, 3);
		        // 변경된 날짜를 Date 객체로 가져옴
		        Date forbid_end = calendar.getTime();
		        penaltyService.updateUserBanStatusPlus(userno, boardno, forbid_end,blacklistno); // 블랙리스트 테이블의 forbid_end 업데이트 함과 동시에 user.Ban업데이트
	        }else {
	        	// 3일 뺴기
		        calendar.add(Calendar.DAY_OF_MONTH, -3);
		        // 변경된 날짜를 Date 객체로 가져옴
		        Date forbid_end = calendar.getTime();
		        penaltyService.updateUserBanStatusMinus(userno, boardno, forbid_end,blacklistno); // 블랙리스트 테이블의 forbid_end 업데이트 함과 동시에 user.Ban업데이트

	        }

	    	return "redirect:/admin/blacklist";
	    }
	    

	   
	   
	 
		
	    

	    // 패널티 업데이트 수동 호출 (테스트 용도)
	    @GetMapping("/Penalty")
	    public String updatePenalty() {
	        penaltyService.updatePenaltyAndUserStatus();
	        blacklistService.updateBlacklistForbid_endDelete();//자동으로 forbid_end 기간이 현재 날짜값 지나면 blacklist에서 삭제
	        blacklistService.updateBlacklistUserBanNull();//자동으로 user.ban 기간이 현재 날짜 값지나면 ban null로꿈
	       
	        return "패널티 업데이트가 완료되었습니다.";
	    }
	    
		
	  
	
}
