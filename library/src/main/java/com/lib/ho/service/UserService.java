package com.lib.ho.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lib.dto.UserDto;
import com.lib.ho.dao.UserDao;

@Service
public class UserService {

	@Autowired
	private UserDao dao;

	public List<UserDto> getAllUsers() {
		return dao.getAllUsers();
	}
	
	public void updateUser(UserDto user) {
        dao.updateUser(user);
    }
	
	public String findUserIdByEmail(String email) {
        String userId = dao.findUserIdByEmail(email);
        if (userId != null) {
            return userId;
        } else {
            throw new IllegalArgumentException("일치하는 이메일이 없습니다.");
        }
    }

}