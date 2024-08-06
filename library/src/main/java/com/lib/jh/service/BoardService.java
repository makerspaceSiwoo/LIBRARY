package com.lib.jh.service;

import org.springframework.stereotype.Service;

import com.lib.dto.BoardDto;
import com.lib.jh.dao.BoardDao;

@Service
public class BoardService {

	BoardDao dao;
	
	public int insert(BoardDto dto) {
		return dao.insert(dto);
	}
	
	
	
}
