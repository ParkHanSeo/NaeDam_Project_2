package com.naedam.admin.community.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.JsonObject;
import com.naedam.admin.community.model.vo.Email;
import com.naedam.admin.community.model.vo.EmailSetting;
import com.naedam.admin.community.model.vo.MsgInfo;
import com.naedam.admin.community.model.vo.Review;
import com.naedam.admin.community.model.vo.ReviewImg;
import com.naedam.admin.community.model.vo.Sms;
import com.naedam.admin.community.model.vo.SmsSetting;

public interface CommunityService {

	// review
	List<Review> reviewList(Map<Object, Object> param); // 리뷰 목록 조회

	List<Review> reviewModal(int reviewCode); // 모달 정보 조회

	List<ReviewImg> reviewImgModal(int reviewCode); // 모달 이미지 조회

	int selectCategory(String reviewCode); // 리뷰 카테고리 조회
	
	int imgDelete(String reviewCode); // 리뷰 이미지 삭제	
	
	int selectDelete(String reviewCode); // 선택된 리뷰 삭제
	
	int totalReviewCount(Map<Object, Object> param); // review 전체 목록 수

	// sms
	MsgInfo selectMsgInfo(long orderNo); // 주문 정보 조회
	
	List<SmsSetting> smsCheck(String templateId); // 특정 설정값 조회
	
	int smsAutoSend(HashMap<String, String> param);	// 자동 발송 여부 수정
	
	List<SmsSetting> selectSmsSetting();
	List<Sms> selectSmsList(HashMap<String, Object> param);	// 설정 정보 조회
	
	HashMap<String, Object> loadSms(int category); // 기본 문구 + 저장 문구

	int modifySms(String code, String content); // 템플릿 수정
	
	int sendSms(JsonObject json); // sms 발송
	
	int countBySendPhone(String phone); // sms 이용 내역 조회
	
	int totalSmsCount(HashMap<String, Object> param); // sms 전체 목록 수
	
	// email
	List<EmailSetting> emailCheck(String templateId); // 특정 설정값 조회
	
	int mailAutoSend(HashMap<String, String> param); // 자동 발송 여부 수정

	List<EmailSetting> selectEmailSetting();
	List<Email> selectEmailList(HashMap<String, Object> param); // 설정 정보 조회

	HashMap<String, Object> loadEmail(String templateId, int category); // 기본 문구 + 저장 문구

	int modifyMail(String templateId, String title, String content); // 템플릿 수정
	
	int sendEmail(JsonObject json); // email 발송 
	
	int totalEmailCount(HashMap<String, Object> param); // email 전체 목록 수

}
