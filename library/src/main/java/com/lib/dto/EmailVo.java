package com.lib.dto;

import lombok.Data;

@Data
public class EmailVo {
	private String subject;
	private String content;
	private String data;
	private String receiver;

}
