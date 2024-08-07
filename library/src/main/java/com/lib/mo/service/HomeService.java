package com.lib.mo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lib.mo.dao.HomeDao;

@Service
public class HomeService {

	@Autowired
	HomeDao dao;
	
	public int allbook() {
		return dao.count();
	}
	
}
