package com.lib.siwoo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class SiwooTestController {

	@Autowired
	AddBookImgService imgservice;
	@Autowired
	AddBookMetaService metaservice;
	
	@GetMapping("/test/siwoo")
	public String navertest() {
		return "admin/manage/siwootest/addimg";
	}
	
//	@GetMapping("/test/naver")
//	public String apitest(Model m) {
//		int success = imgservice.addBookImg();
//		System.out.println(success);
//		m.addAttribute("success",success);
//		return "/admin/manage/siwootest/addimg";
//	}
//	
//	@GetMapping("/test/loc")
//	public String addmetatest() {
//		int done = metaservice.addBookLoc();
//		System.out.println(done);
//		return "admin/manage/siwootest/addimg";
//	}
	
//	@GetMapping("/test/category")
//	public String addcategory() {
//		int done = metaservice.addBookCategory();
//		System.out.println(done);
//		return "admin/manage/siwootest/addimg";
//	}
//	
}
