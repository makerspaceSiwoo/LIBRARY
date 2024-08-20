package com.lib.pjh.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import com.lib.dto.UserDto;

@Mapper
public interface JoinDao {
    
    @Select("SELECT COUNT(*) FROM user WHERE userID = #{userID}")
    int checkid(@Param("userID") String userID);
    //회원가입시 아이디 중복 체크

    @Insert("INSERT INTO user (userno, admin, userID, userPW, gender, name, birth, phone, email, address, ban, penalty, state) " +
            "VALUES (#{userno}, #{admin}, #{userID}, #{userPW}, #{gender}, #{name}, #{birth}, #{phone}, #{email}, #{address}, #{ban}, #{penalty}, #{state})")
    void insertUser(UserDto user);
    //회원가입시 데이터베이스에 회원정보 기입
    
    
}
