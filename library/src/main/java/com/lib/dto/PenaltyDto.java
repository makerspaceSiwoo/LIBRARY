package com.lib.dto;

import java.util.Date;

import lombok.Data;

@Data
public class PenaltyDto {

	private Date penalty_end;
	private int penaltyno;
	private int userno;
	private Date unreturned_end;
	private Date record_end; 
	
}
