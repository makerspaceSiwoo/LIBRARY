package com.lib.dto;

import java.util.Date;

import lombok.Data;

@Data
public class BorrowDto {
	private String booktitle;
	private String author;
	private String callno;
	private int userno;
	private Date start;
	private Date end;
	private int recordno;
	private String type;
	private int bookno;
	private int borrowno;
	private Date r_start;
	private Date u_end;
	private int no;
	private String userID;
	
}
