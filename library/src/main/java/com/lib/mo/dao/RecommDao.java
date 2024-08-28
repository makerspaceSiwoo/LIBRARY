package com.lib.mo.dao;

import java.util.Date;
import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.lib.mo.dto.RecommDto;

@Mapper
public interface RecommDao {

//	전체
	@Select({"SELECT LEFT(b.callno, LOCATE('=', b.callno) - 1) AS callno_prefix, COUNT(r.bookno) AS ct, MIN(b.booktitle) AS booktitle, "
			+ "MIN(b.author) AS author, MIN(b.publisher) AS publisher, MIN(b.category) AS category, min(b.callno) as callno, MIN(b.img) AS img "
			+ "FROM book b "
			+ "JOIN record r ON b.bookno = r.bookno "
			+ "WHERE r.type = '대출' AND r.start BETWEEN DATE_SUB(NOW(), INTERVAL 6 MONTH) AND NOW() "
			+ "GROUP BY callno_prefix "
			+ "ORDER BY ct DESC "
			+ "LIMIT 10"})
	List<RecommDto> allrcbook();

//	카테고리
	@Select({"SELECT left(b.callno, LOCATE('=', b.callno) - 1) as callno_prefix, min(b.booktitle) as booktitle, min(b.author) as author, "
			+ "min(b.publisher) as publihser, min(b.category) as category, min(b.img) as img, min(b.callno) as callno, COUNT(r.bookno) AS ct "
			+ "FROM book b "
			+ "JOIN record r ON b.bookno = r.bookno "
			+ "JOIN (SELECT SUBSTRING_INDEX(b.category, '/', 1) AS category, COUNT(r.bookno) AS cnt "
			+ "      FROM book b \r\n"
			+ "      JOIN (SELECT * FROM record WHERE userno = #{userno} AND type = '대출') r ON b.bookno = r.bookno "
			+ "      GROUP BY category "
			+ "      ORDER BY cnt DESC "
			+ "      LIMIT 1) AS cat ON SUBSTRING_INDEX(b.category, '/', 1) = cat.category "
			+ "WHERE r.type = '대출' "
			+ "AND r.start BETWEEN DATE_SUB(NOW(), INTERVAL 6 MONTH) AND NOW() "
			+ "GROUP BY callno_prefix "
			+ "ORDER BY ct DESC "
			+ "LIMIT 10"})
	List<RecommDto> catercbook(@Param("userno") int userno);
	
//	성별
	@Select({"select left(b.callno, LOCATE('=', b.callno) - 1) as callno_prefix, min(b.booktitle) as booktitle, min(b.author) as author, min(b.publisher) as publisher, "
			+ "min(b.category) as category, min(b.img) as img, min(b.callno) as callno, count(r.bookno) as ct "
			+ "from book b join record r on b.bookno = r.bookno "
			+ "join user u on r.userno = u.userno "
			+ "where r.type = '대출' and u.gender = #{gender} "
			+ "and r.start BETWEEN DATE_SUB(NOW(), INTERVAL 6 MONTH) AND NOW() "
			+ "group by callno_prefix order by ct desc limit 10"})
	List<RecommDto> genrcbook(@Param("gender") String gender);
	
//	연령대
	@Select({"select \r\n"
			+ "       min(b.booktitle) as booktitle, min(b.author) as author, min(b.publisher) as publisher, min(b.category) as category, \r\n"
			+ "		min(b.img) as img, min(b.callno) as callno, COUNT(r.bookno) AS ct, left(b.callno, LOCATE('=', b.callno) - 1) as callno_prefix ,\r\n"
			+ "       min(((YEAR(NOW()) - year(r.birth)) div 10)*10 )as agegroup\r\n"
			+ "from book b join (select * from record r natural join user u where (YEAR(NOW()) - year(u.birth)) div 10 = #{group}) r on b.bookno = r.bookno\r\n"
			+ "WHERE r.type = '대출' AND r.start BETWEEN DATE_SUB(NOW(), INTERVAL 6 MONTH) AND NOW() \r\n"
			+ "GROUP BY callno_prefix\r\n"
			+ "ORDER BY ct DESC limit 10"})
	List<RecommDto> agercbook(@Param("group") int group);
	
}
