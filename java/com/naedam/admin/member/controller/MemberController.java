package com.naedam.admin.member.controller;

import java.beans.PropertyEditor;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.naedam.admin.common.Mir9Utils;
import com.naedam.admin.coupon.model.service.CouponService;
import com.naedam.admin.coupon.model.vo.Coupon;
import com.naedam.admin.coupon.model.vo.MemberCoupon;
import com.naedam.admin.member.model.service.MemberService;
import com.naedam.admin.member.model.vo.Address;
import com.naedam.admin.member.model.vo.AddressBook;
import com.naedam.admin.member.model.vo.Authorities;
import com.naedam.admin.member.model.vo.Member;
import com.naedam.admin.member.model.vo.MemberAccessHistory;
import com.naedam.admin.member.model.vo.MemberEntity;
import com.naedam.admin.member.model.vo.MemberGrade;
import com.naedam.admin.member.model.vo.MemberMemo;
import com.naedam.admin.member.model.vo.WithdrawalMemberEntity;
import com.naedam.admin.point.model.service.PointService;
import com.naedam.admin.point.model.vo.MemberPoint;

import lombok.extern.slf4j.Slf4j;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/admin/member")
@Slf4j
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	private CouponService couponService;
	
	// 회원 탈퇴
	@GetMapping("/memberWithdrawal.do")
	public void memberWithdrawal() {}
	
	// 회원 탈퇴 로직
	@PostMapping("/memberWithdrawal.do")
	public String memberWithdrawal(@RequestParam String password, @RequestParam String reason,
								   Authentication authentication, RedirectAttributes redirectAttribute,
								   HttpServletRequest request) {
		Map<String, Object> param = new HashMap<>();
		// 회원 조회
		Member member = (Member) authentication.getPrincipal();
		log.debug("[principal] member = {}", member);
		int memberNo = member.getMemberNo();
		param.put("memberNo", memberNo);
		param.put("reason", reason);
		
		// 비밀번호 비교
		if(passwordEncoder.matches(password, member.getPassword())){
			try {
				/*
				 *  1) 회원 탈퇴로 변경 (status : Y -> N)(update)
				 *  2) 탈퇴일 : (withdrawalDate : NOW(update)
				 *  3) 탈퇴사유 : (reason : update)
				 */
				int resultMemberToWithdrawal = memberService.updateMemberToWithdrawal(param);
				String msg = resultMemberToWithdrawal > 0 ? "회원 탈퇴가 완료되었습니다." : "회원 탈퇴에 실패했습니다.";
				redirectAttribute.addFlashAttribute("msg", msg);
				
			} catch (Exception e) {
				log.error("회원 탈퇴 오류", e);
				throw e;
			}
			return "redirect:/";
			 
		} else {
			redirectAttribute.addFlashAttribute("msg", "비밀번호가 일치하지 않습니다.");
			return "redirect:/admin/member/memberWithdrawal.do";
		}
			
	}

	@Autowired
	private PointService pointService;
	
	// 회원 리스트
	@RequestMapping("/list.do")
	public String memberList(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) {
		
		int limit = 10;
		int offset = (cPage - 1) * limit;
		
		try {
			// 회원 리스트 전체 게시물 목록
			List<MemberEntity> memberList = memberService.selectMemberList(offset, limit);
			model.addAttribute("memberList", memberList);
			
			// 전체 게시물 수
			int totalMemberListCount = memberService.selectMemberListCount();
			model.addAttribute("totalMemberListCount", totalMemberListCount);
			
			// 명칭 가져오기
			List<MemberGrade> memberGradeList = memberService.selectMemberGradeList();
			model.addAttribute("memberGradeList", memberGradeList);
			
			// 쿠폰 리스트
			List<Coupon> couponList = couponService.selectCouponList();
			model.addAttribute("couponList",couponList);
			
			// pagebar
			String url = request.getRequestURI();
			String pagebar = Mir9Utils.getPagebar(cPage, limit, totalMemberListCount, url);
			model.addAttribute("pagebar", pagebar);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "admin/member/memberList";
	}
	
	// id 중복 검사
	@ResponseBody
	@GetMapping("/checkIdDuplicate.do")
	public Map<String, Object> checkIdDuplicate(@RequestParam Map<String, Object> param) {
		log.debug("{}", "checkIdDuplicate.do 실행");
		Map<String, Object> map = new HashMap<>();
		Member member = memberService.selectOneMemberByMap(param);
		map.put("available", member == null);
		return map;
	}
	
	// 회원리스트 - 등록
	@PostMapping("/memberInsertModalFrm.do")
	public String memberInsertModalFrm(Member member, Address address, AddressBook addressBook, MemberMemo memberMemo, MemberGrade memberGradeNo,
									   @RequestParam String mobile1, @RequestParam String mobile2, @RequestParam String mobile3, @RequestParam String authority, RedirectAttributes redirectAttributes) {
		
		try {
			String phone = mobile1 + mobile2 + mobile3;
			
			// 0. 비밀번호 암호화 처리
			String rawPassword = member.getPassword();
			String encryptedPassword = passwordEncoder.encode(rawPassword);
			member.setPassword(encryptedPassword);
			
			// 1. 회원(Member) 등록
			Member paramMember = new Member();
			
			paramMember.setFirstName(member.getFirstName());
			paramMember.setLastName(member.getLastName());
			paramMember.setEmail(member.getEmail());
			paramMember.setPhone(phone);
			paramMember.setStatus(member.getStatus());
			paramMember.setId(member.getId());
			paramMember.setPassword(member.getPassword());
			paramMember.setProfileImg(member.getProfileImg());
					
			int resultRegisterMember = memberService.insertRegisterMember(paramMember);
			
			// 2. 주소 입력
			// 2.1. 주소 입력
			int resultRegisterAddress = memberService.insertAddress(address);
			
			// 2.2. 주소록 입력
			AddressBook paramAddressBook = new AddressBook();
			paramAddressBook.setAddressBookNo(addressBook.getAddressBookNo());
			paramAddressBook.setAddressNo(address.getAddressNo());
			paramAddressBook.setMemberNo(paramMember.getMemberNo());
			
			int resultRegisterAddressBook = memberService.insertAddressBook(paramAddressBook);
			
			// 3. 메모 입력
			// 3.1. 회원 입력 시 생성된 회원번호(MemberNo) 설정
			MemberMemo paramMemberMemo = new MemberMemo();
			paramMemberMemo.setMemberMemoNo(memberMemo.getMemberMemoNo());
			paramMemberMemo.setMemberNo(paramMember.getMemberNo());
			paramMemberMemo.setMemberMemoContent(memberMemo.getMemberMemoContent());
			
			int memberNo = paramMember.getMemberNo();
			
			// 3.2. 메모 입력
			int resultRegisterMemberMemo = memberService.insertMemberMemo(paramMemberMemo);
			
			// 4. 등급 입력(update)
			// 4.1. 권한 입력
			Authorities paramAuthorities = new Authorities();
			paramAuthorities.setAuthority(authority);
			paramAuthorities.setMemberNo(paramMember.getMemberNo());
			
			int resultInsertAuthorities = memberService.insertAuthorities(paramAuthorities);
			
			String msg = "";
			
			if(resultRegisterMember > 0 && resultRegisterAddress > 0 
			   && resultRegisterAddressBook > 0 && resultRegisterMemberMemo > 0
			   && resultInsertAuthorities > 0) {
				msg = "해당 회원이 등록 되었습니다.";
			} else {
				msg = "회원 등록이 실패했습니다.";
			}

			redirectAttributes.addFlashAttribute("msg", msg);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/admin/member/list.do";
	}
	
	// 타입별 검색
	@ResponseBody
	@GetMapping("/typeSearch.do")
	public Map<String, Object> typeSearch(@RequestParam(defaultValue = "1") int cPage, @RequestParam String type, @RequestParam String keyword, HttpServletRequest request){		
		
		int limit = 10;
		int offset = (cPage - 1) * limit;
		
		Map<String, Object> param = new HashMap<>();
		param.put("type", type);
		param.put("keyword", keyword);
		
		// 검색 게시물 
		String url = request.getContextPath();
		List<MemberEntity> searchMemberList = memberService.selectSearchMemberList(param, offset, limit);
		String searchMemberListStr = Mir9Utils.getSearchMemberListStr(searchMemberList, url);
		
		// 검색 게시물 수
		int searchListCount = memberService.selectSearchListCount(param);
		
		// pagebar
		url = request.getRequestURI();
		String pagebar = Mir9Utils.getPagebarMember(cPage, limit, searchListCount, url);
		
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("searchMemberListStr", searchMemberListStr);
		resultMap.put("searchListCount", searchListCount);
		resultMap.put("pagebar", pagebar);
		
		return resultMap;
	}
	
	// 회원 상세보기
	@ResponseBody
	@GetMapping("/memberDetail.do/{memberNo}")
	public Map<String, Object> memberDetail(@PathVariable int memberNo, Model model, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<>();
		
		// 1. 상세보기 -> 회원조회
		Member member = memberService.selectOneMemberByMemberNo(memberNo);
		model.addAttribute("member", member);
		
		// 휴대폰 번호 분기
		String mobile2 = member.getPhone().substring(3, 7);
		String mobile3 = member.getPhone().substring(7, 11);
		
		// 시간 양식 변경
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String regDate = dateFormat.format(member.getRegDate());
		String loginDate = "";
		
		if(member.getLoginDate() == null){
			loginDate = "";
		} else {
			loginDate = dateFormat.format(member.getLoginDate());
		}
		
		String updateDate = "";
		if(member.getUpdateDate() == null) {
			updateDate = "";
		} else {
			updateDate = dateFormat.format(member.getUpdateDate());
		}
		
		// 2. 주소(Address) 조회
		Address address = memberService.selectOneAddress(memberNo);
		model.addAttribute("address", address);
		
		// 3. 메모(MemberMemoContent) 조회
		MemberMemo memberMemo = memberService.selectOneMemo(memberNo);

		if(memberMemo.getMemberMemoContent() == null) 
			 memberMemo.setMemberMemoContent("");
	
		model.addAttribute("memberMemo = {}", memberMemo);
		
		// 4. 회원 권한 조회
		Authorities authorities = memberService.selectOneAuthorities(memberNo);
		model.addAttribute("authorities = {}", authorities);
		
		// 5. 회원 포인트 총계 조회
		int totalPoint = 0;
		try {
			totalPoint = memberService.selectMemberTotalPoint(memberNo);
		} catch (Exception e) {}
		String pointName = pointService.selectPointName();
		
		map.put("member", member);
		map.put("mobile2", mobile2);
		map.put("mobile3", mobile3);
		map.put("address", address);
		map.put("memberMemo", memberMemo);
		map.put("authorities", authorities);
		map.put("regDate", regDate);
		map.put("loginDate", loginDate);
		map.put("updateDate", updateDate);
		map.put("totalPoint", totalPoint);
		map.put("pointName", pointName);
		
		return map;
	}
	
	
	// 회원 상세보기 저장(update)
	@SuppressWarnings("unchecked")
	@ResponseBody
	@PostMapping("/memberUpdate.do")
	public String memberUpdate(@RequestBody String data, RedirectAttributes redirectAttributes) {
		ObjectMapper mapper = new ObjectMapper();
		
		try {
			Map<String, String> map = mapper.readValue(data, Map.class);
			
			String phone = map.get("mobile1") + map.get("mobile2") + map.get("mobile3");
			
			// 회원(Member) 수정
			Member paramMember = new Member();
			paramMember.setMemberNo(Integer.parseInt(map.get("memberNo")));
			paramMember.setFirstName(map.get("firstName"));
			paramMember.setLastName(map.get("lastName"));
			paramMember.setEmail(map.get("email"));
			paramMember.setPhone(phone);
			paramMember.setStatus(map.get("status"));
			
			if(map.get("password").isEmpty()) {
				paramMember.setPassword(map.get("password"));
			} else {
				// 비밀번호 암호화 처리
				String rawPassword = map.get("password"); 
				String encryptedPassword = passwordEncoder.encode(rawPassword);
				paramMember.setPassword(encryptedPassword);
			}

			int resultMemberUpdate = memberService.memberUpdate(paramMember);
			
			// 주소(Address) 수정
			Address paramAddress = new Address();
			paramAddress.setAddressNo(Integer.parseInt(map.get("addressNo")));
			paramAddress.setAddressMain(map.get("addressMain"));
			paramAddress.setAddressSub(map.get("addressSub"));
			paramAddress.setAddressZipcode(Integer.parseInt(map.get("addressZipcode")));
			
			int resultAddressUpdate = memberService.addressUpdate(paramAddress);
			
			// 메모(MemberMemo) 수정
			MemberMemo paramMemberMemo = new MemberMemo();
			paramMemberMemo.setMemberNo(Integer.parseInt(map.get("memberNo")));
			paramMemberMemo.setMemberMemoContent(map.get("memberMemoContent"));
			
			int resultMemberMemo = memberService.memberMemoUpdate(paramMemberMemo);
			
			// 권한(Authorities) 수정
			Authorities paramAuthorities = new Authorities();
			paramAuthorities.setAuthority(map.get("authority"));
			paramAuthorities.setMemberNo(Integer.parseInt(map.get("memberNo")));
			
			int resultAuthorities = memberService.authoritiesUpdate(paramAuthorities);
	
		} catch(IOException e) {}

		return "redirect:/admin/member/list.do";
	}
	
	
	// 탈퇴회원 리스트
	@GetMapping("/withdrawalList.do")
	public String withdarawalMemberList(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) {
		
		int limit = 5;
		int offset = (cPage - 1) * limit;
		
		try {
			// 탈퇴 회원 리스트 전체 게시물 목록
			// 일반 회원 리스트에서 status = 'N'인 상태만 jsp에 뿌리는 과정
			List<MemberEntity> withdrawalMemberList = memberService.selectWithdrawalMemberListMemberList(offset, limit);
			model.addAttribute("withdrawalMemberList", withdrawalMemberList);
			
			// 탈퇴회원 전체 게시물 수
			int totalwithdrawalCount = memberService.selectWithdrawalCount();
			model.addAttribute("totalwithdrawalCount", totalwithdrawalCount);
			
			// 명칭 가져오기
			List<MemberGrade> memberGradeList = memberService.selectMemberGradeList();
			model.addAttribute("memberGradeList", memberGradeList);

			// pagebar
			String url = request.getRequestURI();
			String pagebar = Mir9Utils.getPagebar(cPage, limit, totalwithdrawalCount, url);
			model.addAttribute("pagebar", pagebar);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "admin/member/withdrawalMemberList";
	}
	
	// 탈퇴 회원 타입별 검색
	@ResponseBody
	@GetMapping("/withdrawalTypeSearch.do")
	public Map<String, Object> withdrawalTypeSearch(@RequestParam(defaultValue = "1") int cPage, @RequestParam String type, @RequestParam String keyword, HttpServletRequest request){
		
		int limit = 5;
		int offset = (cPage - 1) * limit;
		
		Map<String, Object> param = new HashMap<>();
		param.put("type", type);
		param.put("keyword", keyword);
		
		// 탈퇴회원 검색 게시물
		String url = request.getContextPath();
		List<MemberEntity> searchWithdrawalList = memberService.selectSearchWithdrawalList(param, offset, limit);
		String searchWithdrawalListStr = Mir9Utils.getSearchWithdrawalListStr(searchWithdrawalList, url);
		
		// 탈퇴 회원 전체 게시물 수
		int searchListCount = memberService.selectSearchWithdrawalListCount(param);
		log.debug("searchListCount = {}", searchListCount);
		
		// pagebar
		url = request.getRequestURI();
		String pagebar = Mir9Utils.getPagebarWithdrawal(cPage, limit, searchListCount, url);
		
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("searchWithdrawalListStr", searchWithdrawalListStr);
		resultMap.put("searchListCount", searchListCount);
		resultMap.put("pagebar", pagebar);
		
		return resultMap;
	
	}
	
	// 회원&탈퇴회원 선택 삭제
	@PostMapping("/memberDelete.do")
	public String memberDelete(@RequestParam int[] memberNo, RedirectAttributes redirectAttribute, HttpServletRequest request) throws Exception {
		Map<String, Object> param = new HashMap<>();
		
		try {		
			// 주소 번호 조회
			List<Address> addressList = memberService.findAddressNo(memberNo);
			for(int i = 0; i < addressList.size(); i++) {
				int addressNo = addressList.get(i).getAddressNo();				
				// 주소 삭제
				int resultDeleteAddress = memberService.deleteAddress(addressNo);
			}
			
			// 주소록 삭제
			int resultDeleteAddressBook = memberService.deleteAddressBook(memberNo);
					
			// 권한 삭제
			int resultDeleteAuthorities = memberService.deleteAuthorities(memberNo);
			
			// 메모 삭제
			int resultDeleteMemberMemo = memberService.deleteMemberMemo(memberNo);
			
			// 회원 삭제
			int resultDeleteMember = memberService.deleteMember(memberNo);
						
			redirectAttribute.addFlashAttribute("msg", "해당 회원이 삭제되었습니다.");
		} catch (Exception e) {
			log.error("회원 삭제 실패", e);
			throw e; // spring container에게 예외상황 알림
		}
		
		String referer = request.getHeader("Referer");

		return "redirect:" + referer;
	}
	
	// 탈퇴회원 상세보기
	@ResponseBody
	@GetMapping("/withdrawalMemberDetail.do/{memberNo}")
	public Map<String, Object> withdrawalMemberDetail(@PathVariable int memberNo, Model model, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<>();
		
		WithdrawalMemberEntity withdrawalMemberEntity = memberService.selectOneWithdrawalMemberEntity(memberNo);
		model.addAttribute("withdrawalMemberEntity", withdrawalMemberEntity);
		
		// 휴대폰 번호 분기
		String mobile1 = withdrawalMemberEntity.getPhone().substring(0, 3);
		String mobile2 = withdrawalMemberEntity.getPhone().substring(3, 7);
		String mobile3 = withdrawalMemberEntity.getPhone().substring(7, 11);
		
		// 시간 양식 변경
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String regDate = dateFormat.format(withdrawalMemberEntity.getRegDate());
		
		String loginDate = "";
		
		if(withdrawalMemberEntity.getLoginDate() == null){
			loginDate = "";
		} else {
			loginDate = dateFormat.format(withdrawalMemberEntity.getLoginDate());
		}
		
		String updateDate = "";
		if(withdrawalMemberEntity.getUpdateDate() == null) {
			updateDate = "";
		} else {
			updateDate = dateFormat.format(withdrawalMemberEntity.getUpdateDate());
		}
		
		String withdrawalDate = "";
		if(withdrawalMemberEntity.getWithdrawalDate() == null) {
			withdrawalDate = "";
		} else {
			withdrawalDate = dateFormat.format(withdrawalMemberEntity.getWithdrawalDate());
		}
		
		// 주소(Address) 조회
		Address address = memberService.selectOneAddress(memberNo);
		model.addAttribute("address", address);
		
		// 메모(MemberMemoContent) 조회
		MemberMemo memberMemo = memberService.selectOneMemo(memberNo);

		if(memberMemo.getMemberMemoContent() == null) 
			 memberMemo.setMemberMemoContent("");
	
		model.addAttribute("memberMemo = {}", memberMemo);
		
		// 회원 권한 조회
		Authorities authorities = memberService.selectOneAuthorities(memberNo);
		model.addAttribute("authorities = {}", authorities);
				
		map.put("withdrawalMemberEntity", withdrawalMemberEntity);
		map.put("mobile1", mobile1);
		map.put("mobile2", mobile2);
		map.put("mobile3", mobile3);
		map.put("address", address);
		map.put("memberMemo", memberMemo);
		map.put("authorities", authorities);
		map.put("regDate", regDate);
		map.put("loginDate", loginDate);
		map.put("withdrawalDate", withdrawalDate);
		map.put("updateDate", updateDate);
		
		return map;
	}
	
	// 탈퇴회원 상세보기 등록(update)
	@SuppressWarnings("unchecked")
	@ResponseBody
 	@PostMapping("/withdrawalMemberUpdate.do")
	public String withdrawalMemberUpdate(@RequestBody String data, RedirectAttributes redirectAttribute) {
		ObjectMapper mapper = new ObjectMapper();
		
		try {
			Map<String, String> map = mapper.readValue(data, Map.class);
			
			String phone = map.get("mobile1") + map.get("mobile2") + map.get("mobile3");
			
			// 탈퇴회원(Member) 수정
			WithdrawalMemberEntity paramWithdrawal = new WithdrawalMemberEntity();
			paramWithdrawal.setMemberNo(Integer.parseInt(map.get("memberNo")));
			paramWithdrawal.setFirstName(map.get("firstName"));
			paramWithdrawal.setLastName(map.get("lastName"));
			paramWithdrawal.setEmail(map.get("email"));
			paramWithdrawal.setPhone(phone);
			paramWithdrawal.setStatus(map.get("status"));
			paramWithdrawal.setReason(map.get("reason"));
			
			if(map.get("password").isEmpty()) {
				paramWithdrawal.setPassword(map.get("password"));
			} else {
				// 비밀번호 암호화 처리
				String rawPassword = map.get("password");
				String encryptedPassword = passwordEncoder.encode(rawPassword);
				paramWithdrawal.setPassword(encryptedPassword);
			}
			
			int resultWithdrawalMember = memberService.memberUpdate(paramWithdrawal);
			
			// 주소(Address) 수정
			Address paramAddress = new Address();
			paramAddress.setAddressNo(Integer.parseInt(map.get("addressNo")));
			paramAddress.setAddressMain(map.get("addressMain"));
			paramAddress.setAddressSub(map.get("addressSub"));
			paramAddress.setAddressZipcode(Integer.parseInt(map.get("addressZipcode")));
			
			int resultAddressUpdate = memberService.addressUpdate(paramAddress);
			
			// 메모(MemberMemo) 수정
			MemberMemo paramMemberMemo = new MemberMemo();
			paramMemberMemo.setMemberNo(Integer.parseInt(map.get("memberNo")));
			paramMemberMemo.setMemberMemoContent(map.get("memberMemoContent"));
			
			int resultMemberMemo = memberService.memberMemoUpdate(paramMemberMemo);
			
			// 권한(Authorities) 수정
			Authorities paramAuthorities = new Authorities();
			paramAuthorities.setAuthority(map.get("authority"));
			paramAuthorities.setMemberNo(Integer.parseInt(map.get("memberNo")));
			
			int resultAuthorities = memberService.authoritiesUpdate(paramAuthorities);

		} catch (IOException e) {}

		return "redirect:/admin/member/withdrawalList.do";
	}
	
	
	// 회원 접속 이력 관리
	@GetMapping("/log")
	public String memberAccessHistory(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) {		
		int limit = 20;
		int offset = (cPage - 1) * limit;
		
		try {
			// 접속 이력 리스트
			List<MemberAccessHistory> memberAccessHistoryList = memberService.seletHistoryList(offset, limit);
			model.addAttribute("memberAccessHistoryList", memberAccessHistoryList);
			
			// 접속 이력 게시글 수
			int totalAccessHistoryCount = memberService.selectAccessHistoryCount();
			model.addAttribute("totalAccessHistoryCount", totalAccessHistoryCount);
			
			// pagebar
			String url = request.getRequestURI();
			String pagebar = Mir9Utils.getPagebar(cPage, limit, totalAccessHistoryCount, url);
			model.addAttribute("pagebar", pagebar);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "admin/member/memberAccessHistory";
	}
	
	// 회원 접속이력 관리 타입별 검색
	@ResponseBody
	@GetMapping("/typeSearchByAcceessHistory.do")
	public Map<String, Object> typeSearchByAcceessHistory(@RequestParam(defaultValue = "1") int cPage, @RequestParam String type, @RequestParam String keyword, HttpServletRequest request){		
		
		int limit = 20;
		int offset = (cPage - 1) * limit;
		
		Map<String, Object> param = new HashMap<>();
		param.put("type", type);
		param.put("keyword", keyword);
		
		// 접속 이력 검색 게시물
		String url = request.getContextPath();
		List<MemberAccessHistory> searchAccessHistoryList = memberService.seletSearchAccessHistory(param, offset, limit);
		String searchAccessHistoryListStr = Mir9Utils.getSearchAccessHistoryListStr(searchAccessHistoryList, url);
		
		// 접속 이력 검색 게시물 수
		int searchHistoryListCount = memberService.selectSearchHistoryListCount(param);
		
		// pagebar
		url = request.getRequestURI();
		String pagebar = Mir9Utils.getPagebarAccessHistory(cPage, limit, searchHistoryListCount, url);
		
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("searchAccessHistoryListStr", searchAccessHistoryListStr);
		resultMap.put("searchHistoryListCount", searchHistoryListCount);
		resultMap.put("pagebar", pagebar);
		
		return resultMap;
	}
	
	// 회원 접속이력 관리 선택 삭제
	@PostMapping("/accessHistoryDelete.do")
	public String accessHistoryDelete(@RequestParam int[] accessHistoryNo, RedirectAttributes redirectAttribute, HttpServletRequest request) throws Exception {
		try {
			int resultAccessHistoryDelete = memberService.deleteAccessHistory(accessHistoryNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		String referer = request.getHeader("Referer");
		return "redirect:" + referer;
	}
	
	// 등급 관리 조회
	@GetMapping("/memberGrade.do")
	public Map<String, Object> memberGrade(Model model, HttpServletRequest request) {
		// 명칭 가져오기
		List<MemberGrade> memberGradeList = memberService.selectMemberGradeList();
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("memberGradeList", memberGradeList);
		return resultMap;
	}
	
	// 등급 수정
	@SuppressWarnings("unchecked")
	@ResponseBody
	@PostMapping("/memberGradeUpdate.do")
	public String memberGradeUpdate(@RequestBody String data, RedirectAttributes redirectAttributes) {
		ObjectMapper mapper = new ObjectMapper();
		try {
			Map<String, String> map = mapper.readValue(data, Map.class);
			MemberGrade paramGrade = new MemberGrade();
			Set<String> keySet = map.keySet();

				for(String key : keySet) {
					System.out.println(key + " : " + map.get(key));
					paramGrade.setMemberGradeNo(Integer.parseInt(key));
					paramGrade.setMemberGradeName(map.get(key));
					int resultMemberGradeUpdate = memberService.memberGradeUpdate(paramGrade);
				}
				
			} catch (IOException e) {}
		
		return "redirect:/admin/member/memberGrade.do";
	}
	
	// 선택 회원 적립금 내역보기
	@RequestMapping(value="/memberPointList/{memberNo}", method= {RequestMethod.GET, RequestMethod.POST})
	public String selectedMemberPointList(
			@PathVariable int memberNo,
			@RequestParam(defaultValue="1") int cPage,
			@RequestParam(required=false) String field,
			@RequestParam(required=false) String keyword,
			HttpServletRequest request,
			Model model) {
		
		int limit = 15;
		int startRow = (cPage - 1) * limit + 1;
		int endRow = startRow + limit -1;
		
		Map<String, Object> param = new HashMap<>();
		param.put("memberNo", memberNo);
		param.put("field", field);
		param.put("keyword", keyword);
		param.put("startRow", startRow);
		param.put("endRow", endRow);
		
		// 전체 회원 포인트 목록 조회
		List<MemberPoint> mPointList = memberService.selectMemberPointListByParam(param);
		int totalPointCount = memberService.totalPointCount(param);
		String pointAllUri = "";
		if((field == null || field == "") 
				&& (keyword == null || keyword == "")) {
			pointAllUri = request.getRequestURI();
		}
		else {
			pointAllUri = request.getRequestURI() + "?field=" + field + "&keyword=" + keyword;
		}
		String pagebar = Mir9Utils.getPagebar(cPage, limit, totalPointCount, pointAllUri);

		model.addAttribute("mPointList", mPointList);
		model.addAttribute("total", totalPointCount);
		model.addAttribute("param",param);
		model.addAttribute("pagebar", pagebar);
		
		return "admin/member/memberPointList";
	}

	// 전체 회원 적립금 관리
	@RequestMapping(value="/point", method= {RequestMethod.GET, RequestMethod.POST})
	public String memberPointList(
			@RequestParam(defaultValue="0") int mNo,
			@RequestParam(defaultValue="1") int cPage,
			@RequestParam(required=false) String field,
			@RequestParam(required=false) String keyword,
			HttpServletRequest request,
			Model model) {
		
		int limit = 15;
		int startRow = (cPage - 1) * limit + 1;
		int endRow = startRow + limit -1;
		
		Map<String, Object> param = new HashMap<>();
		param.put("memberNo", mNo);
		param.put("field", field);
		param.put("keyword", keyword);
		param.put("startRow", startRow);
		param.put("endRow", endRow);
		
		// 전체 회원 포인트 목록 조회
		List<MemberPoint> mPointList = memberService.selectMemberPointListByParam(param);
		int totalPointCount = memberService.totalPointCount(param);
		String pointAllUri = "";
		if((field == null || field == "") 
				&& (keyword == null || keyword == "")) {
			pointAllUri = request.getRequestURI();
		}
		else {
			pointAllUri = request.getRequestURI() + "?field=" + field + "&keyword=" + keyword;
		}
		String pagebar = Mir9Utils.getPagebar(cPage, limit, totalPointCount, pointAllUri);

		model.addAttribute("mPointList", mPointList);
		model.addAttribute("total", totalPointCount);
		model.addAttribute("param",param);
		model.addAttribute("pagebar", pagebar);
		
		return "admin/member/memberPointList";
	}
	
	// 로그인 화면 요청
	@GetMapping("/memberLogin.do")
	public String memberLoginPage() {	
		return "admin/member/memberList";
	}
	
	@PostMapping("/memberLogin.do")
	public String memberLogin() {
		return "redirect:/admin/dashBoard";
	}
	
	/**
	 * 
	 * @param binder
	 * @InitBinder
	 * 	사용자 요청을 커맨드 객체 바인딩 시 Validator 객체, 특정타입별 editor 객체 설정
	 * 
	 */
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm");
		// 형식객체, 빈값허용여부("" -> null)
		PropertyEditor editor = new CustomDateEditor(sdf, true);
		binder.registerCustomEditor(Date.class, editor);
	}

}
