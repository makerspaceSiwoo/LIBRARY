package com.lib.dto;

import java.util.Date;

import lombok.Data;

@Data
public class BlackListDto {

	private int blacklistno;
	private int boardno;
	private int commno;
	private Date forbid_end;
	private String reason;
	private int userno;
	private String contents;
	
	
}
