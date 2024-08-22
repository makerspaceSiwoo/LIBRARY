package com.lib.pjh.dao;


import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.lib.dto.BorrowDto;
import com.lib.dto.UnreturnDto;
import com.lib.dto.UserDto;

import lombok.experimental.PackagePrivate;

@Mapper
public interface BookDao {

	@Select("select b.booktitle, b.author,b.bookno, b.callno ,u.end as u_end,u.borrowno,u.userno from book b left join unreturned u on b.bookno = u.bookno where b.booktitle like concat('%',#{booktitle},'%') limit #{size} offset #{offset}")
	List<BorrowDto> borrowbook(@Param("booktitle") String booktitle,@Param("size")int size,@Param("offset")int offset);
	//검색 기능
	
	@Insert("insert into record (type, bookno, userno,end) values('반납',#{bookno},#{userno},now())")
	void borrowno(@Param("bookno") int bookno, @Param("userno")int userno);
	//반납시 record 테이블 등록
	
	@Insert("insert into record (start, end, type, bookno, userno) values(now(),date_add(now(),interval 7 day),'대출',#{bookno},(select userno from user where userID = #{userID}))")
	void bookno(@Param("bookno")int bookno,@Param("userID")String userID);
	//대출시 record 테이블 등록
	
	@Insert("insert into unreturned (end,bookno,userno) values(date_add(now(),interval 7 day),#{bookno},(select userno from user where userID = #{userID}))")
	void unreturn(@Param("bookno")int bookno,@Param("userID")String userID);
	//대출시 unrecord 테이블 등록

	@Insert("insert into penalty(penalty_end, userno) values(date_add(now(), interval timestampdiff(day, now(), #{u_end}) day),#{userno})")
	void latereturn(@Param("userno") int userno,@Param("u_end") Date u_end);
	//연체 반납시 패널티 테이블 등록
	
//	@Select("select penalty_end from penalty where userno=#{userno}")
//	Date penalty_end(int userno);
	
	@Update("update user set penalty=1 where userno=#{userno}")
	void penalty(@Param("userno") int userno);
	//연체 반납시 user 테이블 회원 penalty값=1로(패널티상태) 변경
	
	@Delete("delete from unreturned where bookno=#{bookno}")
	void delete(@Param("bookno") int bookno);
	//반납,연체 반납완료시 unrecord 테이블 값 삭제
	
	@Select("select count(*) from user where penalty=1 and userID=#{userID}")
	int prohibited(@Param("userID")String userID);
	//연체시 대출기능 정지를 위한 패널티보유자 검색
	
	@Select("select count(*) from unreturned where userno=(select userno from user where userID=#{userID})")
	int treebook(@Param("userID")String userID);
	//책3권 제한하기위한 개수검색
	
	 @Select("SELECT COUNT(*) FROM book WHERE booktitle LIKE CONCAT('%', #{booktitle}, '%')")
	int countBooks(@Param("booktitle") String booktitle);
	}//페이징
	
