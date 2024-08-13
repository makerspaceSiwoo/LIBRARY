package com.lib.jh.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.lib.dto.PenaltyDto;

@Mapper
public interface PenaltyDao {

	//패널티 테이블  전체 조회
    @Select("SELECT * FROM penalty")
    List<PenaltyDto> getAllPenalties(); 

    // penalty 테이블에서 패널티 삭제
    @Delete("DELETE FROM penalty WHERE penaltyno = #{penaltyno}")
    void deletePenalty(int penaltyno);

    //user 테이블에서 penalty 업데이트 ( user penalty 1 이면 ( 대출금지 ) 0이면 (대출가능)
    @Update("UPDATE user SET penalty = #{penalty} WHERE userno = #{userno}")
    void updateUserPenalty(@Param("userno") int userno, @Param("penalty") int penalty); // 사용자 패널티 업데이트
}