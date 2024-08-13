package com.lib.mo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lib.mo.dao.HomeDao;

@Service
public class AdminHomeService {
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
	
	public int artbook() {
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
}
