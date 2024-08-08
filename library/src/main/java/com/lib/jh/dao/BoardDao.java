package com.lib.jh.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

import com.lib.dto.BoardDto;

@Mapper
public interface BoardDao {

	@Insert("insert into board (boardno, type, title, contents, write_date, view, userno) values(#{id}, #{type}, #{title}, #{contents}, #{write_date}, #{view}, #{userno})")
	int insert(BoardDto dto);
	
}
