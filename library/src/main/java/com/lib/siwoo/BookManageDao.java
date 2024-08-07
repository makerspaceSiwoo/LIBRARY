package com.lib.siwoo;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.lib.dto.BookDto;

@Mapper
public interface BookManageDao {

	// db에 책 입력
	@Insert("insert into library.book values(default, #{callno}, #{booktitle}, #{author}, #{publisher}, #{pubyear}, #{loc},#{category},#{img}, null)")
	int insertBook(BookDto dto);
	
	// 이미 있는 책인지 확인
	@Select("select count(*) from library.book where callno=#{callno}")
	int checkDuplicate(String callno);
}
