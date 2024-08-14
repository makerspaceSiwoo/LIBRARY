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
		return dao.catercbook(userno);
	}
	
//	성별
	public List<RecommDto> genrcbook(String gender){
		return dao.genrcbook(gender);
	}
	
//	연령대
	public List<RecommDto> agercbook(Date birth){
		return dao.agercbook(birth);
	}
	
}
