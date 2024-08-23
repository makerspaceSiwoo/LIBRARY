package com.lib.siwoo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lib.dto.BookDto;

@Service
public class SearchResultService {

	@Autowired
	SearchResultDao dao;
	
	public List<UnreturnedBookDto> searchResult(String callno) {
		List<UnreturnedBookDto> blist = new ArrayList<>();
		blist = dao.searchResult(callno); // 해당 청구기호의 책 목록을 저장
		return blist;
	}
	
	public List<BookDto> sameAuthor(String author, String callno){
		List<BookDto> blist = dao.sameAuthor(author,callno);
		return blist;
	}
}
