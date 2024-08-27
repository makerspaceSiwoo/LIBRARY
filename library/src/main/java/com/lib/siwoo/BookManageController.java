package com.lib.siwoo;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.lib.dto.BookDto;
import com.lib.dto.UserDto;
import com.lib.mo.service.SearchService;

@SessionAttributes("user")
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
		List<BookDto> failed = new ArrayList<>(); // 실패한 책 리스트를 리턴
//		System.out.println(blist);
		for(BookDto b : blist) {
			int chk = bservice.insertBook(b); // blist에 있는 book을 하나씩 db에 넣는 작업 + img + meta
				
			if(chk == 1) {
				System.out.println("성공");
			}else { // db에 이미 있거나 다른 이유로 insert에 실패 했을 때 (not null위반 등)
				System.out.println("실패");
				System.out.println(b.getBooktitle() + " " + b.getCallno());
				failed.add(b);
			}
		}// 책 입력 완료
		// 비어있는 칼럼 채우기		
		return failed; // 책 삽입에 실패한 책들
	}
	
	
	// 수정, 삭제 페이지
	
	// 수정/삭제할 책 검색 - 청구 기호로
	@GetMapping("/book/manage")
	public String targetBookList(@RequestParam(required = true, defaultValue = "", name="booktitle") String booktitle,
			@RequestParam(name = "p", defaultValue = "1") int page,
			Model m) {
		if(booktitle != null) { //  제목을 입력하지 않으면 리스트를 가져오지 않음
			int count = bservice.targetcount(booktitle);
			if (count > 0) {
				int perPage = 10; // 한 페이지에 보일 글의 갯수
				int startRow = (page - 1) * perPage;
				int endRow = page * perPage;

				List<BookDto> bookList = bservice.targetbook(booktitle, startRow, perPage);
				m.addAttribute("blist", bookList);

				int pageNum = 5;
				int totalPages = count / perPage + (count % perPage > 0 ? 1 : 0); // 전체 페이지 수

				int begin = (page - 1) / pageNum * pageNum + 1;
				int end = begin + pageNum - 1;
				if (end > totalPages) {
					end = totalPages;
				}
				m.addAttribute("begin", begin);
				m.addAttribute("current",page);
				m.addAttribute("pageNum", pageNum);
				m.addAttribute("totalPages", totalPages);
				m.addAttribute("end", end);
			}
			m.addAttribute("count", count);
			m.addAttribute("booktitle", booktitle);
		}
		return "admin/manage/book2";
	}
	

	@GetMapping("/book/mod")
	public String targetBook(@RequestParam(required = true, name="bookno") int bookno,Model m) {
		BookDto book = bservice.selectBook(bookno);
		m.addAttribute("book",book);
		return "admin/manage/book3";
	}
	
	@PostMapping("/book/mod")
	@ResponseBody
	public int modBook(@RequestBody BookDto dto, Model m) {
		int done = bservice.modBook(dto);
		System.out.println(done);
		return done;
	}
	
	@DeleteMapping("/book/del")
	@ResponseBody
	public int delBook(@RequestParam("bookno") int bookno) {
		int done = bservice.delBook(bookno);
		System.out.println(done);
		return done;
	}
	

}
