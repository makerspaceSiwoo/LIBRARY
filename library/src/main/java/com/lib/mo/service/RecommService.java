package com.lib.mo.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lib.mo.dao.RecommDao;
import com.lib.mo.dto.RecommDto;

@Service
public class RecommService {
	@Autowired
	RecommDao dao;
	
//	전체
	public List<RecommDto> allrcbook(){
		return dao.allrcbook();
	}
	
//	카테고리
	public List<RecommDto> catercbook(int userno){
		System.out.println(userno);
		return dao.catercbook(userno);
	}
	
//	성별
	public List<RecommDto> genrcbook(String gender){
		System.out.println(gender);
		return dao.genrcbook(gender);
	}
	
//	연령대
	public List<RecommDto> agercbook(Date birth){
		System.out.println(birth);
		// birth 가공 -> 10대인지, 20대인지,... -> 1 , 2 , ...
		int year = new Date().getYear();
		int group = (year-birth.getYear()) / 10;
		System.out.println(group);
		return dao.agercbook(group);
	}
	
}
