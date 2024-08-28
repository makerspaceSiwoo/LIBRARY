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
	
	@Select("select * from (select * from book where callno like concat(#{callno},'%') ) as b left join unreturned using(bookno,userno)")
	public List<UnreturnedBookDto> searchResult(@Param("callno") String callno);
	
//	@Select("select * from (select * from book where callno like concat(substring_index(#{callno},'=',1), '%' ) ) as b left join unreturned using(bookno,userno)")
//	public List<UnreturnedBookDto> searchResult2(@Param("callno") String callno);
	
	@Select("select * from book where callno like concat('%', #{authorinfo}, '%') and author like #{author} and callno not like concat(#{callno}, '%') order by rand() limit 5")
	public List<BookDto> sameAuthor(@Param("author")String author, @Param("authorinfo")String authorinfo, @Param("callno") String callno);
	
}
