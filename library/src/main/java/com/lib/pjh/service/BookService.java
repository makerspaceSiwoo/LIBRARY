package com.lib.pjh.service;

import java.awt.print.Book;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lib.dto.BorrowDto;
import com.lib.ho.dao.UserDao;
import com.lib.pjh.dao.BookDao;

@Service
public class BookService {

	@Autowired
	BookDao bookDao;
	  
	 public List<BorrowDto> borrowbook(String booktitle) {
	     return bookDao.borrowbook(booktitle);
	 }
	 
	 public void recordno(int recordno) {
		 bookDao.recordno(recordno);
	 }
	 
	 public void bookno(int bookno, int userno) {
		 bookDao.bookno(bookno, userno);
		 
	 }
	 
}
