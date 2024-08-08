package com.lib.dto;

import java.util.Date;

import lombok.Data;

@Data
public class Record {

	private int bookno;
	private Date end;
	private int recordno;
	private Date start;
	private String type;
	private int userno;
	
}
