package com.lib.dto;

import java.util.Date;

import lombok.Data;

@Data
public class UnreturnedDto {

	private int bookno;
	private int borrowno;
	private Date end;
	private int userno;
	
}
