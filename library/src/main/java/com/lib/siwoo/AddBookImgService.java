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
		String title = b.getBooktitle();
		String author = b.getAuthor();
		String publisher = b.getPublisher();
		String title2 = i.getTitle();
		String author2 = i.getAuthor();
		String publisher2 = i.getPublisher();
		if((title.contains(title2) || title2.contains(title)) // 제목,저자는 둘 중 하나가 다른 하나를 포함하는 것으로 확인
				&& (author.contains(author2) || author2.contains(author))
				&& publisher.equals(publisher2)) {
			return true;
		} else {
			return false;
		}
		
	}
	
	// img 링크가 비어있는 레코드를 db에서 가져와 네이버 도서에서 검색 후 이미지 링크를 복사해 db 업데이트
	public int addBookImg() {
		int success=0;
		int limit = 300; // 업데이트할 도서의 수 - 이미지가 비어있는 도서 중 n 권
		List<BookDto> blist = new ArrayList<>(); 
		blist = dao.findNoImg(limit); // 이미지 비어있는 책 리스트 dto
		for(BookDto b : blist) {
			// naver api에 도서 검색
			NaverBookDto n = new NaverBookDto();
			try {
				Thread.sleep(1000);
				n = naver.bookinfo(b.getBooktitle()); // 해당 제목으로 검색된 10권의 책 - items
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			
			for(Item item : n.getItems()) {
				if(check(b,item)) {
//					System.out.println(item.getImage()); 확인용
					b.setImg(item.getImage()); // 맞는 책을 검색한 후, dto 업데이트
					break;
				}
			}
			if(b.getImg().equals("")) { // 네이버 검색 후에도 img 없는 경우
				b.setImg("/bookImg/noIMG.png");
			}
			else {
				success ++;
			}
			// dto 변경 완료 -> db update
			dao.updateImg(b.getImg(), b.getBookno());
//			System.out.println(b); 확인용
		}
		return success; // img 찾는데 성공한 책 수
	}

}
