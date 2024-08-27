package com.lib.siwoo;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.IOUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
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

	@Transactional
	// 임시 경로에 업로드된 파일에서 dto를 추출해 db에 저장한다. 실패시 -1을 리턴하고, 성공시 성공한 권수를 리턴한다.
	public byte[] uploadExcel(MultipartFile file) { // 임시 경로에 업로드 된 파일에 접근 가능
		int done= 0;
//		, fail = 0;
		int max = 1000; // 최대 저장 가능 행 개수
		System.out.println(file.getOriginalFilename());
		String extension = FilenameUtils.getExtension(file.getOriginalFilename());

		// 엑셀 파일인지 확인 후, 전처리 - 양식에 맞는 파일인지...
		if (!extension.equals("xlsx") && !extension.equals("xls")) {
//	      done=-1;
//	      return new int[] {done, fail};
			return null;
		}
		Workbook workbook = null;
		int rownum = 0;
		try {
			if (extension.equals("xlsx")) {
				workbook = new XSSFWorkbook(file.getInputStream());
			} else if (extension.equals("xls")) {
				workbook = new HSSFWorkbook(file.getInputStream());
			}
			Sheet sheet = workbook.getSheetAt(0);
			rownum = sheet.getPhysicalNumberOfRows() - 2; // 행 개수 -2 (가이드란)
////////////////////////////////////// max 행 개수 변환
			rownum = Math.min(max, rownum); // 최대 1000개만
////////////////////////////////////// 		
			for (int i = 2; i <= rownum + 2; i++) { // 3번째 행부터
				// 확인 후 읽어서 BookDto 리스트로 저장
				Row row = sheet.getRow(i);
				setColor(sheet, row, "red"); // 검사 전 빨간색으로 설정
/////////////////////////////////////유효성 검사 파트0
				boolean valid = true;
				if (row == null) {
					valid = false;
				} else {
					// 유효성 검사 : 해당 행의 cell이 null이 아니어야 다음 단계로
					for (int j = 0; j < 5; j++) { // 칼럼 개수 = 5
						Cell cell = row.getCell(j);
						if (cell != null) { // null이 아닐때
							continue;
						} else {
							valid = false;
						}
					}
					if (valid==true && row.getCell(4).getCellType() != CellType.NUMERIC) { // 마지막 cell은 숫자 값
						valid = false; // 숫자 값이 아닌 경우
					}
				}
/////////////////////////////////////		        
				if (valid) {
					String booktitle = row.getCell(0).toString();
					String author = row.getCell(1).toString();
					String callno = row.getCell(2).toString();
					String publisher = row.getCell(3).toString();
					int pubyear = (int) row.getCell(4).getNumericCellValue(); // 에러 발생 가능

					BookDto book = new BookDto();
					book.setBooktitle(booktitle); // 책 이름
					book.setAuthor(author); // 저자
					book.setCallno(callno); // 청구기호
					book.setPublisher(publisher); // 출판사
					book.setPubyear(pubyear); // 출판 연도

					int success = bservice.insertBook(book); // db에 저장
			        done += 1;
			        System.out.println(done);
					// 성공 1 실패 0
					if (success == 1) {
						setColor(sheet, row, "green"); // db 삽입 성공 시 초록색으로 변경
					}

				} else {
					// 실패 엑셀 작성 - 비어있는 셀
					continue;
				}
			} // for

			// 파일 변경 사항을 outputstream에 저장
			// 수정된 워크북을 지정된 파일에 작성
			// 수정된 워크북을 ByteArrayOutputStream에 저장
			ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
			workbook.write(byteArrayOutputStream);
			return byteArrayOutputStream.toByteArray(); // 변경사항이 적용된 ( 색 변경 ) 엑셀을 byte로 리턴

		} catch (Exception e) {
			e.printStackTrace();
		}
//	    fail = (rownum) - done; // 실패 수 = 행 수 - 성공 권 수
		// 완료되면 실제 업로드에 성공한 책 수 리턴
//	   	return new int[] {done, fail};
		// 실패시 null
		return null;
	}

	// 실패한 목록을 엑셀로 다운받게 하자. 직접 입력이든, 엑셀 업로드든
	// 업로드 한 파일의 색 변경 성공:초록/ 실패:빨강
	public void setColor(Sheet sheet, Row row, String color) {
		if (row == null || sheet == null) {
			return; // 시트나 행이 null인 경우 아무 작업도 하지 않음
		}
		Workbook workbook = sheet.getWorkbook();
		// 빨간색 배경 스타일 생성
		CellStyle colorStyle;

		if (workbook instanceof org.apache.poi.xssf.usermodel.XSSFWorkbook) { // xlsx 만 가능
			// XSSF (xlsx 파일)
			colorStyle = ((org.apache.poi.xssf.usermodel.XSSFWorkbook) workbook).createCellStyle();
			if (color.equals("red")) {
				((XSSFCellStyle) colorStyle).setFillForegroundColor(new XSSFColor(java.awt.Color.RED, null));
				((XSSFCellStyle) colorStyle).setFillPattern(FillPatternType.SOLID_FOREGROUND);
			} else {
				((XSSFCellStyle) colorStyle).setFillForegroundColor(new XSSFColor(java.awt.Color.GREEN, null));
				((XSSFCellStyle) colorStyle).setFillPattern(FillPatternType.SOLID_FOREGROUND);
			}
		} else {
			return; // 지원하지 않는 워크북 타입인 경우
		}
		// 행의 모든 셀을 순회하며 색 배경 스타일 적용
		for (Cell cell : row) {
			if (cell.getCellType() != CellType.BLANK && cell != null) { // 비어있지 않은 셀 확인
				cell.setCellStyle(colorStyle);
			}
		}
	}

//	// 색을 변경한 엑셀 다시 다운로드
//	public void downResult(HttpServletResponse response, MultipartFile file) {
//		 // 업로드 된 파일 이름 변경해서 다시 다운로드
//		String filename = file.getOriginalFilename();
//		String extension = FilenameUtils.getExtension(filename);
//		String originname = FilenameUtils.getBaseName(filename);
//		String newname = originname + "_result."+extension;
//		System.out.println(newname);
//		
//		try (InputStream inputStream =  file.getInputStream()){
//			response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
//			// 파일 이름을 URL 인코딩
//			String encodedFilename = URLEncoder.encode(newname, "UTF-8").replace("+", "%20");
//			response.setHeader("Content-Disposition", "attachment; filename=\"" + encodedFilename + "\"");
//			IOUtils.copy(inputStream, response.getOutputStream());
//			response.flushBuffer();
//			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//		
//	}

	@Transactional
	// 색을 변경한 엑셀 다시 다운로드
	public void downResult(HttpServletResponse response, byte[] fileBytes, String filename) {
		String extension = FilenameUtils.getExtension(filename);
		String originname = FilenameUtils.getBaseName(filename);
		String newname = originname + "_result." + extension;
		System.out.println(newname);
		// 업로드 된 파일 이름 변경해서 다시 다운로드
		try {
			response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
			String encodedFilename = URLEncoder.encode(newname, "UTF-8").replace("+", "%20");
			response.setHeader("Content-Disposition", "attachment; filename=\"" + encodedFilename + "\"");
			
			response.getOutputStream().write(fileBytes);
			response.getOutputStream().flush();
			response.setStatus(HttpServletResponse.SC_OK); // 성공 상태
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

//	public boolean chk(Workbook workbook) { // workbook, sheet 유효성 검사
//		boolean chk = true;
//		if(workbook == null) {
//			chk = false;
//			return chk;
//		}else if(workbook.getSheetAt(0) == null) {
//			chk = false;
//			return chk;
//		}else {
//			return chk;
//		}
//	}

}
