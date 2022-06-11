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
import org.springframework.web.bind.annotation.ModelAttribute;
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
		param.put("reason", reason);
		param.put("member", member);
		param.put("memberNo", member.getMemberNo());
		param.put("password", password);
		Map<String, Object> resultMap = memberService.updateMemberToWithdrawal(param);
		redirectAttribute.addFlashAttribute("msg", resultMap.get("msg"));
		return (String)resultMap.get("return");
			
	}

	@Autowired
	private PointService pointService;
	
	// 회원 리스트
	@RequestMapping("/list.do")
	public String memberList(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) {
		int limit = 10;
		// 회원 리스트 전체 게시물 목록
		Map<String, Object> resultMap = memberService.selectMemberList(cPage, limit, request.getRequestURI());
		model.addAttribute("memberList", resultMap.get("memberList"));
		// 전체 게시물 수
		model.addAttribute("totalMemberListCount",resultMap.get("totalMemberListCount"));
		// 명칭 가져오기
		model.addAttribute("memberGradeList", resultMap.get("memberGradeList"));
		// 쿠폰 리스트
		model.addAttribute("couponList",resultMap.get("couponList"));
		// pagebar
		model.addAttribute("pagebar", resultMap.get("pagebar"));
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
	
	// 회원관리 프로세서
	@PostMapping("/memberProcess")
	public String memberProcess(@ModelAttribute Member member, 
									   @ModelAttribute Address address, 
									   @ModelAttribute AddressBook addressBook, 
									   @ModelAttribute MemberMemo memberMemo, 
									   @ModelAttribute Authorities authorities,
									   @ModelAttribute WithdrawalMemberEntity withdrawalMemberEntity,
									   @RequestParam(value="mode",required=false,defaultValue="") String mode,
									   @RequestParam(value="mobile1",required=false,defaultValue="") String mobile1, @RequestParam(value="mobile2",required=false,defaultValue="") String mobile2,
									   @RequestParam(value="mobile3",required=false,defaultValue="") String mobile3, 
									   @RequestParam(value="memberNo",required=false,defaultValue="") int[] memberNo, RedirectAttributes redirectAttributes) throws Exception {
		String phone = mobile1 + mobile2 + mobile3;
		member.setPhone(phone);
		withdrawalMemberEntity.setPhone(phone);
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("member", member);
		map.put("address", address);
		map.put("addressBook", addressBook);
		map.put("memberMemo", memberMemo);
		map.put("authorities", authorities);
		map.put("withdrawalMemberEntity", withdrawalMemberEntity);
		map.put("memberNo", memberNo);
		map.put("mode", mode);
		Map<String, Object> resultMap = memberService.memberProcess(map);
		redirectAttributes.addFlashAttribute("msg", (String)resultMap.get("msg"));
		return (String)resultMap.get("return");
	}
	
	// 타입별 검색
	@ResponseBody
	@GetMapping("/typeSearch.do")
	public Map<String, Object> typeSearch(@RequestParam(defaultValue = "1") int cPage, @RequestParam String type, @RequestParam String keyword, HttpServletRequest request){
		int limit = 10;
		Map<String, Object> map = new HashMap<>();
		map.put("type", type);
		map.put("keyword", keyword);
		map.put("contextPath", request.getContextPath());
		Map<String, Object> resultMap = memberService.selectSearchMemberList(map, cPage, limit, request.getRequestURI());	
		return resultMap;
	}
	
	// 회원 상세보기
	@ResponseBody
	@GetMapping("/memberDetail.do/{memberNo}")
	public Map<String, Object> memberDetail(@PathVariable int memberNo, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("memberNo", memberNo);
		Map<String, Object> resultMap = memberService.memberDetail(map);
		resultMap.get("");
		model.addAttribute("member", resultMap.get("member"));
		model.addAttribute("address", resultMap.get("address"));
		model.addAttribute("memberMemo", resultMap.get("memberMemo"));
		model.addAttribute("authorities", resultMap.get("authorities"));
		return resultMap;
	}
	
	
	// 탈퇴회원 리스트
	@GetMapping("/withdrawalList.do")
	public String withdarawalMemberList(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) throws Exception {
		int limit = 5;
		int offset = (cPage - 1) * limit;
		Map<String, Object> resultMap = memberService.selectWithdrawalMemberListMemberList(offset, limit);
		// 탈퇴 회원 리스트 전체 게시물 목록
		// 일반 회원 리스트에서 status = 'N'인 상태만 jsp에 뿌리는 과정
		model.addAttribute("withdrawalMemberList", resultMap.get("withdrawalMemberList"));
		// 탈퇴회원 전체 게시물 수
		model.addAttribute("totalwithdrawalCount", resultMap.get("totalwithdrawalCount"));
		// 명칭 가져오기
		model.addAttribute("memberGradeList", resultMap.get("memberGradeList"));
		// pagebar
		String url = request.getRequestURI();
		String pagebar = Mir9Utils.getPagebar(cPage, limit, (int)resultMap.get("totalwithdrawalCount"), url);
		model.addAttribute("pagebar", pagebar);
		return "admin/member/withdrawalMemberList";
	}
	
	// 탈퇴 회원 타입별 검색
	@ResponseBody
	@GetMapping("/withdrawalTypeSearch.do")
	public Map<String, Object> withdrawalTypeSearch(@RequestParam(defaultValue = "1") int cPage, @RequestParam String type, @RequestParam String keyword, HttpServletRequest request){
		int limit = 5;
		Map<String, Object> param = new HashMap<>();
		param.put("type", type);
		param.put("keyword", keyword);
		param.put("contextPath", request.getContextPath());
		Map<String, Object> resultMap = memberService.selectSearchWithdrawalList(param, cPage, limit, request.getRequestURI());
		return resultMap;
	}
	
	// 탈퇴회원 상세보기
	@ResponseBody
	@GetMapping("/withdrawalMemberDetail.do/{memberNo}")
	public Map<String, Object> withdrawalMemberDetail(@PathVariable int memberNo, Model model, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> resultMap = memberService.selectOneWithdrawalMemberEntity(memberNo);
		model.addAttribute("withdrawalMemberEntity", resultMap.get("withdrawalMemberEntity"));
		// 주소(Address) 조회
		model.addAttribute("address", resultMap.get("address"));
		// 메모(MemberMemoContent) 조회
		model.addAttribute("memberMemo", resultMap.get("memberMemo"));
		// 회원 권한 조회
		model.addAttribute("authorities", resultMap.get("authorities"));
		return resultMap;
	}
	

	// 회원 접속 이력 관리
	@GetMapping("/log")
	public String memberAccessHistory(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) throws Exception {		
		int limit = 20;
		// 접속 이력 리스트
		Map<String,Object> resultMap = memberService.seletHistoryList(cPage, limit, (String)request.getRequestURI());
		model.addAttribute("memberAccessHistoryList",resultMap.get("memberAccessHistoryList"));	
		// 접속 이력 게시글 수
		model.addAttribute("totalAccessHistoryCount",resultMap.get("totalAccessHistoryCount"));	
		// pagebar
		model.addAttribute("pagebar",resultMap.get("pagebar"));
		return "admin/member/memberAccessHistory";
	}
	
	// 회원 접속이력 관리 타입별 검색
	@ResponseBody
	@GetMapping("/typeSearchByAcceessHistory.do")
	public Map<String, Object> typeSearchByAcceessHistory(@RequestParam(defaultValue = "1") int cPage, @RequestParam String type, @RequestParam String keyword, HttpServletRequest request){		
		int limit = 20;		
		Map<String, Object> param = new HashMap<>();
		param.put("type", type);
		param.put("keyword", keyword);
		param.put("contextPath", request.getContextPath());
		// 접속 이력 검색 게시물
		Map<String, Object> resultMap = memberService.seletSearchAccessHistory(param, cPage, limit, request.getRequestURI());
		return resultMap;
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
	public String memberGradeUpdate(@RequestBody String data, RedirectAttributes redirectAttributes) throws Exception {
		memberService.memberGradeUpdate(data);
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
		Map<String, Object> param = new HashMap<>();
		param.put("memberNo", memberNo);
		param.put("field", field);
		param.put("keyword", keyword);
		param.put("startRow", (cPage - 1) * 15 + 1);
		param.put("endRow", (cPage - 1) * 15 + 1 + 15 -1);
		param.put("cPage", cPage);
		param.put("limit", 15);
		param.put("pointAllUri", request.getRequestURI());
		param.put("pointAllUri2", request.getRequestURI() + "?field=" + field + "&keyword=" + keyword);		
		// 전체 회원 포인트 목록 조회
		Map<String, Object> resultMap = memberService.selectMemberPointListByParam(param);
		model.addAttribute("mPointList",resultMap.get("mPointList"));
		model.addAttribute("total", resultMap.get("totalPointCount"));
		model.addAttribute("param",param);
		model.addAttribute("pagebar", resultMap.get("pagebar"));
		
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

		Map<String, Object> param = new HashMap<>();
		param.put("memberNo", mNo);
		param.put("field", field);
		param.put("keyword", keyword);
		param.put("startRow", (cPage - 1) * 15 + 1);
		param.put("endRow", (cPage - 1) * 15 + 1 + 15 -1);
		param.put("cPage", cPage);
		param.put("limit", 15);
		param.put("pointAllUri", request.getRequestURI());
		param.put("pointAllUri2", request.getRequestURI() + "?field=" + field + "&keyword=" + keyword);
		// 전체 회원 포인트 목록 조회
		Map<String, Object> resultMap = memberService.selectMemberPointListByParam(param);
		model.addAttribute("mPointList",resultMap.get("mPointList"));
		model.addAttribute("total", resultMap.get("totalPointCount"));
		model.addAttribute("param",param);
		model.addAttribute("pagebar", resultMap.get("pagebar"));
		
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
	
	@GetMapping("/test")
	public Map<String, Object> test(int number, String str) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put(str, number);
		
		return result;
	}

}
