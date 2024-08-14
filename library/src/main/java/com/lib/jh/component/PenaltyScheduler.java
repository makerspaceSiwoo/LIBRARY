package com.lib.jh.component;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.lib.jh.service.PenaltyService;

@Component
public class PenaltyScheduler {

    @Autowired
    private PenaltyService penaltyService;

    // 매일 자정에 실행
    @Scheduled(cron = "0 0 0 * * ?")
    public void schedulePenaltyUpdate() {
        penaltyService.updatePenaltyAndUserStatus();
    }
    

}