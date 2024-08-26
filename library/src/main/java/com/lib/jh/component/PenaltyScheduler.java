package com.lib.jh.component;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.lib.jh.service.BlackListService;
import com.lib.jh.service.PenaltyService;

@Component
public class PenaltyScheduler {

    @Autowired
    private PenaltyService penaltyService;
    
    @Autowired
    private BlackListService blacklistService;
    // 매시 2분 마다 스케쥴링
    @Scheduled(cron = "0 2 * * * ?")
    public void schedulePenaltyUpdate() {
    	penaltyService.updatePenaltyAndUserStatus(); //자동으로 penalty_end기간이 현재 날짜값 지나면 user.penalty 상태값을 0으로 바꾸고 penalty테이블에서 레코드삭제
    	blacklistService.updateBlacklistForbid_endDelete();//자동으로 forbid_end 기간이 현재 날짜값 지나면 blacklist에서 삭제
    	blacklistService.updateBlacklistUserBanNull();//자동으로 user.ban 기간이 현재 날짜 값지나면 ban null로꿈
        
    }
    

}