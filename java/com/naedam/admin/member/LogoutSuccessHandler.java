package com.naedam.admin.member;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.SimpleUrlLogoutSuccessHandler;
import org.springframework.stereotype.Service;

import com.naedam.admin.member.model.vo.Member;
import com.naedam.admin.security.model.service.SecurityService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class LogoutSuccessHandler extends SimpleUrlLogoutSuccessHandler{

	@Autowired
	private SecurityService securityService;
	
	@Override
	public void onLogoutSuccess(
						HttpServletRequest request,
						HttpServletResponse response,
						Authentication authentication) throws IOException, ServletException {
		log.debug("{}", "로그아웃 핸들러 작동!");
		
		// 세션 무효화 처리
		HttpSession session = request.getSession();
		session.invalidate();
		
		// 회원 접속이력 관리 - 로그아웃
		Map<String, Object> paramHistory = new HashMap<>();
		Member principal = (Member) authentication.getPrincipal();
		
		paramHistory.put("accessHistoryId", principal.getId());
		paramHistory.put("accessHistoryName", principal.getLastName() + principal.getFirstName());
		paramHistory.put("accessHistoryStatus", "logout");
		String ip = request.getRemoteAddr();
		paramHistory.put("accessHistoryIp", ip);
		
		int resultAccessHistoryByLogout = securityService.insertAccessHistoryByLogout(paramHistory);
		log.debug("resultAccessHistoryByLogout = {}", resultAccessHistoryByLogout);
		
		response.sendRedirect("memberLogin");
	}
	
	
}
