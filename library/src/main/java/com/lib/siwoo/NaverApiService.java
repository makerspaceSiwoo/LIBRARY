package com.lib.siwoo;

import java.net.URI;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

@Service
public class NaverApiService {
	
	@Autowired
	RestTemplate restTemplate;
	
	//naver 책 검색 api요청

	public NaverBookDto bookinfo(String d_titl) {

		URI uri = UriComponentsBuilder.fromUriString("https://openapi.naver.com").path("/v1/search/book_adv.json")

				.queryParam("d_titl", d_titl).queryParam("display", "10").queryParam("start", "1") // 10 권 검색

				.queryParam("sort", "sim").encode().build().toUri();



		RequestEntity<Void> req = RequestEntity.get(uri).header("X-Naver-Client-Id", "5ArcGfKTf5JyOe_UkEoI") // 클라이언트 id

				.header("X-Naver-Client-Secret", "XoOpj4CUFT") // 클라이언트 시크릿



				.build();



		ResponseEntity<NaverBookDto> response = restTemplate.exchange(req, NaverBookDto.class);

		NaverBookDto info = response.getBody();
		return info;

	}



}
