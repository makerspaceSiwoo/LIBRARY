package com.lib.mo.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.lib.mo.dto.RecommDto;

@Mapper
public interface RecommDao {

	@Select({"<script>select b.booktitle, b.author, b.publisher, b.pubyear, u.gender, b.img,",
			"year(now()) - year(u.birth) + 1 as age, count(r.bookno) as bookcount",
			"from record r left outer join user u on r.userno = u.userno inner join book b  on r.bookno = b.bookno",
			"<where>u.gender like concat(#{gen},'%') and b.category like concat ('%',#{cate},'%')",
			"and r.type='대출' and r.start=>date_sub(now(),interval #{mon}month)",
			"and(year(now())-year(u.birth)+1) between #{start} and #{end}</where>",
			"group by r.bookno, u.name, b.booktitle, b.author, b.publisher, b.pubyear, age, u.gender, b.img",
			"order by bookcount desc limit 10</script>"})
	List<RecommDto> recommbook(Map<String, Object>params);
	
	@Select({"<script>select b.booktitle, b.author, b.publisher, b.pubyear, u.gender, b.img",
			"year(now()) - year(u.birth) + 1 as age, count(r.bookno) as bookcount",
			"from record r left outer join user u on r.userno = u.userno inner join book b  on r.bookno = b.bookno",
			"<where>gender like concat(#{gen},'%') and b.category like concat ('%',#{cate},'%')",
			"and r.type='대출'and r.start=>date_sub(now(),interval #{mon}month)",
			"and(year(now())-year(u.birth)+1) between #{start} and #{end}</where>",
			"group by r.bookno, u.name, b.booktitle, b.author, b.publisher, b.pubyear, age, u.gender, b.img</script>"})
	int recommcount(Map<String, Object>m);
}
