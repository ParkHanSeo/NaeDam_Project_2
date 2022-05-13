package com.naedam.admin.member.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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

@Repository
public class MemberDaoImpl implements MemberDao {
	
	@Autowired
	private SqlSession session;

	// 회원가입
	@Override
	public int insertMember(Member member) {
		return session.insert("member.insertMember", member);
	}

	// 로그인 - 해당 id정보 가져오기
	@Override
	public Member selectOneMember(String id) {
		return session.selectOne("member.selectOneMember", id);
	}

	// 회원 리스트 전체 게시물 목록
	@Override
	public List<MemberEntity> selectMemberList() {
		return session.selectList("member.selectMemberList");
	}

	// 회원 리스트 전체 게시물 수
	@Override
	public int selectMemberListCount() {
		return session.selectOne("member.selectMemberListCount");
	}

	// id 중복 검사
	@Override
	public Member selectOneMemberByMap(Map<String, Object> param) {
		return session.selectOne("member.selectOneMemberByMap", param);
	}

	// 타입별 검색 게시물
	@Override
	public List<MemberEntity> selectSearchMemberList(Map<String, Object> param) {
		return session.selectList("member.selectSearchMemberList", param);
	}

	// 검색 게시물 수
	@Override
	public int selectSearchListCount(Map<String, Object> param) {
		return session.selectOne("member.selectSearchListCount", param);
	}

	// 회원 삭제
	@Override
	public int deleteMember(int[] memberNo) {
		return session.delete("member.deleteMember", memberNo);
	}

	// 회원 등급 리스트
	@Override
	public List<MemberGrade> selectMemberGradeList() {
		return session.selectList("member.selectMemberGradeList");
	}

	// 회원 등급 수정
	@Override
	public int memberGradeUpdate(MemberGrade paramGrade) {
		return session.update("member.memberGradeUpdate", paramGrade);
	}

	// 주소 입력
	@Override
	public int insertAddress(Address address) {
		return session.insert("member.insertAddress", address);
	}

	// 메모 입력
	@Override
	public int insertMemberMemo(MemberMemo memberMemo) {
		return session.insert("member.insertMemberMemo", memberMemo);
	}

	// 회원 입력
	@Override
	public int insertRegisterMember(Member paramMember) {
		return session.insert("member.insertRegisterMember", paramMember);
	}

	// 주소록 입력
	@Override
	public int insertAddressBook(AddressBook paramAddressBook) {
		return session.insert("member.insertAddressBook", paramAddressBook);
	}

	// 권한 입력
	@Override
	public int insertAuthorities(Authorities paramAuthorities) {
		return session.insert("member.insertAuthorities", paramAuthorities);
	}

	// 회원정보 조회(회원번호)
	@Override
	public Member selectOneMemberByMemberNo(int memberNo) {
		return session.selectOne("member.selectOneMemberByMemberNo", memberNo);
	}

	// 회원주소 조회
	@Override
	public Address selectOneAddress(int memberNo) {
		return session.selectOne("member.selectOneAddress", memberNo);
	}

	// 회원메모 조회
	@Override
	public MemberMemo selectOneMemo(int memberNo) {
		return session.selectOne("member.selectOneMemo", memberNo);
	}

	// 회원등급 조회
	@Override
	public Authorities selectOneAuthorities(int memberNo) {
		return session.selectOne("member.selectOneAuthorities", memberNo);
	}

	// 회원정보 수정(상세보기)
	@Override
	public int memberUpdate(Member paramMember) {
		return session.update("member.memberUpdate", paramMember);
	}
	
	// 회원 적립금 관리
	@Override
	public List<MemberPoint> selectMemberPointListByParam(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return session.selectList("member.selectMemberPointListByParam", param);
	}

	// 회원주소 수정(상세보기)
	@Override
	public int addressUpdate(Address paramAddress) {
		return session.update("member.addressUpdate", paramAddress);
	}

	// 권한(Authorities) 수정
	@Override
	public int authoritiesUpdate(Authorities paramAuthorities) {
		return session.update("member.authoritiesUpdate", paramAuthorities);
	}

	// 메모(MemberMemo) 수정
	@Override
	public int memberMemoUpdate(MemberMemo paramMemberMemo) {
		return session.update("member.memberMemoUpdate", paramMemberMemo);
	}

	// 엑셀 다운로드
	@Override
	public List<MemberListExcelForm> selectMemberListExcelForm() {
		return session.selectList("member.selectMemberListExcelForm");
	}

	// 회원 삭제
	@Override
	public int memberWithdrawal(String id) {
		return session.delete("member.memberWithdrawal", id);
	}

	// 주소 삭제
	@Override
	public int deleteAddress(int addressNo) {
		return session.delete("member.deleteAddress", addressNo);
	}

	// 주소록 조회
	@Override
	public AddressBook selectOneAddressBook(int memberNo) {
		return session.selectOne("member.selectOneAddressBook", memberNo);
	}

	// 주소록 삭제
	@Override
	public int deleteAddressBook(int addressBookNo) {
		return session.delete("member.deleteAddressBook", addressBookNo);
	}

	// 권한 삭제
	@Override
	public int deleteAuthorties(int memberNo) {
		return session.delete("member.deleteAuthorties", memberNo);
	}

	// 탈퇴 사유
	@Override
	public int updateReason(Map<String, Object> param) {
		return session.update("member.updateReason", param);
	}

	// 탈퇴 회원 리스트
	@Override
	public List<MemberEntity> selectWithdrawalMemberList() {
		return session.selectList("member.selectWithdrawalMemberList");
	}

	// 탈퇴 회원 전체 게시물 수
	@Override
	public int selectWithdrawalCount() {
		return session.selectOne("member.selectWithdrawalCount");
	}

	// 탈퇴회원 검색 게시물 수
	@Override
	public int selectSearchWithdrawalListCount(Map<String, Object> param) {
		return session.selectOne("member.selectSearchWithdrawalListCount", param);
	}
	
	@Override
	public int selectMemberTotalPoint(int memberNo) {
		// TODO Auto-generated method stub
		return session.selectOne("member.selectMemberTotalPoint", memberNo);
	}


	// 탈퇴회원 삭제
	@Override
	public int deleteWithdrawal(int[] memberNo) {
		return session.delete("member.deleteWithdrawal", memberNo);
	}

	// 주소번호 조회
	@Override
	public List<Address> findAddressNo(int[] memberNo) {
		return session.selectList("member.findAddressNo", memberNo);
	}

	// 주소 삭제
	@Override
	public int deleteWithdrawalAddress(int addressNo) {
		return session.delete("member.deleteWithdrawalAddress", addressNo);
	}

	// 주소록 삭제
	@Override
	public int deleteWithdrawalAddressBook(int[] memberNo) {
		return session.delete("member.deleteWithdrawalAddressBook", memberNo);
	}

	// 권한 삭제
	@Override
	public int deleteWithdrawalAuthority(int[] memberNo) {
		return session.delete("member.deleteWithdrawalAuthority", memberNo);
	}

	

	




	@Override
	public int selectTodayRegMemberCnt() {
		// TODO Auto-generated method stub
		return session.selectOne("member.selectTodayRegMemberCnt");
	}

	// 탈퇴회원 조회
	@Override
	public WithdrawalMember selectOneMemberByWithdrawalMemberNo(int memberNo) {
		return session.selectOne("member.selectOneMemberByWithdrawalMemberNo", memberNo);
	}

	// 주소록 삭제
	@Override
	public int deleteAddressBookByMemberNo(int[] memberNo) {
		return session.delete("member.deleteAddressBookByMemberNo", memberNo);
	}

	// 권한 삭제
	@Override
	public int deleteAuthorityByMemberNo(int[] memberNo) {
		return session.delete("member.deleteAuthorityByMemberNo", memberNo);
	}

	@Override
	public List<Address> findMemberAddressList(int[] memberNo) {
		return session.selectList("member.findMemberAddressList", memberNo);
	}

	@Override
	public int deleteMemoByMemberNo(int[] memberNo) {
		return session.delete("member.deleteMemoByMemberNo", memberNo);
	}

	// 메모 영구삭제
	@Override
	public int deleteWithdrawalMemo(int[] memberNo) {
		return session.delete("member.deleteWithdrawalMemo", memberNo);
	}

	// 탈퇴회원 상세조회
	@Override
	public WithdrawalMemberEntity selectOneWithdrawalMemberEntity(int memberNo) {
		return session.selectOne("member.selectOneWithdrawalMemberEntity", memberNo);
	}

	@Override
	public int deleteMemberMemo(int memberNo) {
		return session.delete("member.deleteMemberMemo", memberNo);
	}

	// 탈퇴회원 타입별 검색
	@Override
	public List<MemberEntity> selectSearchWithdrawalList(Map<String, Object> param) {
		return session.selectList("member.selectSearchWithdrawalList", param);
	}

	// 회원 탈퇴로 변경
	@Override
	public int updateMemberToWithdrawal(Map<String, Object> param) {
		return session.update("member.updateMemberToWithdrawal", param);
	}

	@Override
	public List<MemberAccessHistory> seletHistoryList() {
		return session.selectList("member.seletHistoryList");
	}

	@Override
	public int totalAccessHistoryCount() {
		return session.selectOne("member.totalAccessHistoryCount");
	}

	@Override
	public List<MemberAccessHistory> seletSearchAccessHistory(Map<String, Object> param) {
		return session.selectList("member.seletSearchAccessHistory", param);
	}

	@Override
	public int searchHistoryListCount(Map<String, Object> param) {
		return session.selectOne("member.searchHistoryListCount", param);
	}

	@Override
	public int deleteAccessHistory(int[] accessHistoryNo) {
		return session.delete("member.deleteAccessHistory", accessHistoryNo);
	}

	@Override
	public List<MemberAccessHistoryListExcelForm> selectMemberAccessHistoryListExcelForm() {
		return session.selectList("member.selectMemberAccessHistoryListExcelForm");
	}

	// 회원 정보 조회
	@Override
	public List<Member> selectMemberInfo(String code) {
		return session.selectList("member.selectMemberInfo", code);
	}



	
}
