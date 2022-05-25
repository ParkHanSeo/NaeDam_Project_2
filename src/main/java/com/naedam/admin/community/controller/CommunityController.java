package com.naedam.admin.community.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.naedam.admin.common.Mir9Utils;
import com.naedam.admin.community.model.service.CommunityService;
import com.naedam.admin.community.model.vo.Email;
import com.naedam.admin.community.model.vo.EmailSetting;
import com.naedam.admin.community.model.vo.Review;
import com.naedam.admin.community.model.vo.Sms;
import com.naedam.admin.community.model.vo.SmsSetting;

@Controller
@RequestMapping("/admin/comm")
public class CommunityController {
	
	@Autowired
	private CommunityService communityService;
	
	// mail 설정
	@GetMapping("/email")
	public String commEmail(Model model) {
		
		// mail 설정 정보 조회
		List<EmailSetting> emailSetting = communityService.selectEmailSetting();
		model.addAttribute("emailSetting", emailSetting);
		
		return "admin/community/email";
	}
	
	// mail 조회 + 검색
	@RequestMapping(value="/email_list", method= {RequestMethod.GET, RequestMethod.POST})
	public String commEmailList(
			@RequestParam(defaultValue="1") int cPage,
			@RequestParam(required=false) String field,
			@RequestParam(required=false) String keyword,
			HttpServletRequest request,
			Model model) {
		
		int limit = 15;
		int startRow = (cPage - 1) * limit + 1;
		int endRow = startRow + limit -1;
		
		HashMap<String, Object> param = new HashMap<>();
		param.put("field", field);
		param.put("keyword", keyword);
		param.put("startRow", startRow);
		param.put("endRow", endRow);
		
		// 메일 목록 조회
		List<Email> emailList = communityService.selectEmailList(param);		
		int totalEmailCount = communityService.totalEmailCount(param);
		String emailUri = "";
		if((field == null || field == "") && (keyword == null || keyword == "")) {
			emailUri = request.getRequestURI();
		}
		else {
			emailUri = request.getRequestURI() + "?field=" + field + "&keyword=" + keyword;
		}
		String pagebar = Mir9Utils.getPagebar(cPage, limit, totalEmailCount, emailUri);

		model.addAttribute("emailList", emailList);
		model.addAttribute("total", totalEmailCount);	
		model.addAttribute("param", param);
		model.addAttribute("pagebar", pagebar);
		
		return "admin/community/emailList";
	}
	
	// sms 설정 + 기본 문구 + 저장 문구
	@GetMapping("/sms")
	public String commSms(Model model) {
	
		// sms 설정 정보 조회
		List<SmsSetting> smsSetting = communityService.selectSmsSetting();
		model.addAttribute("smsSetting", smsSetting);
		
		// CORS 문제 해결
		// 기본 문구
		int category = 81149;
		HashMap<String, Object> originSms = communityService.loadSms(category); 
		
		// list에 담기
		List<String> templateId = (List<String>) originSms.get("templateId");
		List<String> content = (List<String>) originSms.get("body");

		model.addAttribute("templateId", templateId);
		model.addAttribute("content", content);

		// 저장 문구
		category = 81150;
		HashMap<String, Object> savedSms = communityService.loadSms(category); 
		
		// list에 담기
		List<String> savedTemplateId = (List<String>) savedSms.get("templateId");
		List<String> savedContent = (List<String>) savedSms.get("body");
		
		model.addAttribute("savedTemplateId", savedTemplateId);
		model.addAttribute("savedContent", savedContent);

		return "admin/community/sms";
	}
	
	// sms 조회 + 검색
	@RequestMapping(value="/sms_list", method= {RequestMethod.GET, RequestMethod.POST})
	public String commSmsList(
			@RequestParam(defaultValue="1") int cPage,
			@RequestParam(required=false) String field,
			@RequestParam(required=false) String keyword,
			HttpServletRequest request,
			Model model) {
		
		int limit = 15;
		int startRow = (cPage - 1) * limit + 1;
		int endRow = startRow + limit -1;
		
		HashMap<String, Object> param = new HashMap<>();
		param.put("field", field);
		param.put("keyword", keyword);
		param.put("startRow", startRow);
		param.put("endRow", endRow);
		
		// sms 목록 조회
		List<Sms> smsList = communityService.selectSmsList(param);
		int totalSmsCount = communityService.totalSmsCount(param);
		String smsUri = "";
		if((field == null || field == "") && (keyword == null || keyword == "")) {
			smsUri = request.getRequestURI();
		}
		else {
			smsUri = request.getRequestURI() + "?field=" + field + "&keyword=" + keyword;
		}
		String pagebar = Mir9Utils.getPagebar(cPage, limit, totalSmsCount, smsUri);
		
		model.addAttribute("smsList", smsList);
		model.addAttribute("total", totalSmsCount);
		model.addAttribute("param", param);
		model.addAttribute("pagebar", pagebar);

		return "admin/community/smsList";
	}
	
	// 리뷰 조회 + 검색
	@RequestMapping(value="/review", method={RequestMethod.GET, RequestMethod.POST})
	public String commReview(
			@RequestParam(defaultValue="1") int cPage,
			@RequestParam(required=false) String field,
			@RequestParam(required=false) String keyword,
			HttpServletRequest request,
			Model model) {
		
		int limit = 15;
		int startRow = (cPage - 1) * limit + 1;
		int endRow = startRow + limit -1;
		
		Map<Object, Object> param = new HashMap<>(); 
		param.put("field", field);
		param.put("keyword", keyword);
		param.put("startRow", startRow);
		param.put("endRow", endRow);
		
		// 리뷰 목록 조회
		List<Review> reviewList = communityService.reviewList(param);	
		int totalReviewCount = communityService.totalReviewCount(param);
		String reviewUri = "";
		if((field == null || field == "") && (keyword == null || keyword == "")) {
			reviewUri = request.getRequestURI();
		}
		else {
			reviewUri = request.getRequestURI() + "?field=" + field + "&keyword=" + keyword;
		}
		String pagebar = Mir9Utils.getPagebar(cPage, limit, totalReviewCount, reviewUri);
		
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("param", param);
		model.addAttribute("pagebar", pagebar);
		
		return "admin/community/review";
	}
		
	// 리뷰 삭제
	@PostMapping("/delete")
	public String selectDelete(
			HttpServletRequest request) {
		
		// 선택된 리뷰 번호
		List<String> selectedCode = Arrays.asList(request.getParameterValues("list[]"));

		int delImg = 0;
		int delReview = 0;
		int categoryNo = 0;
		
		for(String reviewCode : selectedCode) {
			// 카테고리 조회
			categoryNo = communityService.selectCategory(reviewCode);

			// 이미지 삭제
			if(categoryNo == 1) { // 포토 후기일 경우
				delImg = communityService.imgDelete(reviewCode);
			}
			
			// 리뷰 삭제
			delReview = communityService.selectDelete(reviewCode);
		}
		
		return "redirect:/admin/comm/review";
	}
	
	// imgbb 테스트
	@RequestMapping(value="/imgbb", method={RequestMethod.GET, RequestMethod.POST}) 
	public String imgbbTest(){
		return "admin/community/urlTest";
	}
	
}
