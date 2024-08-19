package com.lib.mo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lib.mo.dao.RecommDao;
import com.lib.mo.dto.RecommDto;

@Service
public class RecommService {
	@Autowired
	RecommDao dao;
	
	public List<RecommDto> recommbook(String gen, String cate, int mon, int start, int end){
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("gen", gen);
		m.put("cate", cate);
		m.put("mon", mon);
		m.put("start", start);
		m.put("end", end);
		return dao.recommbook(m);
	}
	
	public int recommcount(String gen, String cate, int mon, int start, int end) {
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("gen", gen);
		m.put("cate", cate);
		m.put("mon", mon);
		m.put("start", start);
		m.put("end", end);
		return dao.recommcount(m);
	}
}
