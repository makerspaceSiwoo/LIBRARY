package com.lib.siwoo;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lib.dto.BookDto;

@Service
public class SearchResultService {

	@Autowired
	SearchResultDao dao;
	
	public List<UnreturnedBookDto> searchResult(String callno) {
		List<UnreturnedBookDto> blist = new ArrayList<>();
		// callno 가공
		String result = callno.split("=")[0] + "=";
		blist = dao.searchResult(result); // 동일한 책의 목록을 저장
		return blist;
	}
	
	public List<BookDto> sameAuthor(String author, String callno){
		// 같은 저자의 다른 책
		// 같은 저자는 같은 callno
		String pattern = "-([가-힣a-zA-Z])(\\d+)";  // -[한글/영어][숫자] 추출 패턴

        Pattern r = Pattern.compile(pattern);
        Matcher m = r.matcher(callno);
        String authorinfo="";
        if (m.find()) {
            String matchedPart = m.group(0);  // 전체 매칭된 부분 (-임74)
            authorinfo = matchedPart;
        }
		List<BookDto> blist = dao.sameAuthor(author,authorinfo ,callno);
		return blist;
	}
}
