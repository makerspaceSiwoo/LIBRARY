package com.lib.pjh.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lib.dto.BorrowDto;
import com.lib.pjh.service.BookService;

@Controller
public class BookController {

	@Autowired
	BookService bookservice;
	
	@GetMapping("/book/borrow")
	public String manage() {
		return "parkjae/book/borrow";
	}
	
	@GetMapping("/book/record")
	public String borrowbook(@RequestParam("booktitle")String booktitle, Model m){
		List<BorrowDto> borrowbook = bookservice.borrowbook(booktitle);
		m.addAttribute("borrowbook", borrowbook );
		return "parkjae/book/borrow";
	}
	
	@GetMapping("/book/return")
	public String returnbook(@RequestParam("recodeno") int recordno) {
		bookservice.recordno(recordno);
		return "parkjae/book/borrow";
	}
	
	@GetMapping("/book/lent")
	public String lentbook(@RequestParam("bookno") int bookno, Model m) {
		m.addAttribute("bookno", bookno);
		return "parkjae/book/lent";
	}
	
	@PostMapping("/book/lent")
	public String lent(@RequestParam("bookno") int bookno,@RequestParam("userno") int userno, Model m) {
		bookservice.bookno(bookno, userno);
		
		
		return "redirect:/book/borrow";
	}


	
	
	
	
	
	

	
}
  