package com.lib.siwoo;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpServletResponse;

@SessionAttributes("user")
@Controller
public class AddBookExcelController {

	@Autowired
	AddBookExcelService excelservice;
	
    @GetMapping("/book/add/downform")
    public void downExcel(HttpServletResponse response) {
       excelservice.downExcel(response);
    }
    
    @PostMapping("/book/add/excel")
    public void uploadExcel(@RequestParam("booklistexcel") MultipartFile file,HttpServletResponse response, Model m ) { // 임시 경로에 업로드 된 파일에 접근 가능
    	byte[] result = excelservice.uploadExcel(file);
    	if(result == null) {
    		System.out.println("엑셀 파일만 업로드 해 주세요");
    	}
//    	int done = 1;
//    	m.addAttribute("done",done);
//    	excelservice.downResult(response, file); // 결과 파일 다운로드
    	excelservice.downResult(response, result, file.getOriginalFilename());
//    	return "redirect:/book/add";
    }
    
}
