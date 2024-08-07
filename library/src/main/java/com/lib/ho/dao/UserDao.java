package com.lib.ho.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.lib.dto.UserDto;

@Mapper
public interface UserDao {
	
	@Select("select * from user")
	List<UserDto> getAllUsers();
	
	@Insert("INSERT INTO user (userID, userPW, email, name, gender, birth, phone, address, ban, penalty, state, admin) VALUES (#{userID}, #{userPW}, #{email}, #{name}, #{gender}, #{birth}, #{phone}, #{address}, #{ban}, #{penalty}, #{state}, #{admin})")
    void insertUser(UserDto user);
	
}
