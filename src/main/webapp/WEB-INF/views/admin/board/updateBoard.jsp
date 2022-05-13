<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="contatiner">
	
	<form name="updateBoardForm" method="post">
		<div class="modal fade" id="updateBoardModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog" style="width:600px;">
        <div class="modal-content">
            <form name="form" method="post">
            <input type="hidden" name="mode" id="mode">
            <input type="hidden" name="boardNo" id="boardNo2">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">게시판 수정</h4>
            </div>
            <div class="modal-body">

            <h4><p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i> 게시판 정보</p></h4>
            <table class="table table-bordered">
            <tr>
                <td class="menu">제목</td>
                <td align="left" colspan="3"><input type="text" name="boardTitle" id="boardTitle2" class="form-control input-sm"></td>
            </tr>
            <tr>
                <td class="menu">종류 <span class="text-light-blue"><i class="fa fa-check"></i></span></td>
                <td colspan="3">
                <select name="boardType" id="boardType2" class="form-control input-sm" style="width:120px;">
      <option value="list">일반</option>      <option value="gallery">갤러리</option>      <option value="qna">FAQ</option>      <option value="webzine">웹진</option>      <option value="movie">동영상</option>      <option value="event">이벤트</option>      <option value="manual">메뉴얼</option>      <option value="brochure">브로슈어</option>                </select>
                </td>
            </tr>
            <tr>
                <td class="menu">카테고리</td>
                <td align="left" colspan="3"><input type="text" name="boardCategory" id="boardCategory2" class="form-control input-sm" placeholder=",(콤마)로 구분해 주세요"></td>
            </tr>
            <tr>
                <td class="menu">수신 메일 주소</td>
                <td align="left" colspan="3"><input type="text" name="boardEmail" id="boardEmail2" placeholder=", 구분" class="form-control input-sm"></td>
            </tr>
<!--
            <tr>
                <td class="menu">리스트 표출</td>
                <td align="left">
                <input type="radio" name="show_list" id="show_list_y" value="y">사용&nbsp;&nbsp;
                <input type="radio" name="show_list" id="show_list_n" value="n">숨김&nbsp;&nbsp;
                <span class="text-light-blue">※ 글 상세보기에서 리스트가 표출됩니다.<span>
                </td>
            </tr>
-->
            <tr>
                <td class="menu">리스트 권한</td>
                <td align="left">
                <select name="authorityList" id="authorityList2" class="form-control input-sm" style="width:120px;">
                <option value="0">비회원</option>
      <option value="3">ㅈㅇㅇㅈ</option>      <option value="2">회원</option>      <option value="1">슈퍼관리자</option>                </select>
                </td>
                <td class="menu">보기 권한</td>
                <td align="left">
                <select name="authorityView" id="authorityView2" class="form-control input-sm" style="width:120px;">
                <option value="0">비회원</option>
      <option value="3">ㅈㅇㅇㅈ</option>      <option value="2">회원</option>      <option value="1">슈퍼관리자</option>                </select>
                </td>
            </tr>
            <tr>
                <td class="menu">쓰기 권한</td>
                <td align="left">
                <select name="authorityWrite" id="authorityWrite2" class="form-control input-sm" style="width:120px;">
                <option value="0">비회원</option>
      <option value="3">ㅈㅇㅇㅈ</option>      <option value="2">회원</option>      <option value="1">슈퍼관리자</option>                </select>
                </td>
                <td class="menu">수정 권한</td>
                <td align="left">
                <select name="authorityUpdate" id="authorityUpdate2" class="form-control input-sm" style="width:120px;">
                <option value="0">비회원</option>
      <option value="3">ㅈㅇㅇㅈ</option>      <option value="2">회원</option>      <option value="1">슈퍼관리자</option>                </select>
                </td>
            </tr>
            <tr>
                <td class="menu">삭제 권한</td>
                <td align="left">
                <select name="authorityDelete" id="authorityDelete2" class="form-control input-sm" style="width:120px;">
                <option value="0">비회원</option>
      <option value="3">ㅈㅇㅇㅈ</option>      <option value="2">회원</option>      <option value="1">슈퍼관리자</option>                </select>
                </td>
                <td class="menu">답변 권한</td>
                <td align="left">
                <select name="authorityAnswer" id="authorityAnswer2" class="form-control input-sm" style="width:120px;">
                <option value="0">비회원</option>
      <option value="3">ㅈㅇㅇㅈ</option>      <option value="2">회원</option>      <option value="1">슈퍼관리자</option>                </select>
                </td>
            </tr>
            <tr>
                <td class="menu">공지 권한</td>
                <td align="left">
                <select name="authorityNotice" id="authorityNotice2" class="form-control input-sm" style="width:120px;">
      <option value="3">ㅈㅇㅇㅈ</option>      <option value="2">회원</option>      <option value="1">슈퍼관리자</option>                </select>
                </td>
                <td class="menu">댓글 권한</td>
                <td align="left">
                <select name="authorityComment" id="authorityComment2" class="form-control input-sm" style="width:120px;">
                <option value="0">비회원</option>
      <option value="3">ㅈㅇㅇㅈ</option>      <option value="2">회원</option>      <option value="1">슈퍼관리자</option>                </select>
                </td>
            </tr>
            <tr>
                <td class="menu">기타 옵션</td>
                <td align="left" colspan="3">
                <span class="option_tab"><input type="checkbox" name="optionNotice" id="optionNotice2" value="y">공지기능</span>
                <span class="option_tab"><input type="checkbox" name="optionComment" id="optionComment2" value="y">댓글</span>
                <span class="option_tab"><input type="checkbox" name="optionSecret" id="optionSecret2" value="y">비밀글</span>
                <span class="option_tab"><input type="checkbox" name="optionAnswer" id="optionAnswer2" value="y">답변기능</span>
                <span class="option_tab"><input type="checkbox" name="optionCaptcha" id="optionCaptcha2" value="y">도용방지문자</span>
                <span class="option_tab"><input type="checkbox" name="optionMass" id="optionMass2" value="y">대용량 업로드</span>
                <span class="option_tab"><input type="checkbox" name="optionOrder" id="optionOrder2" value="y">순서변경</span>
                <span class="option_tab" style="width:263px;"><input type="checkbox" id="optionAddinfo2" name="optionAddinfo" value="y">추가정보(휴대전화,이메일)</span>
                <span class="option_tab"><input type="checkbox" name="optionPopup" id="optionPopup2" value="y">상세보기(팝업)</span>
                </td>
            </tr>
            <tr>
                <td class="menu">구글번역 언어</td>
                <td align="left" colspan="3">
                <span class="option_tab"><input type="checkbox" name="google_translate[]" id="google_ko" value="ko">한국어</span>
                <span class="option_tab"><input type="checkbox" name="google_translate[]" id="google_en" value="en">영어</span>
                <span class="option_tab"><input type="checkbox" name="google_translate[]" id="google_zh-CN" value="zh-CN">중국어</span>
                <span class="option_tab"><input type="checkbox" name="google_translate[]" id="google_ja" value="ja">일본어</span>
                <span class="option_tab"><input type="checkbox" name="google_translate[]" id="google_de" value="de">독일어</span>
                <span class="option_tab"><input type="checkbox" name="google_translate[]" id="google_vi" value="vi">베트남어</span>
                <span class="option_tab"><input type="checkbox" name="google_translate[]" id="google_es" value="es">스페인어</span>
                <span class="option_tab"><input type="checkbox" name="google_translate[]" id="google_ar" value="ar">아랍어</span>
                <span class="option_tab"><input type="checkbox" name="google_translate[]" id="google_th" value="th">태국어</span>
                </td>
            </tr>
            <tr>
                <td colspan="4">
                <textarea name="header" id="header" rows="6" class="form-control input-sm" placeholder="상단에 들어갈 css" style="width:100%;"></textarea>
                </td>
            </tr>
            </table>

            </div>
            <div class="modal-footer">
            <button type="button" onclick="fncUpdateBoard()" class="btn btn-primary">확인</button>&nbsp;&nbsp;&nbsp;
            </div>
            </form>
        </div>
    </div>
		</div>
	</form>
</div>
