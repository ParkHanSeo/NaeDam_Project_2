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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.ObjectMapper;
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
	public String memberWithdrawal(
			@RequestParam String password,
			@RequestParam String reason,
			Authentication authentication,
			RedirectAttributes redirectAttribute,
			HttpServletRequest request) {
		log.debug("password = {}", password);
		log.debug("reason = {}", reason);
		Map<String, Object> param = new HashMap<>();
		// 회원 조회
		Member member = (Member) authentication.getPrincipal();
		log.debug("[principal] member = {}", member);
		int memberNo = member.getMemberNo();
		// 주소 조회
		//Address address = memberService.selectOneAddress(memberNo);
		//int addressNo = address.getAddressNo();
		//String id = member.getId();
		param.put("memberNo", memberNo);
		param.put("reason", reason);
		
		// 주소록 조회
		//AddressBook resultAddressBook = memberService.selectOneAddressBook(memberNo);
		//log.debug("resultAddressBook = {}", resultAddressBook);
		//int addressBookNo = resultAddressBook.getAddressBookNo();
		
		// 비밀번호 비교
		if(passwordEncoder.matches(password, member.getPassword())){
			
			try {
				// 주소록 삭제
				//int resultDeleteAddressBook = memberService.deleteAddressBook(addressBookNo);
				//log.debug("resultDeleteAddressBook = {}", resultDeleteAddressBook);

				// 주소 삭제
				//int resultDeleteAddress = memberService.deleteAddress(addressNo);
				//log.debug("resultDeleteAddress = {}", resultDeleteAddress);

				// 권한 삭제
				//int resultDeleteAuthorities = memberService.deleteAuthorties(memberNo);
				//log.debug("resultDeleteAuthorities = {}", resultDeleteAuthorities);
				
				// 메모 삭제
				//int resultDeleteMemberMemo = memberService.deleteMemberMemo(memberNo);
				//log.debug("resultDeleteMemberMemo = {}", resultDeleteMemberMemo);
				
				/*
				 *  1) 회원 탈퇴로 변경 (status : Y -> N)(update)
				 *  2) 탈퇴일 : (withdrawalDate : NOW(update)
				 *  3) 탈퇴사유 : (reason : update)
				 */
				int resultMemberToWithdrawal = memberService.updateMemberToWithdrawal(param);
				log.debug("resultMemberToWithdrawal = {}", resultMemberToWithdrawal);
				
				
				//int resultMemberWithdrawal = memberService.memberWithdrawal(id);
				//log.debug("resultMemberWithdrawal = {}", resultMemberWithdrawal);
				
				// 탈퇴 사유(update)
				//int resultUpdateReason = memberService.updateReason(param);
				//log.debug("resultUpdateReason = {}", resultUpdateReason);
				
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
	public String memberList(Model model, HttpServletRequest request) {
		
		// 회원 리스트 전체 게시물 목록
		List<MemberEntity> memberList = memberService.selectMemberList();
		log.debug("memberList = {}", memberList);
		model.addAttribute("memberList", memberList);
		
		// 전체 게시물 수
		int totalMemberListCount = memberService.selectMemerListCount();
		log.debug("totalMemberListCount = {}", totalMemberListCount);
		model.addAttribute("totalMemberListCount", totalMemberListCount);
		
		// 명칭 가져오기
		List<MemberGrade> memberGradeList = memberService.selectMemberGradeList();
		log.debug("memberGradeList = {}", memberGradeList);
		model.addAttribute("memberGradeList", memberGradeList);
		
		// 쿠폰 리스트
		List<Coupon> couponList = couponService.selectCouponList();
		model.addAttribute("couponList",couponList);
		
		return "admin/member/memberList";
	}
	
	// id 중복 검사
	@ResponseBody
	@GetMapping("/checkIdDuplicate.do")
	public Map<String, Object> checkIdDuplicate(@RequestParam Map<String, Object> param) {
		log.debug("id = {}", param);
		Map<String, Object> map = new HashMap<>();
		Member member = memberService.selectOneMemberByMap(param);
		log.debug("member = {}", member);

		map.put("available", member == null);
		
		return map;
	}
	
	// 회원리스트 - 등록
	@PostMapping("/memberInsertModalFrm.do")
	public String memberInsertModalFrm(
						Member member, 
						Address address,
						AddressBook addressBook,
						MemberMemo memberMemo,
						MemberGrade memberGradeNo,
						@RequestParam String mobile1,
						@RequestParam String mobile2,
						@RequestParam String mobile3,
						@RequestParam String authority,
						RedirectAttributes redirectAttributes) {
		log.debug("{}", "memberInsertModalFrm.do 요청!");
		log.debug("member = {}", member);
		log.debug("memberMemo = {}", memberMemo);
		log.debug("memberGradeNo = {}", memberGradeNo);
		log.debug("mobile = {}", mobile1);
		log.debug("mobile = {}", mobile2);
		log.debug("mobile = {}", mobile3);
		log.debug("address = {}", address);
		log.debug("authority = {}", authority);
		
		String phone = mobile1 + mobile2 + mobile3;
		
		// 0. 비밀번호 암호화 처리
		log.debug("{}", passwordEncoder);
		String rawPassword = member.getPassword();
		String encryptedPassword = passwordEncoder.encode(rawPassword);
		member.setPassword(encryptedPassword);
		log.debug("{} -> {}", rawPassword, encryptedPassword);
		
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
		log.debug("resultRegisterMember = {}", resultRegisterMember);
		
		// 2. 주소 입력
		// 2.1. 주소 입력
		int resultRegisterAddress = memberService.insertAddress(address);
		log.debug("resultRegisterAddress = {}", resultRegisterAddress);
		
		// 2.2. 주소록 입력
		AddressBook paramAddressBook = new AddressBook();
		paramAddressBook.setAddressBookNo(addressBook.getAddressBookNo());
		paramAddressBook.setAddressNo(address.getAddressNo());
		paramAddressBook.setMemberNo(paramMember.getMemberNo());
		
		int resultRegisterAddressBook = memberService.insertAddressBook(paramAddressBook);
		log.debug("resultRegisterAddress = {}", resultRegisterAddress);
		
		// 3. 메모 입력
		// 3.1. 회원 입력 시 생성된 회원번호(MemberNo) 설정
		MemberMemo paramMemberMemo = new MemberMemo();
		paramMemberMemo.setMemberMemoNo(memberMemo.getMemberMemoNo());
		paramMemberMemo.setMemberNo(paramMember.getMemberNo());
		paramMemberMemo.setMemberMemoContent(memberMemo.getMemberMemoContent());
		
		int memberNo = paramMember.getMemberNo();
		log.debug("memberNo = {}", memberNo);
		
		// 3.2. 메모 입력
		int resultRegisterMemberMemo = memberService.insertMemberMemo(paramMemberMemo);
		log.debug("resultRegisterMemberMemo = {}", resultRegisterMemberMemo);
		
		// 4. 등급 입력(update)
		// 4.1. 권한 입력
		Authorities paramAuthorities = new Authorities();
		paramAuthorities.setAuthority(authority);
		paramAuthorities.setMemberNo(paramMember.getMemberNo());
		
		int resultInsertAuthorities = memberService.insertAuthorities(paramAuthorities);
		log.debug("resultInsertAuthorities = {}", resultInsertAuthorities);
		
		String msg = "";
		
		if(resultRegisterMember > 0 
				&& resultRegisterAddress > 0 
				&& resultRegisterAddressBook > 0
				&& resultRegisterMemberMemo > 0
				&& resultInsertAuthorities > 0) {
			msg = "해당 회원이 등록 되었습니다.";
		} else {
			msg = "회원 등록이 실패했습니다.";
		}

		redirectAttributes.addFlashAttribute("msg", msg);
		
		return "redirect:/admin/member/list.do";
	}
	
	// 타입별 검색
	@ResponseBody
	@GetMapping("/typeSearch.do")
	public Map<String, Object> typeSearch(
			@RequestParam String type, 
			@RequestParam String keyword,
			HttpServletRequest request){
		log.debug("{}", "타입별 검색 시작");
		log.debug("type = {}", type);
		log.debug("keyboard = {}", keyword);
		
		Map<String, Object> param = new HashMap<>();
		param.put("type", type);
		param.put("keyword", keyword);
		log.debug("param = {}", param);
		
		// 검색 게시물 
		List<MemberEntity> searchMemberList = memberService.selectSearchMemberList(param);
		log.debug("searchMemberList = {}", searchMemberList);

		// 검색 게시물 수
		int searchListCount = memberService.selectSearchListCount(param);
		log.debug("searchListCount = {}", searchListCount);
		
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("searchMemberList", searchMemberList);
		resultMap.put("searchListCount", searchListCount);
		
		return resultMap;
	}
	
	// 회원 선택 삭제
	@PostMapping("/memberDelete.do")
	public String memberDelete(
						@RequestParam int[] memberNo,
						RedirectAttributes redirectAttr,
						HttpServletRequest request) throws Exception {
		log.debug("{}", "memberDelete.do 시작");
		log.debug("memberNo = {}", memberNo);
		
		try {
			// 주소 번호 조회
			List<Address> MemberaddressList = memberService.findMemberAddressList(memberNo);
			log.debug("MemberaddressList = {}", MemberaddressList);
			for(int i = 0; i < MemberaddressList.size(); i++) {
				
				int addressNo = MemberaddressList.get(i).getAddressNo();
				log.debug("addressNo = {}", addressNo);
				
				// 주소 삭제
				int resultDeleteAddress = memberService.deleteAddress(addressNo);
				log.debug("resultDeleteAddress = {}", resultDeleteAddress);
				
				// 주소 영구삭제
				int resultWithdrawalAddress = memberService.deleteWithdrawalAddress(addressNo);
				log.debug("resultWithdrawalAddress = {}", resultWithdrawalAddress);
			}
			
			// 주소록 삭제
			int resultDeleteBook = memberService.deleteAddressBookByMemberNo(memberNo);
			log.debug("resultDeleteBook = {}", resultDeleteBook);
			
			// 권한 삭제
			int resultDeleteAuthority = memberService.deleteAuthorityByMemberNo(memberNo);
			log.debug("resultDeleteAuthority = {}", resultDeleteAuthority);
			
			// 메모 삭제
			int resultDeleteMemo = memberService.deleteMemoByMemberNo(memberNo);
			log.debug("resultDeleteMemo = {}", resultDeleteMemo);
			
			// 회원 삭제
			int result = memberService.deleteMember(memberNo);
			log.debug("result = {}", result);
			
			// 주소록 영구삭제
			int resultWithdrawalAddressBook = memberService.deleteWithdrawalAddressBook(memberNo);
			log.debug("resultWithdrawalAddressBook = {}", resultWithdrawalAddressBook);
			
			// 권한 영구삭제
			int resultWithdrawalAuthority = memberService.deleteWithdrawalAuthority(memberNo);
			log.debug("resultWithdrawalAuthority = {}", resultWithdrawalAuthority);
			
			// 메모 영구삭제
			int resultWithdrawalMemo = memberService.deleteWithdrawalMemo(memberNo);
			log.debug("resultWithdrawalMemo = {}", resultWithdrawalMemo);
			
			// 회원 영구삭제
			int resultWithdrawalMember = memberService.deleteWithdrawal(memberNo);
			log.debug("resultWithdrawalMember = {}", resultWithdrawalMember);
			
			redirectAttr.addFlashAttribute("msg", "해당 회원이 삭제되었습니다.");
		} catch (Exception e) {
			log.error("회원 삭제 실패", e);
			throw e; // spring container에게 예외상황 알림
		}
		
		String referer = request.getHeader("Referer");
		log.debug("referer = {}", referer);
		
		return "redirect:" + referer;
	}
	
	// 회원 상세보기
	@ResponseBody
	@GetMapping("/memberDetail.do/{memberNo}")
	public Map<String, Object> memberDetail(@PathVariable int memberNo, Model model,
								HttpServletRequest request,
								HttpServletResponse response) {
		
		log.debug("memberNo = {}", memberNo);
		
		Map<String, Object> map = new HashMap<>();
		
		// 업무로직
		// 1. 회원(Member) 조회
		Member member = memberService.selectOneMemberByMemberNo(memberNo);
		log.debug("member = {}", member);
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
		log.debug("address = {}", address);
		model.addAttribute("address", address);
		
		// 3. 메모(MemberMemoContent) 조회
		MemberMemo memberMemo = memberService.selectOneMemo(memberNo);
		log.debug("memberMemo = {}", memberMemo);

		if(memberMemo.getMemberMemoContent() == null) 
			 memberMemo.setMemberMemoContent("");
	
		model.addAttribute("memberMemo = {}", memberMemo);
		
		// 4. 회원 권한 조회
		Authorities authorities = memberService.selectOneAuthorities(memberNo);
		log.debug("authorities = {}", authorities);
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
		log.debug("{}", "memberUpdate.do 요청!");
		log.debug("param = {}", data);
		
		ObjectMapper mapper = new ObjectMapper();
		
		try {
			Map<String, String> map = mapper.readValue(data, Map.class);
			log.debug("map = {}", map);
			
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
				log.debug("{}", passwordEncoder);
				String rawPassword = map.get("password"); 
				String encryptedPassword = passwordEncoder.encode(rawPassword);
				paramMember.setPassword(encryptedPassword);
				log.debug("{} -> {}", rawPassword, encryptedPassword);
			}

			int resultMemberUpdate = memberService.memberUpdate(paramMember);
			log.debug("resultMemberUpdate = {}", resultMemberUpdate);
			
			// 주소(Address) 수정
			Address paramAddress = new Address();
			paramAddress.setAddressNo(Integer.parseInt(map.get("addressNo")));
			paramAddress.setAddressMain(map.get("addressMain"));
			paramAddress.setAddressSub(map.get("addressSub"));
			paramAddress.setAddressZipcode(Integer.parseInt(map.get("addressZipcode")));
			
			int resultAddressUpdate = memberService.addressUpdate(paramAddress);
			log.debug("resultAddressUpdate = {}", resultAddressUpdate);
			
			// 메모(MemberMemo) 수정
			MemberMemo paramMemberMemo = new MemberMemo();
			paramMemberMemo.setMemberNo(Integer.parseInt(map.get("memberNo")));
			paramMemberMemo.setMemberMemoContent(map.get("memberMemoContent"));
			
			int resultMemberMemo = memberService.memberMemoUpdate(paramMemberMemo);
			log.debug("resultMemberMemo = {}", resultMemberMemo);
			
			// 권한(Authorities) 수정
			Authorities paramAuthorities = new Authorities();
			paramAuthorities.setAuthority(map.get("authority"));
			paramAuthorities.setMemberNo(Integer.parseInt(map.get("memberNo")));
			
			int resultAuthorities = memberService.authoritiesUpdate(paramAuthorities);
			log.debug("resultAuthorities = {}", resultAuthorities);
			
	
		} catch(IOException e) {}

		return "redirect:/admin/member/list.do";
	}
	

	// 탈퇴회원 리스트
	@GetMapping("/withdrawalList.do")
	public String withdarawalMemberList(Model model, HttpServletRequest request) {
		log.debug("withdarawalMemberList = {}","withdarawalMemberList 시작");
		
		// 탈퇴 회원 리스트 전체 게시물 목록
		List<MemberEntity> withdrawalMemberList = memberService.selectMemberList();
		log.debug("withdrawalMemberList = {}", withdrawalMemberList);
		model.addAttribute("withdrawalMemberList", withdrawalMemberList);
		
		// 탈퇴회원 전체 게시물 수
		int totalwithdrawalCount = memberService.selectWithdrawalCount();
		log.debug("totalwithdrawalCount = {}", totalwithdrawalCount);
		model.addAttribute("totalwithdrawalCount", totalwithdrawalCount);
		
		// 명칭 가져오기
		List<MemberGrade> memberGradeList = memberService.selectMemberGradeList();
		log.debug("memberGradeList = {}", memberGradeList);
		model.addAttribute("memberGradeList", memberGradeList);
		
		/*
		// 탈퇴 회원 리스트
		List<WithdrawalMember> withdrawalMemberList = memberService.selectWithdrawalMemberList();
		log.debug("withdrawalMember = {}", withdrawalMemberList);
		model.addAttribute("withdrawalMemberList", withdrawalMemberList);
		*/
				
		// 탈퇴 회원 전체 게시물 수
		//int withdrawalCount = memberService.selectWithdrawalCount();
		//log.debug("withdrawalCount = {}", withdrawalCount);
		//model.addAttribute("withdrawalCount", withdrawalCount);
		
		return "admin/member/withdrawalMemberList";
	}
	
	// 탈퇴회원 타입별 검색
	@ResponseBody
	@GetMapping("/withdrawalTypeSearch.do")
	public Map<String, Object> withdrawalTypeSearch(
			@RequestParam String type, 
			@RequestParam String keyword,
			HttpServletRequest request){
		log.debug("{}", "타입별 검색 시작");
		log.debug("type = {}", type);
		log.debug("keyboard = {}", keyword);
		
		Map<String, Object> param = new HashMap<>();
		param.put("type", type);
		param.put("keyword", keyword);
		log.debug("param = {}", param);
		
		// 탈퇴회원 검색 게시물 
		List<MemberEntity> searchWithdrawalList = memberService.selectSearchWithdrawalList(param);
		log.debug("searchWithdrawalList = {}", searchWithdrawalList);

		// 탈퇴회원 검색 게시물 수
		int searchListCount = memberService.selectSearchWithdrawalListCount(param);
		log.debug("searchListCount = {}", searchListCount);
		
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("searchWithdrawalList", searchWithdrawalList);
		resultMap.put("searchListCount", searchListCount);
		
		return resultMap;
	}
	
	// 탈퇴회원 선택 삭제
	@PostMapping("/withdrawalDelete.do")
	public String withdrawalDelete(
				@RequestParam int[] memberNo,
				RedirectAttributes redirectAttr,
				HttpServletRequest request) throws Exception {
		log.debug("{}", "withdrawalDelete.do 시작");
		log.debug("memberNo = {}", memberNo);
		Map<String, Object> param = new HashMap<>();
		
		try {		
			// 주소 번호 조회
			List<Address> addressList = memberService.findAddressNo(memberNo);
			log.debug("addressNo = {}", addressList);
			for(int i = 0; i < addressList.size(); i++) {
				
				int addressNo = addressList.get(i).getAddressNo();
				log.debug("addressNo = {}", addressNo);
				
				// 주소 영구삭제
				int resultDeleteAddress = memberService.deleteWithdrawalAddress(addressNo);
				log.debug("resultDeleteAddress = {}", resultDeleteAddress);
			}
			
			// 주소록 영구삭제
			int resultDeleteBook = memberService.deleteWithdrawalAddressBook(memberNo);
			log.debug("resultDeleteBook = {}", resultDeleteBook);
			
					
			// 권한 영구삭제
			int resultDeleteAuthority = memberService.deleteWithdrawalAuthority(memberNo);
			log.debug("resultDeleteAuthority = {}", resultDeleteAuthority);
			
			// 메모 영구삭제
			int resultDeleteMemo = memberService.deleteWithdrawalMemo(memberNo);
			log.debug("resultDeleteMemo = {}", resultDeleteMemo);
			
			// 회원 영구삭제
			int resultDeleteMember = memberService.deleteWithdrawal(memberNo);
			log.debug("result = {}", resultDeleteMember);			
						
			redirectAttr.addFlashAttribute("msg", "해당 회원이 삭제되었습니다.");
		} catch (Exception e) {
			log.error("회원 삭제 실패", e);
			throw e; // spring container에게 예외상황 알림
		}
		
		String referer = request.getHeader("Referer");
		log.debug("referer = {}", referer);
		return "redirect:" + referer;
	}
	
	// 탈퇴회원 상세보기
	@ResponseBody
	@GetMapping("/withdrawalMemberDetail.do/{memberNo}")
	public Map<String, Object> withdrawalMemberDetail(@PathVariable int memberNo, Model model,
				HttpServletRequest request,
				HttpServletResponse response) {
		log.debug("memberNo = {}", memberNo);
		Map<String, Object> map = new HashMap<>();
		
		WithdrawalMemberEntity withdrawalMemberEntity = memberService.selectOneWithdrawalMemberEntity(memberNo);
		log.debug("withdrawalMemberEntity = {}", withdrawalMemberEntity);
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
		log.debug("address = {}", address);
		model.addAttribute("address", address);
		
		// 메모(MemberMemoContent) 조회
		MemberMemo memberMemo = memberService.selectOneMemo(memberNo);
		log.debug("memberMemo = {}", memberMemo);

		if(memberMemo.getMemberMemoContent() == null) 
			 memberMemo.setMemberMemoContent("");
	
		model.addAttribute("memberMemo = {}", memberMemo);
		
		// 회원 권한 조회
		Authorities authorities = memberService.selectOneAuthorities(memberNo);
		log.debug("authorities = {}", authorities);
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
		log.debug("{}", "withdrawalMemberUpdate.do 요청!");
		log.debug("param = {}", data);
		
		ObjectMapper mapper = new ObjectMapper();
		
		try {
			Map<String, String> map = mapper.readValue(data, Map.class);
			log.debug("map = {}", map);
			
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
				log.debug("{}", passwordEncoder);
				String rawPassword = map.get("password");
				String encryptedPassword = passwordEncoder.encode(rawPassword);
				paramWithdrawal.setPassword(encryptedPassword);
				log.debug("{} -> {}", rawPassword, encryptedPassword);
			}
			
			int resultWithdrawalMember = memberService.memberUpdate(paramWithdrawal);
			log.debug("resultWithdrawalMember = {}", resultWithdrawalMember);
			
			// 주소(Address) 수정
			Address paramAddress = new Address();
			paramAddress.setAddressNo(Integer.parseInt(map.get("addressNo")));
			paramAddress.setAddressMain(map.get("addressMain"));
			paramAddress.setAddressSub(map.get("addressSub"));
			paramAddress.setAddressZipcode(Integer.parseInt(map.get("addressZipcode")));
			
			int resultAddressUpdate = memberService.addressUpdate(paramAddress);
			log.debug("resultAddressUpdate = {}", resultAddressUpdate);
			
			// 메모(MemberMemo) 수정
			MemberMemo paramMemberMemo = new MemberMemo();
			paramMemberMemo.setMemberNo(Integer.parseInt(map.get("memberNo")));
			paramMemberMemo.setMemberMemoContent(map.get("memberMemoContent"));
			
			int resultMemberMemo = memberService.memberMemoUpdate(paramMemberMemo);
			log.debug("resultMemberMemo = {}", resultMemberMemo);
			
			// 권한(Authorities) 수정
			Authorities paramAuthorities = new Authorities();
			paramAuthorities.setAuthority(map.get("authority"));
			paramAuthorities.setMemberNo(Integer.parseInt(map.get("memberNo")));
			
			int resultAuthorities = memberService.authoritiesUpdate(paramAuthorities);
			log.debug("resultAuthorities = {}", resultAuthorities);
			
			
		} catch (IOException e) {}
		
	
		
		return "redirect:/admin/member/withdrawalList.do";
	}
	
	
	// 회원 접속이력 관리
	@GetMapping("/log")
	public String memberAccessHistory(Model model, HttpServletRequest request) {
		
		// 접속 이력 리스트
		List<MemberAccessHistory> memberAccessHistoryList = memberService.seletHistoryList();
		log.debug("memberAccessHistoryList = {}", memberAccessHistoryList);
		model.addAttribute("memberAccessHistoryList", memberAccessHistoryList);
		
		// 접속 이력 게시글 수typeSearchByAcceessHistory.do
		int totalAccessHistoryCount = memberService.selectAccessHistoryCount();
		log.debug("totalAccessHistoryCount = {}", totalAccessHistoryCount);
		model.addAttribute("totalAccessHistoryCount", totalAccessHistoryCount);
		
		return "admin/member/memberAccessHistory";
	}
	
	// 회원 접속이력 관리 타입별 검색
	@ResponseBody
	@GetMapping("/typeSearchByAcceessHistory.do")
	public Map<String, Object> typeSearchByAcceessHistory(
									@RequestParam String type,
									@RequestParam String keyword,
									HttpServletRequest request){
		log.debug("{}", "타입별 검색 시작");
		log.debug("type = {}", type);
		log.debug("keyboard = {}", keyword);
		
		Map<String, Object> param = new HashMap<>();
		param.put("type", type);
		param.put("keyword", keyword);
		log.debug("param = {}", param);
		
		// 검색 게시물
		List<MemberAccessHistory> searchAccessHistoryList = memberService.seletSearchAccessHistory(param);
		log.debug("searchAccessHistoryList = {}", searchAccessHistoryList);
		
		// 검색 게시물 수
		int searchHistoryListCount = memberService.selectSearchHistoryListCount(param);
		log.debug("searchHistoryListCount = {}", searchHistoryListCount);
		
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("searchAccessHistoryList", searchAccessHistoryList);
		resultMap.put("searchHistoryListCount", searchHistoryListCount);
		
		return resultMap;
	}
	
	// 회원 접속이력 관리 선택 삭제
	@PostMapping("/accessHistoryDelete.do")
	public String accessHistoryDelete(@RequestParam int[] accessHistoryNo,
			RedirectAttributes redirectAttribute,
			HttpServletRequest request) throws Exception {
					
		int resultAccessHistoryDelete = memberService.deleteAccessHistory(accessHistoryNo);
		log.debug("resultAccessHistoryDelete = {}", resultAccessHistoryDelete);
		
		
		String referer = request.getHeader("Referer");
		log.debug("referer = {}", referer);
		
		return "redirect:" + referer;
	}
	
	
	// 등급 관리 조회(select)
	@GetMapping("/memberGrade.do")
	public Map<String, Object> memberGrade(Model model, HttpServletRequest request) {
		
		// 명칭 가져오기
		List<MemberGrade> memberGradeList = memberService.selectMemberGradeList();
		log.debug("memberGradeList = {}", memberGradeList);
		//model.addAttribute("memberGardeList", memberGradeList);
		
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("memberGradeList", memberGradeList);

		return resultMap;
	}
	
	// 등급 수정(update)
	@SuppressWarnings("unchecked")
	@ResponseBody
	@PostMapping("/memberGradeUpdate.do")
	public String memberGradeUpdate(
				@RequestBody String data,
				RedirectAttributes redirectAttributes) {
		
		log.debug("{}", "memberGradeUpdate.do 요청!");
		log.debug("param = {}", data);
		ObjectMapper mapper = new ObjectMapper();
		
		try {
			Map<String, String> map = mapper.readValue(data, Map.class);
			log.debug("map = {}", map);
			
			MemberGrade paramGrade = new MemberGrade();
			
			Set<String> keySet = map.keySet();
			for(String key : keySet) {
				System.out.println(key + " : " + map.get(key));
				
				paramGrade.setMemberGradeNo(Integer.parseInt(key));
				paramGrade.setMemberGradeName(map.get(key));
				
				int resultMemberGradeUpdate = memberService.memberGradeUpdate(paramGrade);
				log.debug("resultMemberGradeUpdate = {}", resultMemberGradeUpdate);
			}
			
		
			} catch (IOException e) {}

		return "redirect:/admin/member/memberGrade.do";
	}
	
	// 회원 적립금 내역보기
	@GetMapping("/memberPointList/{memberNo}")
	public String memberPointList(@PathVariable int memberNo, Model model, HttpServletRequest request, HttpServletResponse response) {
		
		log.debug("memberNo = {}", memberNo);
		
		// 업무로직
		
		
		return "admin/member/memberPointList";
	}
	
	// 회원 적립금 관리
	@GetMapping("/point")
	public String memberPointList(Model model, @RequestParam(defaultValue = "0") int mNo) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("memberNo", mNo);
		List<MemberPoint> mPointList = memberService.selectMemberPointListByParam(param);
		
		model.addAttribute("mPointList",mPointList);
		
		return "admin/member/memberPointList";
	}
	
	@PostMapping("/point")
	@SuppressWarnings("rawtypes")
	public String memberPointList(HttpServletRequest request, Model model, @RequestParam(defaultValue = "0") int mNo) {
		Map<String, Object> param = new HashMap<String, Object>();
		Enumeration params = request.getParameterNames();
		while (params.hasMoreElements()){
		    String name = (String)params.nextElement();
		    param.put(name, request.getParameter(name));
		}
		param.put("memberNo", mNo);
		List<MemberPoint> mPointList = memberService.selectMemberPointListByParam(param);
		
		model.addAttribute("mPointList",mPointList);
		model.addAttribute("param",param);
		return "/admin/member/memberPointList";
	}
	
	//쿠폰 등록, 적립금 지급/차감
	/* TODO
	 * - email, sms 처리 미완.
	 * */
	@PostMapping("/process.do")
	public String process(HttpServletRequest request, Model model, RedirectAttributes redirectAttr) {
		String mode = request.getParameter("mode");
		String msg = null;
		int result = 0;
		
		// 쿠폰 등록
		if(mode.equals("coupon")) {
			String couponNo = request.getParameter("coupon_code");
			List<String> memberNoList = Arrays.asList(request.getParameter("member_code").split(","));
			
			for(String memberNo : memberNoList) {
				MemberCoupon memberCoupon = new MemberCoupon(0, Integer.parseInt(memberNo), Integer.parseInt(couponNo), null);
				result = couponService.insertMemberCoupon(memberCoupon);
			}
			if(result > 0) msg = "쿠폰이 정상 지급되었습니다.";
		// 적립금 지금
		}else if(mode.equals("point")) {
			int point = Integer.parseInt(request.getParameter("point").replace(",", ""));
			
			// 차감일 경우, 음수로 변환
			if(request.getParameter("plus_minus_type").equals("-")) point *= -1;
			
			MemberPoint memberPoint = new MemberPoint();
			memberPoint.setPointAmount(point);
			memberPoint.setPointTitle(request.getParameter("content"));
			
			List<String> memberNoList = Arrays.asList(request.getParameter("member_code").split(","));
			for(String memberNo : memberNoList) {
				memberPoint.setMemberNo(Integer.parseInt(memberNo));
				result = pointService.insertMemberPoint(memberPoint);
			}
			
			if(result > 0) msg = "적립금이 정상 지급/차감되었습니다.";
		}
		
		redirectAttr.addFlashAttribute("msg",msg);
		
		return "redirect:/admin/member/list.do";
		
	}
	
	// 회원가입
	@GetMapping("/memberEnroll.do")
	public String memberEnroll() {
		return "admin/member/memberEnroll";
	}
	
	// 회원가입
	@PostMapping("/memberEnroll.do")
	public String memberEnroll(Member member, RedirectAttributes redirectAttr) {
		log.debug("member = {}", member);
		
		try {
			// 0. 비밀번호 암호화 처리
			log.info("{}", passwordEncoder);
			String rawPassword = member.getPassword();
			String encryptedPassword = passwordEncoder.encode(rawPassword);
			member.setPassword(encryptedPassword);
			log.info("{} -> {}", rawPassword, encryptedPassword);
			
			// 1.업무로직
			int result = memberService.insertMember(member);
			
			// 2.리다이렉트 & 사용자피드백 전달
			redirectAttr.addFlashAttribute("msg", "회원가입 성공!");
		} catch (Exception e) {
			log.error("회원가입 실패", e);
			throw e;
		}
		
		return "redirect:/";
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
