package com.lib.jh.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lib.dto.CommDto;
import com.lib.jh.dao.CommDao;

@Service
public class CommService {
	@Autowired
	CommDao dao;
	
	public int insertComm(CommDto dto) {
		return dao.insertComm(dto);
	}
	
	public int deleteComm(int userno,int commno) {
		return dao.deleteComm(userno,commno);
	}
	
	public List<CommDto> selectComm(int boardno){
		return dao.selectComm(boardno);
	}
	
	public int updateComm(String contents,int commno,int userno ) {
		System.out.println(contents);
		return dao.updateComm(contents, commno, userno);
	}
}
