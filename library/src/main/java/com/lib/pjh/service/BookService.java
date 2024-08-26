package com.lib.pjh.service;

import java.awt.print.Book;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lib.dto.BorrowDto;
import com.lib.dto.UnreturnDto;
import com.lib.dto.UserDto;
import com.lib.ho.dao.UserDao;
import com.lib.pjh.dao.BookDao;

@Service
public class BookService {

	@Autowired
	BookDao bookDao;
	  
	 public List<BorrowDto> borrowbook(String booktitle,int size,int offset) {
	     return bookDao.borrowbook(booktitle,size,offset);
	 }//검색 서비스
	 
	 public void borrowno(int bookno,int userno) {
		 bookDao.borrowno(bookno,userno);
	 }//반납시 record 테이블 등록
	 
	 public void bookno(int bookno, String userID) {
		 bookDao.bookno(bookno, userID); 
	 }//대출시 record 테이블 등록
	 
	 public void unreturn(int bookno, String userID) {
		 bookDao.unreturn(bookno, userID);
	 }//대출시 unrecord 테이블 등록
	 
	 public void latereturn(int userno, Date u_end) {
		  bookDao.latereturn(userno, u_end);
	 }//연체 반납시 패널티 테이블 등록
	 
	 public void penalty(int userno) {
		 bookDao.penalty(userno);
	 }//연체 반납시 user 테이블 회원 penalty값=1로(패널티상태) 변경
	 
	 public void delete(int bookno) {
		 bookDao.delete(bookno);
	 }//반납,연체 반납완료시 unrecord 테이블 값 삭제
	 
	 public int loan(String userID){
		 return bookDao.prohibited(userID);
	 }//연체시 대출기능 정지를 위한 패널티보유자 검색
	 
	 public int treebook(String userID) {
		 return bookDao.treebook(userID);
	 }//책3권 제한하기위한 개수검색 

	 public int countBooks(String booktitle) {
	      return bookDao.countBooks(booktitle);
	 }//페이징을위한 책개수 검색
	 
}
