package com.lib.jh.service;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lib.dto.BlackListDto;
import com.lib.dto.BoardDto;
import com.lib.dto.CommDto;
import com.lib.jh.dao.BlackListDao;
import com.lib.jh.dao.BoardDao;
import com.lib.jh.dao.CommDao;
import com.lib.jh.dao.UserDao2;

@Service
public class BlackListService {

	@Autowired
	BoardDao boardDao;

	@Autowired
	CommDao commDao;
	
	@Autowired
	BlackListDao blackDao;
	
	@Autowired
    private UserDao2 userDao;
	
	// 게시글 신고 처리
    public int reportBoard(BlackListDto dto) {
        return blackDao.insertBoardReport(dto);
    }

    // 댓글 신고 처리
    public int reportComm(BlackListDto dto) {
        return blackDao.insertCommReport(dto);
    }
    
    
    // 게시글 상태를 REPORTED로 업데이트
    public void boardStateReport(int boardno) {
    	blackDao.updateBoardStateToReported(boardno);
    }
    
    // 게시글 상세보기 (상태 확인)
    public BoardDto getBoard(int boardno) {
        return boardDao.selectOne(boardno);
    }
    
    // 댓글 상태를 REPORTED로 업데이트
    public void commStateReport(int commno) {
    	blackDao.updateCommStateToReported(commno);
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
    public void updateBlacklistForbit_end(int blacklistno) {
    	LocalDate currentDate = LocalDate.now();
    	int day = 3; // forbid_end 버튼 클릭 했을 당시 부터 3일 정지
    	Date forbid_end = java.sql.Date.valueOf(currentDate.plusDays(day)); // LocalDate 타입을 Date타입으로 변환
    	blackDao.updateBlacklistForbit_end(forbid_end, blacklistno);
    }
    
    // blacklist.forbid_end를 user.ban으로 전달 해야되는데 이미 있다면 blacklist.forbid_end 에서 - 현재날자값 뺀후 남은 값을 user.ban에 더해줘야됨
    
    
}
