package com.naedam.admin.security.model.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.naedam.admin.member.model.vo.MemberAccessHistory;
import com.naedam.admin.security.model.dao.SecurityDao;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class SecurityService implements UserDetailsService {

	@Autowired
	private SecurityDao securityDao;
	
	/**
	 * loadUserByUsername = selectOneMember
	 * username = id
	 * UserDetails : VO에서 구현한 interface
	 * 
	 * 스프링이 로그인 요청을 가로챙 때 username, password 변수 2개를 가로채는데
	 * password 부분 처리는 알아서 처리,
	 * username이 DB에 있는지 확인해줘야 함
	 */
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		log.debug("username = {}", username); // id
		
		UserDetails member = securityDao.loadUserByUsername(username); 
		log.debug("member = {}", member);
		
		/**
		 * 조회된 회원이 없다면 예외를 던져서 security에 알림.
		 */
		if(member == null)
			throw new UsernameNotFoundException(username);
		
		return member;
	}

	public int insertLoginDate(Map<String, Object> param) {
		return securityDao.insertLoginDate(param);
	}
	


	public void track(String string) {
		// TODO Auto-generated method stub
		
	}

	public int insertAccessHistoryByLogin(Map<String, Object> paramHistory) {
		return securityDao.insertAccessHistoryByLogin(paramHistory);
	}

	public int insertAccessHistoryByLogout(Map<String, Object> paramHistory) {
		return securityDao.insertAccessHistoryByLogout(paramHistory);
	}

	
	
}
