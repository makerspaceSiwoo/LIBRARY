package com.lib.dto;

import java.util.Date;

import lombok.Data;

@Data
public class userDto {

	private int userno;
	private String admin;
	private String userID;
	private String userPW;
	private String gender;
	private String name;
	private Date birth;
	private int phone;
	private String email;
	private String address;
	private int ban;
	private int penalty;
	private String state;
	
}
