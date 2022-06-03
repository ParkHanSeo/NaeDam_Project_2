package com.naedam.admin.community.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
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
	 
	/**
	 * 공통 : 목록 + 검색 + 페이징
	 * @param mode			: 맵핑
	 * @param cPage			: 현재 페이지
	 * @param field			: 검색 필드명
	 * @param keyword		: 검색 키워드
	 * @param request
	 * @param model
	 * @return admin/community/{sms.jsp || email.jsp || smsList.jsp || emailList.jsp || review.jsp} 
	 */
	@RequestMapping(value="/{mode}", method= {RequestMethod.GET, RequestMethod.POST})
	public String selectList(
			@PathVariable String mode,
			@RequestParam(defaultValue="1") int cPage,
			@RequestParam(required=false) String field,
			@RequestParam(required=false) String keyword,
			HttpServletRequest request,
			Model model) {
		Map<String, Object> param = communityService.selectCommunityList(mode, cPage, field, keyword, request); 		
		model.addAllAttributes(param);
		return "admin/community/" + mode;
	}
	
	/**
	 * ajax 조회 및 수정
	 * @param mode			: 맵핑
	 * @param id			: 로그인 회원ID
	 * @param templateId	: 템플릿명
	 * @param reviewCode	: 후기 번호
	 * @param jsonStr	
	 * @return result admin/community/{sms.jsp || email.jsp}
	 */
	@ResponseBody 
	@RequestMapping(value="/load/{mode}", method= {RequestMethod.GET, RequestMethod.POST})
	public Map<String, Object> load(
			@PathVariable String mode,
			@RequestParam(required=false) String id,
			@RequestParam(required=false) List<Object> templateId,
			@RequestParam(required=false) Integer reviewCode,
			@RequestBody(required=false) String jsonStr) {
		Map<String, Object> param = new HashMap<>();
		param.put("id", id);
		param.put("templateId", templateId);
		param.put("reviewCode", reviewCode);
		param.put("jsonStr", jsonStr);
		Map<String, Object> result = communityService.load(mode, param);
		return result;
	}

	/**
	 * 메시지 발송
	 * @param mode			: 맵핑
	 * @param jsonStr		
	 * @return result
	 */
	@ResponseBody
	@RequestMapping(value="/send/{mode}", method= {RequestMethod.GET, RequestMethod.POST})
	public Map<String, Object> sendMsg(
			@PathVariable String mode,
			@RequestBody(required=false) String jsonStr) {
		Map<String, Object> result = communityService.send(mode, jsonStr);
		return result;
	}
	
	/**
	 * 후기 삭제
	 * @param request
	 * @param model
	 * @return admin/community/review.jsp
	 */
	@PostMapping("/delete")
	public String selectDelete(
			HttpServletRequest request,
			Model model) {
		String msg = communityService.selectDelete(request);
		model.addAttribute("msg", msg);
		return "redirect:/admin/comm/review";
	}
		
	/*
	// imgbb 테스트
	@RequestMapping(value="/imgbb", method={RequestMethod.GET, RequestMethod.POST}) 
	public String imgbbTest(){
		return "admin/community/urlTest";
	}
	*/
}
