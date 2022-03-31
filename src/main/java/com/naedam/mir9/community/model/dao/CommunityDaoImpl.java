package com.naedam.mir9.community.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.naedam.mir9.community.model.vo.Review;
import com.naedam.mir9.community.model.vo.ReviewImg;

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
	
}
