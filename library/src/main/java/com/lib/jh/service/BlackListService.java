package com.lib.jh.service;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lib.dto.BlackListDto;
import com.lib.dto.BoardDto;
import com.lib.dto.CommDto;
import com.lib.dto.UserDto;
import com.lib.jh.dao.BlackListDao;
import com.lib.jh.dao.BoardDao;
import com.lib.jh.dao.CommDao;
import com.lib.jh.dao.UserDao2;

@Service
public class BlackListService {

	

	
	@Autowired
	UserDao2 userdao;
	
	@Autowired
	BoardDao boardDao;

	@Autowired
	CommDao commDao;
	
	@Autowired
	BlackListDao blackDao;
	
	  //게시글 신고처리 (boardno가 기존에 있으면 신고처리 불가)


	
	// 게시글 신고 처리
    public int reportBoard(BlackListDto dto) {
        
    	return blackDao.insertBoardReportIfNotExists(dto);
    }
    
	
    // 댓글 신고 처리
    public int reportComm(BlackListDto dto) {
        return blackDao.insertCommReport(dto);
    }
    
    
    // 게시글 상태를 REPORTED로 업데이트
    public void boardStateReport(int boardno) {
    	String state = boardDao.boardStateOne(boardno);
    	if(state==null) {
        	blackDao.updateBoardStateToReported1(boardno);
    	}else if( state.equals("BLIND")) {
    		blackDao.updateBoardStateToReported2(boardno);
    	}else {
    		blackDao.updateBoardStateToReported1(boardno);
    	}
    	
    	
    }    
    // 게시글 상세보기 (상태 확인)
    public BoardDto getBoard(int boardno) {
        return boardDao.selectOne(boardno);
    }
    
    // 댓글 상태를 REPORTED로 업데이트
    public void commStateReport(int commno) {
    	String state = commDao.selectOneState(commno);
    	if(state==null) {
        	blackDao.updateCommStateToReported1(commno);
    	}else if( state.equals("BLIND")) {
    		blackDao.updateCommStateToReported2(commno);
    	}else {
    		blackDao.updateCommStateToReported1(commno);
    	}
    	
    }

    
    // 댓글 상세보기 (상태 확인)
    public CommDto getComm(int commno) {
        return commDao.selectOne(commno);
    }
    
    // 블랙리스트 리스트 가져오기
    public List<BlackListDto> BlackListAll(){
    	return blackDao.blacklistAll();
    }
    
    // 블래리스트 삭제 기능
    public void deleteBlackList(int blacklistno) {
    	blackDao.deleteBlackList(blacklistno);
    }
	

    // 사서가 블랙리스트 forbid_end 설정 (3일동안)
    public void updateBlacklistForbid_end_plus(int blacklistno) {
    	Date forbidEnd = blackDao.SelectOneForbidEnd(blacklistno);
        int day = 3; // forbid_end 버튼 클릭 시부터 3일 정지

        if (forbidEnd == null) {
            // forbidEnd가 null이면 클릭 당시 시간으로부터 +3일 정지
            Calendar calendar = Calendar.getInstance();
            calendar.add(Calendar.DAY_OF_MONTH, day);
            Date forbid_end = calendar.getTime();
            blackDao.updateBlacklistForbit_end(forbid_end, blacklistno);
        } else {
            // forbidEnd가 null이 아닌 값이 들어있으면 forbidEnd 값으로부터 +3일 정지
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(forbidEnd);
            calendar.add(Calendar.DAY_OF_MONTH, day);
            Date newForbidEndDate = calendar.getTime();
            blackDao.updateBlacklistForbit_end(newForbidEndDate, blacklistno);
        }
    }
    
    public void updateBlacklistForbid_end_minus(int blacklistno) {
        Date forbidEnd = blackDao.SelectOneForbidEnd(blacklistno);
        int day = 3; // forbid_end 버튼 클릭 시부터 3일 정지

        if (forbidEnd == null) {
            // forbidEnd가 null이면 클릭 당시 시간으로부터 -3일 정지
            Calendar calendar = Calendar.getInstance();
            calendar.add(Calendar.DAY_OF_MONTH, -day);
            Date forbid_end = calendar.getTime();
            blackDao.updateBlacklistForbit_end(forbid_end, blacklistno);
        } else {
            // forbidEnd가 null이 아닌 값이 들어있으면 forbidEnd 값으로부터 -3일 정지
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(forbidEnd);
            calendar.add(Calendar.DAY_OF_MONTH, -day);
            Date newForbidEndDate = calendar.getTime();
            blackDao.updateBlacklistForbit_end(newForbidEndDate, blacklistno);
        }
    }
    
    
 // 현재 날짜 기준으로 값이 적은 것들만 삭제 (blacklist 테이블의 forbid_end 기준)
    public void updateBlacklistForbid_endDelete() {
        List<BlackListDto> blackListDto = blackDao.blacklistAll();

        for (BlackListDto bldto : blackListDto) {
            Date forbidEnd = bldto.getForbid_end();

            if (forbidEnd != null) {
                if (forbidEnd.before(new Date())) {
                    // forbid_end가 만료된 경우 삭제
                    blackDao.deleteBlackList(bldto.getBlacklistno());
                }
            } else {
                System.out.println("forbid_end가 null입니다");
            }
        }
    }
    
    
   
    
 // 현재 날짜 기준으로 값이 적은 것들만 삭제 (user 테이블의 ban 기준)
    public void updateBlacklistUserBanNull() {
        List<UserDto> userDto = userdao.selectUsertAll();
        
        for(UserDto userdto : userDto) {
            Date banDate = userdto.getBan();
            if (banDate != null && banDate.before(new Date())) {
                // user.ban이 현재 날짜 기준으로 값이 적으면 삭제
                userdao.updateUserBan(userdto.getUserno(), null);
            }
            else {}
        }
    }
  
    
 
    
}
