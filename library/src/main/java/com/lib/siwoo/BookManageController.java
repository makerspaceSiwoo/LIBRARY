package com.lib.siwoo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lib.dto.BookDto;

@Controller
public class BookManageController {
	
	@Autowired
	BookManageService bservice;
	
	@GetMapping("/book/add")
	public String addBookform() {
		return "admin/manage/book";
	}
	
	@PostMapping("/book/add")
	@ResponseBody
	public List<BookDto> addBooklist(@RequestBody List<BookDto> blist) {
		List<BookDto> failed = new ArrayList<>();
		System.out.println(blist);
		for(BookDto b : blist) {
			int chk = bservice.insertBook(b); // blist에 있는 book을 하나씩 db에 넣는 작업
			if(chk == 1) {
				System.out.println("성공");
			}else { // db에 이미 있거나 다른 이유로 insert에 실패 했을 때 (not null위반 등)
				System.out.println("실패");
				System.out.println(b.getBooktitle() + " " + b.getCallno());
				failed.add(b);
			}
		}
		return failed;
		
	}
	
	

}
