package com.naedam.admin.member.model.service;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.naedam.admin.common.Mir9Utils;
import com.naedam.admin.coupon.model.dao.CouponDao;
import com.naedam.admin.member.model.dao.MemberDao;
import com.naedam.admin.member.model.vo.Address;
import com.naedam.admin.member.model.vo.AddressBook;
import com.naedam.admin.member.model.vo.Authorities;
import com.naedam.admin.member.model.vo.Member;
import com.naedam.admin.member.model.vo.MemberAccessHistory;
import com.naedam.admin.member.model.vo.MemberAccessHistoryListExcelForm;
import com.naedam.admin.member.model.vo.MemberEntity;
import com.naedam.admin.member.model.vo.MemberGrade;
import com.naedam.admin.member.model.vo.MemberListExcelForm;
import com.naedam.admin.member.model.vo.MemberMemo;
import com.naedam.admin.member.model.vo.WithdrawalMember;
import com.naedam.admin.member.model.vo.WithdrawalMemberEntity;
import com.naedam.admin.point.model.dao.PointDao;
import com.naedam.admin.point.model.vo.MemberPoint;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	@Autowired
	private PointDao pointDao;
	@Autowired
	private CouponDao couponDao;
	
	// 회원관리 프로세스
	public Map<String, Object> memberProcess(Map<String, Object> map) throws Exception{
		Map<String, Object> resultMap = new HashMap<String,Object>();
		Member member = (Member) map.get("member");
		if("insert".equals(map.get("mode"))) {
			// 1. 회원(Member) 등록
			String rawPassword = member.getPassword();
			String encryptedPassword = passwordEncoder.encode(rawPassword);
			member.setPassword(encryptedPassword);
			int resultRegisterMember = memberDao.insertRegisterMember(member);
			resultMap.put("resultRegisterMember", resultRegisterMember);
			
			// 2. 주소 입력
			// 2.1. 주소 입력
			Address address = (Address) map.get("address");
			int resultRegisterAddress = memberDao.insertAddress(address);
			resultMap.put("resultRegisterMember", resultRegisterAddress);
			// 2.2. 주소록 입력
			AddressBook addressBook = (AddressBook) map.get("addressBook");
			addressBook.setAddressNo(address.getAddressNo());
			addressBook.setMemberNo(member.getMemberNo());
			int resultRegisterAddressBook = memberDao.insertAddressBook(addressBook);
			resultMap.put("resultRegisterAddressBook", resultRegisterAddressBook);
			
			// 3. 메모 입력
			// 3.1. 회원 입력 시 생성된 회원번호(MemberNo) 설정
			MemberMemo memberMemo = (MemberMemo) map.get("memberMemo");
			memberMemo.setMemberNo(member.getMemberNo());
			// 3.2. 메모 입력
			int resultRegisterMemberMemo = memberDao.insertMemberMemo(memberMemo);
			resultMap.put("resultRegisterMemberMemo", resultRegisterMemberMemo);
			
			// 4. 등급 입력(update)
			// 4.1. 권한 입력 
			Authorities authorities = (Authorities) map.get("authorities");
			authorities.setMemberNo(member.getMemberNo());
			int resultInsertAuthorities = memberDao.insertAuthorities(authorities);
			resultMap.put("resultInsertAuthorities", resultInsertAuthorities);
			
			String msg = "";
			if(resultRegisterMember > 0 && resultRegisterAddress > 0 
			   && resultRegisterAddressBook > 0 && resultRegisterMemberMemo > 0
			   && resultInsertAuthorities > 0) {
				msg = "해당 회원이 등록 되었습니다.";				
			} else {
				msg = "회원 등록이 실패했습니다.";
			}
			resultMap.put("msg", msg);
			resultMap.put("return", "redirect:/admin/member/list.do");
			return resultMap;
		}else if("update".equals(map.get("mode"))) {
			String rawPassword = member.getPassword();
			String encryptedPassword = passwordEncoder.encode(rawPassword);
			member.setPassword(encryptedPassword);
			// 1. 회원(Member) 수정
			int resultRegisterMember = memberDao.memberUpdate(member);
			resultMap.put("resultRegisterMember", resultRegisterMember);
			
			// 2. 주소 입력
			// 2.1. 주소 입력
			Address address = (Address) map.get("address");
			int resultRegisterAddress = memberDao.addressUpdate(address);
			resultMap.put("resultRegisterMember", resultRegisterAddress);
			
			// 3. 메모 입력
			// 3.1. 회원 입력 시 생성된 회원번호(MemberNo) 설정
			MemberMemo memberMemo = (MemberMemo) map.get("memberMemo");
			memberMemo.setMemberNo(member.getMemberNo());
			// 3.2. 메모 입력
			int resultRegisterMemberMemo = memberDao.memberMemoUpdate(memberMemo);
			resultMap.put("resultRegisterMemberMemo", resultRegisterMemberMemo);
			
			// 4. 등급 입력(update)
			// 4.1. 권한 입력 
			Authorities authorities = (Authorities) map.get("authorities");
			authorities.setMemberNo(member.getMemberNo());
			int resultInsertAuthorities = memberDao.authoritiesUpdate(authorities);
			resultMap.put("resultInsertAuthorities", resultInsertAuthorities);
			
			String msg = "";
			if(resultRegisterMember > 0 && resultRegisterAddress > 0 
			   && resultRegisterMemberMemo > 0 && resultInsertAuthorities > 0) {
				msg = "해당 회원이 수정 되었습니다.";				
			} else {
				msg = "회원 수정이 실패했습니다.";
			}
			resultMap.put("msg", msg);
			resultMap.put("return", "redirect:/admin/member/list.do");
			return resultMap;
		}else if("delete".equals(map.get("mode")) || "withdrawalDelete".equals(map.get("mode"))) {
			int[] memberNo = (int[]) map.get("memberNo");
			// 주소 번호 조회
			List<Address> addressList = memberDao.findAddressNo(memberNo);
			for(int i = 0; i < addressList.size(); i++) {
				int addressNo = addressList.get(i).getAddressNo();				
				// 주소 삭제
				memberDao.deleteAddress(addressNo);
			}
			// 주소록 삭제
			memberDao.deleteAddressBook(memberNo);		
			// 권한 삭제
			memberDao.deleteAuthorities(memberNo);
			// 메모 삭제
			memberDao.deleteMemberMemo(memberNo);
			// 회원 삭제
			memberDao.deleteMember(memberNo);
			
			resultMap.put("msg", "해당 회원이 삭제되었습니다.");
			if("delete".equals(map.get("mode"))) {
				resultMap.put("return", "redirect:/admin/member/list.do");	
			}else if("withdrawalDelete".equals(map.get("mode"))) {
				resultMap.put("return", "redirect:/admin/member/withdrawalList.do");
			}
			return resultMap;
		}else if("withdrawalUpdate".equals(map.get("mode"))) {
			WithdrawalMemberEntity withdrawalMemberEntity = (WithdrawalMemberEntity) map.get("withdrawalMemberEntity");
			String rawPassword = member.getPassword();
			String encryptedPassword = passwordEncoder.encode(rawPassword);
			member.setPassword(encryptedPassword);
			// 1. 회원(Member) 수정
			int resultRegisterMember = memberDao.memberUpdate(withdrawalMemberEntity);
			resultMap.put("resultRegisterMember", resultRegisterMember);
			
			// 2. 주소 입력 
			// 2.1. 주소 입력
			Address address = (Address) map.get("address");
			int resultRegisterAddress = memberDao.addressUpdate(address);
			resultMap.put("resultRegisterMember", resultRegisterAddress);
			
			// 3. 메모 입력
			// 3.1. 회원 입력 시 생성된 회원번호(MemberNo) 설정
			MemberMemo memberMemo = (MemberMemo) map.get("memberMemo");
			memberMemo.setMemberNo(member.getMemberNo());
			// 3.2. 메모 입력
			int resultRegisterMemberMemo = memberDao.memberMemoUpdate(memberMemo);
			resultMap.put("resultRegisterMemberMemo", resultRegisterMemberMemo);
			
			// 4. 등급 입력(update)
			// 4.1. 권한 입력 
			Authorities authorities = (Authorities) map.get("authorities");
			authorities.setMemberNo(member.getMemberNo());
			int resultInsertAuthorities = memberDao.authoritiesUpdate(authorities);
			resultMap.put("resultInsertAuthorities", resultInsertAuthorities);
			
			String msg = "";
			if(resultRegisterMember > 0 && resultRegisterAddress > 0 
			   && resultRegisterMemberMemo > 0 && resultInsertAuthorities > 0) {
				msg = "해당 회원이 수정 되었습니다.";				
			} else {
				msg = "회원 수정이 실패했습니다.";
			}
			resultMap.put("msg", msg);
			resultMap.put("return", "redirect:/admin/member/withdrawalList.do");
			return resultMap;
		}else if("historyDelete".equals(map.get("mode"))) {
			int[] accessHistoryNo = (int[]) map.get("memberNo");
			memberDao.deleteAccessHistory(accessHistoryNo);
			resultMap.put("return", "redirect:/admin/member/log");
			return resultMap;
		}
		
		return resultMap;
	}
	
	public Map<String, Object> memberDetail(Map<String, Object> map) throws Exception{
		Map<String, Object> resultMap = new HashMap<String,Object>();
		int memberNo = (int) map.get("memberNo");
		// 회원조회
		Member member = memberDao.selectOneMemberByMemberNo(memberNo);
		resultMap.put("member", member);

		// 휴대폰 번호 분기
		resultMap.put("mobile2", member.getPhone().substring(3, 7));
		resultMap.put("mobile3", member.getPhone().substring(7, 11));
		
		// 시간 양식 변경
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		resultMap.put("regDate", dateFormat.format(member.getRegDate()));
		String loginDate = "";
		if(member.getLoginDate() == null){
			loginDate = "";
		} else {
			loginDate = dateFormat.format(member.getLoginDate());
		}
		resultMap.put("loginDate", loginDate);
		String updateDate = "";
		if(member.getUpdateDate() == null) {
			updateDate = "";
		} else {
			updateDate = dateFormat.format(member.getUpdateDate());
		}
		resultMap.put("updateDate", updateDate);
		// 2. 주소(Address) 조회
		resultMap.put("address", memberDao.selectOneAddress(memberNo));
		
		// 3. 메모(MemberMemoContent) 조회
		MemberMemo memberMemo = memberDao.selectOneMemo(memberNo);
		if(memberMemo.getMemberMemoContent() == null) 
			 memberMemo.setMemberMemoContent("");
		resultMap.put("memberMemo", memberMemo);
		
		// 4. 회원 권한 조회
		resultMap.put("authorities",memberDao.selectOneAuthorities(memberNo)); 
		
		// 5. 회원 포인트 총계 조회
		int totalPoint = 0;
		try {
			totalPoint = memberDao.selectMemberTotalPoint(memberNo);
		} catch (Exception e) {}
		resultMap.put("totalPoint", totalPoint);
		resultMap.put("pointName",pointDao.selectPointName());
		
		return resultMap;
	}
	
	// 로그인 - 해당 id정보 가져오기
	@Override
	public Member selectOneMember(String id) {
		return memberDao.selectOneMember(id);
	}

	// 회원 리스트 전체 게시물 목록
	@Override
	public Map<String, Object> selectMemberList(int cPage, int limit, String url) {
		Map<String, Object> resultMap = new HashMap<>();
		int offset = (cPage - 1) * limit;
		// 회원 리스트 전체 게시물 목록
		resultMap.put("memberList", memberDao.selectMemberList(cPage, limit));
		// 전체 게시물 수
		resultMap.put("totalMemberListCount", memberDao.selectMemberListCount());
		// 명칭 가져오기
		resultMap.put("memberGradeList", memberDao.selectMemberGradeList());
		// 쿠폰 리스트
		resultMap.put("couponList", couponDao.selectCouponList());
		// pagebar
		resultMap.put("pagebar", Mir9Utils.getPagebar(cPage, limit, memberDao.selectMemberListCount(), url));
		return resultMap;
		//return memberDao.selectMemberList(offset, limit);
	}

	// 회원 리스트 전체 게시물 수
	@Override
	public int selectMemberListCount() {
		return memberDao.selectMemberListCount();
	}

	// id 중복 검사
	@Override
	public Member selectOneMemberByMap(Map<String, Object> param) {
		return memberDao.selectOneMemberByMap(param);
	}

	// 타입별 검색 게시물
	@Override
	public Map<String, Object> selectSearchMemberList(Map<String, Object> map, int cPage, int limit, String url) {
		Map<String, Object> resultMap = new HashMap<>();
		int offset = (cPage - 1) * limit;
		// 검색 게시물
		resultMap.put("searchMemberListStr", Mir9Utils.getSearchMemberListStr(memberDao.selectSearchMemberList(map, offset, limit), (String)map.get("contextPath")));
		// 검색 게시물 수
		resultMap.put("searchListCount", memberDao.selectSearchListCount(map));
		// pagebar
		resultMap.put("request.getContextPath()", Mir9Utils.getPagebarMember(cPage, limit, memberDao.selectSearchListCount(map), url));

		return resultMap;
	}

	// 검색 게시물 수
	@Override
	public int selectSearchListCount(Map<String, Object> param) {
		return memberDao.selectSearchListCount(param);
	}

	// 회원 삭제
	@Override
	public int deleteMember(int[] memberNo) {
		return memberDao.deleteMember(memberNo);
	}

	// 회원 등급 리스트
	@Override
	public List<MemberGrade> selectMemberGradeList() {
		return memberDao.selectMemberGradeList();
	}

	// 회원 등급 수정
	public void memberGradeUpdate(String data) {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, String> map;
		try {
			map = mapper.readValue(data, Map.class);
			MemberGrade paramGrade = new MemberGrade();
			Set<String> keySet = map.keySet();
			for(String key : keySet) {
				System.out.println(key + " : " + map.get(key));
				paramGrade.setMemberGradeNo(Integer.parseInt(key));
				paramGrade.setMemberGradeName(map.get(key));
				int resultMemberGradeUpdate = memberDao.memberGradeUpdate(paramGrade);
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	// 주소 입력
	@Override
	public int insertAddress(Address address) {
		return memberDao.insertAddress(address);
	}

	// 메모 입력
	@Override
	public int insertMemberMemo(MemberMemo memberMemo) {
		return memberDao.insertMemberMemo(memberMemo);
	}

	// 회원 등록
	@Override
	public int insertRegisterMember(Member paramMember) {
		return memberDao.insertRegisterMember(paramMember);
	}

	// 주소록 입력
	@Override
	public int insertAddressBook(AddressBook paramAddressBook) {
		return memberDao.insertAddressBook(paramAddressBook);
	}

	// 권한 입력
	@Override
	public int insertAuthorities(Authorities paramAuthorities) {
		return memberDao.insertAuthorities(paramAuthorities);
	}

	// 회원정보 조회(회원번호)
	@Override
	public Member selectOneMemberByMemberNo(int memberNo) {
		return memberDao.selectOneMemberByMemberNo(memberNo);
	}

	// 회원주소 조회
	@Override
	public Address selectOneAddress(int memberNo) {
		return memberDao.selectOneAddress(memberNo);
	}

	// 회원메모 조회
	@Override
	public MemberMemo selectOneMemo(int memberNo) {
		return memberDao.selectOneMemo(memberNo);
	}

	// 회원등급 조회
	@Override
	public Authorities selectOneAuthorities(int memberNo) {
		return memberDao.selectOneAuthorities(memberNo);
	}
	
	// 회원 적립금 목록
	@Override
	public Map<String, Object> selectMemberPointListByParam(Map<String, Object> param) {
		Map<String, Object> resultMap = new HashMap<>();
		String pointAllUri = "";
		if((param.get("field") == null || param.get("field") == "") && (param.get("keyword") == null || param.get("keyword") == "")) {
			pointAllUri = (String)param.get("pointAllUri");
		}else {
			pointAllUri = (String)param.get("pointAllUri2");
		}
		resultMap.put("mPointList", memberDao.selectMemberPointListByParam(param));
		resultMap.put("totalPointCount", memberDao.totalPointCount(param));
		resultMap.put("param", param);
		resultMap.put("pagebar", Mir9Utils.getPagebar((int)param.get("cPage"),(int)param.get("limit") , memberDao.totalPointCount(param), pointAllUri));
		return resultMap;
	}
	
	// 회원 적립금 목록 수 
	@Override
	public int totalPointCount(Map<String, Object> param) {
		return memberDao.totalPointCount(param);
	}

	// 회원정보 수정(상세보기)
	@Override
	public int memberUpdate(Member paramMember) {
		return memberDao.memberUpdate(paramMember);
	}

	// 회원주소 수정(상세보기)
	@Override
	public int addressUpdate(Address paramAddress) {
		return memberDao.addressUpdate(paramAddress);
	}

	// 권한(Authorities) 수정
	@Override
	public int authoritiesUpdate(Authorities paramAuthorities) {
		return memberDao.authoritiesUpdate(paramAuthorities);
	}

	// 메모(MemberMemo) 수정
	@Override
	public int memberMemoUpdate(MemberMemo paramMemberMemo) {
		return memberDao.memberMemoUpdate(paramMemberMemo);
	}

	// 엑셀 다운로드
	@Override
	public List<MemberListExcelForm> selectMemberListExcelForm() {
		return memberDao.selectMemberListExcelForm();
	}

	// 주소 삭제
	@Override
	public int deleteAddress(int addressNo) {
		return memberDao.deleteAddress(addressNo);
	}

	// 주소록 조회
	@Override
	public AddressBook selectOneAddressBook(int memberNo) {
		return memberDao.selectOneAddressBook(memberNo);
	}

	// 탈퇴 사유
	@Override
	public int updateReason(Map<String, Object> param) {
		return memberDao.updateReason(param);
	}

	// 탈퇴 회원 전체 게시물 수
	@Override
	public int selectWithdrawalCount() {
		return memberDao.selectWithdrawalCount();
	}
	
	// 포인트 총계
	@Override
	public int selectMemberTotalPoint(int memberNo) {
		return memberDao.selectMemberTotalPoint(memberNo);
	}

	// 주소 번호 조회
	@Override
	public List<Address> findAddressNo(int[] memberNo) {
		return memberDao.findAddressNo(memberNo);
	}

	@Override
	public int selectTodayRegMemberCnt() {
		return memberDao.selectTodayRegMemberCnt();
	}

	// 탈퇴회원 조회
	@Override
	public WithdrawalMember selectOneMemberByWithdrawalMemberNo(int memberNo) {
		return memberDao.selectOneMemberByWithdrawalMemberNo(memberNo);
	}

	// 권한 삭제
	@Override
	public int deleteAuthorities(int[] memberNo) {
		return memberDao.deleteAuthorities(memberNo);
	}

	//
	@Override
	public List<Address> findMemberAddressList(int[] memberNo) {
		return memberDao.findMemberAddressList(memberNo);
	}

	// 메모 삭제
	@Override
	public int deleteMemberMemo(int[] memberNo) {
		return memberDao.deleteMemberMemo(memberNo);
	}

	// 탈퇴회원 상세조회
	@Override
	public Map<String, Object> selectOneWithdrawalMemberEntity(int memberNo) {
		Map<String,Object> resultMap = new HashMap<>();
		WithdrawalMemberEntity withdrawalMemberEntity = memberDao.selectOneWithdrawalMemberEntity(memberNo);
		resultMap.put("withdrawalMemberEntity", withdrawalMemberEntity);
		
		// 휴대폰 번호 분기
		resultMap.put("mobile1", withdrawalMemberEntity.getPhone().substring(0, 3));
		resultMap.put("mobile2", withdrawalMemberEntity.getPhone().substring(3, 7));
		resultMap.put("mobile3", withdrawalMemberEntity.getPhone().substring(7, 11));
		
		// 시간 양식 변경
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		resultMap.put("regDate", dateFormat.format(withdrawalMemberEntity.getRegDate()));
		
		String loginDate = "";
		
		if(withdrawalMemberEntity.getLoginDate() == null){
			resultMap.put("loginDate", "");
		} else {
			resultMap.put("loginDate", dateFormat.format(withdrawalMemberEntity.getLoginDate()));
		}
		
		String updateDate = "";
		if(withdrawalMemberEntity.getUpdateDate() == null) {
			resultMap.put("updateDate", "");
		} else {
			resultMap.put("updateDate", dateFormat.format(withdrawalMemberEntity.getUpdateDate()));
		}
		
		String withdrawalDate = "";
		if(withdrawalMemberEntity.getWithdrawalDate() == null) {
			resultMap.put("withdrawalDate", "");
		} else {
			resultMap.put("withdrawalDate", dateFormat.format(withdrawalMemberEntity.getWithdrawalDate()));
		}
		
		// 주소(Address) 조회
		resultMap.put("address", memberDao.selectOneAddress(memberNo));
		
		// 메모(MemberMemoContent) 조회
		MemberMemo memberMemo = memberDao.selectOneMemo(memberNo);
		if(memberMemo.getMemberMemoContent() == null) {
			memberMemo.setMemberMemoContent("");
		}
		resultMap.put("memberMemo", memberMemo);
		// 회원 권한 조회
		resultMap.put("authorities", memberDao.selectOneAuthorities(memberNo));
		
		return resultMap;
	}

	// 회원 탈퇴로 변경
	@Override
	public Map<String, Object> updateMemberToWithdrawal(Map<String, Object> param) {
		Map<String, Object> resultMap = new HashMap<>();
		Member member = (Member) param.get("member");
		if(passwordEncoder.matches((String)param.get("password"), member.getPassword())) {
			int resultMemberToWithdrawal = memberDao.updateMemberToWithdrawal(param);
			resultMap.put("msg", resultMemberToWithdrawal > 0 ? "회원 탈퇴가 완료되었습니다." : "회원 탈퇴에 실패했습니다.");
			resultMap.put("return", "redirect:/");
			return resultMap;
		} else {
			resultMap.put("msg", "비밀번호가 일치하지 않습니다.");
			resultMap.put("return", "redirect:/admin/member/memberWithdrawal.do");
			return resultMap;
		}
	}

	// 회원 접속 이력 관리
	@Override
	public Map<String, Object> seletHistoryList(int cPage, int limit, String url) {
		Map<String,Object> resultMap = new HashMap<String,Object>();
		int offset = (cPage - 1) * limit;
		resultMap.put("memberAccessHistoryList", memberDao.seletHistoryList(offset, limit));
		resultMap.put("totalAccessHistoryCount", memberDao.totalAccessHistoryCount());
		resultMap.put("pagebar", Mir9Utils.getPagebar(cPage, limit, memberDao.totalAccessHistoryCount(), url));
		return resultMap;
	}

	// 접속 이력 게시글 수
	@Override
	public int selectAccessHistoryCount() {
		return memberDao.totalAccessHistoryCount();
	}

	// 접속 이력 검색 게시물
	@Override
	public Map<String, Object> seletSearchAccessHistory(Map<String, Object> param, int cPage, int limit, String url) {
		Map<String,Object> resultMap = new HashMap<String,Object>();
		int offset = (cPage - 1) * limit;
		resultMap.put("searchAccessHistoryListStr", Mir9Utils.getSearchAccessHistoryListStr(memberDao.seletSearchAccessHistory(param, offset, limit), (String)param.get("contextPath")));
		resultMap.put("searchHistoryListCount", memberDao.searchHistoryListCount(param));
		resultMap.put("pagebar", Mir9Utils.getPagebarAccessHistory(cPage, limit, memberDao.searchHistoryListCount(param), url));
		return resultMap;
	}

	// 접속 이력 검색 게시물 수
	@Override
	public int selectSearchHistoryListCount(Map<String, Object> param) {
		return memberDao.searchHistoryListCount(param);
	}

	// 접속 이력 선택 삭제
	@Override
	public int deleteAccessHistory(int[] accessHistoryNo) {
		return memberDao.deleteAccessHistory(accessHistoryNo);
	}

	@Override
	public List<MemberAccessHistoryListExcelForm> selectMemberAccessHistoryListExcelForm() {
		return memberDao.selectMemberAccessHistoryListExcelForm();
	}

	// 회원 아이디 조회
	@Override
	public String selectMemberIdByNo(int memberNo) {
		return memberDao.selectMemberIdByNo(memberNo);
	}

	// 주소록 삭제
	@Override
	public int deleteAddressBook(int[] memberNo) {
		return memberDao.deleteAddressBook(memberNo);
	}

	// 탈퇴 회원 리스트
	@Override
	public Map<String,Object> selectWithdrawalMemberListMemberList(int offset, int limit) {
		Map<String, Object> resultMap = new HashMap<String,Object>();
		resultMap.put("withdrawalMemberList", memberDao.selectWithdrawalMemberListMemberList(offset, limit));
		resultMap.put("totalwithdrawalCount", memberDao.selectWithdrawalCount());
		resultMap.put("memberGradeList", memberDao.selectMemberGradeList());
		return resultMap;
	}

	// 탈퇴 회원 전체 게시물 수
	@Override
	public int selectSearchWithdrawalListCount(Map<String, Object> param) {
		return memberDao.selectSearchWithdrawalListCount(param);
	}

	// 탈퇴회원 검색 게시물
	@Override
	public Map<String,Object> selectSearchWithdrawalList(Map<String, Object> param, int cPage, int limit, String url) {
		Map<String, Object> resultMap = new HashMap<String,Object>();
		int offset = (cPage - 1) * limit;
		resultMap.put("searchWithdrawalListStr", Mir9Utils.getSearchWithdrawalListStr(memberDao.selectSearchWithdrawalList(param, offset, limit), (String)param.get("contextPath")));
		resultMap.put("searchListCount", memberDao.selectSearchWithdrawalListCount(param));
		resultMap.put("pagebar", Mir9Utils.getPagebarWithdrawal(cPage, limit, memberDao.selectSearchWithdrawalListCount(param), url));
		return resultMap;
	}

}
