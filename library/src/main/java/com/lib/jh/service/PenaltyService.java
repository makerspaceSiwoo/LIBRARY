package com.lib.jh.service;


import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lib.dto.PenaltyDto;
import com.lib.jh.dao.PenaltyDao;

@Service
public class PenaltyService {
 
    @Autowired
    private PenaltyDao penaltyDao;
    
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
}