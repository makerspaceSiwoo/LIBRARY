package com.lib.siwoo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.lib.dto.BookDto;

@Controller
public class SearchResultController {
	
	@Autowired
	SearchResultService bservice;
	
	// 검색 리스트에서 선택한 책 페이지로 이동시키는 컨트롤러
	@GetMapping("/search/no={callno}")
	public String searchResult(@PathVariable("callno") String callno, Model m) {
	
		
		List<UnreturnedBookDto> blist = bservice.searchResult(callno);
		System.out.println(blist);
		List<BookDto> otherbooks = bservice.sameAuthor(blist.get(0).getAuthor(),callno);
		
		m.addAttribute("blist",blist);
		m.addAttribute("otherbooks", otherbooks);
		return "user/searchResult";
	}

}
