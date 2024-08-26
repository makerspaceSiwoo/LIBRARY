package com.lib.siwoo;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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
				
				imgdone = imgservice.addBookImgone(dto); // 새로 추가하는 책에 대해서만 - 중간에 실패 -> noimg
				
				// 유효성 검사 - 청구기호 유효성 검사
				String pattern = "([가-힣a-zA-Z]*)(\\d+(\\.\\d+)?)-([가-힣a-zA-Z])\\d+([가-힣ㄱ-ㅎa-zA-Z])\\d*(v\\.\\d+(\\.\\d+)?+(c\\.\\d+)?)?=(\\d+)";		        
				Pattern r = Pattern.compile(pattern);
		        Matcher m = r.matcher(dto.getCallno());
				if(!m.matches()) { // 청구 기호가 형식에 맞지 않는 경우
					System.out.println("잘못된 청구기호 형식");
					System.out.println(dto.getCallno());
					return 0; // 책 삽입 실패
				}

				locdone = metaservice.addBookLocOne(dto); // 해당 책의 서가 위치 dto에 입력
				categorydone = metaservice.addBookCategoryOne(dto); // 해당 책의 카테고리 dto에 입력
				
				success = dao.insertBook(dto); // 책 삽입
				
				System.out.printf("이미지 삽입 성공 : %d,  서가위치 삽입 성공 : %d, 분류 삽입 성공 : %d\n",imgdone,locdone,categorydone);
				return success;
			}else {
				return 0;
//				System.out.println("이미 존재하는 도서 입니다.");
			}
		} catch(Exception e) {
			e.printStackTrace();
		}	
		return 0; // 이미 존재하는 책이면 db에 추가하지 않고, 0 리턴
	}
	
	
	public int targetcount(String booktitle) {
		return dao.targetcount(booktitle);
	}
	
	public List<BookDto> targetbook(String booktitle, int startRow, int perPage){ // 청구기호로 책 검색
		return dao.targetbook(booktitle, startRow, perPage);
		
	}
	
	public BookDto selectBook(int bookno) {
		return dao.selectBook(bookno);
	}
	
	public int modBook(BookDto dto) {
		return dao.modBook(dto);
	}
	
	public int delBook(int bookno) {
		return dao.delBook(bookno);
	}

}
