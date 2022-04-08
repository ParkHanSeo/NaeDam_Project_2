<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>	

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="회원 관리" name="title" />
</jsp:include>

<style>
.ui-menu {
	z-index: 9999;
	width: 400px;
	}
</style>

<!-- content-wrapper -->
<div class="content-wrapper">
<!-- <link href="https://mir9.co.kr/resource/css/s9jss_single.css" rel="stylesheet"> -->

<section class="content-header">
	<h1>
		회원 관리 <small>member list</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
		<li>회원 관리</li>
		<li class="active">회원 리스트</li>
	</ol>
</section>

<section class="content">
<div class="row">
	<div class="col-xs-12">
	<form:form name="memberDeleteFrm" action="${pageContext.request.contextPath}/member/memberDelete.do" method="POST">
		<div class="box">
			<div class="box-body">
			<div id="totalCountContainer">
				<label style="margin-top: 5px;">총 ${totalMemberListCount} 건</label>
			</div>
				<!-- 타입별 검색 -->
				<form name="search-form" onsubmit="return false">
					<div class="box-tools pull-right" style="margin-bottom: 5px;">
						<div class="has-feedback">
							<span> 
								<input type="text" name="keyword" id="keyword"
								value="" class="form-control input-sm" placeholder="검색" /> 
								<span
									class="glyphicon glyphicon-search form-control-feedback">
								</span>
							</span>
						</div>
					</div>
					<div class="box-tools pull-right" style="margin-bottom: 5px;">
						<div class="has-feedback">
							<select name="type" class="form-control input-sm">
								<option value="last_name">성</option>
								<option value="first_name">이름</option>
								<option value="phone">휴대폰</option>
							</select>
						</div>
					</div>
				</form>
				<table class="table table-bordered table-hover checkbox-group">
					<%-- <form name="form_list" method="post"
						action=""> --%>
						<!-- <input type="hidden" name="mode" id="mode"> -->
						<thead>
							<tr>
								<td style="width: 30px;">
									<input type="checkbox" name="select_all" id="checkAll" />
								</td>
								<td style="width: 110px;">아이디</td>
								<td style="width: 110px;">이름</td>
								<td style="width: 110px;">휴대폰</td>
								<td>주소</td>
								<td style="width: 100px;">현재 적립금</td>
								<td style="width: 120px;">가입일</td>
								<td style="width: 50px;">상태</td>
								<td style="width: 80px;">적립금</td>
								<td style="width: 100px;">명령</td>
							</tr>
						</thead>
						<tbody id = "tbody">
							<c:forEach items="${memberList}" var="memberEntity">
								<tr>
									<td style="width: 30px;">
										<input type="checkbox" class="member-is-checked" name="" data-target="${memberEntity.memberNo}"  />
									</td>
									<td style="width: 110px;">${memberEntity.id}</td>
									<td style="width: 110px;">${memberEntity.lastName}${memberEntity.firstName}</td>
									<td style="width: 110px;">${memberEntity.phone}</td>
									<td>${memberEntity.addressMain} ${memberEntity.addressSub}</td>
									<td style="width: 100px;">${memberEntity.pointAmt}</td>
									<td style="width: 120px;">
										<fmt:formatDate pattern = "yyyy/MM/dd HH:mm" value="${memberEntity.regDate}"/>
									</td>
									<td>
										<span class="label label-success" style="font-size: 12px;">보임</span>
									</td>
									<td>
										<button type="button" id="btn_${memberEntity.memberNo}" value="${memberEntity.memberNo}" class="btn btn-primary btn-xs">
											내역보기
										</button>
									</td>
									<td>
										<button type="button" onclick="onclickUpdate(18);" class="btn btn-primary btn-xs">
											상세보기
										</button>
									</td>
								</tr>
							</c:forEach>
						</tbody>
<!-- 
						<tr>
							<td><input type="checkbox" name="list[]" value="18" /></td>
							<td>asdf</td>
							<td>나미르</td>
							<td></td>
							<td align="left">부산 중구 중앙대로 114(중앙동4가) 102동 2301호</td>
							<td>1,000</td>
							<td>2022/03/04 16:12</td>
							<td><span class="label label-success"
								style="font-size: 12px;">보임</span></td>
							<td><button type="button"
									onclick="location.replace('?tpf=admin/member/point&field=id&keyword=asdf')"
									class="btn btn-primary btn-xs">내역보기</button></td>
							<td>
								<button type="button" onclick="onclickUpdate(18);"
									class="btn btn-primary btn-xs">상세보기</button>
							</td>
						</tr> -->
					<%-- </form> --%>
				</table>
				<br>
				<button type="button"
					id="memberListDeleteBtn"
					class="btn btn-danger">
					<i class="fa fa-minus-square"></i> 선택삭제
				</button>
				
				<!-- 등록 -->
				<button type="button" onclick="onclickInsert();"
					class="btn btn-primary">
					<i class="fa fa-plus-square"></i> 등록
				</button>
				
				<button type="button" onclick="onclickPoint();"
					class="btn btn-warning" style="margin-left: 20px;">
					<i class="fa fa-won"></i> 적립금 지급
				</button>
				<button type="button" onclick="onclickCoupon();"
					class="btn btn-warning">
					<i class="fa fa-credit-card"></i> 쿠폰 지급
				</button>
				<button type="button" onclick="downloadExcel();"
					class="btn btn-warning">
					<i class="fa fa-file-excel-o"></i> Excel 다운로드
				</button>
				<form name="form_download" method="post"
					action="?tpf=admin/member/process">
					<input type="hidden" name="mode" value="downloadExcel"> <input
						type="hidden" name="search_data">
				</form>
				<!--    // 관리자단에서 회원가입 숨김
                    <button type="button" onclick="onclickSMS();" class="btn btn-danger"><i class="fa fa-bell"></i> SMS발송</button>
-->

				<div style="text-align: right;">
					<ul class="pagination" style="margin: 0;">
						<li class="active"><a
							href="?tpf=admin/member/list&status=y&page=1">1</a></li>
					</ul>
				</div>
			</div>
			<!-- /.box-body -->
		</div>
		<!-- /.box -->
		</form:form>
	</div>
	<!-- /.col-xs-12 -->
</div>
<!-- /.row --> 
</section>

	<form name="formID" method="post" onsubmit="return false;"
		action="?tpf=admin/member/process">
		<input type="hidden" name="mode" value="checkId"> <input
			type="hidden" name="id">
	</form>

	<!-- // 회원 등록 폼 -->
	<div class="modal fade" id="modalRegister" tabindex="-2"
		; role="dialog" aria-labelledby="myModal" aria-hidden="true">
		<div class="modal-dialog" style="width: 620px;">
			<div class="modal-content">
				<form name="form" method="post" onsubmit="return false;"
					action="?tpf=admin/member/process">
					<input type="hidden" name="mode"> <input type="hidden"
						name="member_code">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">회원 등록</h4>
					</div>
					<div class="modal-body">

						<h4>
							<p class="text-light-blue">
								<i class="fa fa-fw fa-info-circle"></i> 회원정보
							</p>
						</h4>
						<table class="table table-bordered">
							<tr>
								<td class="menu">아이디</td>
								<td align="left">
									<input type="text" id="id" name="id" class="form-control input-sm" style="width: 30%; float: left;" />&nbsp;
									<button type="button" id="btn_check_id" value="N"
										class="btn btn-sm btn-default" onclick="onclickCheckId();">아이디
										중복확인</button> 4~12자로 입력하세요.</td>
							</tr>
							<tr>
								<td class="menu">비밀번호</td>
								<td align="left"><input type="password" name="password"
									placeholder="" class="form-control input-sm"
									style="width: 30%; float: left;" /> 대소문자와 숫자 포함 8~15자로 입력하세요</td>
							</tr>
							<tr>
								<td class="menu">비밀번호 확인</td>
								<td align="left"><input type="password"
									name="password_confirm" placeholder=""
									class="form-control input-sm" style="width: 30%;" /></td>
							</tr>
							<tr>
								<td class="menu">이름</td>
								<td align="left"><input type="text" name="first_name"
									class="form-control input-sm" style="width: 30%; float: left;"
									placeholder="이름" /> <input type="text" name="name"
									class="form-control input-sm" style="width: 30%;"
									placeholder="성" /></td>
							</tr>
							<tr>
								<td class="menu">휴대폰</td>
								<td align="left"><select name="mobile1"
									class="form-control input-sm" style="width: 15%; float: left;">
										<option value="010">010</option>
										<option value="011">011</option>
										<option value="016">016</option>
										<option value="017">017</option>
										<option value="018">018</option>
										<option value="019">019</option>
								</select> <span style="float: left;">-</span> <input type="text"
									name="mobile2" onkeyup="this.value=checkNum(this.value)"
									class="form-control input-sm" style="width: 15%; float: left;"
									maxlength="4" /> <span style="float: left;">-</span> <input
									type="text" name="mobile3"
									onkeyup="this.value=checkNum(this.value)"
									class="form-control input-sm" style="width: 15%; float: left;"
									maxlength="4" /></td>
							</tr>
							<tr>
								<td class="menu">이메일</td>
								<td align="left"><input type="text" name="email"
									class="form-control input-sm" style="width: 60%;" /></td>
							</tr>
							<tr>
								<td class="menu">주소</td>
								<td align="left"><input type="text" name="zipcode"
									id="zipcode" readonly class="form-control input-sm"
									style="width: 15%; background-color: #dddddd; float: left;" />&nbsp;
									<button type="button" onclick="callAddress();"
										class="btn btn-sm btn-default">주소입력</button>
									<span id="displaySearch"
									style="float: right; font-size: 13px; padding-top: 10px; display: none;">[검색
										자료 : <span id="displaySearchCount" style="color: red;"></span>건]
								</span><br> <input type="text" class="input-addr" id="address"
									placeholder="주소입력 예) 느티마을4단, ㄱㄴㅍㅇㄴㅅ, 여의 메리츠, 행자부, 목동아파트, 테헤란로 152"
									style="display: none; margin: 5px 0 0 0; width: 100%;">
									<input type="text" name="addr" id="addr" readonly
									class="form-control input-sm"
									style="margin: 5px 0; width: 100%; background-color: #dddddd;" />
									<input type="text" name="addr_etc" id="addr_etc"
									placeholder="상세주소" class="form-control input-sm"
									style="width: 100%;" /></td>
							</tr>
							<tr>
								<td class="menu">메모</td>
								<td align="left"><textarea name="memo" id="memo" rows="4"
										class="form-control input-sm" style="width: 100%;"></textarea></td>
							</tr>
							<tr>
								<td class="menu">현재 포인트</td>
								<td align="left"><span id="current_point"></span></td>
							</tr>
							<tr id="display_level">
								<td class="menu">등급 <span class="text-light-blue"><i
										class="fa fa-check"></i></span></td>
								<td><select name="level" id="level"
									class="form-control input-sm" style="width: 120px;">
										<option value="1">슈퍼관리자</option>
										<option value="2">회원</option>
										<option value="3">ㅈㅇㅇㅈ</option>
								</select></td>
							</tr>
							<!-- 
							<tr id="display_status">
								<td class="menu">상태 <span class="text-light-blue"><i
										class="fa fa-check"></i></span></td>
								<td><select name="status" id="status"
									class="form-control input-sm" style="width: 120px;">
										<option value="y">정상</option>
										<option value="n">대기</option>
								</select></td>
							</tr>
							<tr id="display_last_login_date">
								<td class="menu">최근 접속일</td>
								<td align="left"><span id="last_login_date"></span></td>
							</tr>
							<tr id="display_update_date">
								<td class="menu">수정일자</td>
								<td align="left"><span id="update_date"></span></td>
							</tr>
							<tr id="display_reg_date">
								<td class="menu">등록일자</td>
								<td align="left"><span id="reg_date"></span></td>
							</tr>
							 -->
						</table>
				</form>
			</div>
		</div>
		<div class="modal-footer">
			<button type="button" onclick="register();" class="btn btn-primary">저장</button>
			<!--<button type="button" onclick="deleteMember();" class="btn btn-danger">삭제</button>-->
		</div>
	</div>
</div>
</div>

<!-- // 적립금 지급 폼 -->
<div class="modal fade" id="modalPoint" tabindex="-2" role="dialog"
	aria-labelledby="myModal" aria-hidden="true">
	<div class="modal-dialog" style="width: 500px;">
		<div class="modal-content">
			<form name="formPoint" method="post" onsubmit="return false;"
				action="?tpf=admin/member/process">
				<input type="hidden" name="mode" value="point"> <input
					type="hidden" name="member_code">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabelPortfolio">적립금 지급</h4>
				</div>
				<div class="modal-body">

					<table class="table table-bordered">
						<tr>
							<td class="menu">대상 회원</td>
							<td align="left"><span id="sendCount"></span> 명</td>
						</tr>
						<tr>
							<td class="menu">지급 형태</td>
							<td align="left"><select name="sms_type"
								class="form-control input-sm" style="width: 120px;">
									<option value="+">지급</option>
									<option value="-">차감</option>
							</select></td>
						</tr>
						<tr>
							<td class="menu">적립금</td>
							<td align="left"><input type="text" name="point"
								onkeyup="this.value=displayComma(checkNum(this.value))"
								class="form-control input-sm" style="width: 120px;" /></td>
						</tr>
						<tr>
							<td class="menu">메모</td>
							<td align="left"><input type="text" name="content"
								class="form-control input-sm" /></td>
						</tr>
						<tr>
							<td class="menu">알림 설정</td>
							<td align="left"><input type="checkbox" name="is_send_sms"
								value="y" /> SMS 알림 (설정된 SMS 발송)<br> <input
								type="checkbox" name="is_send_email" value="y" /> 메일 알림 (설정된 메일
								발송)<br></td>
						</tr>
					</table>
			</form>
		</div>

	</div>
	<div class="modal-footer">
		<button type="button" onclick="registerPoint();"
			class="btn btn-primary">지급하기</button>
	</div>
</div>
</div>
</div>

<!-- // 쿠폰 지급 폼 -->
<div class="modal fade" id="modalCoupon" tabindex="-2" role="dialog"
	aria-labelledby="myModal" aria-hidden="true">
	<div class="modal-dialog" style="width: 500px;">
		<div class="modal-content">
			<form name="formCoupon" method="post" onsubmit="return false;"
				action="?tpf=admin/member/process">
				<input type="hidden" name="mode" value="coupon"> <input
					type="hidden" name="member_code">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabelPortfolio">쿠폰 지급</h4>
				</div>
				<div class="modal-body">

					<table class="table table-bordered">
						<tr>
							<td class="menu">대상 회원</td>
							<td align="left"><span id="sendCountCoupon"></span> 명</td>
						</tr>
						<tr>
							<td class="menu">쿠폰 선택</td>
							<td align="left"><select name="coupon_code"
								class="form-control input-sm">
									<option value="">선택</option>
									<option value="12|신년인사 쿠폰|제한 없음">신년인사 쿠폰
							</select> ※ 쿠폰은 회원당 한번씩만 발급 할수 있습니다.</td>
						</tr>
						<tr>
							<td class="menu">알림 설정</td>
							<td align="left"><input type="checkbox" name="is_send_sms"
								value="y" /> SMS 알림 (설정된 SMS 발송)<br> <input
								type="checkbox" name="is_send_email" value="y" /> 메일 알림 (설정된 메일
								발송)<br></td>
						</tr>
					</table>
			</form>
		</div>

	</div>
	<div class="modal-footer">
		<button type="button" onclick="registerCoupon();"
			class="btn btn-primary">지급하기</button>
	</div>
</div>
</div>
</div>

<!-- // SMS 발송 폼 -->
<div class="modal fade" id="modalSMS" tabindex="-2" role="dialog"
	aria-labelledby="myModal" aria-hidden="true">
	<div class="modal-dialog" style="width: 500px;">
		<div class="modal-content">
			<form name="formSMS" method="post" onsubmit="return false;"
				action="?tpf=admin/member/process">
				<input type="hidden" name="mode" value="sms"> <input
					type="hidden" name="field" value=""> <input type="hidden"
					name="keyword" value="">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabelPortfolio">SMS 발송</h4>
				</div>
				<div class="modal-body">

					<table class="table table-bordered">
						<tr>
							<td class="menu">수신자</td>
							<td align="left">5 명</td>
						</tr>

						<tr>
							<td class="menu">메세지<br> (<span id="msg_count">0</span>
								/ 90 byte)
							</td>
							<td align="left"><textarea name="msg" id="msg" rows="4"
									style="width: 100%;"></textarea></td>
						</tr>
					</table>
			</form>
		</div>

	</div>
	<div class="modal-footer">
		<button type="button" onclick="registerSMS();" class="btn btn-primary">보내기</button>
	</div>
</div>
</div>
</div>
</div>
<!-- /.content-wrapper -->

<script>
function downloadExcel() {  // Excel 다운로드
    form_download.target = 'iframe_process';
    form_download.search_data.value = $('#form_search :input').serialize();
    form_download.submit();
}

// 상세보기
$("button[id^='btn_']").on('click', function(e){
	//console.log(e.target);
	//console.log("해당 no = " + $(e.target).val());
	var memberNo = $(e.target).val();
	console.log("memberNo = " + memberNo);
	
	location.href = `${pageContext.request.contextPath}/member/memberPointList/\${memberNo}`; // \$ : "EL이 아니라 JavaScript $다."를 표시
});

$('#findList').each(function(){
	console.log("들어오냐");
});

function onclickInsert(){
	console.log("등록(onclickInsert())");
	$("#modalRegister").modal();
}

// 아이디 중복 확인
function onclickCheckId(){
	console.log("아이디 중복 확인");
	var id = $("#id").val();
	console.log("id = " + id);
	
	// id 값을 입력하지 않았을 때
	if(id == ""){
		alert("id를 정확히 입력해주세요");
		// 해당 위치로 입력 커서 이동
		$("#id").focus();
		return;
	}
	
	// 아이디 개수 유효성 검사
	if(!/^[a-zA-Z0-9]{4,12}$/.test(id)){
		alert("id를 정확히 입력해주세요");
		$("#id").focus();
		return;
	}
	
	const data = {
			id : id
	};
	const jsonData = JSON.stringify(data);
	
	// 비동기 중복 검사
	$.ajax({
		url : `${pageContext.request.contextPath}/member/checkIdDuplicate.do`,
		data : data,
		contentType : "application/json ; charset=utf-8",
		method : "GET",
		success(data) {
			const {available} = data;
			if(available){
				alert("사용 가능한 아이디 입니다.");
			}
			else{
				alert("[" + id + "]은 이미 사용중인 아이디 입니다. \n\n 다른 아이디를 사용하시기 바랍니다.")
			}
		},
		error : console.log
	});
};

/* 타입별 검색 */
$(document).ready(function(){
	// Enter Event
	$("#keyword").keydown(function(keyNum){
		
		var keyword = $('input[name=keyword]').val(); // 검색어
		var type = $('select[name=type]').val(); // 검색 타입
	
		if(keyNum.keyCode == 13){
			console.log("Enter Event! - 타입별 검색");
			console.log("keyword = " + keyword);
			console.log("type = " + type);
			
			const search = {
				"type" : type,
				"keyword" : keyword
			};
			
			$.ajax({
				type : "GET",
				url : `${pageContext.request.contextPath}/member/typeSearch.do`,
				data : search,
				contentType: "application/json; charset=utf-8",
				success(data){
					console.log("ajaxData = " + JSON.stringify(data));
					
					$("#tbody").html('');
					
					$.each(data.searchMemberList, (k, v) => {
						$("#tbody").append(`
								<tr>
								<td style="width: 30px;">
									<input type="checkbox" name="select_all" onclick=selectAllCheckBox( 'form_list'); />
								</td>
								<td style="width: 110px;">\${v.id}</td>
								<td style="width: 110px;">\${v.lastName}\${v.firstName}</td>
								<td style="width: 110px;">\${v.phone}</td>
								<td>\${v.addressMain} \${v.addressSub}</td>
								<td style="width: 100px;">\${v.pointAmt}</td>
								<td style="width: 120px;">\${v.regDate}</td>
								<td>
									<span class="label label-success" style="font-size: 12px;">보임</span>
								</td>
								<td>
									<button type="button" id="btn_\${v.memberNo}" value="\${v.memberNo}" class="btn btn-primary btn-xs">
										내역보기
									</button>
								</td>
								<td>
									<button type="button" onclick="onclickUpdate(18);" class="btn btn-primary btn-xs">
										상세보기
									</button>
								</td>
							</tr>
								`);
					});
					
					$("#totalCountContainer").html(`<label style="margin-top: 5px;">총 \${data["searchListCount"]} 건</label>`)
				},
				error : console.log	
			});
		}
	})
});

// 체크박스 전체 선택
$(".checkbox-group").on("click", "#checkAll", ((e)=>{
	let checked = $(e.target).is(":checked");
	console.log("전체 선택 : " + checked);
	
	if(checked){
		$(e.target).parents(".checkbox-group").find("input:checkbox").prop("checked", true);
	} else {
		$(e.target).parents(".checkbox-group").find("input:checkbox").prop("checked", false);
	}
}));

// 체크박스 개별 선택
$(".member-is-checked").on("click", ((e)=>{
	let isChecked = true;
	console.log("개별 선택 : " + isChecked);
	
	$(".member-is-checked").each((i, item)=>{
		isChecked = isChecked && $(item).is(":checked");
		console.log("i : " + i);
		console.log(item);
		console.log($(item).is(":checked"));
	});
	
	$("#checkAll").prop("checked", isChecked);
}));

$("#memberListDeleteBtn").click((e)=>{
	let isChecked = false;
	
	$(".member-is-cheked").each((i, item)=>{
		isChecked = isChecked || $(item).is(":checked");
		let target = $(item).data("target");
		
		if($(item).is(":checked")){
			$(item).after(`<input type="hidden" name="memberNo" value="\${target}"/>`);
		}
	});
	
	if(!isChecked){
		alert("선택된 목록이 없습니다.");
		return;
	}
	
	console.log("클릭");
	console.log($(document.memberDeleteFrm));
	$(document.noticeDeleteFrm).submit();
});




</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>