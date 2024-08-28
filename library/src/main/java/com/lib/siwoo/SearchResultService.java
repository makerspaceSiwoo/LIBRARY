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
		
		char[] delimiters = {';', ',','&'}; // 특정 문자들

	    int minIndex = author.length();
	        // 특정 문자들 중 하나가 나올 때까지 반복
	    for (char delimiter : delimiters) {
	         int index = author.indexOf(delimiter);
	         if (index != -1 && index < minIndex) {
	             minIndex = index;
	         }
	    }
	        // 자른 결과
	    String result = author.substring(0, minIndex); 
	     // 모든 띄어쓰기를 %로 대체
	    result = result.replace(" ", "%"); 
	        // 앞뒤로 % 붙이기
	    result = "%" + result + "%";
	     
		callno = callno.substring(0, callno.length() - 1); // 청구 기호 마지막 문자 제거 -> 같은 책들은 검색결과 제외
		String pattern = "-([가-힣a-zA-Z])(\\d+)";  // -[한글/영어][숫자] 추출 패턴
        Pattern r = Pattern.compile(pattern);
        Matcher m = r.matcher(callno);
        String authorinfo=""; // 청구기호 중 저자 번호

        if (m.find()) {
            String matchedPart = m.group(0);  // 전체 매칭된 부분 (-임74)
            authorinfo = matchedPart;
        }
		List<BookDto> blist = dao.sameAuthor(result, authorinfo ,callno);
		return blist;
	}
}
