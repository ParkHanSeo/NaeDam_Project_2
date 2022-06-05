package com.naedam.admin.member.model.service;

import java.util.List;
import java.util.Map;

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

public interface MemberService {
	
	// 회원관리 프로세스
	Map<String, Object> memberProcess(Map<String, Object> map) throws Exception;
	
	// 회원 상세보기
	Map<String, Object> memberDetail(Map<String, Object> map) throws Exception;
	
	// 로그인 - 해당 id정보 가져오기
	Member selectOneMember(String id);

	// 회원 리스트 전체 게시물 목록
	Map<String, Object> selectMemberList(int cPage, int limit, String url);

	// 회원 리스트 전체 게시물 수 
	int selectMemberListCount();

	// id 중복 검사
	Member selectOneMemberByMap(Map<String, Object> param);

	// 타입별 검색 게시물
	Map<String, Object> selectSearchMemberList(Map<String, Object> map, int cPage, int limit, String url);

	// 검색 게시물 수
	int selectSearchListCount(Map<String, Object> param);

	// 회원 삭제
	int deleteMember(int[] memberNo);

	// 회원 등급 리스트
	List<MemberGrade> selectMemberGradeList();

	// 회원 등급 수정
	void memberGradeUpdate(String data);

	// 주소 입력
	int insertAddress(Address address);

	// 메모 입력
	int insertMemberMemo(MemberMemo memberMemo);

	// 회원 등록
	int insertRegisterMember(Member paramMember);

	// 주소록 입력
	int insertAddressBook(AddressBook paramAddressBook);

	// 권한 입력
	int insertAuthorities(Authorities paramAuthorities);

	// 회원정보 조회(회원번호)
	Member selectOneMemberByMemberNo(int memberNo);

	// 회원주소 조회
	Address selectOneAddress(int memberNo);

	// 회원메모 조회
	MemberMemo selectOneMemo(int memberNo);

	// 회원등급 조회
	Authorities selectOneAuthorities(int memberNo);
	
	// 회원 적립금 목록
	Map<String, Object> selectMemberPointListByParam(Map<String, Object> param);

	// 회원 적립금 목록 수
	int totalPointCount(Map<String, Object> param);
	
	// 회원정보 수정(상세보기)
	int memberUpdate(Member paramMember);

	// 회원주소 수정(상세보기)
	int addressUpdate(Address paramAddress);

	// 권한(Authorities) 수정
	int authoritiesUpdate(Authorities paramAuthorities);

	// 메모(MemberMemo) 수정
	int memberMemoUpdate(MemberMemo paramMemberMemo);

	// 엑셀 다운로드
	List<MemberListExcelForm> selectMemberListExcelForm();
	
	// 포인트 총계
	int selectMemberTotalPoint(int memberNo);

	// 주소 삭제 
	int deleteAddress(int addressNo);

	// 주소록 조회 
	AddressBook selectOneAddressBook(int memberNo);

	// 주소록 삭제
	int deleteAddressBook(int[] memberNo);

	// 권한 삭제
	int deleteAuthorities(int[] memberNo);

	// 탈퇴 사유
	int updateReason(Map<String, Object> param);

	// 탈퇴 회원 전체 게시물 수
	int selectWithdrawalCount();

	// 주소 번호 조회
	List<Address> findAddressNo(int[] memberNo);

	int selectTodayRegMemberCnt();

	// 탈퇴회원 조회
	WithdrawalMember selectOneMemberByWithdrawalMemberNo(int memberNo);

	List<Address> findMemberAddressList(int[] memberNo);

	// 메모 삭제
	int deleteMemberMemo(int[] memberNo);

	// 탈퇴회원 상세조회
	Map<String, Object> selectOneWithdrawalMemberEntity(int memberNo);

	// 회원 탈퇴로 변경
	Map<String, Object> updateMemberToWithdrawal(Map<String, Object> param);

	// 회원 접속 이력 관리
	Map<String, Object> seletHistoryList(int cPage, int limit, String url);
	
	// 접속 이력 게시글 수
	int selectAccessHistoryCount();

	// 접속 이력 검색 게시물
	Map<String, Object> seletSearchAccessHistory(Map<String, Object> param, int cPage, int limit, String url);

	// 접속 이력 검색 게시물 수
	int selectSearchHistoryListCount(Map<String, Object> param);

	// 접속 이력 선택 삭제
	int deleteAccessHistory(int[] accessHistoryNo);

	List<MemberAccessHistoryListExcelForm> selectMemberAccessHistoryListExcelForm();

	// 회원 아이디 조회
	String selectMemberIdByNo(int memberNo);

	// 탈퇴 회원 리스트
	Map<String,Object> selectWithdrawalMemberListMemberList(int offset, int limit);

	// 탈퇴 회원 전체 게시물 수
	int selectSearchWithdrawalListCount(Map<String, Object> param);

	// 탈퇴회원 검색 게시물
	Map<String, Object> selectSearchWithdrawalList(Map<String, Object> param, int cPage, int limit, String url);

}
