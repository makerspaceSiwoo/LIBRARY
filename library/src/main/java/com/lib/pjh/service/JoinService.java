package com.lib.pjh.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.lib.pjh.dao.JoinDao;
import com.lib.dto.UserDto;

@Service
public class JoinService {

    private final JoinDao joinDao;

    @Autowired
    public JoinService(JoinDao joinDao) {
        this.joinDao = joinDao;
    }

    public boolean checkUserIdDuplicate(String userID) {
        int count = joinDao.checkid(userID);
        return count > 0; // 중복된 아이디가 있으면 true 반환
    }

    public void registerUser(UserDto user) {
        joinDao.insertUser(user);
    }
}