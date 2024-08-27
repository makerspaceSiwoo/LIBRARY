package com.lib.siwoo;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lib.dto.BookDto;

@Service
public class AddBookMetaService {
	
	@Autowired
	AddBookMetaDao dao;
	
	private String[][] allcategory = {
			// 000
			{"총류","도서관,서지학","문헌정보학","백과사전","강연집, 수필집, 연설문집","일반 연속간행물",
				"일반학회, 단체, 협회, 기관","신문, 언론, 저널리즘","일반전집, 총서","향토자료"},
			// 100
			{"철학","형이상학","인식론, 인과론, 인간학","철학의 체계","경학","아시아철학,사상","서양철학",
				"논리학","심리학","윤리학,도덕철학"},
			// 200
			{"종교","비교종교","불교","기독교","도교","천도교","신도","파라문교, 인도교","회교(이슬람교)","기타 제종교"},
			// 300
			{"사회과학","통계학","경제학","사회학, 사회문제","정치학","행정학","법학","교육학","풍속, 민속학","국방, 군사학"},
			// 400
			{"자연과학","수학","물리학","화학","천문학","지학","광물학","생명과학","식물학","동물학"},
			// 500
			{"기술과학","의학","농업,농학","공학, 공학일반","건축공학","기계공학","전기공학, 전자공학",
				"화학공학","제조업","가정학 및 가정생활"},
			// 600
			{"예술","건축술","조각","공예, 장식미술","서예","회화, 도화","사진술","음악","연극","오락, 운동"},
			// 700
			{"언어","한국어","중국어","일본어","영어","독일어","프랑스어","스페인어","이탈리아어","기타제어"},
			// 800
			{"문학","한국문학","중국문학","일본문학","영미문학","독일문학","프랑스문학","스페인문학","이탈리아문학","기타 제문학"},
			// 900
			{"역사","아시아(아세아)","유럽(구라파)","아프리카","북아메리카(북미)", "남아메리카(남미)",
				"오세아니아(대양주)","양극지방","지리","전기"}
			};
		
	public int addBookLocOne(BookDto dto) { // loc 가 비어있는 book을 찾아 입력 - 책 추가 시 행해야 함
		int done=0;
		String callno = dto.getCallno();
		if(Character.isDigit(callno.charAt(0))) {
			// 숫자로 시작
			dto.setLoc("종합자료실");
		}else {
			switch ((callno.charAt(0))) {
			case '디': {
				dto.setLoc("디지털 자료실");
				break;
			}
			case 'C':
			case '외': {
				dto.setLoc("외국어 자료실");
				break;
			}
			case '아':{
			}
			case '유':{
				dto.setLoc("아동/청소년 자료실");
				break;
			}
			default:
				dto.setLoc("종합자료실");
				break;
			}
		}
		done += 1;
		return done;
	}
		
	public int addBookCategoryOne(BookDto dto) { // category가 비어있는 도서 분류를 추가
		int done=0;
		String category = "";
		String callno = dto.getCallno();
		int sub = 0;
        String pattern = "([가-힣a-zA-Z]*)(\\d{1,3})(\\.\\d+)?";  // 앞의 문자들을 제외하고 숫자 1~3자리를 추출하는 패턴
        Pattern r = Pattern.compile(pattern);
        Matcher m = r.matcher(callno);
		try {
			if (m.find()) {
	            sub = Integer.parseInt(m.group(2));  // 첫 번째 매칭된 숫자 부분을 추출
	        }
		}catch(Exception e) {
			e.printStackTrace();
		}
		int a = sub/100; // 대분류 _xx
		int b = (sub%100)/10; // 소분류 x_x
		category = allcategory[a][0]+"/"+allcategory[a][b];
		dto.setCategory(category);
		done +=1;
		return done;
	}

//	public int addBookLoc() { // loc 가 비어있는 book을 찾아 입력 - 책 추가 시 행해야 함
//	int done=0;
//	done += dao.addBookLoc("디지털 자료실", "디");
//	done += dao.addBookLoc("외국어 자료실", "외");
//	done += dao.addBookLoc("아동/청소년 자료실", "아");
//	done += dao.addBookLoc("아동/청소년 자료실", "유");
//	done += dao.addBookLoc("종합자료실", "[0-9]");
//	return done;
//}	
//	
//	public int addBookCategory() { // category가 비어있는 도서분류를 추가
//		int done=0;
//		String[][] all = {
//				// 000
//				{"총류","도서관,서지학","문헌정보학","백과사전","강연집, 수필집, 연설문집","일반 연속간행물",
//					"일반학회, 단체, 협회, 기관","신문, 언론, 저널리즘","일반전집, 총서","향토자료"},
//				// 100
//				{"철학","형이상학","인식론, 인과론, 인간학","철학의 체계","경학","아시아철학,사상","서양철학",
//					"논리학","심리학","윤리학,도덕철학"},
//				// 200
//				{"종교","비교종교","불교","기독교","도교","천도교","신도","파라문교, 인도교","회교(이슬람교)","기타 제종교"},
//				// 300
//				{"사회과학","통계학","경제학","사회학, 사회문제","정치학","행정학","법학","교육학","풍속, 민속학","국방, 군사학"},
//				// 400
//				{"자연과학","수학","물리학","화학","천문학","지학","광물학","생명과학","식물학","동물학"},
//				// 500
//				{"기술과학","의학","농업,농학","공학, 공학일반","건축공학","기계공학","전기공학, 전자공학",
//					"화학공학","제조업","가정학 및 가정생활"},
//				// 600
//				{"예술","건축술","조각","공예, 장식미술","서예","회화, 도화","사진술","음악","연극","오락, 운동"},
//				// 700
//				{"언어","한국어","중국어","일본어","영어","독일어","프랑스어","스페인어","이탈리아어","기타제어"},
//				// 800
//				{"문학","한국문학","중국문학","일본문학","영미문학","독일문학","프랑스문학","스페인문학","이탈리아문학","기타 제문학"},
//				// 900
//				{"역사","아시아(아세아)","유럽(구라파)","아프리카","북아메리카(북미)", "남아메리카(남미)",
//					"오세아니아(대양주)","양극지방","지리","전기"}
//				};
//		
//			List<CategoryDto> clist = dao.findnoCategory();
//			// callno, bookno 정보의 clist
//			for(CategoryDto c: clist) {
//				String category = ""; // dao 사용할 1번 파라미터
//				String callno = c.getCallno(); // 카테고리 작성에 필요한 정보
//				int bookno = c.getBookno(); // dao 사용할 2번 파라미터
//				int sub = 0;
//				try {
//					if(Character.isDigit(callno.charAt(0))) { // 시작이 숫자
//						sub = Integer.parseInt(callno.substring(0,3)); // 청구기호 세자리 추출
//					}else {
//						sub = Integer.parseInt(callno.substring(1,4));
//					}
//				}catch(Exception e) {
//					e.printStackTrace();
//				}
//				int a = sub/100; // 대분류 _xx
//				int b = (sub%100)/10; // 소분류 x_x
//				category = all[a][0]+"/"+all[a][b];
//				
//				done += dao.addCategory(category, bookno);
//			}
//		return done;
//	}

}
