package com.lib.siwoo;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.lib.dto.BookDto;

@Mapper
public interface AddBookImgDao {
	
	// img link가 비어있는 책 db에서 가져오기
	@Select("select * from book where img='' or img is null limit #{limit}")
	public List<BookDto> findNoImg(int limit);
	
	@Update("update book set img=#{img} where bookno=#{bookno}")
	public int updateImg(@Param("img") String img, @Param("bookno") int bookno);

}
