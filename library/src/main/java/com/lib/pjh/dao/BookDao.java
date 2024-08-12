package com.lib.pjh.dao;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.lib.dto.BorrowDto;

@Mapper
public interface BookDao {

	@Select("SELECT b.booktitle, b.author,b.bookno, b.callno,r.type,r.recordno ,r.userno ,r.start, r.end FROM book b left outer JOIN record r ON b.bookno = r.bookno where b.booktitle like concat('%',#{booktitle},'%')")
	List<BorrowDto> borrowbook(String booktitle);
	
	@Update("update record set type=null where recordno=#{recordno}")
	void recordno(int recordno);
	
	@Insert("insert into record (start, end, type, bookno, userno) values(now(),date_add(now(),interval 12 day),'대출',#{bookno},#{userno})")
	void bookno(@Param("bookno") int bookno,@Param("userno") int userno);
}