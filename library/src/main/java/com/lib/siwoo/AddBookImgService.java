package com.lib.siwoo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lib.dto.BookDto;

@Service
public class AddBookImgService {
	
	@Autowired
	AddBookImgDao dao;
	
	@Autowired
	NaverApiService naver;
	
	public boolean check(BookDto b, Item i) {
		String pattern = "[^ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z0-9]"; //국어, 영어 숫자 제외 다른 패턴 안 받음
		String title = b.getBooktitle().replaceAll(pattern, "");
		String author = b.getAuthor().replaceAll(pattern, "");
		String publisher = b.getPublisher().replaceAll(pattern, "");
		String title2 = i.getTitle().replaceAll(pattern, "");
		String author2 = i.getAuthor().replaceAll(pattern, "");
		String publisher2 = i.getPublisher().replaceAll(pattern, "");
		// 제목, 저자, 출판사 문자열을 전처리 한 후 - 일치하는 도서가 있는 지 확인
		if((title.contains(title2) || title2.contains(title)) // 둘 중 하나가 다른 하나를 포함하는 것으로 확인
				&& (author.contains(author2) || author2.contains(author))
				&& (publisher.contains(publisher2) || publisher2.contains(publisher))) {
			return true;
		} else {
			return false;
		}
		
	}
	
//	// img 링크가 비어있는 레코드를 db에서 가져와 네이버 도서에서 검색 후 이미지 링크를 복사해 db 업데이트
//	public int addBookImg() { // 여러개
//		int success=0;
//		int limit = 300; // 업데이트할 도서의 수 - 이미지가 비어있는 도서 중 n 권
//		int rest = 1000; // sleep 하는 시간
//		List<BookDto> blist = new ArrayList<>(); 
//		blist = dao.findNoImg(limit); // 이미지 비어있는 책 리스트 dto
//		for(BookDto b : blist) {
//			// naver api에 도서 검색
//			NaverBookDto n = new NaverBookDto();
//			
//			try {					
//				Thread.sleep(rest); //naver api 속도제한
//				n = naver.bookinfo(b.getBooktitle()); // 해당 제목으로 검색된 10권의 책 - items
//			}catch (Exception e) {
//				e.printStackTrace();
//			}
//			
//			for(Item item : n.getItems()) {
//				if(check(b,item)) {
////					System.out.println(item.getImage()); 확인용
//					b.setImg(item.getImage()); // 맞는 책을 검색한 후, dto 업데이트
//					break;
//				}
//			} // for itemlist end
//			if(b.getImg().equals("")) { // 네이버 검색 후에도 img 없는 경우
//				b.setImg("/bookImg/noIMG.png");
//			}
//			else {
//				success ++;
//			}
//			// dto 변경 완료 -> db update
//			dao.updateImg(b.getImg(), b.getBookno());
////			System.out.println(b); 확인용
//		} // for blist end
//		return success; // img 찾는데 성공한 책 수
//	}
	
	public int addBookImgone(BookDto dto) {
		int success=0;
		int rest = 100; // sleep 하는 시간
			// naver api에 도서 검색
			NaverBookDto n = new NaverBookDto();
			dto.setImg(""); // 초기화
			try {					
				Thread.sleep(rest); //naver api 속도제한
				n = naver.bookinfo(dto.getBooktitle()); // 해당 제목으로 검색된 10권의 책 - items
//				System.out.println(n);
				for(Item item : n.getItems()) {
//					System.out.println(item); //확인용
					if(check(dto,item)) {
						
						dto.setImg(item.getImage()); // 맞는 책을 검색한 후, dto 업데이트
						break;
					}
				} // for itemlist end
			}catch (Exception e) {
				e.printStackTrace();
			}
			if(dto.getImg().equals("")) { // 네이버 검색 후에도 img 없는 경우 or api 에러로 못 가져온 경우-n.getItems에서null point exception
				dto.setImg("/bookImg/noIMG.png");
			}
			else {
				success ++;
			}
//			System.out.println(dto.getImg()); //확인용
			// dto 변경 완료 -> db update
//			System.out.println(dto.getImg()+"  "+ dto.getBookno()); //확인용
			dao.updateImg(dto.getImg(), dto.getBookno());
//			System.out.println(b); 확인용
		return success; // img 찾는데 성공한 책 수
	}

}
