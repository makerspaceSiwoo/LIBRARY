package com.lib.ho.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lib.dto.UserDto;
import com.lib.ho.dao.UserDao;

@Service
public class UserService {

	@Autowired
	UserDao dao;

	public List<UserDto> getAllUsers() {
		return dao.getAllUsers();
	}
	
	public void updateUser(UserDto user) {
        dao.updateUser(user);
    }

	public UserDto findByUserID(String userID) {
        return dao.findByUserID(userID);
    }
}