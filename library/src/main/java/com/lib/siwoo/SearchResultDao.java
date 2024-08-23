package com.lib.siwoo;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.lib.dto.BookDto;

@Mapper
public interface SearchResultDao {
	
//	@Select("select * from library.book where callno like concat(#{callno},'%')")
//	public List<BookDto> searchResult(String callno);
	
	@Select("select * from (select * from book where callno like concat(#{callno}, '%')) as b left join unreturned using(bookno,userno)")
	public List<UnreturnedBookDto> searchResult(String callno);
	
	@Select("select * from book where author=#{author} and callno not like concat(#{callno}, '%')")
	public List<BookDto> sameAuthor(@Param("author")String author, @Param("callno") String callno);
	
}
