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
	
	@Autowired
	AddBookImgService imgservice;
	
	@Autowired
	AddBookMetaService metaservice;
	
	@GetMapping("/book/add")
	public String addBookform() {
		return "admin/manage/book";
	}
	
	@PostMapping("/book/add")
	@ResponseBody
	public List<BookDto> addBooklist(@RequestBody List<BookDto> blist) {
		int imgdone, locdone, categorydone = 0;
		List<BookDto> failed = new ArrayList<>(); // 실패한 책 리스트를 리턴
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
		}// 책 입력 완료
		// 비어있는 칼럼 채우기
		imgdone = imgservice.addBookImg(); // 300개까지만 가능
		locdone = metaservice.addBookLoc();
		categorydone = metaservice.addBookCategory();
		
		System.out.printf("이미지 삽입 성공 권수 : %d,  서가위치 삽입 성공 권수 : %d, 분류 삽입 성공권수 : %d\n",imgdone,locdone,categorydone);
		return failed; // 책 삽입에 실패한 책들
		
	}
	
	

}
