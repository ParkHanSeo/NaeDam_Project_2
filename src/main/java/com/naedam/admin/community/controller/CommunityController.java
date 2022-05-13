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

	// SMS 인증키
	private static String smsKey = "cuyb2ATgfZrgb0LF";
	private static String smsSecret = "3VxajYQb";
	
	// mail 설정
	@GetMapping("/email")
	public String commEmail(Model model) {
		
		// sms 설정 정보 조회
		List<EmailSetting> emailSetting = communityService.selectEmailSetting();
		model.addAttribute("emailSetting", emailSetting);
		
		return "admin/community/email";
	}
	
	// mail 조회 + 검색
	@RequestMapping(value="/email_list", method= {RequestMethod.GET, RequestMethod.POST})
	public String commEmailList(
			@RequestParam(required=false) String field,
			@RequestParam(required=false) String keyword,			
			Model model) {
		
		HashMap<String, Object> param = new HashMap<>();
		param.put("field", field);
		param.put("keyword", keyword);
		
		// 총 건 수 => 전체 조회 건의 길이
		List<Email> emailList = communityService.selectEmailList(param);
		int total = emailList.size();
		model.addAttribute("emailList", emailList);
		model.addAttribute("total", total);		
		
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
		HashMap<String, Object> originSms = communityService.loadSms(smsKey, smsSecret, category); 
		
		// list에 담기
		List<String> templateId = (List<String>) originSms.get("templateId");
		List<String> content = (List<String>) originSms.get("body");

		model.addAttribute("templateId", templateId);
		model.addAttribute("content", content);

		// 저장 문구
		category = 81150;
		HashMap<String, Object> savedSms = communityService.loadSms(smsKey, smsSecret, category); 
		
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
			@RequestParam(required=false) String field,
			@RequestParam(required=false) String keyword,			
			Model model) {
		
		HashMap<String, Object> param = new HashMap<>();
		param.put("field", field);
		param.put("keyword", keyword);
		
		// 총 건 수 => 전체 조회 건의 길이
		List<Sms> smsList = communityService.selectSmsList(param);
		int total = smsList.size();
		model.addAttribute("smsList", smsList);
		model.addAttribute("total", total);

		return "admin/community/smsList";
	}
	
	// 리뷰 조회 + 검색
	@RequestMapping(value="/review", method={RequestMethod.GET, RequestMethod.POST})
	public String commReview(
			@RequestParam(required=false) String field,
			@RequestParam(required=false) String keyword,
			Model model) {
		
		Map<Object, String> param = new HashMap<>(); 
		param.put("field", field);
		param.put("keyword", keyword);
		
		List<Review> reviewList = communityService.reviewList(param);		
		model.addAttribute("reviewList", reviewList);
		
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
