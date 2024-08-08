package com.lib.siwoo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class AddBookImgController {

	@Autowired
	AddBookImgService imgservice;
	
	@GetMapping("/test/siwoo")
	public String navertest() {
		return "admin/manage/siwootest/addimg";
	}
	
	@GetMapping("/test/naver")
	public String apitest(Model m) {
		int success = imgservice.addBookImg();
		System.out.println(success);
		m.addAttribute("success",success);
		return "/admin/manage/siwootest/addimg";
	}
	
}
