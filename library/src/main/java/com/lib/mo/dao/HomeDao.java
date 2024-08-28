package com.lib.mo.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.lib.dto.BoardDto;
import com.lib.dto.BookDto;

@Mapper
public interface HomeDao {

	@Select("select count(*) from book")
	int allcount();
	
	@Select("select count(*) from book where category like concat ('총류','%')")
	int chongcount();
	
	@Select("select count(*) from book where category like concat ('철학','%')")
	int chulcount();
	
	@Select("select count(*) from book where category like concat ('종교','%')")
	int jongcount();
	
	@Select("select count(*) from book where category like concat ('사회과학','%')")
	int sacount();
	
	@Select("select count(*) from book where category like concat ('자연과학','%')")
	int zacount();
	
	@Select("select count(*) from book where category like concat ('기술과학','%')")
	int gicount();
	
	@Select("select count(*) from book where category like concat ('예술','%')")
	int yeacount();
	
	@Select("select count(*) from book where category like concat ('언어','%')")
	int uncount();
	
	@Select("select count(*) from book where category like concat ('문학','%')")
	int muncount();
	
	@Select("select count(*) from book where category like concat ('역사','%')")
	int yeokcount();
	
	@Select("select * from board where type='announcement' order by boardno desc limit 5")
	List<BoardDto> notice();
	
	@Select("select * from book where callno like '%=1' order by bookno desc limit 3")
	List<BookDto> newBook();
	
	@Select("select count(*) from book where loc= '아동/청소년 자료실'")
	int childBook();
	
	@Select("select count(*) from book where loc='외국어 자료실'")
	int foreignBook();
	
	@Select("select count(*) from book where loc='종합자료실'")
	int commonBook();
	
}
