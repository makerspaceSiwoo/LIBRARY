package com.lib.dto;

import java.util.Date;

import lombok.Data;

@Data
public class UnreturnDto {
	private String booktitle;
	private String author;
	private String callno;
	private int userno;
	private Date start;
	private Date end;
	private Date unreturned_end;
	private Date record_end;
	private int recordno;
	private String type;
	private int bookno;
	private int borrowno;
	
}
