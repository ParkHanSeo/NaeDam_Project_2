package com.naedam.admin.member.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
import com.naedam.admin.point.model.vo.MemberPoint;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberDao memberDao;

	// 회원가입
	@Override
	public int insertMember(Member member) {
		return memberDao.insertMember(member);
	}

	// 로그인 - 해당 id정보 가져오기
	@Override
	public Member selectOneMember(String id) {
		return memberDao.selectOneMember(id);
	}

	// 회원 리스트 전체 게시물 목록
	@Override
	public List<MemberEntity> selectMemberList(int offset, int limit) {
		return memberDao.selectMemberList(offset, limit);
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
	public List<MemberEntity> selectSearchMemberList(Map<String, Object> param, int offset, int limit) {
		return memberDao.selectSearchMemberList(param, offset, limit);
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
	@Override
	public int memberGradeUpdate(MemberGrade paramGrade) {
		return memberDao.memberGradeUpdate(paramGrade);
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
	
	// 회원 적립금 관리
	@Override
	public List<MemberPoint> selectMemberPointListByParam(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return memberDao.selectMemberPointListByParam(param);
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
		// TODO Auto-generated method stub
		return memberDao.selectMemberTotalPoint(memberNo);

	}

	// 주소 번호 조회
	@Override
	public List<Address> findAddressNo(int[] memberNo) {
		return memberDao.findAddressNo(memberNo);
	}

	@Override
	public int selectTodayRegMemberCnt() {
		// TODO Auto-generated method stub
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
	public WithdrawalMemberEntity selectOneWithdrawalMemberEntity(int memberNo) {
		return memberDao.selectOneWithdrawalMemberEntity(memberNo);
	}

	// 회원 탈퇴로 변경
	@Override
	public int updateMemberToWithdrawal(Map<String, Object> param) {
		return memberDao.updateMemberToWithdrawal(param);
	}

	// 회원 접속 이력 관리
	@Override
	public List<MemberAccessHistory> seletHistoryList(int offset, int limit) {
		return memberDao.seletHistoryList(offset, limit);
	}

	// 접속 이력 게시글 수
	@Override
	public int selectAccessHistoryCount() {
		return memberDao.totalAccessHistoryCount();
	}

	// 접속 이력 검색 게시물
	@Override
	public List<MemberAccessHistory> seletSearchAccessHistory(Map<String, Object> param, int offset, int limit) {
		return memberDao.seletSearchAccessHistory(param, offset, limit);
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

	// 회원 정보 조회
	@Override
	public List<Member> selectMemberInfo(String code) {
		return memberDao.selectMemberInfo(code);
	}


	// sms 발신 번호 조회
	@Override
	public String getPhoneById(String id) {
		return memberDao.getPhoneById(id);
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
	public List<MemberEntity> selectWithdrawalMemberListMemberList(int offset, int limit) {
		return memberDao.selectWithdrawalMemberListMemberList(offset, limit);
	}

	// 탈퇴 회원 전체 게시물 수
	@Override
	public int selectSearchWithdrawalListCount(Map<String, Object> param) {
		return memberDao.selectSearchWithdrawalListCount(param);
	}

	// 탈퇴회원 검색 게시물
	@Override
	public List<MemberEntity> selectSearchWithdrawalList(Map<String, Object> param, int offset, int limit) {
		return memberDao.selectSearchWithdrawalList(param, offset, limit);
	}

	
}
