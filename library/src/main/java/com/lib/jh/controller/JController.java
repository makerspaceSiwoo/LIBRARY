package com.lib.jh.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.lib.dto.BlackListDto;
import com.lib.dto.BoardDto;
import com.lib.dto.CommDto;
import com.lib.dto.UserDto;
import com.lib.jh.service.BlackListService;
import com.lib.jh.service.BoardService;
import com.lib.jh.service.CommService;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@SessionAttributes("user")
@Controller
public class JController {
	
	// 로그인 기능 생기면 변환하기 
	@ModelAttribute("user")
	   public UserDto getDto() {
	    //  return new userDto();
		UserDto user = new UserDto();
		
		// 임시로 세션 user에ban값 넣음
	    // "2024-08-13" 문자열을 Date로 변환
	    String dateString = "2024-08-12";
	    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	    try {
	        Date banDate = formatter.parse(dateString);
	        user.setBan(banDate); // 변환된 Date 객체를 setBan에 설정
	    } catch (ParseException e) {
	        e.printStackTrace(); // 예외 처리
	    }

	    return user;
	   }
	
	//BoardService 주입
	@Autowired
	BoardService boardservice;
	
	//CommService 주입
	@Autowired
	CommService commservice;
	
	@Autowired
    BlackListService blacklistService;
// 사용 안하는중 ===================================================================================
//	//게시글 리스트 (페이징) 별로면 수업때 썻던 코드 가지고 오기.
//	@GetMapping("/board/list")
//	public String boardList(Model m, @RequestParam(value="p", defaultValue = "1") int page) {
//	    int size = 10; // 한 페이지에 보여줄 게시글 수
//	    List<BoardDto> result1 = boardservice.selectPage(page, size);
//	    int totalCount = boardservice.selectTotalCount();
//	    int totalPages = (int) Math.ceil(((double)totalCount) / size);
//
//	    m.addAttribute("blist", result1);
//	    m.addAttribute("currentPage", page);
//	    m.addAttribute("totalPages", totalPages);
//
//	    return "ha_board/boardlist";
//	}
// 사용 안하는중 ===================================================================================
	
	//게시글 상세보기(내용) 보기 기능
	@GetMapping("/board/no/{boardno}")
	public String boardContent(@PathVariable("boardno") int boardno, Model m,HttpServletRequest request, HttpServletResponse response) {
		
		// 쿠키에서 조회 기록 가져오기
	    Cookie[] cookies = request.getCookies();
	    String cookieName = "viewedBoard_" + boardno;
	    Long lastViewedTime = null;

	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            if (cookieName.equals(cookie.getName())) {
	                lastViewedTime = Long.parseLong(cookie.getValue());
	                break;
	            }
	        }
	    }

	    // 현재 시간
	    long currentTime = System.currentTimeMillis();

	    // 1시간 동안 조회수 중복 증가 방지 (시간 단위: milliseconds)
	    long timeLimit = 60 * 60 * 1000;

	    if (lastViewedTime == null || (currentTime - lastViewedTime) > timeLimit) {
	        // 조회수 증가
	        boardservice.incrementViewCount(boardno);
	        // 쿠키에 현재 조회 시간 저장
	        Cookie newCookie = new Cookie(cookieName, String.valueOf(currentTime));
	        newCookie.setMaxAge(60 * 60); // 1시간 동안 유지
	        response.addCookie(newCookie);
	    }
		
		//게시글 정보 가져오기
		BoardDto result2 = boardservice.selectOne(boardno);
		m.addAttribute("bcontent",result2);
	    
		// 댓글 리스트 가져오기
		List<CommDto> result3= commservice.selectComm(boardno); //게시글별 댓글 리스트 가져오기
		m.addAttribute("commList",result3);
		
		//게시글 유저 아이디 가져오기
		String BoardUserId = boardservice.userIdGet(result2.getUserno());
		m.addAttribute("userId",BoardUserId);
		
		
	
		
		return "ha_board/boardcontent";
	}
	
	
	// 게시판 글 작성 기능
	
	//( 게시글작성 페이지가기 ) 
	@GetMapping("board/write")
	public String boardWrite(@ModelAttribute("user") UserDto user, Model m) {
		  // user.ban값 있으면 게시글작성 접근금지 
		if(user.getBan()==null) {
        	return "ha_board/boardwrite";
        }
		else if (user.getBan().after(new Date())) { // BAN날짜가 오늘 날짜보다 값이 많으면 벤당한것
            // 권한이 없는 경우, 접근 불가 메시지와 함께 다른 페이지로 리다이렉트
            m.addAttribute("errorMessage", "너 벤당함");
            return "ha_board/errorpage"; // 403 접근 금지 페이지로 리다이렉트
        }
        else {
        	return "ha_board/boardwrite";
        }
		
	}
	
	//( 게시글작성 후 실제업로드 )
	@PostMapping("/board/write")
	public String boardWriteS(BoardDto dto) {
		boardservice.insert(dto);
		return "redirect:/board/list";
	}
	// ----------------------------------------
	
	
	// 게시글 수정 기능 
	
	// ( 게시글 수정 페이지로 가기 ) 
	@GetMapping("/board/mod/{boardno}")
	public String boardUpdate(@PathVariable("boardno")int boardno,Model m) {
		BoardDto result3 = boardservice.selectOne(boardno);
		m.addAttribute("boardcontent",result3);
		return "ha_board/boardupdate";
		
	}
	
	//( 게시글 수정후 실제 업로드 ) 
	@PostMapping("/board/mod/complete")
	public String boardUpdateS(BoardDto dto) {
		boardservice.update(dto);
		return "redirect:/board/list";
	}
	// ----------------------------------------
	
	//게시글 삭제 기능
	
	@GetMapping("/board/delete/{boardno}")
	public String boardDeleteS(@PathVariable("boardno")int boardno,Model m,@ModelAttribute("user") UserDto user) {
		boardservice.delete(user.getUserno(),boardno);
		return "redirect:/board/list"	;
	}
	
	// 게시글 검색(페이징기능)
	@GetMapping("/board/search")
	public String boardSearch(
	    @RequestParam(value="type", required=false) String type,
	    @RequestParam(value="title", required=false) String title,
	    @RequestParam(value="p", defaultValue = "1") int page, // 페이지 파라미터 추가
	    @RequestParam(value="size", defaultValue = "10") int size, // 한 페이지에 보여줄 게시글 수 (기본값)
	    Model m) {

	    List<BoardDto> searchResults;
	    int totalCount;

	    // 검색 조건이 없을 경우 전체 게시글 가져오기
	    if (type == null && title == null || (type.isEmpty() && title.isEmpty())) {
	        searchResults = boardservice.selectPage(page, size);
	        totalCount = boardservice.selectTotalCount();
	    } else {
	        // 검색 조건이 있을 때 검색 결과 가져오기
	        int offset = (page - 1) * size; // 페이징을 위한 오프셋 계산
	        searchResults = boardservice.BoardSearch(type, title, offset, size);
	        totalCount = boardservice.getSearchTotalCount(type, title);
	    }

	    m.addAttribute("searchResults", searchResults);
	    m.addAttribute("type", type);
	    m.addAttribute("title", title);

	    // 총 페이지 수 계산
	    int totalPages = (int) Math.ceil((double) totalCount / size);
	    m.addAttribute("currentPage", page);
	    m.addAttribute("totalPages", totalPages);

	    return "ha_board/boardsearch"; // JSP 파일로 이동
	}
	
	// 댓글 작성 기능
	@PostMapping("/comm/write")
	public String commWrite(CommDto dto,@ModelAttribute("user") UserDto user, Model m) {
		 // user.ban값 있으면 댓글 작성 금지
		if(user.getBan()==null) {
			commservice.insertComm(dto);
			return "redirect:/board/no/" + dto.getBoardno();
        }
		else if (user.getBan().after(new Date())) {
            // 권한이 없는 경우, 접근 불가 메시지와 함께 다른 페이지로 리다이렉트
            m.addAttribute("errorMessage", "너 벤당함");
            return "ha_board/errorpage"; // 403 접근 금지 페이지로 리다이렉트
        }
        else {
        	commservice.insertComm(dto);
        	return "redirect:/board/no/" + dto.getBoardno();
        }
		
	}
	
	//댓글 삭제
	@PostMapping("/comm/delete/{boardno}/{commno}")
	public String commDelete(@PathVariable("boardno")int boardno,@PathVariable("commno")int commno,@ModelAttribute("user") UserDto user) {
		commservice.deleteComm(user.getUserno(), commno);
		return  "redirect:/board/no/"+boardno;
		
	}
	
	//댓글 수정
	@PostMapping("/comm/update")
	public String commUpdate(@RequestParam("boardno")int boardno,@RequestParam(value="contents")String contents,@RequestParam(value="commno")int commno,@ModelAttribute("user") UserDto user) {
		commservice.updateComm(contents, commno, user.getUserno());
		return  "redirect:/board/no/"+boardno;
	}
	
	// --------------------------------------------신고기능-----------------------------------------------------------------
	
	// 게시글 신고 처리
    @PostMapping("/board/report/{boardno}")
    public String reportBoard(@PathVariable("boardno") int boardno, BlackListDto blacklistDto) {
        // 블랙리스트에 신고 내역 추가
        blacklistDto.setBoardno(boardno);
        blacklistService.reportBoard(blacklistDto);
        
       
        
        return "redirect:/board/no/" + boardno; // 신고 후 해당 게시글로 리다이렉트
    }
	
    // 댓글 신고 처리
    @PostMapping("/comm/report/{commno}")
    public String reportComm(@PathVariable("commno") int commno,@RequestParam("boardno")int boardno, BlackListDto blacklistDto) {
        // 블랙리스트에 신고 내역 추가
        blacklistDto.setCommno(commno);
        blacklistDto.setBoardno(boardno);
        blacklistService.reportComm(blacklistDto);
     

        return "redirect:/board/no/" + boardno; // 신고 후 해당 게시글로 리다이렉트
    }
	
    @GetMapping("/comm/test123")
    public void asd() {
    	blacklistService.updateBlacklistUserBanNull();
    }
	
}
