package com.lib.jh.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.lib.dto.UserDto;

@Mapper
public interface UserDao2 {

	@Select("SELECT * FROM USER")
	List<UserDto> selectUsertAll();
	   // 사용자 번호로 사용자의 정보를 조회
    @Select("SELECT * FROM user WHERE userno = #{userno}")
    UserDto selectUserById(int userno);
  

    // 사용자의 ban 시간을 업데이트
    @Update("UPDATE user SET ban = #{newBanEnd} WHERE userno = #{userno}")
    int updateUserBan(@Param("userno")int userno, @Param("newBanEnd")Date newBanEnd);
    

    @Select("SELECT * FROM user WHERE userno = #{userno}")
    UserDto findByUserno(int userno);


}
