package com.naedam.admin.common;

import java.lang.reflect.Field;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.naedam.admin.form.model.service.FormService;
import com.naedam.admin.form.model.vo.FormPost;
import com.naedam.admin.form.model.vo.Item;
import com.naedam.admin.member.model.service.MemberService;
import com.naedam.admin.member.model.vo.MemberAccessHistoryListExcelForm;
import com.naedam.admin.member.model.vo.MemberListExcelForm;
import com.naedam.admin.order.model.service.OrderService;
import com.naedam.admin.order.model.vo.OrderExcelForm;
import com.naedam.admin.point.model.service.PointService;
import com.naedam.admin.point.model.vo.MemberPointExcelForm;
import com.naedam.admin.product.model.service.ProductService;
import com.naedam.admin.product.model.vo.ProductExcelForm;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/excel")
@Slf4j
public class ExcelController {
	
	@Autowired
	private OrderService orderService;
	@Autowired
	private ProductService productService;
	@Autowired
	private PointService pointService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private FormService formService;
	
	private static final int WIDTH = 2800;

    private final String[] orderHeader = {"순번", "주문번호", "상품명", "주문자", "연락처", "결제금액", "결제방법", "입금은행명", "예금주명", "수취인 성명", "수취인 연락처", "배송지 주소", "고객요청 사항", "상태"};
    private final String[] productHeader = {"카테고리", "모델명", "상품명", "소제목", "요약", "소비자 가격", "가격", "상품옵션", "상세설명", "new아이템", "best아이템", "event아이템", "언어", "품절여부", "표출상태", "등록일자"};
	private final String[] memberPointHeader = {"아이디", "이름", "이메일", "포인트 사용내역", "사용 포인트", "일시"};
	private final String[] memberListHeader = {"아이디", "이름", "휴대폰", "이메일", "주소", "메모", "등급", "상태", "최근 접속일", "수정일자", "등록일자"};
	private final String[] memberAccessHistoryListHeader = {"아이디", "이름", "접속 IP", "상태", "일시"};
	
	
	@PostMapping("/download.do")
	public void excelDownload(HttpServletResponse response, HttpServletRequest request) throws Exception {
		String type = request.getParameter("download_type");
		String searchType = request.getParameter("search_type");
		
		List<String> excelHeader = null;
		List<Object> excelContentList = new ArrayList<Object>(); 
		List<Object> excelContentList2 = new ArrayList<Object>();
		List<Object> excelContentList3 = new ArrayList<Object>();
		Workbook wb = new XSSFWorkbook();
		Sheet sheet = null;
		String fileName = "";
		
		String memberId = "";
		if(searchType != null && searchType != "") { // 특정 회원 조회
			int memberNo = Integer.parseInt(searchType);
			memberId = memberService.selectMemberIdByNo(memberNo);
		}
		
		Object[] data = null;
		if(type.equals("order")) {
			excelHeader = Arrays.asList(orderHeader);
			sheet = wb.createSheet("order_list");
			fileName += "order_list_" + dateCode();
			List<OrderExcelForm> orderExcelFormList = orderService.selectOrderExcelForm();
			for(OrderExcelForm o : orderExcelFormList) {
				excelContentList.add(o);
			}
			
		}else if(type.equals("product")) {
			excelHeader = Arrays.asList(productHeader);
			sheet = wb.createSheet("product_list");
			fileName += "product_list_" + dateCode();
			List<ProductExcelForm> productExcelFormList = productService.selectProductExcelForm();
			for(ProductExcelForm p : productExcelFormList) {
				excelContentList.add(p);
			}
		}else if(type.equals("memberPoint")) {
			excelHeader = Arrays.asList(memberPointHeader);
			sheet = wb.createSheet("member_point_history");
			fileName += "member_point_history_" + dateCode();
			// + 특정 회원 적립금 조회 가능
			List<MemberPointExcelForm> MemberPointExcelFormList = pointService.selectMemberPointExcelForm(memberId);
			for(MemberPointExcelForm p : MemberPointExcelFormList) {
				excelContentList.add(p);
			}
		}else if(type.equals("memberList")) {
			excelHeader = Arrays.asList(memberListHeader);
			sheet = wb.createSheet("member_list");
			fileName += "member_list_" + dateCode();
			List<MemberListExcelForm> MemberListExcelFormList = memberService.selectMemberListExcelForm();
			for(MemberListExcelForm p : MemberListExcelFormList) {
				excelContentList2.add(p);
			}
		}else if(type.equals("memberAccessHistoryList")) {
			excelHeader = Arrays.asList(memberAccessHistoryListHeader);
			sheet = wb.createSheet("member_access_history_list");
			fileName += "member_access_history_list_" + dateCode();
			List<MemberAccessHistoryListExcelForm> MemberAccessHistoryListExcelFormList = memberService.selectMemberAccessHistoryListExcelForm();
			for(MemberAccessHistoryListExcelForm p : MemberAccessHistoryListExcelFormList) {
				excelContentList2.add(p);
			}
		}else if(type.equals("formPost")) {
			String formNo = request.getParameter("formNo");
			List<String> formPostHeader = new ArrayList<>();
			List<Item> itemList = formService.formTr(Integer.parseInt(formNo));
			List<FormPost> fp = formService.formPostList(Integer.parseInt(formNo));
			for(int i = 0; i < itemList.size(); i++) {				
				formPostHeader.add(0,itemList.get(i).getLabel());
			}
			Collections.reverse(formPostHeader);
			excelHeader = formPostHeader;
			sheet = wb.createSheet("form_list");
			fileName += "form_list" + dateCode();
			List<String> formPostList = new ArrayList<>();
			for(int i = 0; i < fp.size(); i++) {
				data = fp.get(i).getItemData().split("&");
				if(data != null) {
					formPostList.add(i,Arrays.toString(data));
				}else if(data == null) {}
			}
			for(int i = 0; i < formPostList.size(); i++) {
				excelContentList3.add(i,formPostList.get(i));
			}
			

		}

		Row row = null;
		Cell cell = null;
		int rowNum = 0;

		
		// header
		row = sheet.createRow(rowNum++);
		for(int i = 0; i < excelHeader.size(); i++) {
			sheet.setHorizontallyCenter(true);
			cell = row.createCell(i);
			cell.setCellValue(excelHeader.get(i));
		}

		

		
		// body
		for(Object vo : excelContentList) {
			int cnt = 0;
			row = sheet.createRow(rowNum++);
		    try{
		        Object obj = vo;
		        for (Field field : obj.getClass().getDeclaredFields()){
		            field.setAccessible(true);
		            Object value = field.get(obj);
		            
		            if(!field.getName().equals("serialVersionUID")) {
		            	
		            	// Date타입 ==> String으로 캐스팅
		            	if(value instanceof Date) {
		            		value = castDate((Date) value);
		            		log.debug("value = {}", value);
		            	}
		            	// 셀 너비 자동 조절
		    			sheet.autoSizeColumn(cnt);
		    		    sheet.setColumnWidth(cnt, (sheet.getColumnWidth(cnt))+(short)1024);
			            // 데이터 작성
		    		    cell = row.createCell(cnt);
			            cell.setCellValue(String.valueOf(value));
			            cnt++;
		            }
		        }
		    }catch (Exception e){
		    	e.printStackTrace();
		    }
		}

		
		// body
		for(Object vo : excelContentList2) {
			int cnt = 0;
			row = sheet.createRow(rowNum++);
		    try{
		        Object obj = vo;
		        for (Field field : obj.getClass().getDeclaredFields()){
		            field.setAccessible(true);
		            Object value = field.get(obj);
		            
		            if(!field.getName().equals("serialVersionUID")) {
		            	
		            	// Date타입 ==> String으로 캐스팅
		            	if(value instanceof Date) {
		            		value = memberDate((Date) value);
		            		log.debug("value = {}", value);
		            	}
		            	// 셀 너비 자동 조절
		    			sheet.autoSizeColumn(cnt);
		    		    sheet.setColumnWidth(cnt, (sheet.getColumnWidth(cnt))+(short)1024);
			            // 데이터 작성
		    		    cell = row.createCell(cnt);
			            cell.setCellValue(String.valueOf(value));
			            cnt++;
		            }
		        }
		    }catch (Exception e){
		    	e.printStackTrace();
		    }
		}
		
		// body
		int forInt = 0;
		for(Object vo : excelContentList3) {
			int cnt = 0;
			row = sheet.createRow(rowNum++);
		    try{
		        Object obj = vo;
	        	// 셀 너비 자동 조절
    			sheet.autoSizeColumn(cnt);
    		    sheet.setColumnWidth(cnt, (sheet.getColumnWidth(cnt))+(short)1024);
    		    // 데이터 작성
    		    String formNo = request.getParameter("formNo");
    		    List<FormPost> fp = formService.formPostList(Integer.parseInt(formNo));
    		    data = fp.get(forInt).getItemData().split("&");
    		    for(int i = 0; i < data.length; i++) {
    		    	cell = row.createCell(i);
    		    	cell.setCellValue(data[i].toString());
    		    }
	            cnt++;
	            forInt++;
		        
		    }catch (Exception e){
		    	e.printStackTrace();
		    }
		}
		
		
		
		
		// 컨텐츠 타입과 파일명 지정
		response.setContentType("ms-vnd/excel");
		fileName += ".xlsx";
		response.setHeader("content-Disposition", "attachment;filename=" + fileName);
		
		// Excel file output
		wb.write(response.getOutputStream());
		wb.close();
		
	}
	
	private String dateCode() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMdd");
		Date now = new Date();
		
		return sdf.format(now);
	}
	private String castDate(Date date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
		return sdf.format(date);
	}
	private String memberDate(Date date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		return sdf.format(date);
	}
}
