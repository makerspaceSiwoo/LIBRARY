package com.lib.ho.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lib.dto.UserDto;
import com.lib.ho.dao.UserDao;
import com.lib.ho.dto.UnretDto;

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

	public boolean existsByUserID(String userID) {
		return dao.existsByUserID(userID);
	}

	public UserDto findByUserID(String userID) {
		return dao.findByUserID(userID);
	}

	public String findUserIdByEmail(String email) {
		String userId = dao.findUserIdByEmail(email);
		if (userId != null) {
			return userId;
		} else {
			throw new IllegalArgumentException("일치하는 이메일이 없습니다.");
		}
	}

	public void withdrawUser(String userID) {
		dao.updateState("탈퇴", userID);
	}

	public UserDto findUserByIdAndEmail(String userID, String email) {
		return dao.findByUserIdAndEmail(userID, email);
	}

	public void updateUserPassword(int userno, String newPassword) {
		dao.updateUserPassword(userno, newPassword);
	}
	
	public boolean existsByEmail(String email) {
        return dao.existsByEmail(email);
    }
	
	public List<UnretDto> unret(int user){
		return dao.unretbook(user);
	}
	
	public List<UnretDto> record(int user){
		return dao.recodbook(user);
	}
	
}