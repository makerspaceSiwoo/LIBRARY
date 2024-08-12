package com.lib.siwoo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lib.dto.BookDto;

@Service
@Transactional
public class BookManageService {
	
	@Autowired
	BookManageDao dao;
	
	@Autowired
	AddBookImgService imgservice;
	
	@Autowired
	AddBookMetaService metaservice;
	
	// 이미 있는 책인지 확인
	public int insertBook(BookDto dto) {
		// dto의 칼럼이 null인 경우, 접근이 실패할 수 있음	
		int success=0;
		int imgdone, locdone=0, categorydone = 0;
		try {
			if(dao.checkDuplicate(dto.getCallno()) == 0) { // 청구 기호로 검색해서 이미 존재하는지 확인
				success = dao.insertBook(dto);
				imgdone = imgservice.addBookImgone(dto); // 새로 추가하는 책에 대해서만
				locdone = metaservice.addBookLocOne(dto); // 해당 책의 서가 위치 입력
				categorydone = metaservice.addBookCategoryOne(dto); // 해당 책의 카테고리 입력
				
				System.out.printf("이미지 삽입 성공 : %d,  서가위치 삽입 성공 : %d, 분류 삽입 성공 : %d\n",imgdone,locdone,categorydone);
				return success;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}	
		return -1; // 이미 존재하는 책이면 db에 추가하지 않고, -1 리턴
	}

}
