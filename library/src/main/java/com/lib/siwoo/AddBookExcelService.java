package com.lib.siwoo;

import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.IOUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.lib.dto.BookDto;

import jakarta.servlet.http.HttpServletResponse;

@Service
public class AddBookExcelService {
	
	@Autowired
	BookManageService bservice;
	
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
	
	// 임시 경로에 업로드된 파일에서 dto를 추출해 db에 저장한다. 실패시 -1을 리턴하고, 성공시 성공한 권수를 리턴한다.
	public int[] uploadExcel(MultipartFile file ) { // 임시 경로에 업로드 된 파일에 접근 가능
		int done= 0, fail = 0;
		System.out.println(file.getOriginalFilename());
		String extension = FilenameUtils.getExtension(file.getOriginalFilename());

		// 저장할 List<BookDto>
		List<BookDto> blist = new ArrayList<>();
		
		// 엑셀 파일인지 확인 후, 전처리 - 양식에 맞는 파일인지...
	    if (!extension.equals("xlsx") && !extension.equals("xls")) {
	      done=-1;
	      return new int[] {done, fail};
	    }
	    Workbook workbook = null;
	    int rownum=0;
	    try {
		    if (extension.equals("xlsx")) {
		      workbook = new XSSFWorkbook(file.getInputStream());
		    } else if (extension.equals("xls")) {
		      workbook = new HSSFWorkbook(file.getInputStream());
		    }
		    Sheet sheet = workbook.getSheetAt(0);
		    rownum = sheet.getPhysicalNumberOfRows()-1;
		    for (int i = 2; i < rownum; i++) { // 3번째 행부터
		    	// 확인 후 읽어서 BookDto 리스트로 저장
		        Row row = sheet.getRow(i);
		        
/////////////////////////////////////유효성 검사 파트
		        boolean valid = true;
		        // 유효성 검사 cell이 null이 아니어야 함
		        for(int j=0; j<5; j++) { // 칼럼 개수 = 5
		        	Cell cell = row.getCell(j);
		        	if(cell != null) { // null이 아닐때
		        		continue;
		        	}else {
		        		valid = false;
		        	}
		        }
		        if(!row.getCell(4).getCellType().toString().equals("NUMERIC")) {
		        	valid = false;
		        }
/////////////////////////////////////		        
		        
		        if(valid) {
		        	String booktitle = row.getCell(0).getStringCellValue();
			        String author = row.getCell(1).getStringCellValue();
			        String callno = row.getCell(2).getStringCellValue();
			        String publisher = row.getCell(3).getStringCellValue();
			        int pubyear = (int)row.getCell(4).getNumericCellValue(); // 에러 발생 가능

			        BookDto book = new BookDto();
			        book.setBooktitle(booktitle);  // 책 이름
			        book.setAuthor(author);  //저자
			        book.setCallno(callno);  // 청구기호
			        book.setPublisher(publisher);  // 출판사
			        book.setPubyear(pubyear);  // 출판 연도
			        blist.add(book);
		        }else {
		        	// 실패 엑셀 작성 - 비어있는 셀
		        	continue;
		        }

		      }// for
		    // DB 전달
		    System.out.println(blist.size());
		    for(BookDto b : blist) {
		    	done += bservice.insertBook(b); // 성공 1 실패 0
		    	// 실패할 경우 엑셀 작성 - 이미 있는 책(청구기호)
		    }

	    }catch(Exception e) {
	    	e.printStackTrace();
	    }
	    fail = (rownum-2) - done; // 실패 수 = 행 수 - 성공 권 수
	    
		// 완료되면 실제 업로드에 성공한 책 수 리턴
	   	return new int[] {done, fail};
	}
	
	// 실패한 목록을 엑셀로 다운받게 하자. 직접 입력이든, 엑셀 업로드든

}
