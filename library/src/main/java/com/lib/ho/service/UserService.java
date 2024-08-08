package com.lib.ho.service;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.boot.autoconfigure.security.SecurityProperties.User;

@Mapper
public interface UserService {

	@Select("SELECT * FROM user WHERE userID = #{userID} AND userPW = #{userPW}")
    User getUserByCredentials(String userID, String userPW);
	
}
