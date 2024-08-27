package com.lib.pjh.controller;


import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lib.dto.BookDto;
import com.lib.dto.BorrowDto;
import com.lib.dto.UnreturnDto;
import com.lib.dto.UserDto;
import com.lib.pjh.service.BookService;

@Controller
public class BookController {

	@Autowired
	BookService bookservice;
	
	@GetMapping("/book/borrow")
	public String manage() {
		return "parkjae/book/borrow";
	} //기본페이지
	
	@GetMapping("/book/record")
	public String borrowbook(@RequestParam(name="booktitle", defaultValue="")String booktitle,@RequestParam(name="page", defaultValue="1")int page,@RequestParam(name="size", defaultValue="10")int size, Model m){
	    
	    	if (page < 1) {page = 1;}// 페이지 값이 1보다 작을 경우 1로 설정
			int totalItems = bookservice.countBooks(booktitle); // 전체 항목 수 계산
			if(totalItems ==0) {
				m.addAttribute("count", 0);
				m.addAttribute("booktitle", booktitle);
				return "parkjae/book/borrow";
			}
			int totalPages = (int) Math.ceil((double) totalItems / size); // 총 페이지 수 계산
			
			if (page > totalPages) {page = totalPages;}// 만약 총 페이지 수보다 현재 페이지가 클 경우, 마지막 페이지로 설정
			int offset = (page - 1) * size;
			
			List<BorrowDto> borrowbook = bookservice.borrowbook(booktitle,size,offset);// 검색 및 현재 페이지 범위 계산
			int currentBlock = (int) Math.ceil((double) page / 5);  // 현재 페이지가 속한 5개 페이지 블록
		    int startPage = (currentBlock - 1) * 5 + 1;
		    int endPage = Math.min(currentBlock * 5, totalPages);
	    	m.addAttribute("unreturned", borrowbook);
	    	m.addAttribute("now", new Date());
	    	m.addAttribute("currentPage", page);
	    	m.addAttribute("pageSize", size);
	    	m.addAttribute("totalPages", totalPages);
	    	m.addAttribute("startPage", startPage);
	    	m.addAttribute("endPage", endPage);
	
	    	
		return "parkjae/book/borrow";
	}//검색 컨트롤러
	
	@GetMapping("/book/return")
	public String returnbook(@RequestParam("userno") int userno,@RequestParam("bookno") int bookno) {
		bookservice.borrowno(bookno,userno);
		bookservice.delete(bookno);
		return "redirect:/book/record";
	}//반납 컨트롤러
	
	@GetMapping("/book/latereturn")
	public String latereturnbook(@RequestParam("userno") int userno,@RequestParam("formattedDate") @DateTimeFormat(pattern = "yyyy-MM-dd") Date u_end,@RequestParam("bookno") int bookno, Model m) {
		bookservice.penalty(userno);
		bookservice.borrowno(bookno,userno);
		bookservice.delete(bookno);
		return "redirect:/book/record";
	}//연체반납 컨트롤러
	
	
	@GetMapping("/book/lent")
	public String lentbook(@RequestParam("bookno") int bookno, @RequestParam("booktitle") String booktitle, Model m) {
		
		m.addAttribute("bookno", bookno);
		m.addAttribute("booktitle", booktitle);
		
		return "parkjae/book/lent";
	}// 대출버튼 클릭시 유저아이디 입력페이지로 이동
	
	
	@PostMapping("/book/lent")//유저아이디 입력 페이지
	public String lent(@RequestParam("bookno") int bookno,
			@RequestParam("userID") String userID, 
			@RequestParam("booktitle") String booktitle,
			Model m) {
		int prohibit = bookservice.loan(userID);
		int countbook = bookservice.treebook(userID);
		
		if(prohibit == 1) {
			m.addAttribute("errorMessage","해당 유저는 대출 금지되었습니다. 사유 : 연체자");
			m.addAttribute("bookno", bookno);
			m.addAttribute("booktitle", booktitle);
			return "parkjae/book/lent";
		}//패널티보유시 대출금지 오류메세지 화면에 출력
		
		if (countbook >= 3) {
	        m.addAttribute("errorMessage", "해당 유저는 이미 3권 이상의 책을 대출  중입니다.");
	        m.addAttribute("bookno", bookno);
			m.addAttribute("booktitle", booktitle);
	        return "parkjae/book/lent"; 
	    }// 같은 페이지로 돌아가서 에러 메시지를 표시
		
		if(userID == null) {
			m.addAttribute("errorMessage", "등록된 유저가 아닙니다. 다시확인해주세요.");
			m.addAttribute("bookno", bookno);
			m.addAttribute("booktitle", booktitle);
			return "parkjae/book/lent";
		}//등록된 유저가 아닐시 오류메세지 화면에 출력 
		
		try {
			bookservice.bookno(bookno, userID); // 대출시 record 테이블등록
			bookservice.unreturn(bookno, userID); // 대출 unreturned 테이블등록
		} catch (Exception e) {
			m.addAttribute("errorMessage","해당 ID의 유저가 존재하지 않습니다.");
			m.addAttribute("bookno", bookno);
			m.addAttribute("booktitle", booktitle);
			return "parkjae/book/lent";
		}//유저ID가 존재하지않을떄 예외처리(오류메세지 화면에 출력)
		
		m.addAttribute("bookno", bookno);
		m.addAttribute("booktitle", booktitle);
		return "redirect:/book/record";
	    }// lent.jsp에서 유저번호 입력시 기존페이지로 이동
	


	
	
	
	
	
	

	
}
  