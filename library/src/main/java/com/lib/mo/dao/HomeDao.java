package com.lib.mo.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface HomeDao {

	@Select("select count(*) from book")
	int count();
	
}
