package com.lib.siwoo;

import java.util.List;

import lombok.Data;

@Data
public class NaverBookDto {
	
	private String lastBuildDate;
	private int total;
	private int start;
	private int display;
	private List<Item> items;
}
