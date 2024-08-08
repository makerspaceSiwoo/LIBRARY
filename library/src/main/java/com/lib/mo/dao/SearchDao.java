package com.lib.mo.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.lib.dto.BookDto;

@Mapper
public interface SearchDao {
	
	@Select({ "<script>select * from book",
		"<where><choose><when test=\"searchn == 0\">booktitle like concat('%',#{search},'%')</when>",
		"<when test=\"searchn == 1\">category like concat('%',#{search},'%')</when>",
		"<when test=\"searchn == 2\">author like concat('%',#{search},'%')</when>",
		"</choose></where> order by booktitle limit #{start}, #{count}</script>"})
	List<BookDto> searchBook(Map<String, Object> params);
	
	@Select({ "<script>select count(*) from book", "<where>","<choose>",
		"<when test=\"searchn == 0\">booktitle like concat('%',#{search},'%')</when>",
		"<when test=\"searchn == 1\">category like concat('%',#{search},'%') </when>",
		"<when test=\"searchn == 2\">author like concat('%',#{search},'%') </when>", "</choose></where></script>" })
	int countBook(Map<String, Object>m);
}