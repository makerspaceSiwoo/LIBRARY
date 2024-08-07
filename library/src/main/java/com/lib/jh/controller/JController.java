package com.lib.jh.controller;

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

import com.lib.dto.BoardDto;
import com.lib.dto.UserDto;
import com.lib.jh.service.BoardService;

@SessionAttributes("user")
@Controller
public class JController {
	
	// 로긘 기능 생기면 변환하기 
	@ModelAttribute("user")
	   public UserDto getDto() {
	    //  return new userDto();
		UserDto user = new UserDto();
		user.setUserno(2);
		return user;
	   }
	
	@Autowired
	BoardService boardservice;
	
	//게시글 리스트 (페이징) 별로면 수업때 썻던 코드 가지고 오기.
	@GetMapping("/home1")
	public String boardList(Model m, @RequestParam(value="page", defaultValue = "1") int page) {
	    int size = 10; // 한 페이지에 보여줄 게시글 수
	    List<BoardDto> result1 = boardservice.selectPage(page, size);
	    int totalCount = boardservice.selectTotalCount();
	    int totalPages = (int) Math.ceil(((double)totalCount) / size);

	    m.addAttribute("blist", result1);
	    m.addAttribute("currentPage", page);
	    m.addAttribute("totalPages", totalPages);

	    return "ha_board/boardlist";
	}
	//
	
	//게시글 상세보기(내용) 보기 기능
	@GetMapping("/home2/content/{boardno}")
	public String boardContent(@PathVariable("boardno") int boardno, Model m) {
		BoardDto result2 = boardservice.selectOne(boardno);
		m.addAttribute("bcontent",result2);
		
		return "ha_board/boardcontent";
	}
	
	
	
	// 게시판 글 작성 기능 
	@GetMapping("/home3")
	public String boardWrite() {
		return "ha_board/boardwrite";
	}
	
	@PostMapping("/home3/test")
	public String boardWriteS(BoardDto dto) {
		boardservice.insert(dto);
		return "ha_board/complete";
	}
	// 
	
	
	// 게시글 수정 기능
	@GetMapping("/home4/test/{boardno}")
	public String boardUpdate(@PathVariable("boardno")int boardno,Model m) {
		BoardDto result3 = boardservice.selectOne(boardno);
		m.addAttribute("boardcontent",result3);
		return "ha_board/boardupdate";
	}
	
	@PostMapping("/home4/test")
	public String boardUpdateS(BoardDto dto) {
		boardservice.update(dto);
		return "ha_board/complete";
	}
	
	
	//게시글 삭제 기능!!
	
	@GetMapping("/home5/test/{boardno}")
	public String boardDeleteS(@PathVariable("boardno")int boardno,Model m) {
		BoardDto result4 =boardservice.selectOne(boardno);
		boardservice.delete(result4);
		return "ha_board/complete";
	}
	
	
	
	
	
	
	
	
}
