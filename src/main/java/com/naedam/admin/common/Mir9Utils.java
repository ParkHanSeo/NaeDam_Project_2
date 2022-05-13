package com.naedam.admin.common;

import java.io.IOException;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class Mir9Utils {
	/**
	 * 
	 *  
	 * @param cPage
	 * @param numPerPage
	 * @param totalContents
	 * @param url
	 * @return
	 */

	public static String getPagebar(int cPage, int numPerPage, int totalContents, String url) {
		StringBuilder pagebar = new StringBuilder();
		
		// ?��체페?���??�� 
		int totalPage = (int) Math.ceil((double) totalContents / numPerPage);
		
		// ?��?���?번호�? ?���??��?��?�� 링크
		String delimeter = url.contains("?") ? "&" : "?";
		url = url + delimeter + "cPage="; // /spring/board/boardList.do?cPage=
		// ?��?���?바크�? 
		int pagebarSize = 5;
		
		/* 
		 		1 2 3 4 5 >>
		 		
		 	<<	6 7 8 9 10 >>
		 	
		 	<< 11 12
		 	
		 	pageStart : ?��?��?��?�� pageNo
		 		- cPage?? pagebarSize?�� ?��?�� 결정
		 */
		int pageStart = (cPage - 1) / pagebarSize * pagebarSize + 1;
		int pageEnd = pageStart + pagebarSize - 1;
		
		int pageNo = pageStart;
		
		/*
		 <nav aria-label="Page navigation example">
		  <ul class="pagination justify-content-center">
		    <li class="page-item disabled">
		      <a class="page-link" href="#" aria-label="Previous" tabindex="-1">
		        <span aria-hidden="true">&laquo;</span>
		        <span class="sr-only">Previous</span>
		      </a>
		    </li>
		    
		    <li class="page-item"><a class="page-link" href="#">1</a></li>
		    <li class="page-item"><a class="page-link" href="#">2</a></li>
		    <li class="page-item"><a class="page-link" href="#">3</a></li>
		    
		    <li class="page-item">
		      <a class="page-link" href="#" aria-label="Next">
		        <span aria-hidden="true">&raquo;</span>
		        <span class="sr-only">Next</span>
		      </a>
		    </li>
		  </ul>
		</nav>
		<script>
		const paging = (cPage) => {
			location.href = url + cPage;
		}
		</script>
		
		 */
		
		pagebar.append("<nav aria-label=\"Page navigation example\">\n"
				+ "		  <ul class=\"pagination justify-content-center\">\n");
		
		// 1.?��?��
		if(pageNo == 1) {
			pagebar.append("<li class=\"page-item disabled\">\r\n"
					+ "		      <a class=\"page-link\" href=\"#\" aria-label=\"Previous\" tabindex=\"-1\">\r\n"
					+ "		        <span aria-hidden=\"true\">&laquo;</span>\r\n"
					+ "		        <span class=\"sr-only\">Previous</span>\r\n"
					+ "		      </a>\r\n"
					+ "		    </li>\n");
		}
		else {
			pagebar.append("<li class=\"page-item \">\r\n"
					+ "		      <a class=\"page-link\" href=\"javascript:paging(" + (pageNo - 1) + ")\" aria-label=\"Previous\" >\r\n"
					+ "		        <span aria-hidden=\"true\">&laquo;</span>\r\n"
					+ "		        <span class=\"sr-only\">Previous</span>\r\n"
					+ "		      </a>\r\n"
					+ "		    </li>\n");
		}
		
		// 2.pageNo
		while(pageNo <= pageEnd && pageNo <= totalPage) {
			if(pageNo == cPage) {
				// ?��?��?��?���??�� 경우 링크 ?��공안?��.
				pagebar.append("<li class=\"page-item active\"><a class=\"page-link\" href=\"#\">" + pageNo + "<span class=\"sr-only\">(current)</span></a></li>\n");
			}
			else {
				// ?��?��?��?���?�? ?��?�� 경우 링크�? ?���?.
				pagebar.append("<li class=\"page-item\"><a class=\"page-link\" href=\"javascript:paging(" + pageNo + ")\">" + pageNo + "</a></li>\n");
			}
			
			pageNo++;
		}
		
		// 3.?��?��
		if(pageNo > totalPage) {
			pagebar.append("<li class=\"page-item disabled\">\r\n"
					+ "		      <a class=\"page-link\" href=\"#\" tabindex=\"-1\" aria-label=\"Next\">\r\n"
					+ "		        <span aria-hidden=\"true\">&raquo;</span>\r\n"
					+ "		        <span class=\"sr-only\">Next</span>\r\n"
					+ "		      </a>\r\n"
					+ "		    </li>\n");
		}
		else {
			pagebar.append("<li class=\"page-item\">\r\n"
					+ "		      <a class=\"page-link\" href=\"javascript:paging(" + pageNo + ")\" aria-label=\"Next\">\r\n"
					+ "		        <span aria-hidden=\"true\">&raquo;</span>\r\n"
					+ "		        <span class=\"sr-only\">Next</span>\r\n"
					+ "		      </a>\r\n"
					+ "		    </li>\n");
		}
		
		pagebar.append("		  </ul>\r\n"
				+ "		</nav>\r\n"
				+ "		<script>\r\n"
				+ "		const paging = (cPage) => {\r\n"
				+ "			location.href = '" + url + "' + cPage;\r\n"
				+ "		}\r\n"
				+ "		</script>\n");
		
		return pagebar.toString();
	}

	// 파일 업로드 유틸
	public static String getRenamedFilename(String originalFilename) {
		// 확장자 가져오기
		// 확장자 문자열 변수를 하나 만들어 놓는다.
		String ext = ""; 
		
		// 매개변수로 넘어온 originalFilename에서 마지막 "." index를 찾는다.
		int dot = originalFilename.lastIndexOf(".");
		
		// 확장자가 있다면, "." index 이후로 잘라내기를 한다. 
		if(dot > -1)
			ext = originalFilename.substring(dot); // .txt
		
		// 형식지정
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS_");
		// 난수 생성(무조건 세자리)
		DecimalFormat df = new DecimalFormat("000"); // 30 -> 030
		
		// 새 파일명
		return sdf.format(new Date()) + df.format(Math.random() * 999) + ext;
	}
	
	public static Map<String, Object> parseJsonStr(String jsonStr) {
		ObjectMapper mapper = new ObjectMapper();
		HashMap<String, Object> map = new HashMap<String, Object>();
		try {
			map = mapper.readValue(jsonStr, 
			        new TypeReference<HashMap<String, Object>>() {});
		} catch (IOException e) {
			
		}
		
		return map;
	}
	
	
	public static Date stringToDate(String dateStr) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		try {
			date = sdf.parse(dateStr);
		} catch (ParseException e) {}
		return date;
	}
	
}
