package com.naedam.admin.community.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.naedam.admin.community.model.vo.Email;
import com.naedam.admin.community.model.vo.EmailSetting;
import com.naedam.admin.community.model.vo.MsgInfo;
import com.naedam.admin.community.model.vo.Review;
import com.naedam.admin.community.model.vo.ReviewImg;
import com.naedam.admin.community.model.vo.Sms;
import com.naedam.admin.community.model.vo.SmsSetting;

@Repository
public class CommunityDaoImpl implements CommunityDao {
	@Autowired
	private SqlSession session;

	// 후기 목록 조회
	@Override
	public int totalReviewCount(Map<String, Object> param) {
		return session.selectOne("review.totalReviewCount", param);
	}
	@Override
	public List<Object> reviewList(Map<String, Object> param) {
		return session.selectList("review.reviewList", param);
	}
	
	// 후기 상세보기
	@Override
	public List<Review> reviewModal(int reviewCode) {
		return session.selectList("review.reviewModal", reviewCode);
	}
	@Override
	public List<ReviewImg> reviewImgModal(int reviewCode) {
		return session.selectList("review.reviewImgModal", reviewCode);
	}

	// 후기 삭제
	@Override
	public int selectCategory(String reviewCode) {
		return session.selectOne("review.selectCategory", reviewCode);
	}	
	@Override
	public int imgDelete(String reviewCode) {
		return session.delete("review.imgDelete", reviewCode);
	}	
	@Override
	public int selectDelete(String reviewCode) {
		return session.delete("review.selectDelete", reviewCode);
	}
	
	// SMS 목록 조회
	@Override
	public int totalSmsCount(Map<String, Object> param) {
		return session.selectOne("sms.totalSmsCount", param);
	}
	@Override
	public List<Object> selectSmsList(Map<String, Object> param) {
		return session.selectList("sms.selectSmsList", param);
	}
	
	// SMS 이용 요금 조회
	@Override
	public int countBySendPhone(String phone) {
		return session.selectOne("sms.countBySendPhone", phone);
	}
	
	// SMS 자동발송 여부 조회
	@Override
	public List<Object> selectSmsSetting() {
		return session.selectList("sms.selectSmsSetting");
	}
	
	// SMS 설정 저장
	@Override
	public int smsAutoSend(Map<String, Object> setMod) {
		return session.update("sms.autoSend", setMod);
	}
	
	// Email 목록 조회
	@Override
	public int totalEmailCount(Map<String, Object> param) {
		return session.selectOne("email.totalEmailCount", param);
	}
	@Override
	public List<Object> selectEmailList(Map<String, Object> param) {
		return session.selectList("email.selectEmailList", param);
	}
	
	// Email 자동발송 여부 조회
	@Override
	public List<Object> selectEmailSetting() {
		return session.selectList("email.selectEmailSetting");
	}
	
	// Email 설정 저장
	@Override
	public int emailAutoSend(Map<String, Object> setMod) {
		return session.update("email.autoSend", setMod);
	}

	// 회원 정보 v_msg_info 조회
	@Override
	public MsgInfo selectMsgInfo(long orderNo) {
		return session.selectOne("sms.msgInfo", orderNo);
	}
	
	// SMS 발송
	@Override
	public List<SmsSetting> smsAutoChecked(String templateId) {
		return session.selectList("sms.smsCheck", templateId);
	}
	@Override
	public int insertSms(HashMap<String, Object> param2) {
		return session.insert("sms.insertSms", param2);
	}
	
	// Email 발송
	@Override
	public List<EmailSetting> emailAutoChecked(String templateId) {
		return session.selectList("email.emailCheck", templateId);
	}
	@Override
	public int insertEmail(HashMap<String, Object> param2) {
		return session.insert("email.insertEmail", param2);
	}

}
