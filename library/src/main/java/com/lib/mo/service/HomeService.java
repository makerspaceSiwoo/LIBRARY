package com.lib.mo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lib.dto.BoardDto;
import com.lib.dto.BookDto;
import com.lib.mo.dao.HomeDao;

@Service
public class HomeService {

	@Autowired
	HomeDao dao;
	
	public int chongbook() {
		return dao.chongcount();
	}
	
	public int chulbook() {
		return dao.chulcount();
	}
	
	public int jongbook() {
		return dao.jongcount();
	}
	
	public int sabook() {
		return dao.sacount();
	}
	
	public int zabook() {
		return dao.zacount();
	}
	
	public int gibook() {
		return dao.gicount();
	}
	
	public int yeabook() {
		return dao.yeacount();
	}
	
	public int unbook() {
		return dao.uncount();
	}
	
	public int munbook() {
		return dao.muncount();
	}
	
	public int yeokbook() {
		return dao.yeokcount();
	}
	
	public int allbook() {
		return dao.allcount();
	}
	
	public List<BoardDto>notice(){

		return dao.notice();
	}
	
	public List<BookDto>newBook(){
		return dao.newBook();
	}
	
	public int childBook(){
		return dao.childBook();
	}
	public int foreignBook(){
		return dao.foreignBook();
	}
	public int commonBook(){
		return dao.commonBook();
	}
}
