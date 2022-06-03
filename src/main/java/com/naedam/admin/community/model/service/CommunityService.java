package com.naedam.admin.community.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.google.gson.JsonObject;
import com.naedam.admin.community.model.vo.Email;
import com.naedam.admin.community.model.vo.EmailSetting;
import com.naedam.admin.community.model.vo.MsgInfo;
import com.naedam.admin.community.model.vo.Review;
import com.naedam.admin.community.model.vo.ReviewImg;
import com.naedam.admin.community.model.vo.Sms;
import com.naedam.admin.community.model.vo.SmsSetting;

public interface CommunityService {

	// 공통 : 목록 + 검색 + 페이징
	Map<String, Object> selectCommunityList(
			String mode, int cPage, String field, String keyword, HttpServletRequest request); 
	
	// ajax 요청
	Map<String, Object> load(String mode, Map<String, Object> param); 
	
	// 메시지 발송
	Map<String, Object> send(String mode, String jsonStr); 
	
	// 후기 삭제
	String selectDelete(HttpServletRequest request);
	
}
