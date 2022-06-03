package com.naedam.admin.community.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.naedam.admin.community.model.vo.Email;
import com.naedam.admin.community.model.vo.EmailSetting;
import com.naedam.admin.community.model.vo.MsgInfo;
import com.naedam.admin.community.model.vo.Review;
import com.naedam.admin.community.model.vo.ReviewImg;
import com.naedam.admin.community.model.vo.Sms;
import com.naedam.admin.community.model.vo.SmsSetting;

public interface CommunityDao {

	// review				: 후기 목록 조회
	int totalReviewCount(Map<String, Object> param);
	List<Object> reviewList(Map<String, Object> param);
	
	// reviewModal			: 후기 상세보기
	List<Review> reviewModal(int reviewCode);
	List<ReviewImg> reviewImgModal(int reviewCode);

	// delete				: 후기 삭제
	int selectCategory(String reviewCode);	
	int imgDelete(String reviewCode);	
	int selectDelete(String reviewCode);

	// smsList				: SMS 목록 조회
	int totalSmsCount(Map<String, Object> param);
	List<Object> selectSmsList(Map<String, Object> param);
	
	// charge				: SMS 이용 요금 조회
	int countBySendPhone(String phone);
	
	// smsAutoSendCheck		: SMS 자동발송 여부 조회
	List<Object> selectSmsSetting();
	
	// smsSettingModify		: SMS 설정 저장
	int smsAutoSend(Map<String, Object> setMod);
	
	// emailList			: Email 목록 조회
	int totalEmailCount(Map<String, Object> param);
	List<Object> selectEmailList(Map<String, Object> param);
	
	// emailAutoSendCheck	: Email 자동발송 여부 조회
	List<Object> selectEmailSetting();
	
	// emailSettingModify	: Email 설정 저장 
	int emailAutoSend(Map<String, Object> setMod);

	// 회원 정보 조회
	MsgInfo selectMsgInfo(long orderNo);
	
	// 설정값 조회
	List<SmsSetting> smsAutoChecked(String templateId);
	List<EmailSetting> emailAutoChecked(String templateId);
	
	// 발송 목록 추가
	int insertSms(HashMap<String, Object> param2);
	int insertEmail(HashMap<String, Object> param2);
}
