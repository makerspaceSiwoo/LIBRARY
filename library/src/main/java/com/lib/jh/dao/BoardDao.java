package com.lib.jh.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.lib.dto.BoardDto;
import com.lib.dto.BoardJoinUserDto;

@Mapper
public interface BoardDao {
	// 게시글 생성
	@Insert("insert into board (type, title, contents, write_date, view, userno) values(#{type}, #{title}, #{contents}, now(), #{view}, #{userno})")
	int insert(BoardDto dto);
	
	// 게시판 리스트 불러오기
	@Select("select * from board")
	List<BoardDto> selectAll();

	
	// 게시글 수정
	@Update("update board set contents = #{contents}, title= #{title} where boardno = ${boardno} and #{userno}")
	int updateBoard(BoardDto dto);
	
	//게시글 삭제
	@Delete("delete from board where userno = #{userno} and boardno = #{boardno}")
	int delete(@Param("userno")int userno, @Param("boardno")int boardno);
	
	// 게시글 1개 불러오기 (게시글 상세보기 기능)
	@Select("select * from board where boardno = #{boardno}")
	BoardDto selectOne(int boardno);
	
	 // board에서 state값 1개 확인 
    @Select("SELECT state FROM board where boardno = #{boardno}")
    String boardStateOne(int boardno);
	
	//게시글 리스트(페이징)
	@Select("""
		    SELECT b.*, u.*
		    FROM board b
		    INNER JOIN user u ON b.userno = u.userno
		    ORDER BY b.write_date DESC
		    LIMIT #{offset}, #{limit}
		""")
    List<BoardJoinUserDto> selectPage(@Param("offset") int offset, @Param("limit") int limit);
   
    @Select("select count(*) from board") // 게시글 총 갯수 
    int selectTotalCount();
    //--------------------------------------------
    
//    //게시글 검색
//    @Select("SELECT * FROM board WHERE (type = #{type} OR #{type} IS NULL) AND (title LIKE CONCAT('%', #{title}, '%') OR #{title} IS NULL)")
//    List<BoardDto> BoardSearch(@Param("type") String type, @Param("title") String title);
//    
    //게시글 조회수
    @Update("UPDATE board SET view = view + 1 WHERE boardno = #{boardno}")
    int incrementViewCount(@Param("boardno") int boardno);
    
    
	// 게시판 리스트 userID가져오기
	@Select("select userID from user where userno = #{userno} ")
	String userID(int userno);
	
	
	// getSearchTotalCount 타입에 따른 글 갯수, 조건에 따른 게시글의 총 개수 반환
	@Select("""
		    SELECT COUNT(*)
		    FROM board
		    WHERE (#{type} IS NULL OR #{type} = '' OR type = #{type})
		    AND (#{title} IS NULL OR #{title} = '' OR title LIKE CONCAT('%', #{title}, '%'))
			""")
	int getSearchTotalCount(@Param("type") String type, @Param("title") String title);
	
	// BoardSearch 게시판 검색기능 조건에 따른 게시글 검색 후 리스트로 반환
	@Select("""
		    SELECT b.*, u.*
		    FROM board b
		    INNER JOIN user u ON b.userno = u.userno
		    WHERE (#{type} IS NULL OR #{type} = '' OR b.type = #{type})
		    AND (#{title} IS NULL OR #{title} = '' OR b.title LIKE CONCAT('%', #{title}, '%'))
		    ORDER BY b.write_date DESC
		    LIMIT #{offset}, #{limit}
			""")
	List<BoardJoinUserDto> BoardSearch(@Param("type") String type, @Param("title") String title, @Param("offset") int offset, @Param("limit") int limit);

	// title로 검색하는 쿼리
    @Select("""
    		SELECT b.*, u.*
    		FROM board b
    		INNER JOIN user u ON b.userno = u.userno
    		WHERE b.title LIKE CONCAT('%', #{title}, '%')
    		ORDER BY b.write_date DESC
    		LIMIT #{offset}, #{limit}
    		""")
    List<BoardJoinUserDto> BoardSearchByTitle(@Param("title") String title, @Param("offset") int offset, @Param("limit") int limit);

    // title로 검색된 게시글 수를 가져오는 쿼리
    @Select("""
    		SELECT COUNT(*)
    		FROM board
    		WHERE title LIKE CONCAT('%', #{title}, '%')
    		""")
    int getSearchTotalCountByTitle(@Param("title") String title);

}

