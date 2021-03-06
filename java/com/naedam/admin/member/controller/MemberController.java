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

import org.apache.xmlbeans.impl.jam.annotation.LineDelimitedTagParser;
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
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.naedam.admin.common.Mir9Utils;
import com.naedam.admin.community.model.service.CommunityService;
import com.naedam.admin.community.model.vo.EmailSetting;
import com.naedam.admin.community.model.vo.SmsSetting;
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
	
	// ?????? ??????
	@GetMapping("/memberWithdrawal.do")
	public void memberWithdrawal() {}
	
	// ?????? ?????? ??????
	@PostMapping("/memberWithdrawal.do")
	public String memberWithdrawal(@RequestParam String password, @RequestParam String reason,
								   Authentication authentication, RedirectAttributes redirectAttribute,
								   HttpServletRequest request) {
		Map<String, Object> param = new HashMap<>();
		// ?????? ??????
		Member member = (Member) authentication.getPrincipal();
		log.debug("[principal] member = {}", member);
		int memberNo = member.getMemberNo();
		param.put("memberNo", memberNo);
		param.put("reason", reason);
		
		// ???????????? ??????
		if(passwordEncoder.matches(password, member.getPassword())){
			try {
				/*
				 *  1) ?????? ????????? ?????? (status : Y -> N)(update)
				 *  2) ????????? : (withdrawalDate : NOW(update)
				 *  3) ???????????? : (reason : update)
				 */
				int resultMemberToWithdrawal = memberService.updateMemberToWithdrawal(param);
				String msg = resultMemberToWithdrawal > 0 ? "?????? ????????? ?????????????????????." : "?????? ????????? ??????????????????.";
				redirectAttribute.addFlashAttribute("msg", msg);
				
			} catch (Exception e) {
				log.error("?????? ?????? ??????", e);
				throw e;
			}
			return "redirect:/";
			 
		} else {
			redirectAttribute.addFlashAttribute("msg", "??????????????? ???????????? ????????????.");
			return "redirect:/admin/member/memberWithdrawal.do";
		}
			
	}

	@Autowired
	private PointService pointService;
	
	// ?????? ?????????
	@RequestMapping("/list.do")
	public String memberList(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) {
		
		int limit = 10;
		int offset = (cPage - 1) * limit;
		
		try {
			// ?????? ????????? ?????? ????????? ??????
			List<MemberEntity> memberList = memberService.selectMemberList(offset, limit);
			model.addAttribute("memberList", memberList);
			
			// ?????? ????????? ???
			int totalMemberListCount = memberService.selectMemberListCount();
			model.addAttribute("totalMemberListCount", totalMemberListCount);
			
			// ?????? ????????????
			List<MemberGrade> memberGradeList = memberService.selectMemberGradeList();
			model.addAttribute("memberGradeList", memberGradeList);
			
			// ?????? ?????????
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
	
	// id ?????? ??????
	@ResponseBody
	@GetMapping("/checkIdDuplicate.do")
	public Map<String, Object> checkIdDuplicate(@RequestParam Map<String, Object> param) {
		log.debug("{}", "checkIdDuplicate.do ??????");
		Map<String, Object> map = new HashMap<>();
		Member member = memberService.selectOneMemberByMap(param);
		map.put("available", member == null);
		return map;
	}
	
	// ??????????????? - ??????
	@PostMapping("/memberInsertModalFrm.do")
	public String memberInsertModalFrm(Member member, Address address, AddressBook addressBook, MemberMemo memberMemo, MemberGrade memberGradeNo,
									   @RequestParam String mobile1, @RequestParam String mobile2, @RequestParam String mobile3, @RequestParam String authority, RedirectAttributes redirectAttributes) {
		
		try {
			String phone = mobile1 + mobile2 + mobile3;
			
			// 0. ???????????? ????????? ??????
			String rawPassword = member.getPassword();
			String encryptedPassword = passwordEncoder.encode(rawPassword);
			member.setPassword(encryptedPassword);
			
			// 1. ??????(Member) ??????
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
			
			// 2. ?????? ??????
			// 2.1. ?????? ??????
			int resultRegisterAddress = memberService.insertAddress(address);
			
			// 2.2. ????????? ??????
			AddressBook paramAddressBook = new AddressBook();
			paramAddressBook.setAddressBookNo(addressBook.getAddressBookNo());
			paramAddressBook.setAddressNo(address.getAddressNo());
			paramAddressBook.setMemberNo(paramMember.getMemberNo());
			
			int resultRegisterAddressBook = memberService.insertAddressBook(paramAddressBook);
			
			// 3. ?????? ??????
			// 3.1. ?????? ?????? ??? ????????? ????????????(MemberNo) ??????
			MemberMemo paramMemberMemo = new MemberMemo();
			paramMemberMemo.setMemberMemoNo(memberMemo.getMemberMemoNo());
			paramMemberMemo.setMemberNo(paramMember.getMemberNo());
			paramMemberMemo.setMemberMemoContent(memberMemo.getMemberMemoContent());
			
			int memberNo = paramMember.getMemberNo();
			
			// 3.2. ?????? ??????
			int resultRegisterMemberMemo = memberService.insertMemberMemo(paramMemberMemo);
			
			// 4. ?????? ??????(update)
			// 4.1. ?????? ??????
			Authorities paramAuthorities = new Authorities();
			paramAuthorities.setAuthority(authority);
			paramAuthorities.setMemberNo(paramMember.getMemberNo());
			
			int resultInsertAuthorities = memberService.insertAuthorities(paramAuthorities);
			
			String msg = "";
			
			if(resultRegisterMember > 0 && resultRegisterAddress > 0 
			   && resultRegisterAddressBook > 0 && resultRegisterMemberMemo > 0
			   && resultInsertAuthorities > 0) {
				msg = "?????? ????????? ?????? ???????????????.";				
			} else {
				msg = "?????? ????????? ??????????????????.";
			}
			
			redirectAttributes.addFlashAttribute("msg", msg);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/admin/member/list.do";
	}
	
	// ????????? ??????
	@ResponseBody
	@GetMapping("/typeSearch.do")
	public Map<String, Object> typeSearch(@RequestParam(defaultValue = "1") int cPage, @RequestParam String type, @RequestParam String keyword, HttpServletRequest request){		
		
		int limit = 10;
		int offset = (cPage - 1) * limit;
		
		Map<String, Object> param = new HashMap<>();
		param.put("type", type);
		param.put("keyword", keyword);
		
		// ?????? ????????? 
		String url = request.getContextPath();
		List<MemberEntity> searchMemberList = memberService.selectSearchMemberList(param, offset, limit);
		String searchMemberListStr = Mir9Utils.getSearchMemberListStr(searchMemberList, url);
		
		// ?????? ????????? ???
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
	
	// ?????? ????????????
	@ResponseBody
	@GetMapping("/memberDetail.do/{memberNo}")
	public Map<String, Object> memberDetail(@PathVariable int memberNo, Model model, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<>();
		
		// ????????????
		Member member = memberService.selectOneMemberByMemberNo(memberNo);
		model.addAttribute("member", member);
		
		// ????????? ?????? ??????
		String mobile2 = member.getPhone().substring(3, 7);
		String mobile3 = member.getPhone().substring(7, 11);
		
		// ?????? ?????? ??????
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
		
		// 2. ??????(Address) ??????
		Address address = memberService.selectOneAddress(memberNo);
		model.addAttribute("address", address);
		
		// 3. ??????(MemberMemoContent) ??????
		MemberMemo memberMemo = memberService.selectOneMemo(memberNo);

		if(memberMemo.getMemberMemoContent() == null) 
			 memberMemo.setMemberMemoContent("");
		model.addAttribute("memberMemo", memberMemo);
		
		// 4. ?????? ?????? ??????
		Authorities authorities = memberService.selectOneAuthorities(memberNo);
		model.addAttribute("authorities", authorities);
		
		// 5. ?????? ????????? ?????? ??????
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
	
	
	// ?????? ???????????? ??????(update)
	@SuppressWarnings("unchecked")
	@ResponseBody
	@PostMapping("/memberUpdate.do")
	public String memberUpdate(@RequestBody String data, RedirectAttributes redirectAttributes) {
		ObjectMapper mapper = new ObjectMapper();
		
		try {
			Map<String, String> map = mapper.readValue(data, Map.class);
			
			String phone = map.get("mobile1") + map.get("mobile2") + map.get("mobile3");
			
			// ??????(Member) ??????
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
				// ???????????? ????????? ??????
				String rawPassword = map.get("password"); 
				String encryptedPassword = passwordEncoder.encode(rawPassword);
				paramMember.setPassword(encryptedPassword);
			}

			int resultMemberUpdate = memberService.memberUpdate(paramMember);
			
			// ??????(Address) ??????
			Address paramAddress = new Address();
			paramAddress.setAddressNo(Integer.parseInt(map.get("addressNo")));
			paramAddress.setAddressMain(map.get("addressMain"));
			paramAddress.setAddressSub(map.get("addressSub"));
			paramAddress.setAddressZipcode(Integer.parseInt(map.get("addressZipcode")));
			
			int resultAddressUpdate = memberService.addressUpdate(paramAddress);
			
			// ??????(MemberMemo) ??????
			MemberMemo paramMemberMemo = new MemberMemo();
			paramMemberMemo.setMemberNo(Integer.parseInt(map.get("memberNo")));
			paramMemberMemo.setMemberMemoContent(map.get("memberMemoContent"));
			
			int resultMemberMemo = memberService.memberMemoUpdate(paramMemberMemo);
			
			// ??????(Authorities) ??????
			Authorities paramAuthorities = new Authorities();
			paramAuthorities.setAuthority(map.get("authority"));
			paramAuthorities.setMemberNo(Integer.parseInt(map.get("memberNo")));
			
			int resultAuthorities = memberService.authoritiesUpdate(paramAuthorities);
	
		} catch(IOException e) {}

		return "redirect:/admin/member/list.do";
	}
	
	
	// ???????????? ?????????
	@GetMapping("/withdrawalList.do")
	public String withdarawalMemberList(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) {
		
		int limit = 5;
		int offset = (cPage - 1) * limit;
		
		try {
			// ?????? ?????? ????????? ?????? ????????? ??????
			// ?????? ?????? ??????????????? status = 'N'??? ????????? jsp??? ????????? ??????
			List<MemberEntity> withdrawalMemberList = memberService.selectWithdrawalMemberListMemberList(offset, limit);
			model.addAttribute("withdrawalMemberList", withdrawalMemberList);
			
			// ???????????? ?????? ????????? ???
			int totalwithdrawalCount = memberService.selectWithdrawalCount();
			model.addAttribute("totalwithdrawalCount", totalwithdrawalCount);
			
			// ?????? ????????????
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
	
	// ?????? ?????? ????????? ??????
	@ResponseBody
	@GetMapping("/withdrawalTypeSearch.do")
	public Map<String, Object> withdrawalTypeSearch(@RequestParam(defaultValue = "1") int cPage, @RequestParam String type, @RequestParam String keyword, HttpServletRequest request){
		
		int limit = 5;
		int offset = (cPage - 1) * limit;
		
		Map<String, Object> param = new HashMap<>();
		param.put("type", type);
		param.put("keyword", keyword);
		
		// ???????????? ?????? ?????????
		String url = request.getContextPath();
		List<MemberEntity> searchWithdrawalList = memberService.selectSearchWithdrawalList(param, offset, limit);
		String searchWithdrawalListStr = Mir9Utils.getSearchWithdrawalListStr(searchWithdrawalList, url);
		
		// ?????? ?????? ?????? ????????? ???
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
	
	// ??????&???????????? ?????? ??????
	@PostMapping("/memberDelete.do")
	public String memberDelete(@RequestParam int[] memberNo, RedirectAttributes redirectAttribute, HttpServletRequest request) throws Exception {
		Map<String, Object> param = new HashMap<>();
		
		try {		
			// ?????? ?????? ??????
			List<Address> addressList = memberService.findAddressNo(memberNo);
			for(int i = 0; i < addressList.size(); i++) {
				int addressNo = addressList.get(i).getAddressNo();				
				// ?????? ??????
				int resultDeleteAddress = memberService.deleteAddress(addressNo);
			}
			
			// ????????? ??????
			int resultDeleteAddressBook = memberService.deleteAddressBook(memberNo);
					
			// ?????? ??????
			int resultDeleteAuthorities = memberService.deleteAuthorities(memberNo);
			
			// ?????? ??????
			int resultDeleteMemberMemo = memberService.deleteMemberMemo(memberNo);
			
			// ?????? ??????
			int resultDeleteMember = memberService.deleteMember(memberNo);
						
			redirectAttribute.addFlashAttribute("msg", "?????? ????????? ?????????????????????.");
		} catch (Exception e) {
			log.error("?????? ?????? ??????", e);
			throw e; // spring container?????? ???????????? ??????
		}
		
		String referer = request.getHeader("Referer");

		return "redirect:" + referer;
	}
	
	// ???????????? ????????????
	@ResponseBody
	@GetMapping("/withdrawalMemberDetail.do/{memberNo}")
	public Map<String, Object> withdrawalMemberDetail(@PathVariable int memberNo, Model model, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<>();
		
		WithdrawalMemberEntity withdrawalMemberEntity = memberService.selectOneWithdrawalMemberEntity(memberNo);
		model.addAttribute("withdrawalMemberEntity", withdrawalMemberEntity);
		
		// ????????? ?????? ??????
		String mobile1 = withdrawalMemberEntity.getPhone().substring(0, 3);
		String mobile2 = withdrawalMemberEntity.getPhone().substring(3, 7);
		String mobile3 = withdrawalMemberEntity.getPhone().substring(7, 11);
		
		// ?????? ?????? ??????
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
		
		// ??????(Address) ??????
		Address address = memberService.selectOneAddress(memberNo);
		model.addAttribute("address", address);
		
		// ??????(MemberMemoContent) ??????
		MemberMemo memberMemo = memberService.selectOneMemo(memberNo);

		if(memberMemo.getMemberMemoContent() == null) 
			 memberMemo.setMemberMemoContent("");
	
		model.addAttribute("memberMemo = {}", memberMemo);
		
		// ?????? ?????? ??????
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
	
	// ???????????? ???????????? ??????(update)
	@SuppressWarnings("unchecked")
	@ResponseBody
 	@PostMapping("/withdrawalMemberUpdate.do")
	public String withdrawalMemberUpdate(@RequestBody String data, RedirectAttributes redirectAttribute) {
		ObjectMapper mapper = new ObjectMapper();
		
		try {
			Map<String, String> map = mapper.readValue(data, Map.class);
			
			String phone = map.get("mobile1") + map.get("mobile2") + map.get("mobile3");
			
			// ????????????(Member) ??????
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
				// ???????????? ????????? ??????
				String rawPassword = map.get("password");
				String encryptedPassword = passwordEncoder.encode(rawPassword);
				paramWithdrawal.setPassword(encryptedPassword);
			}
			
			int resultWithdrawalMember = memberService.memberUpdate(paramWithdrawal);
			
			// ??????(Address) ??????
			Address paramAddress = new Address();
			paramAddress.setAddressNo(Integer.parseInt(map.get("addressNo")));
			paramAddress.setAddressMain(map.get("addressMain"));
			paramAddress.setAddressSub(map.get("addressSub"));
			paramAddress.setAddressZipcode(Integer.parseInt(map.get("addressZipcode")));
			
			int resultAddressUpdate = memberService.addressUpdate(paramAddress);
			
			// ??????(MemberMemo) ??????
			MemberMemo paramMemberMemo = new MemberMemo();
			paramMemberMemo.setMemberNo(Integer.parseInt(map.get("memberNo")));
			paramMemberMemo.setMemberMemoContent(map.get("memberMemoContent"));
			
			int resultMemberMemo = memberService.memberMemoUpdate(paramMemberMemo);
			
			// ??????(Authorities) ??????
			Authorities paramAuthorities = new Authorities();
			paramAuthorities.setAuthority(map.get("authority"));
			paramAuthorities.setMemberNo(Integer.parseInt(map.get("memberNo")));
			
			int resultAuthorities = memberService.authoritiesUpdate(paramAuthorities);

		} catch (IOException e) {}

		return "redirect:/admin/member/withdrawalList.do";
	}
	
	
	// ?????? ?????? ?????? ??????
	@GetMapping("/log")
	public String memberAccessHistory(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) {		
		int limit = 20;
		int offset = (cPage - 1) * limit;
		
		try {
			// ?????? ?????? ?????????
			List<MemberAccessHistory> memberAccessHistoryList = memberService.seletHistoryList(offset, limit);
			model.addAttribute("memberAccessHistoryList", memberAccessHistoryList);
			
			// ?????? ?????? ????????? ???
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
	
	// ?????? ???????????? ?????? ????????? ??????
	@ResponseBody
	@GetMapping("/typeSearchByAcceessHistory.do")
	public Map<String, Object> typeSearchByAcceessHistory(@RequestParam(defaultValue = "1") int cPage, @RequestParam String type, @RequestParam String keyword, HttpServletRequest request){		
		
		int limit = 20;
		int offset = (cPage - 1) * limit;
		
		Map<String, Object> param = new HashMap<>();
		param.put("type", type);
		param.put("keyword", keyword);
		
		// ?????? ?????? ?????? ?????????
		String url = request.getContextPath();
		List<MemberAccessHistory> searchAccessHistoryList = memberService.seletSearchAccessHistory(param, offset, limit);
		String searchAccessHistoryListStr = Mir9Utils.getSearchAccessHistoryListStr(searchAccessHistoryList, url);
		
		// ?????? ?????? ?????? ????????? ???
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
	
	// ?????? ???????????? ?????? ?????? ??????
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
	
	// ?????? ?????? ??????
	@GetMapping("/memberGrade.do")
	public Map<String, Object> memberGrade(Model model, HttpServletRequest request) {
		// ?????? ????????????
		List<MemberGrade> memberGradeList = memberService.selectMemberGradeList();
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("memberGradeList", memberGradeList);
		return resultMap;
	}
	
	// ?????? ??????
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
	
	// ?????? ?????? ????????? ????????????
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
		
		// ?????? ?????? ????????? ?????? ??????
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

	// ?????? ?????? ????????? ??????
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
		
		// ?????? ?????? ????????? ?????? ??????
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
	
	// ????????? ?????? ??????
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
	 * 	????????? ????????? ????????? ?????? ????????? ??? Validator ??????, ??????????????? editor ?????? ??????
	 * 
	 */
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm");
		// ????????????, ??????????????????("" -> null)
		PropertyEditor editor = new CustomDateEditor(sdf, true);
		binder.registerCustomEditor(Date.class, editor);
	}
	
	@GetMapping("/test")
	public Map<String, Object> test(int number, String str) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put(str, number);
		
		return result;
	}

}
