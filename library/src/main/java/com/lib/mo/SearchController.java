package com.lib.mo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lib.dto.BookDto;
import com.lib.mo.service.SearchService;

@Controller
public class SearchController {

	@Autowired
	private SearchService service;
	
	
	@GetMapping("/search")
	public String search(@RequestParam(value = "searchn", defaultValue = "0", required = false) int searchn,
			@RequestParam(value = "search", defaultValue = "", required = false) String search,
			@RequestParam(name = "p", defaultValue = "1") int page,
			@RequestParam(name = "cate", defaultValue = "") String cate, Model m) {

		search = search.trim();
		
		int count = service.countBook(searchn, search, cate);
		System.out.println(count);
		
		if (count > 0) {

			int perPage = 10; // 한 페이지에 보일 글의 갯수
			int startRow = (page - 1) * perPage;
			int endRow = page * perPage;

			List<BookDto> bookList = service.searchBook(searchn, search, cate, startRow);
			System.out.println(bookList);
			m.addAttribute("bList", bookList);

			int pageNum = 5;
			int totalPages = count / perPage + (count % perPage > 0 ? 1 : 0); // 전체 페이지 수

			int begin = (page - 1) / pageNum * pageNum + 1;
			int end = begin + pageNum - 1;
			if (end > totalPages) {
				end = totalPages;
			}
			m.addAttribute("begin", begin);
			m.addAttribute("pageNum", pageNum);
			m.addAttribute("totalPages", totalPages);
			m.addAttribute("end", end);
		}
		m.addAttribute("count", count);
		m.addAttribute("searchn", searchn);
		m.addAttribute("search", search);
		m.addAttribute("cate", cate);

		return "user/search";
	}
}
