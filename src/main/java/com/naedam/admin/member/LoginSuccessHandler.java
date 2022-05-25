package com.naedam.admin.member;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Service;

import com.naedam.admin.common.Mir9Utils;
import com.naedam.admin.member.model.vo.Member;
import com.naedam.admin.security.model.service.SecurityService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class LoginSuccessHandler implements AuthenticationSuccessHandler {
	
	@Autowired
	private SecurityService securityService;
	
	/*
	 * HttpServletRequest 객체 : 웹에서 넘어온 Request값을 가지고 있는 객체
	 * HttpServletResponse 객체 : 출력을 정의할 수 있는 객체
	 * Authentication 객체 : 인증에 성공한 사용자의 정보를 가지고 있는 객체
	 */
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {	
		List<String> grade = new ArrayList();
		
		// 사용자가 가진 모든 권한을 문자열로 체크한다.
		// 사용자는 여러권한을 가졌을 수 있다.
		authentication.getAuthorities().forEach(authority -> {
			grade.add(authority.getAuthority());
		});
		
		Map<String, Object> param = new HashMap<>();
		Member principal = (Member) authentication.getPrincipal();
		
		Object username = authentication.getName();
		param.put("username", username);
		param.put("loginDate", principal.getLoginDate());
		log.debug("name = {}", username);
		log.debug("grade = {}", grade);
		
		// 최근 로그인 시간 입력
		int resultLoginDate = securityService.insertLoginDate(param);
		log.debug("resultLoginDate = {}", resultLoginDate);
		
		// 회원 접속이력 관리 - 로그인
		Map<String, Object> paramHistory = new HashMap<>();
		
		log.debug("principalForHistory = {}", principal);
		paramHistory.put("accessHistoryId", principal.getId());
		paramHistory.put("accessHistoryName", principal.getLastName() + principal.getFirstName());
		paramHistory.put("accessHistoryStatus", "login");
		paramHistory.put("loginDate", param.get("loginDate"));
		//String ip = request.getRemoteAddr();
		String ip = Mir9Utils.getClientIP(request);
		log.debug("ip = {}", ip);
		paramHistory.put("accessHistoryIp", ip);
		
		int resultAccessHistoryByLogin = securityService.insertAccessHistoryByLogin(paramHistory);
		log.debug("resultAccessHistoryByLogin = {}", resultAccessHistoryByLogin);
		
		//int resultloginAccessHistory = securityService.insertLoginAccessHistory(paramHistory);
		
		// ADMIN 이 포함되어 있으면 /dashBoard로 리다이렉트
		if(grade.contains("ROLE_ADMIN")) {
			response.sendRedirect("/admin/dashBoard");
			return;
		}
		
		// MEMBER 또는 SELLER가 포함되어 있으면 /memberLogin.do로 리다이렉트
		if(grade.contains("ROLE_MEMBER") || grade.contains("ROLE_SELLER")) {
			response.sendRedirect("memberLogin");
			return;
		}
		
		// 둘다 없으면 로그인 페이지(메인 페이지)로 리다이렉트
		response.sendRedirect("/");
		
		/*
		 * - 강제 인터셉트 당했을 경우의 데이터 get
		 * - 로그인 인증을 위해 Spring Security가 요청을 가로챈 경우
		 * 
		 * RequestCache 인터페이스 : Spring-security에서 제공하는 사용자의 요청을 저장하고 꺼낼 수 있다.
		 * SavedRequest 클래스 객체 : 사용자 요청 정보들이 들어 있다.
		 */
		RequestCache requestCache = new HttpSessionRequestCache();
		SavedRequest savedRequest = requestCache.getRequest(request, response);
		log.debug("requestCache = {}", requestCache);
		log.debug("savedRequest = {}", savedRequest);
		
		// 있을 경우 URI 등 정보를 가져와서 사용
		if(savedRequest != null) {
			String uri = savedRequest.getRedirectUrl();
			
			// 세션에 저장된 객체를 다 사용한 뒤에는 지워줘서 메모리 누수 방지
			requestCache.removeRequest(request, response);
			
			log.debug("uri = {}", uri);
		}
		
		// 세션 Attribute 확인
		Enumeration<String> list = request.getSession().getAttributeNames();
		while(list.hasMoreElements()) {
			log.debug("list = {}", list.nextElement());
		}
				
	}
}
