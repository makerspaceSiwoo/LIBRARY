package com.lib.jh.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lib.dto.BoardDto;
import com.lib.jh.dao.BoardDao;

@Service
public class BoardService {
	@Autowired
	BoardDao dao;
	
	// 게시글 생성
	public int insert(BoardDto dto) {
		return dao.insert(dto);
	}
	// 게시판 리스트 불러오기
	public List<BoardDto> selectAll() {
		return dao.selectAll();
	}
	
	// 게시글 수정
	public void update(BoardDto dto) {
		dao.updateBoard(dto);
	}
	
	//게시글 삭제
	public void delete(int userno,int boardno) {
		dao.delete(userno,boardno);
	}
	
	// 게시글 1개 불러오기 (게시글 상세보기 기능)
	public BoardDto selectOne (int dto) {
		return dao.selectOne(dto);
	}
	
	//게시글 리스트 ( 페이징 )
	public List<BoardDto> selectPage(int page, int size) {
	    int offset = (page - 1) * size;
	    return dao.selectPage(offset, size);
	}
	public int selectTotalCount() {
	    return dao.selectTotalCount();
	}
	
	//게시글 검색
	public List<BoardDto> BoardSearch(String type, String title) {
		 return dao.BoardSearch(type, title);
	}
	
	//게시글 조회수 증가 카운팅
	public void incrementViewCount(int boardno) {
	    dao.incrementViewCount(boardno);
	}
	// 유저 아이디 가져오기
	public String userIdGet(int userno) {
		return dao.userID(userno);
	}
	
	
	
	
}
