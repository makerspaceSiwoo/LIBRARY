package com.lib.siwoo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lib.dto.BookDto;

@Service
public class BookManageService {
	
	@Autowired
	BookManageDao dao;
	
	// 이미 있는 책인지 확인
	public int insertBook(BookDto dto) {
		// dto의 칼럼이 null인 경우, 접근이 실패할 수 있음
		try {
			if(dao.checkDuplicate(dto.getCallno()) == 0) { // 청구 기호로 검색해서 이미 존재하는지 확인
				return dao.insertBook(dto);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 이미 존재하는 책이면 db에 추가하지 않고, -1 리턴
	}

}
