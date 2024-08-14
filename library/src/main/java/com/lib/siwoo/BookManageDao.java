package com.lib.siwoo;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.lib.dto.BookDto;

@Mapper
public interface BookManageDao {

	// db에 책 입력
	@Insert("insert into library.book values(default, #{callno}, #{booktitle}, #{author}, #{publisher}, #{pubyear}, #{loc},#{category},#{img}, null)")
	@Options(useGeneratedKeys = true, keyProperty = "bookno")
	public int insertBook(BookDto dto);
	
	// 이미 있는 책인지 확인
	@Select("select count(*) from library.book where callno=#{callno}")
	public int checkDuplicate(String callno);
	
	// 청구기호로 책 목록 검색
	@Select("select count(*) from book where callno like concat('%',#{callno},'%')")
	public int targetcount(String callno);
	@Select("select * from book where callno like concat('%',#{callno},'%') order by callno limit #{start}, #{count}")
	public List<BookDto> targetbook(@Param("callno") String callno, @Param("start") int start, @Param("count") int count);
	
	// 수정/삭제할 책 정보 가져오기
	@Select("select * from book where bookno=#{bookno}")
	public BookDto selectBook(int bookno);
	
	@Update("update book set booktitle=#{booktitle}, author=#{author}, callno=#{callno}, publisher=#{publisher}, pubyear=#{pubyear} where bookno=#{bookno}")
	public int modBook(BookDto dto);
	
	@Delete("delete from book where bookno=#{bookno}")
	public int delBook(int bookno);
	
	
}
