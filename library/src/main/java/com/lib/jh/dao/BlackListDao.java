 package com.lib.jh.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.lib.dto.BlackListDto;

@Mapper
public interface BlackListDao {

	//블랙리스트 리스트 가져오기
	@Select("SELECT * FROM blacklist order by blacklistno desc")
	List<BlackListDto> blacklistAll();
	
	// 게시글 신고 삽입
	@Insert("INSERT INTO blacklist (boardno, forbid_end, reason, userno, contents) VALUES (#{boardno}, null, #{reason}, #{userno}, #{contents})")
    int insertBlacklistBoardReport(BlackListDto dto);
	
	// 댓글 신고 삽입
    @Insert("INSERT INTO blacklist (boardno,commno, forbid_end, reason, userno, contents) VALUES (#{boardno},#{commno}, null, #{reason}, #{userno}, #{contents})")
    int insertCommReport(BlackListDto dto);
    
    // 사서가 게시글 STATE 업데이트 ( 신고시 BLIND로 STATE변경) 
    @Update("UPDATE board SET state = 'BLIND' WHERE boardno = #{boardno}")
    int updateBoardStateToReported1(int boardno);
    
    // 사서가 게시글 STATE 업데이트 ( 신고시 null로 STATE변경) 
    @Update("UPDATE board SET state = null WHERE boardno = #{boardno}")
    int updateBoardStateToReported2(int boardno);
    

    // 사서가 댓글 STATE 업데이트 (신고시 BLIND로 상태로 변경)
    @Update("UPDATE comm SET state = 'BLIND' WHERE commno = #{commno}")
    int updateCommStateToReported1(int commno);
    // 사서가 댓글 STATE 업데이트 (신고시 null로 상태로 변경)
    @Update("UPDATE comm SET state = null WHERE commno = #{commno}")
    int updateCommStateToReported2(int commno);
    
    // 사서가 블랙리스트 확인후 블랙리스트에서 삭제하기
    @Delete("DELETE FROM BLACKLIST WHERE BLACKLISTNO = #{blacklistno}")
    int deleteBlackList(int blacklistno);
    
    // 사서가 블랙리스트 forbid_end 설정
    @Update("UPDATE blacklist SET forbid_end = #{forbid_end} WHERE blacklistno=#{blacklistno}")
    int updateBlacklistForbit_end(@Param("forbid_end")Date forbid_end ,@Param("blacklistno")int blacklistno);
    
    @Select("SELECT forbid_end FROM blacklist WHERE blacklistno = #{blacklistno}")
    Date SelectOneForbidEnd(int blacklistno);
    
    //count가 0일떄 boardno가 없는것.
    @Select("SELECT COUNT(*) FROM blacklist WHERE boardno = #{boardno}")
    int countByBoardno(@Param("boardno") int boardno);

    // 
    default int insertBoardReportIfNotExists(BlackListDto dto) {
        // boardno가 존재하지 않을 때만 삽입
        if (countByBoardno(dto.getBoardno()) == 0) {
            return insertBlacklistBoardReport(dto);//게시글 신고 삽입
        }
        return 0; // 이미 존재하여 삽입이 되지 않은 경우 0 반환	
    }
    
    // 특정 사용자와 게시글에 대한 블랙리스트 정보를 조회
    @Select("SELECT * FROM blacklist WHERE userno = #{userno} AND boardno = #{boardno}")
    BlackListDto getBlackListByUserAndBoard(@Param("userno")int userno, @Param("boardno")int boardno);

    // 블랙리스트 번호로 블랙리스트 정보를 조회 
    @Select("SELECT * FROM blacklist WHERE blacklistno = #{blacklistno}")
    BlackListDto getBlackListById(int blacklistno);
	
}
