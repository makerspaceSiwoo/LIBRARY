package com.lib.siwoo;

import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import jakarta.servlet.http.HttpServletResponse;

@Controller
public class AddBookExcelController {

	@Autowired
	AddBookExcelService excelservice;
	
    @GetMapping("book/add/downform")
    public void downExcel(HttpServletResponse response) {
       excelservice.downExcel(response);
    }
    
//    @PostMapping("book/add/excel")
    
}
