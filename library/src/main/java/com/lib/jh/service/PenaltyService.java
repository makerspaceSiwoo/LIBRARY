package com.lib.jh.service;


import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lib.dto.PenaltyDto;
import com.lib.dto.UserDto;
import com.lib.jh.dao.PenaltyDao;
import com.lib.jh.dao.UserDao2;

@Service
public class PenaltyService {
 
    @Autowired
    private PenaltyDao penaltyDao;

    @Autowired
    private BlackListService blacklistService;
    
    @Autowired
    private UserDao2 userdao;
    
    
    public void updatePenaltyAndUserStatus() {
        List<PenaltyDto> penalties = penaltyDao.getAllPenalties();

        for (PenaltyDto penalty : penalties) {
            if (penalty.getPenalty_end().before(new Date())) {
                // 패널티가 만료된 경우 (penalty_end 컬럼이 현재 날자보다 적을경우) , 대출 날자가 지나면 재현이 형이 만든걸로 user 패널티가 1로 되서 들어옴 
            	penaltyDao.updateUserPenalty(penalty.getUserno(), 0); // user 패널티 0으로 변경
            	penaltyDao.deletePenalty(penalty.getPenaltyno());
            } else {
                // 패널티가 유효한 경우 ( 중복으로 대출금지 당했을때 , 재현이 형이 SQL문 수정해야됨 만약 중복으로 유저가 있으면 INSERT가 아닌 UPDATE ) 
                penaltyDao.updateUserPenalty(penalty.getUserno(), 1); // user 패널티 1로 설정
            }
        }
        
   
        
    }
    
 // 사용자 ban 상태를 업데이트하는 메서드
    public void updateUserBanStatusPlus(int userno, int boardno, Date forbid_end,int blacklistno) {
        
    	// 현재 시간
        Date now = new Date();

        // 사용자 정보 조회
        UserDto user = userdao.selectUserById(userno);

        // 사용자의 현재 Ban상태
        Date currentBanEnd = user.getBan();
        
        
      
        blacklistService.updateBlacklistForbid_end_plus(blacklistno); //
        
        if (currentBanEnd == null) {  //기존 벤이 없는경우 
            
        	userdao.updateUserBan(userno, forbid_end);
        	
            
        }
        else { //기존 벤이 있으면
            long additionalBanTime = forbid_end.getTime() - now.getTime();
            Date newBanEnd = new Date(currentBanEnd.getTime() + additionalBanTime);
            System.out.println("currentBanEnd"+currentBanEnd);
            System.out.println(newBanEnd);
            userdao.updateUserBan(userno, newBanEnd); // 사용자 ban 업데이트
            
            
        }
        
       }
    
    
 // 사용자 ban 상태를 업데이트하는 메서드
    public void updateUserBanStatusMinus(int userno, int boardno, Date forbid_end,int blacklistno) {
        
    	// 현재 시간
        Date now = new Date();

        // 사용자 정보 조회
        UserDto user = userdao.selectUserById(userno);

        // 사용자의 현재 Ban상태
        Date currentBanEnd = user.getBan();
        
        
      
        blacklistService.updateBlacklistForbid_end_minus(blacklistno); //
        
        if (currentBanEnd != null) {
        	long additionalBanTime = forbid_end.getTime() - now.getTime();
            Date newBanEnd = new Date(currentBanEnd.getTime() + additionalBanTime);
            System.out.println("currentBanEnd"+currentBanEnd);
            System.out.println(newBanEnd);
            userdao.updateUserBan(userno, newBanEnd); // 사용자 ban 업데이트
        }
        
//        if (currentBanEnd == null) {  //기존 벤이 없는경우 
//            
//        	userdao.updateUserBan(userno, forbid_end);
//        	
//            
//        }
//        else { //기존 벤이 있으면
//            long additionalBanTime = forbid_end.getTime() - now.getTime();
//            Date newBanEnd = new Date(currentBanEnd.getTime() + additionalBanTime);
//            System.out.println("currentBanEnd"+currentBanEnd);
//            System.out.println(newBanEnd);
//            userdao.updateUserBan(userno, newBanEnd); // 사용자 ban 업데이트
//            
//            
//        }
//        
       }
    

  }
    
    
    
