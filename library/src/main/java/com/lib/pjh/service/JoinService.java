package com.lib.pjh.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import com.lib.pjh.dao.JoinDao;

import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeMessage.RecipientType;

import com.lib.dto.EmailVo;
import com.lib.dto.UserDto;

@Service("emailService")
public class JoinService {

    private final JoinDao joinDao;
    
    @Autowired
    private JavaMailSender mailSender;
    
    public boolean sendMail(EmailVo email) throws Exception{
    	try {
    		MimeMessage msg = mailSender.createMimeMessage();
    		msg.setSubject(email.getSubject());
    		msg.setText(email.getContent());
    		msg.setRecipient(RecipientType.TO, new InternetAddress(email.getReceiver()));
    		mailSender.send(msg);
    		
    		return true;
    	} catch (Exception ex) {
    		ex.printStackTrace();
    	}
    	return false;
    }
    
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