package com.lib.jh.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lib.dto.BoardDto;
import com.lib.dto.BoardJoinUserDto;
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
	public List<BoardJoinUserDto> selectPage(int page, int size) {
	    int offset = (page - 1) * size;
	    if (offset < 0) {
            offset = 0; // offset이 음수일 경우 0으로 설정 
        }
	    
	    return dao.selectPage(offset, size);
	}
	public int selectTotalCount() {
	    return dao.selectTotalCount();
	}
	
//	// 게시글 검색
//    public List<BoardDto> BoardSearch(String type, String title) {
//        return dao.BoardSearch(type, title);
//    }
	// 게시글 검색 (페이징 포함)
	public List<BoardJoinUserDto> BoardSearch(String type, String title, int offset, int limit) {
	    // title이 null일 경우 쿼리에서 title 조건을 무시하도록 처리
	    return dao.BoardSearch(type, title, offset, limit);
	}
	// getSearchTotalCount 타입에 따른 글 갯수
	public int getSearchTotalCount(String type, String title) {
	    // title이 null일 경우 쿼리에서 title 조건을 무시하도록 처리
	    return dao.getSearchTotalCount(type, title);
	}
	
	//게시글 조회수 증가 카운팅
	public void incrementViewCount(int boardno) {
	    dao.incrementViewCount(boardno);
	}
	// 유저 아이디 가져오기
	public String userIdGet(int userno) {
		return dao.userID(userno);
	}
	
	

	
	 // title로 검색하는 메서드 추가
    public List<BoardJoinUserDto> BoardSearchByTitle(String title, int offset, int limit) {
        return dao.BoardSearchByTitle(title, offset, limit);
    }

    // title로 검색된 게시글 수를 가져오는 메서드 추가
    public int getSearchTotalCountByTitle(String title) {
        return dao.getSearchTotalCountByTitle(title);
    }
}
	
	
	

