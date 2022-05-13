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

	// 리뷰 조회 + 검색
	@Override
	public List<Review> reviewList(Map<Object, String> param) {
		return session.selectList("review.reviewList", param);
	}
	
	// 모달 정보
	@Override
	public List<Review> reviewModal(int reviewCode) {
		return session.selectList("review.reviewModal", reviewCode);
	}

	// 모달 이미지
	@Override
	public List<ReviewImg> reviewImgModal(int reviewCode) {
		return session.selectList("review.reviewImgModal", reviewCode);
	}

	// 카테고리 조회
	@Override
	public int selectCategory(String reviewCode) {
		return session.selectOne("review.selectCategory", reviewCode);
	}	
	
	// 이미지 삭제
	@Override
	public int imgDelete(String reviewCode) {
		return session.delete("review.imgDelete", reviewCode);
	}	
	
	// 리뷰 삭제
	@Override
	public int selectDelete(String reviewCode) {
		return session.delete("review.selectDelete", reviewCode);
	}
	
	// v_msg_info 조회
	@Override
	public MsgInfo selectMsgInfo(long orderNo) {
		return session.selectOne("sms.msgInfo", orderNo);
	}
	
	// sms 자동 발송 체크 여부 조회
	@Override
	public List<SmsSetting> smsCheck(String templateId) {
		return session.selectList("sms.smsCheck", templateId);
	}

	// email 자동 발송 체크 여부 조회
	@Override
	public List<EmailSetting> emailCheck(String templateId) {
		return session.selectList("email.emailCheck", templateId);
	}

	// sms 자동 발송 여부 수정
	@Override
	public int smsAutoSend(HashMap<String, String> param) {
		return session.update("sms.autoSend", param);
	}
	
	// mail 자동 발송 여부 수정
	@Override
	public int mailAutoSend(HashMap<String, String> param) {
		return session.update("email.autoSend", param);
	}

	// sms 등록
	@Override
	public int insertSms(HashMap<String, Object> param2) {
		return session.insert("sms.insertSms", param2);
	}

	// sms setting 조회
	@Override
	public List<SmsSetting> selectSmsSetting() {
		return session.selectList("sms.selectSmsSetting");
	}
	
	// sms list 조회
	@Override
	public List<Sms> selectSmsList(HashMap<String, Object> param) {
		return session.selectList("sms.selectSmsList", param);
	}
	
	// email 등록
	@Override
	public int insertEmail(HashMap<String, Object> param2) {
		return session.insert("email.insertEmail", param2);
	}	
	
	// email setting 조회
	@Override
	public List<EmailSetting> selectEmailSetting() {
		return session.selectList("email.selectEmailSetting");
	}

	// email list 조회
	@Override
	public List<Email> selectEmailList(HashMap<String, Object> param) {
		return session.selectList("email.selectEmailList", param);
	}
}
