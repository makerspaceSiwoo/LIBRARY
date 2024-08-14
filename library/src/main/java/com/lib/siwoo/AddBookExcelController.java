package com.lib.siwoo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpServletResponse;

@Controller
public class AddBookExcelController {

	@Autowired
	AddBookExcelService excelservice;
	
    @GetMapping("book/add/downform")
    public void downExcel(HttpServletResponse response) {
       excelservice.downExcel(response);
    }
    
    @PostMapping("book/add/excel")
    public String uploadExcel(@RequestParam("booklistexcel") MultipartFile file, Model m ) { // 임시 경로에 업로드 된 파일에 접근 가능
    	int[] result = excelservice.uploadExcel(file);
    	int done = result[0], fail = result[1];
    	System.out.println(done);
    	System.out.println(fail);
    	if(done == -1) {
    		System.out.println("엑셀 파일만 업로드 해 주세요");
    	}

    	return "redirect:/book/add";
    }
    
}
