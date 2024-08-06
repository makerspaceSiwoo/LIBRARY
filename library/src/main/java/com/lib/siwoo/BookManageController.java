package com.lib.siwoo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class BookManageController {
	
	@GetMapping("/book/add")
	public String addBook() {
		return "admin/manage/book";
	}

}
