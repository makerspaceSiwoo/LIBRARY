package com.lib.mo.dao;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.lib.mo.dto.RecommDto;

@Mapper
public interface RecommDao {

//	전체
	@Select({"select b.booktitle, b.author, b.category, b.img, count(r.bookno) as ct "
			+ "from book b join record r on b.bookno "
			+ "where r.type = '대출' "
			+ "AND r.start BETWEEN DATE_SUB(NOW(), INTERVAL 6 MONTH) AND NOW() "
			+ "group by b.bookno, b. booktitle, b.category "
			+ "order by ct desc limit 10"})
	List<RecommDto> allrcbook();

//	카테고리
	@Select({"select b.booktitle, b.author, b.category, b.img, count(r.bookno) as ct "
			+ "from book b join record r on b.bookno = r.bookno "
			+ "join (select distinct SUBSTRING_INDEX(category, '/', 1) as category "
			+ "from book where bookno in (select bookno from record where userno = #{userno})limit 1) "
			+ "as cat on SUBSTRING_INDEX(b.category, '/', 1) = cat. category "
			+ "where r.type = '대출' "
			+ "AND r.start BETWEEN DATE_SUB(NOW(), INTERVAL 6 MONTH) AND NOW() "
			+ "group by b.bookno order by ct desc limit 10"})
	List<RecommDto> catercbook(@Param("userno") int userno);
	
//	성별
	@Select({"select b.booktitle, b.author, b.category, b.img, count(r.bookno) as ct "
			+ "from book b join record r on b.bookno = r.bookno "
			+ "join user u on r.userno = u.userno "
			+ "where r.type = '대출' and u.gender = #{gender} "
			+ "and r.start BETWEEN DATE_SUB(NOW(), INTERVAL 6 MONTH) AND NOW() "
			+ "group by b.bookno order by ct desc limit 10"})
	List<RecommDto> genrcbook(@Param("gender") String gender);
	
//	연령대
	@Select({"select "
			+ "    case "
			+ "		when (year(now()) - year(#{birth}) + 1) between 1 and 9 then '영유아' "
			+ "        when (year(now()) - year(#{birth}) + 1) between 10 and 19 then '10대' "
			+ "        when (year(NOW()) - year(#{birth}) + 1) between 20 and 29 then '20대' "
			+ "        when (year(NOW()) - year(#{birth}) + 1) between 30 and 39 then '30대' "
			+ "        when (year(NOW()) - year(#{birth}) + 1) between 40 and 49 then '40대' "
			+ "        else '50대 이상' "
			+ "    end as group, b.booktitle, b.author, b.category, b.img, count(r.bookno) as ct "
			+ "from  book b join  record r on b.bookno = r.bookno "
			+ "join  user u on r.userno = u.userno "
			+ "where r.type = '대출' "
			+ "group by  group, b.bookno order by age_group, ct desc"})
	List<RecommDto> agercbook(@Param("birth") Date birth);
	
}
