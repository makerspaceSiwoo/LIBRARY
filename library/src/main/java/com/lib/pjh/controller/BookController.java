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
		int totalPages = (int) Math.ceil((double) totalItems / size); // 총 페이지 수 계산
		
		if (page > totalPages) {page = totalPages;}// 만약 총 페이지 수보다 현재 페이지가 클 경우, 마지막 페이지로 설정
		
		int offset = (page - 1) * size;
		List<BorrowDto> borrowbook = bookservice.borrowbook(booktitle,size,offset);
		// 현재 페이지 범위 계산
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
	public String latereturnbook(@RequestParam("userno") int userno,@RequestParam("formattedDate") @DateTimeFormat(pattern = "yyyy-MM-dd") Date u_end,@RequestParam("bookno") int bookno) {
		bookservice.latereturn(userno, u_end);
		bookservice.penalty(userno);
		bookservice.borrowno(bookno,userno);
		bookservice.delete(bookno);
		return "redirect:/book/record";
	}//연체반납 컨트롤러
	
	
	@GetMapping("/book/lent")
	public String lentbook(@RequestParam("bookno") int bookno, Model m) {
		List<Integer> loan = bookservice.loan();
		m.addAttribute("loan", loan);
		m.addAttribute("bookno", bookno);
		return "parkjae/book/lent";
	}// 대출시 lent.jsp 이동
	
	@PostMapping("/book/lent")
	public String lent(@RequestParam("bookno") int bookno,@RequestParam("userno") int userno) {
		bookservice.bookno(bookno, userno);
		bookservice.unreturn(bookno, userno);
		return "redirect:/book/record";
	}// lent.jsp에서 유저번호 입력시 기존페이지로 이동
	


	
	
	
	
	
	

	
}
  