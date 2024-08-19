package com.lib.siwoo;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.lib.dto.BookDto;

@Mapper
public interface AddBookMetaDao {

	// 서가 업데이트
	@Update("update book set loc=#{loc} where (left(callno,1) regexp concat('^',#{callhead})) and (loc is null or loc='')")
	public int addBookLoc(@Param("loc") String loc, @Param("callhead") String callno);
	
	// 서가 업데이트 - 하나
	@Update("update book set loc=#{loc} where bookno=#{bookno}")
	public int addBookLocOne(BookDto dto);
	
	// 카테고리 업데이트
	// 카테고리가 없는 책 리스트 가져오기
	@Select("select callno, bookno from book where category is null")
	public List<CategoryDto> findnoCategory();
	// dto 업데이트 후 그 정보대로 db 업데이트
	@Update("update book set category=#{category} where bookno=#{bookno}")
	public int addCategory(@Param("category") String category, @Param("bookno") int bookno);
	
	// 카테고리 업데이트 하나
	@Update("update book set category=#{category} where bookno=#{bookno}")
	public int addCategoryOne(BookDto dto);
	
}
