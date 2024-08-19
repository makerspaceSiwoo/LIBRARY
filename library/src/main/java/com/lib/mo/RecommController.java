package com.lib.mo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lib.mo.dto.RecommDto;
import com.lib.mo.service.RecommService;

@Controller
public class RecommController {

	@Autowired
	RecommService service;
	
	@GetMapping("/recomm")
	public String recomm(@RequestParam(value="gen", defaultValue = "M", required = false) String gen,
			@RequestParam(value = "cate", defaultValue = "", required = false) String cate,
			@RequestParam(value= "mon", defaultValue = "6", required = false) int mon,
			@RequestParam(value = "start", defaultValue = "", required = false) int start,
			@RequestParam(value = "start", defaultValue = "", required = false) int end, Model m) {
		
		int count = service.recommcount(gen, cate, mon, start, end);
		
		if(count>0) {
		List<RecommDto> recommbook = service.recommbook(gen, cate, mon, start, end);
		m.addAttribute("recommbook", recommbook);
		}
		m.addAttribute("gen", gen);
		m.addAttribute("cate", cate);
		m.addAttribute("mon", mon);
		m.addAttribute("start", start);
		m.addAttribute("end", end);
		return "user/recomm";
	}
}
