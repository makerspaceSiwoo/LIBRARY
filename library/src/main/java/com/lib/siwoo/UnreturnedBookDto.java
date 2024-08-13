package com.lib.siwoo;

import java.sql.Date;

import com.lib.dto.BookDto;

import lombok.Data;

@Data
public class UnreturnedBookDto {
	private int bookno;
	private String callno;
	private String booktitle;
	private String author;
	private String publisher;
	private int pubyear;
	private String loc;
	private String category;
	private String img; // 이미지 링크
	private int userno; // 빌린 유저
	private Date end; // 반납 기한
}
