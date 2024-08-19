package com.lib.ho.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.lib.dto.UserDto;

@Mapper
public interface UserDao {
	
	@Select("select * from user")
	List<UserDto> getAllUsers();
	
	@Insert("INSERT INTO user (userID, userPW, email, name, gender, birth, phone, address, ban, penalty, state, admin) VALUES (#{userID}, #{userPW}, #{email}, #{name}, #{gender}, #{birth}, #{phone}, #{address}, #{ban}, #{penalty}, #{state}, #{admin})")
    void insertUser(UserDto user);
	
	@Update("UPDATE user SET userID = #{userID}, userPW = #{userPW}, email = #{email}, name = #{name}, birth = #{birth}, phone = #{phone}, address = #{address} WHERE userno = #{userno}")
    void updateUser(UserDto user);

	@Select("SELECT * FROM user WHERE userID = #{userID}")
    UserDto findByUserID(String userID);

	@Select("SELECT COUNT(*) > 0 FROM user WHERE userID = #{userID}")
    boolean existsByUserID(String userID);
	
	@Select("SELECT userID FROM user WHERE email = #{email}")
    String findUserIdByEmail(String email);
	
}
