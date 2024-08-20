package com.lib.dto;

import java.util.Date;

import lombok.Data;

@Data
public class CommDto {

	private int boardno;
	private int commno;
	private String contents;
	private int userno;
	private Date write_date;
	private String state;
	private String userId;
}
