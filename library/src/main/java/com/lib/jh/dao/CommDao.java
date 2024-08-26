package com.lib.jh.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.lib.dto.CommDto;

@Mapper
public interface CommDao {

	// 게시글 마다 모든 댓글 가져오기
	@Select("select * from comm inner join user on comm.userno = user.userno where boardno=#{boardno} order by write_date desc")
    List<CommDto> selectComm(int boardno);
	// 댓글 작성 기능
	@Insert("insert into comm(contents, write_date, userno, boardno) values(#{contents},now(),#{userno},#{boardno})")
	int insertComm(CommDto dto);
	// 댓글 삭제 기능
	@Delete("delete from comm where userno = #{userno} and commno = #{commno}")
	int deleteComm(@Param("userno")int userno,@Param("commno")int commno);
	// 댓글 수정 기능
	@Update("update comm set contents = #{contents} where commno = #{commno} and userno= #{userno}")
	int updateComm(@Param("contents")String contents, @Param("commno")int commno, @Param("userno")int userno);
	
	// 특정 댓글 가져오기
    @Select("SELECT * FROM comm WHERE commno = #{commno}")
    CommDto selectOne(int commno);
    
	// 특정 댓글 STATE가져오기
    @Select("SELECT state FROM comm WHERE commno = #{commno}")
    String selectOneState(int commno);
}
