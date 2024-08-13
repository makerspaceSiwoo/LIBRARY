package com.lib.dto;

import java.util.Date;

import lombok.Data;

@Data
public class BoardDto {

	private int boardno;
	private String contents;
	private String title;
	private String type;
	private int userno;
	private int view;
	private Date write_date;
	private String state;
	
	
}
