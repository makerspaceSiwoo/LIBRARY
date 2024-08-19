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
	public String borrowbook(@RequestParam(name="booktitle", defaultValue="")String booktitle, Model m){
		List<BorrowDto> borrowbook = bookservice.borrowbook(booktitle);
		m.addAttribute("unreturned", borrowbook);
		m.addAttribute("now", new Date());
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
  