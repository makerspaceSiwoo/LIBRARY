package com.lib.mo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lib.dto.BookDto;
import com.lib.mo.dao.SearchDao;

@Service
public class SearchService {

    @Autowired
    private SearchDao dao;

    public List<BookDto> searchBook(int searchn, String search, String cate, int start){
    	Map<String,Object> m = new HashMap<String, Object>();
    	m.put("searchn", searchn);
    	m.put("search", search);
    	m.put("cate", cate);
    	m.put("start", start);
    	m.put("count", 10);
    	return dao.searchBook(m);
    }
    public int countBook(int searchn, String search, String cate) {   
    	Map<String,Object>m = new HashMap<String,Object>();
    	m.put("searchn", searchn);
    	m.put("search", search);
    	m.put("cate", cate);
    	return dao.countBook(m);
    }
}
