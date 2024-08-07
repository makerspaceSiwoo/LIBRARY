package com.lib.jh.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.lib.dto.BoardDto;

@Mapper
public interface BoardDao {
	// 게시글 생성
	@Insert("insert into board (type, title, contents, write_date, view, userno) values(#{type}, #{title}, #{contents}, now(), #{view}, #{userno})")
	int insert(BoardDto dto);
	
	// 게시판 리스트 불러오기
	@Select("select * from board")
	List<BoardDto> selectAll();
	
	// 게시글 수정
	@Update("update board set contents = #{contents} where boardno = ${boardno} and #{userno}")
	int updateBoard(BoardDto dto);
	
	//게시글 삭제
	@Delete("delete from board where userno = #{userno} and boardno = #{boardno}")
	int delete(BoardDto dto);
	
	// 게시글 1개 불러오기 (게시글 상세보기 기능)
	@Select("select * from board where boardno = #{boardno}")
	BoardDto selectOne(int boardno);
	
	//게시글 페이징
    @Select("select * from board order by write_date asc limit #{offset}, #{limit}")
    List<BoardDto> selectPage(@Param("offset") int offset, @Param("limit") int limit);
    
    @Select("select count(*) from board")
    int selectTotalCount();
    
    
    
	
}
