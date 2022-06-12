<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
	//addBoard 실행 function
	function fncAddBoard(){
		var boardTitle = $("input[name='boardTitle']").val();
		var boardType = $("select[name='boardType']").val();
		var boardCategory = $("input[name='boardCategory']").val();
		var	boardEmail = $("input[name='boardEmail']").val();
		if(boardTitle == null || boardTitle == ''){
			alert("제목이 입력되지 않았습니다.");
			return;
		}else if(boardCategory == null || boardCategory == ''){
			alert("카테고리가 입력되지 않았습니다.");
			return;
		}
		alert("게시판이 등록 되었습니다.")
		$("form[name='addBoard']").attr("method", "POST").attr("action", "/admin/board/boardProcess?${_csrf.parameterName}=${_csrf.token}").submit();
	}
	
	$(function(){
		$("button[name='addBoardButton']").on("click" , function(){
			fncAddBoard();
		})
	})
</script>

<div class="modal fade" id="modalRegister" tabindex="-2" role="dialog" aria-labelledby="myModal" aria-hidden="true">
    <div class="modal-dialog" style="width:600px;">
        <div class="modal-content">
            <form name="addBoard" method="post">
	            <input type="hidden" name="mode" id="mode" value="insert">
	            <input type="hidden" name="board_code" id="board_code">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                <h4 class="modal-title" id="myModalLabel">게시판 생성</h4>
	            </div>
	            <div class="modal-body">
		            <h4><p class="text-light-blue"><i class="fa fa-fw fa-info-circle"></i>게시판 정보</p></h4>
		            <table class="table table-bordered">
			            <tr>
			                <td class="menu">제목</td>
			                <td align="left" colspan="3"><input type="text" name="boardTitle" id="boardTitle" class="form-control input-sm"></td>
			            </tr>
			            <tr>
			                <td class="menu">종류 <span class="text-light-blue"><i class="fa fa-check"></i></span></td>
			                <td colspan="3">
			                	<select name="boardType" id="boardType" class="form-control input-sm" style="width:120px;">
			      					<option value="list">일반</option>      
			      					<option value="gallery">갤러리</option>      
			      					<option value="qna">FAQ</option>      
			      					<option value="webzine">웹진</option>      
			      					<option value="movie">동영상</option>      
			      					<option value="event">이벤트</option>      
			      					<option value="manual">메뉴얼</option>      
			      					<option value="brochure">브로슈어</option>                
			      				</select>
			                </td>
			            </tr>
			            <tr>
			                <td class="menu">카테고리</td>
			                <td align="left" colspan="3"><input type="text" name="boardCategory" id="boardCategory" class="form-control input-sm" placeholder=",(콤마)로 구분해 주세요"></td>
			            </tr>
			            <tr>
			                <td class="menu">수신 메일 주소</td>
			                <td align="left" colspan="3"><input type="text" name="boardEmail" placeholder=", 구분" class="form-control input-sm"></td>
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
			                	<select name="authorityList" class="form-control input-sm" style="width:120px;">
			                		<option value="0">비회원</option>
			      					<option value="3">ㅈㅇㅇㅈ</option>      
			      					<option value="2">회원</option>      
			      					<option value="1">슈퍼관리자</option>                
			      				</select>
			                </td>
			                <td class="menu">보기 권한</td>
			                <td align="left">
				                <select name="authorityView" class="form-control input-sm" style="width:120px;">
				                	<option value="0">비회원</option>
				      				<option value="3">ㅈㅇㅇㅈ</option>      
				      				<option value="2">회원</option>      
				      				<option value="1">슈퍼관리자</option>                
				      			</select>
			                </td>
			            </tr>
			            <tr>
			                <td class="menu">쓰기 권한</td>
			                <td align="left">
			                	<select name="authorityWrite" class="form-control input-sm" style="width:120px;">
			                		<option value="0">비회원</option>
			      					<option value="3">ㅈㅇㅇㅈ</option>      
			      					<option value="2">회원</option>      
			      					<option value="1">슈퍼관리자</option>                
			      				</select>
			                </td>
			                <td class="menu">수정 권한</td>
			                <td align="left">
			                	<select name="authorityUpdate" class="form-control input-sm" style="width:120px;">
			                		<option value="0">비회원</option>
			      					<option value="3">ㅈㅇㅇㅈ</option>      
			      					<option value="2">회원</option>      
			      					<option value="1">슈퍼관리자</option>                
			      				</select>
			                </td>
			            </tr>
			            <tr>
			                <td class="menu">삭제 권한</td>
			                <td align="left">
			                	<select name="authorityDelete" class="form-control input-sm" style="width:120px;">
			                		<option value="0">비회원</option>
			      					<option value="3">ㅈㅇㅇㅈ</option>      
			      					<option value="2">회원</option>      
			      					<option value="1">슈퍼관리자</option>                
			      				</select>
			                </td>
			                <td class="menu">답변 권한</td>
			                <td align="left">
			                	<select name="authorityAnswer" class="form-control input-sm" style="width:120px;">
			                		<option value="0">비회원</option>
			      					<option value="3">ㅈㅇㅇㅈ</option>      
			      					<option value="2">회원</option>      
			      					<option value="1">슈퍼관리자</option>                
			      				</select>
			                </td>
			            </tr>
			            <tr>
			                <td class="menu">공지 권한</td>
			                <td align="left">
			                	<select name="authorityNotice" class="form-control input-sm" style="width:120px;">
			      					<option value="3">ㅈㅇㅇㅈ</option>      
			      					<option value="2">회원</option>      
			      					<option value="1">슈퍼관리자</option>                
			      				</select>
			                </td>
			                <td class="menu">댓글 권한</td>
			                <td align="left">
				                <select name="authorityComment" class="form-control input-sm" style="width:120px;">
				                	<option value="0">비회원</option>
				      				<option value="3">ㅈㅇㅇㅈ</option>      
				      				<option value="2">회원</option>      
				      				<option value="1">슈퍼관리자</option>                
				      			</select>
			                </td>
			            </tr>
			            <tr>
			                <td class="menu">기타 옵션</td>
			                <td align="left" colspan="3">
				                <span class="option_tab"><input type="checkbox" name="optionNotice" value="y">공지기능</span>
				                <span class="option_tab"><input type="checkbox" name="optionComment" value="y">댓글</span>
				                <span class="option_tab"><input type="checkbox" name="optionSecret" value="y">비밀글</span>
				                <span class="option_tab"><input type="checkbox" name="optionAnswer" value="y">답변기능</span>
				                <span class="option_tab"><input type="checkbox" name="optionCaptcha" value="y">도용방지문자</span>
				                <span class="option_tab"><input type="checkbox" name="optionMass" value="y">대용량 업로드</span>
				                <span class="option_tab"><input type="checkbox" name="optionOrder" value="y">순서변경</span>
				                <span class="option_tab" style="width:263px;"><input type="checkbox" name="optionAddinfo" value="y">추가정보(휴대전화,이메일)</span>
				                <span class="option_tab"><input type="checkbox" name="optionPopup" value="y">상세보기(팝업)</span>
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
	            </div><!-- /.modal-body -->
	            <div class="modal-footer">
	            	<button type="button" name="addBoardButton" class="btn btn-primary">확인</button>&nbsp;&nbsp;&nbsp;
	            </div><!-- /.modal-footer -->
            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal fade -->