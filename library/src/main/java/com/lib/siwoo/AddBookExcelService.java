package com.lib.siwoo;

import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;

import org.apache.commons.io.IOUtils;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpServletResponse;

@Service
public class AddBookExcelService {
	
	public void downExcel(HttpServletResponse response) {
		 // 업로드할 엑셀 양식 파일 다운로드
        String filename = "도서추가양식.xlsx";
        String directory = "static/excel/";
        Resource resource = new ClassPathResource(directory + filename);

        try (InputStream inputStream = resource.getInputStream()) {
            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            
            // 파일 이름을 URL 인코딩
            String encodedFilename = URLEncoder.encode(filename, "UTF-8").replace("+", "%20");
            response.setHeader("Content-Disposition", "attachment; filename=\"" + encodedFilename + "\"");

            IOUtils.copy(inputStream, response.getOutputStream());
            response.flushBuffer();
        } catch (IOException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            // 오류 메시지를 추가로 기록합니다.
        }
	}

}
