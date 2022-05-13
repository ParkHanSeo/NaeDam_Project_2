package com.naedam.admin.security.model.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Repository;

import com.naedam.admin.member.model.vo.MemberAccessHistory;

@Repository
public class SecurityDaoImpl implements SecurityDao {

	@Autowired
	private SqlSession session;

	@Override
	public UserDetails loadUserByUsername(String username) {
		return session.selectOne("security.loadUserByUsername", username);
	}

	@Override
	public int insertLoginDate(Map<String, Object> param) {
		return session.update("security.insertLoginDate", param);
	}

	@Override
	public int insertAccessHistoryByLogin(Map<String, Object> paramHistory) {
		return session.insert("security.insertAccessHistoryByLogin", paramHistory);
	}

	@Override
	public int insertAccessHistoryByLogout(Map<String, Object> paramHistory) {
		return session.insert("security.insertAccessHistoryByLogout", paramHistory);
	}



}
