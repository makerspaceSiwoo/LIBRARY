package com.lib.jh.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

@SessionAttributes("user1")
@Controller
public class JController {

	@GetMapping("/home1")
	public String boardList() {
		return "ha_board/boardlist";
	}
	@GetMapping("/home2")
	public String boardContent() {
		return "ha_board/boardwrite";
	}
	@GetMapping("/home3")
	public String boardWrite() {
		return "ha_board/boardcontent";
	}
	
	
	
	
	
	
	
	
}
