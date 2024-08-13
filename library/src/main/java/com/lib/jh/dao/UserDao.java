package com.lib.jh.dao;

import java.util.Date;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.lib.dto.UserDto;

@Mapper
public interface UserDao {

    @Select("SELECT * FROM user WHERE userno = #{userno}")
    UserDto findByUserno(int userno);

    @Update("UPDATE user SET ban = #{ban} WHERE userno = #{userno}")
    int updateUserBan(@Param("userno") int userno, @Param("ban") Date ban);
}